Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeDHG7Y (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 02:59:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54155 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeDHG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:59:21 -0400
X-Google-Smtp-Source: AIpwx4+scfsjDRFrNhOld/TCPvW4VUGE/Y5y6gl+tUpqF5CcdXsKPBqkeD6l5AmaaVEDtFa6Me6JuA==
Date: Sun, 8 Apr 2018 06:59:18 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, casey@schaufler-ca.com,
        jmorris@namei.org, oiaohm@gmail.com, igor.stoppa@huawei.com
Subject: [PATCH v5 1/1] security: Add mechanism to safely (un)load LSMs after
 boot time
Message-ID: <20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a mechanism to add mutable hooks and immutable
hooks to the callback chain. It adds an intermediary item to the
chain which separates mutable and immutable hooks. Immutable hooks
are then marked as read-only, as well as the hook heads. This does
not preclude some hooks being able to be mutated (removed).

It also wraps the hook unloading and execution with an SRCU. One
SRCU is used across all hooks, as the SRCU struct can be memory
intensive, and hook execution time, in general, should be relatively
short.

It also introduces a new kernel parameter "allow_unload_hooks" which
is set to true by default, and if it is set to false, prevents the
LSM's LKM from being unloaded. It can also be set to false at runtime,
but once set to false, it cannot be reset to true.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
---
 include/linux/lsm_hooks.h |  36 ++--
 security/Kconfig          |  13 +-
 security/security.c       | 280 ++++++++++++++++++++++++++---
 security/selinux/hooks.c  | 448 ++++++++++++++++++++++++----------------------
 4 files changed, 518 insertions(+), 259 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ac491137b10a..d486dfd8f3e3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
+#include <linux/module.h>
 
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -1967,6 +1968,7 @@ struct security_hook_list {
 	struct hlist_head		*head;
 	union security_list_options	hook;
 	char				*lsm;
+	struct module			*owner;
 } __randomize_layout;
 
 /*
@@ -1976,15 +1978,27 @@ struct security_hook_list {
  * text involved.
  */
 #define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
-
+	{						\
+		.head = &security_hook_heads.HEAD,	\
+		.hook = { .HEAD = HOOK },		\
+		.owner = THIS_MODULE,			\
+	}
 extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
-#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+#define __lsm_ro_after_init	__ro_after_init
+/* Used to facilitate runtime hook unloading, and loading */
+#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
+#define LSM_HOOK_INIT_MUTABLE(HEAD, HOOK) \
+	{							\
+		.head = &security_hook_heads_mutable.HEAD,	\
+		.hook = { .HEAD = HOOK },			\
+		.owner = THIS_MODULE,				\
+	}
+extern struct security_hook_heads security_hook_heads_mutable;
 /*
  * Assuring the safety of deleting a security module is up to
  * the security module involved. This may entail ordering the
@@ -1997,21 +2011,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
  * disabling their module is a good idea needs to be at least as
  * careful as the SELinux team.
  */
-static inline void security_delete_hooks(struct security_hook_list *hooks,
-						int count)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		hlist_del_rcu(&hooks[i].list);
-}
-#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
-
-/* Currently required to handle SELinux runtime hook disable. */
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-#define __lsm_ro_after_init
-#else
-#define __lsm_ro_after_init	__ro_after_init
+extern void security_delete_hooks(struct security_hook_list *hooks, int count);
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern int __init security_module_enable(const char *module);
diff --git a/security/Kconfig b/security/Kconfig
index c4302067a3ad..28882b20c391 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -32,10 +32,21 @@ config SECURITY
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_WRITABLE_HOOKS
-	depends on SECURITY
+	depends on SECURITY && SRCU
 	bool
 	default n
 
+config SECURITY_UNLOADABLE_MODULES
+	depends on SECURITY_WRITABLE_HOOKS && MODULE_UNLOAD
+	default n
+	bool "Enable security module unloading"
+	help
+	  This allows arbitrary security modules to be unloaded by the user
+	  after boot time. This feature can be disabled via the kernel command
+	  line, or via sysfs after boot time.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
 	help
diff --git a/security/security.c b/security/security.c
index dd246a38b3f0..22531a6b79a3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,11 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <net/flow.h>
+#include <linux/srcu.h>
+#include <linux/mutex.h>
+
+#define SECURITY_HOOK_COUNT \
+	(sizeof(security_hook_heads) / sizeof(struct hlist_head))
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -36,7 +41,9 @@
 #define SECURITY_NAME_MAX	10
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+static DEFINE_MUTEX(security_hook_mutex);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
@@ -52,6 +59,131 @@ static void __init do_security_initcalls(void)
 		call++;
 	}
 }
+#define FOR_EACH_SECURITY_HOOK(ITERATOR, HEAD) \
+	hlist_for_each_entry(ITERATOR, &security_hook_heads.HEAD, list)
+
+#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
+/*
+ * If mutable security hooks are enabled, it exposes a second set of
+ * security_hook_heads. These security_hook_heads will only be executed
+ * if all immutable hooks are executed successfully.
+ */
+struct security_hook_heads security_hook_heads_mutable;
+EXPORT_SYMBOL_GPL(security_hook_heads_mutable);
+DEFINE_STATIC_SRCU(security_hook_srcu);
+
+/*
+ * This blocks the delete_module syscall for hooks that are loaded into the
+ * set of mutable hooks by getting a reference on those modules. This
+ * allows modules to still delete their security hooks, so SELinux
+ * will still be able to unload.
+ */
+static bool allow_unload_hooks =
+	IS_ENABLED(CONFIG_SECURITY_UNLOADABLE_MODULES);
+
+static void lock_existing_hooks(void)
+{
+	struct hlist_head *list = (struct hlist_head *)
+					&security_hook_heads_mutable;
+	struct security_hook_list *P;
+	int i;
+
+	/*
+	 * Prevent module unloading while we're doing this
+	 * try_module_get may fail (safely), if the module
+	 * is already unloading -- allow that.
+	 */
+	mutex_lock(&module_mutex);
+	for (i = 0; i < SECURITY_HOOK_COUNT; i++)
+		hlist_for_each_entry(P, &list[i], list)
+			try_module_get(P->owner);
+	mutex_unlock(&module_mutex);
+}
+
+static int allow_unload_hooks_set(const char *val,
+					const struct kernel_param *kp)
+{
+	bool new_val;
+	int ret = 0;
+
+	ret = strtobool(val, &new_val);
+	if (ret)
+		goto out;
+	mutex_lock(&security_hook_mutex);
+	/* This is a noop */
+	if (new_val == allow_unload_hooks)
+		goto out;
+
+	/* Do not allow for the transition from false -> true */
+	if (new_val) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	allow_unload_hooks = new_val;
+	/* We now need to "lock" all of the existing hooks */
+	lock_existing_hooks();
+out:
+	mutex_unlock(&security_hook_mutex);
+	return ret;
+}
+
+static int allow_unload_hooks_get(char *buffer, const struct kernel_param *kp)
+{
+	int ret;
+
+	mutex_lock(&security_hook_mutex);
+	ret = sprintf(buffer, "%c\n", allow_unload_hooks ? '1' : '0');
+	mutex_unlock(&security_hook_mutex);
+
+	return ret;
+}
+
+static struct kernel_param_ops allow_unload_hooks_param_ops = {
+	.set	= allow_unload_hooks_set,
+	.get	= allow_unload_hooks_get,
+};
+
+module_param_cb(allow_unload_hooks, &allow_unload_hooks_param_ops, NULL, 0644);
+MODULE_PARM_DESC(allow_unload_hooks, "Allow unloading security hooks");
+
+static inline int lock_lsm(void)
+{
+	return srcu_read_lock(&security_hook_srcu);
+}
+
+static inline void unlock_lsm(int idx)
+{
+	srcu_read_unlock(&security_hook_srcu, idx);
+}
+
+void security_delete_hooks(struct security_hook_list *hooks, int count)
+{
+	int i;
+
+	mutex_lock(&security_hook_mutex);
+	for (i = 0; i < count; i++)
+		hlist_del_rcu(&hooks[i].list);
+	mutex_unlock(&security_hook_mutex);
+
+	synchronize_srcu(&security_hook_srcu);
+}
+EXPORT_SYMBOL_GPL(security_delete_hooks);
+
+#define FOR_EACH_SECURITY_HOOK_MUTABLE(ITERATOR, HEAD) \
+	hlist_for_each_entry(ITERATOR, &security_hook_heads_mutable.HEAD, list)
+#else
+static inline int lock_lsm(void)
+{
+	return 0;
+}
+
+static inline void unlock_lsm(int idx) {}
+
+#define allow_unload_hooks	false
+
+#define FOR_EACH_SECURITY_HOOK_MUTABLE(ITERATOR, HEAD)	while (0)
+#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 /**
  * security_init - initializes the security framework
@@ -60,12 +192,6 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
-	int i;
-	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
-
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
-	     i++)
-		INIT_HLIST_HEAD(&list[i]);
 	pr_info("Security Framework initialized\n");
 
 	/*
@@ -156,18 +282,23 @@ int __init security_module_enable(const char *module)
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+void security_add_hooks(struct security_hook_list *hooks, int count, char *lsm)
 {
 	int i;
 
+	mutex_lock(&security_hook_mutex);
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		if (!allow_unload_hooks)
+			WARN_ON(!try_module_get(hooks[i].owner));
 	}
+	mutex_unlock(&security_hook_mutex);
+
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
 }
+EXPORT_SYMBOL_GPL(security_add_hooks);
 
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
@@ -200,25 +331,48 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 #define call_void_hook(FUNC, ...)				\
 	do {							\
 		struct security_hook_list *P;			\
+		int srcu_idx;					\
 								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
+		FOR_EACH_SECURITY_HOOK(P, FUNC)			\
 			P->hook.FUNC(__VA_ARGS__);		\
+		srcu_idx = lock_lsm();				\
+		FOR_EACH_SECURITY_HOOK_MUTABLE(P, FUNC)		\
+			P->hook.FUNC(__VA_ARGS__);		\
+		unlock_lsm(srcu_idx);				\
 	} while (0)
 
-#define call_int_hook(FUNC, IRC, ...) ({			\
+#define call_int_hook2(LABEL, FUNC, IRC, ...) ({		\
 	int RC = IRC;						\
+								\
 	do {							\
 		struct security_hook_list *P;			\
+		int srcu_idx;					\
 								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+		FOR_EACH_SECURITY_HOOK(P, FUNC) {		\
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (RC != 0)				\
+				goto LABEL;			\
+		}						\
+		srcu_idx = lock_lsm();				\
+		FOR_EACH_SECURITY_HOOK_MUTABLE(P, FUNC) {	\
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				break;				\
 		}						\
+		unlock_lsm(srcu_idx);				\
 	} while (0);						\
+LABEL:								\
 	RC;							\
 })
 
+/*
+ * The label for each instance of call_int_hook as it can be
+ * invoked multiple times in a single function definition.
+ */
+#define call_int_hook(FUNC, IRC, ...)	\
+	call_int_hook2(__UNIQUE_ID(FUNC), FUNC, IRC, __VA_ARGS__)
+
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -308,6 +462,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
+	int srcu_idx;
 	int rc;
 
 	/*
@@ -317,13 +472,25 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+	FOR_EACH_SECURITY_HOOK(hp, vm_enough_memory) {
+		rc = hp->hook.vm_enough_memory(mm, pages);
+		if (rc <= 0) {
+			cap_sys_admin = 0;
+			goto out;
+		}
+	}
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, vm_enough_memory) {
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
 			break;
 		}
 	}
+	unlock_lsm(srcu_idx);
+
+out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -795,43 +962,71 @@ int security_inode_killpriv(struct dentry *dentry)
 	return call_int_hook(inode_killpriv, 0, dentry);
 }
 
-int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+int security_inode_getsecurity(struct inode *inode, const char *name,
+			       void **buffer, bool alloc)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc = -EOPNOTSUPP;
+	int srcu_idx;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
+	FOR_EACH_SECURITY_HOOK(hp, inode_getsecurity) {
+		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
+		if (rc != -EOPNOTSUPP)
+			goto out;
+	}
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, inode_getsecurity) {
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-	return -EOPNOTSUPP;
+	unlock_lsm(srcu_idx);
+
+out:
+	return rc;
 }
 
-int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
+int security_inode_setsecurity(struct inode *inode, const char *name,
+				const void *value, size_t size, int flags)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc = -EOPNOTSUPP;
+	int srcu_idx;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
+
+	FOR_EACH_SECURITY_HOOK(hp, inode_setsecurity) {
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-								flags);
+						flags);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			goto out;
 	}
-	return -EOPNOTSUPP;
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, inode_setsecurity) {
+		rc = hp->hook.inode_setsecurity(inode, name, value, size,
+						flags);
+		if (rc != -EOPNOTSUPP)
+			break;
+	}
+	unlock_lsm(srcu_idx);
+
+out:
+	return rc;
 }
 
+
+
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1120,13 +1315,26 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 }
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			 unsigned long arg4, unsigned long arg5)
+			unsigned long arg4, unsigned long arg5)
 {
 	int thisrc;
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
+	int srcu_idx;
+
+
+	FOR_EACH_SECURITY_HOOK(hp, task_prctl) {
+		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+		if (thisrc != -ENOSYS) {
+			rc = thisrc;
+			if (thisrc != 0)
+				goto out;
+		}
+
+	}
 
-	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, task_prctl) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
@@ -1134,6 +1342,9 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+	unlock_lsm(srcu_idx);
+
+out:
 	return rc;
 }
 
@@ -1614,10 +1825,11 @@ int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
-				       struct xfrm_policy *xp,
-				       const struct flowi *fl)
+						struct xfrm_policy *xp,
+						const struct flowi *fl)
 {
 	struct security_hook_list *hp;
+	int srcu_idx;
 	int rc = 1;
 
 	/*
@@ -1629,11 +1841,21 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
+
+
+	FOR_EACH_SECURITY_HOOK(hp, xfrm_state_pol_flow_match) {
+		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
+		goto out;
+	}
+
+	srcu_idx = lock_lsm();
+	FOR_EACH_SECURITY_HOOK_MUTABLE(hp, xfrm_state_pol_flow_match) {
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
+	unlock_lsm(srcu_idx);
+
+out:
 	return rc;
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8abd542c6b7c..571990d4845e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6396,234 +6396,260 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
-static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
-	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
-	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
-	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
-	LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
-
-	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
-	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
-	LSM_HOOK_INIT(capget, selinux_capget),
-	LSM_HOOK_INIT(capset, selinux_capset),
-	LSM_HOOK_INIT(capable, selinux_capable),
-	LSM_HOOK_INIT(quotactl, selinux_quotactl),
-	LSM_HOOK_INIT(quota_on, selinux_quota_on),
-	LSM_HOOK_INIT(syslog, selinux_syslog),
-	LSM_HOOK_INIT(vm_enough_memory, selinux_vm_enough_memory),
-
-	LSM_HOOK_INIT(netlink_send, selinux_netlink_send),
-
-	LSM_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
-	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
-	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
-
-	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
-	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
-	LSM_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),
-	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
-	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
-	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
-	LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
-	LSM_HOOK_INIT(sb_mount, selinux_mount),
-	LSM_HOOK_INIT(sb_umount, selinux_umount),
-	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
-	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
-	LSM_HOOK_INIT(sb_parse_opts_str, selinux_parse_opts_str),
-
-	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
-	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
-
-	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
-	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
-	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
-	LSM_HOOK_INIT(inode_create, selinux_inode_create),
-	LSM_HOOK_INIT(inode_link, selinux_inode_link),
-	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
-	LSM_HOOK_INIT(inode_symlink, selinux_inode_symlink),
-	LSM_HOOK_INIT(inode_mkdir, selinux_inode_mkdir),
-	LSM_HOOK_INIT(inode_rmdir, selinux_inode_rmdir),
-	LSM_HOOK_INIT(inode_mknod, selinux_inode_mknod),
-	LSM_HOOK_INIT(inode_rename, selinux_inode_rename),
-	LSM_HOOK_INIT(inode_readlink, selinux_inode_readlink),
-	LSM_HOOK_INIT(inode_follow_link, selinux_inode_follow_link),
-	LSM_HOOK_INIT(inode_permission, selinux_inode_permission),
-	LSM_HOOK_INIT(inode_setattr, selinux_inode_setattr),
-	LSM_HOOK_INIT(inode_getattr, selinux_inode_getattr),
-	LSM_HOOK_INIT(inode_setxattr, selinux_inode_setxattr),
-	LSM_HOOK_INIT(inode_post_setxattr, selinux_inode_post_setxattr),
-	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
-	LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
-	LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
-	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
-	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
-	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
-	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
-	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
-	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
-
-	LSM_HOOK_INIT(file_permission, selinux_file_permission),
-	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
-	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
-	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
-	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
-	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
-	LSM_HOOK_INIT(file_lock, selinux_file_lock),
-	LSM_HOOK_INIT(file_fcntl, selinux_file_fcntl),
-	LSM_HOOK_INIT(file_set_fowner, selinux_file_set_fowner),
-	LSM_HOOK_INIT(file_send_sigiotask, selinux_file_send_sigiotask),
-	LSM_HOOK_INIT(file_receive, selinux_file_receive),
-
-	LSM_HOOK_INIT(file_open, selinux_file_open),
-
-	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
-	LSM_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
-	LSM_HOOK_INIT(cred_free, selinux_cred_free),
-	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
-	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
-	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
-	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
-	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
-	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
-	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
-	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
-	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
-	LSM_HOOK_INIT(task_getsecid, selinux_task_getsecid),
-	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
-	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
-	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
-	LSM_HOOK_INIT(task_prlimit, selinux_task_prlimit),
-	LSM_HOOK_INIT(task_setrlimit, selinux_task_setrlimit),
-	LSM_HOOK_INIT(task_setscheduler, selinux_task_setscheduler),
-	LSM_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
-	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
-	LSM_HOOK_INIT(task_kill, selinux_task_kill),
-	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
-
-	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
-
-	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
-	LSM_HOOK_INIT(msg_msg_free_security, selinux_msg_msg_free_security),
-
-	LSM_HOOK_INIT(msg_queue_alloc_security,
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+#define __selinux_ro_after_init
+#define SELINUX_HOOK_INIT	LSM_HOOK_INIT_MUTABLE
+#else
+#define __selinux_ro_after_init	__lsm_ro_after_init
+#define SELINUX_HOOK_INIT	LSM_HOOK_INIT
+#endif
+
+static struct security_hook_list selinux_hooks[] __selinux_ro_after_init = {
+	SELINUX_HOOK_INIT(binder_set_context_mgr,
+				selinux_binder_set_context_mgr),
+	SELINUX_HOOK_INIT(binder_transaction, selinux_binder_transaction),
+	SELINUX_HOOK_INIT(binder_transfer_binder,
+				selinux_binder_transfer_binder),
+	SELINUX_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
+
+	SELINUX_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
+	SELINUX_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	SELINUX_HOOK_INIT(capget, selinux_capget),
+	SELINUX_HOOK_INIT(capset, selinux_capset),
+	SELINUX_HOOK_INIT(capable, selinux_capable),
+	SELINUX_HOOK_INIT(quotactl, selinux_quotactl),
+	SELINUX_HOOK_INIT(quota_on, selinux_quota_on),
+	SELINUX_HOOK_INIT(syslog, selinux_syslog),
+	SELINUX_HOOK_INIT(vm_enough_memory, selinux_vm_enough_memory),
+
+	SELINUX_HOOK_INIT(netlink_send, selinux_netlink_send),
+
+	SELINUX_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
+	SELINUX_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
+	SELINUX_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
+
+	SELINUX_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
+	SELINUX_HOOK_INIT(sb_free_security, selinux_sb_free_security),
+	SELINUX_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),
+	SELINUX_HOOK_INIT(sb_remount, selinux_sb_remount),
+	SELINUX_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
+	SELINUX_HOOK_INIT(sb_show_options, selinux_sb_show_options),
+	SELINUX_HOOK_INIT(sb_statfs, selinux_sb_statfs),
+	SELINUX_HOOK_INIT(sb_mount, selinux_mount),
+	SELINUX_HOOK_INIT(sb_umount, selinux_umount),
+	SELINUX_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
+	SELINUX_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
+	SELINUX_HOOK_INIT(sb_parse_opts_str, selinux_parse_opts_str),
+
+	SELINUX_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
+	SELINUX_HOOK_INIT(dentry_create_files_as,
+				selinux_dentry_create_files_as),
+
+	SELINUX_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
+	SELINUX_HOOK_INIT(inode_free_security, selinux_inode_free_security),
+	SELINUX_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	SELINUX_HOOK_INIT(inode_create, selinux_inode_create),
+	SELINUX_HOOK_INIT(inode_link, selinux_inode_link),
+	SELINUX_HOOK_INIT(inode_unlink, selinux_inode_unlink),
+	SELINUX_HOOK_INIT(inode_symlink, selinux_inode_symlink),
+	SELINUX_HOOK_INIT(inode_mkdir, selinux_inode_mkdir),
+	SELINUX_HOOK_INIT(inode_rmdir, selinux_inode_rmdir),
+	SELINUX_HOOK_INIT(inode_mknod, selinux_inode_mknod),
+	SELINUX_HOOK_INIT(inode_rename, selinux_inode_rename),
+	SELINUX_HOOK_INIT(inode_readlink, selinux_inode_readlink),
+	SELINUX_HOOK_INIT(inode_follow_link, selinux_inode_follow_link),
+	SELINUX_HOOK_INIT(inode_permission, selinux_inode_permission),
+	SELINUX_HOOK_INIT(inode_setattr, selinux_inode_setattr),
+	SELINUX_HOOK_INIT(inode_getattr, selinux_inode_getattr),
+	SELINUX_HOOK_INIT(inode_setxattr, selinux_inode_setxattr),
+	SELINUX_HOOK_INIT(inode_post_setxattr, selinux_inode_post_setxattr),
+	SELINUX_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
+	SELINUX_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
+	SELINUX_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
+	SELINUX_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
+	SELINUX_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
+	SELINUX_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
+	SELINUX_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
+	SELINUX_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
+	SELINUX_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
+
+	SELINUX_HOOK_INIT(file_permission, selinux_file_permission),
+	SELINUX_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
+	SELINUX_HOOK_INIT(file_free_security, selinux_file_free_security),
+	SELINUX_HOOK_INIT(file_ioctl, selinux_file_ioctl),
+	SELINUX_HOOK_INIT(mmap_file, selinux_mmap_file),
+	SELINUX_HOOK_INIT(mmap_addr, selinux_mmap_addr),
+	SELINUX_HOOK_INIT(file_mprotect, selinux_file_mprotect),
+	SELINUX_HOOK_INIT(file_lock, selinux_file_lock),
+	SELINUX_HOOK_INIT(file_fcntl, selinux_file_fcntl),
+	SELINUX_HOOK_INIT(file_set_fowner, selinux_file_set_fowner),
+	SELINUX_HOOK_INIT(file_send_sigiotask, selinux_file_send_sigiotask),
+	SELINUX_HOOK_INIT(file_receive, selinux_file_receive),
+
+	SELINUX_HOOK_INIT(file_open, selinux_file_open),
+
+	SELINUX_HOOK_INIT(task_alloc, selinux_task_alloc),
+	SELINUX_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
+	SELINUX_HOOK_INIT(cred_free, selinux_cred_free),
+	SELINUX_HOOK_INIT(cred_prepare, selinux_cred_prepare),
+	SELINUX_HOOK_INIT(cred_transfer, selinux_cred_transfer),
+	SELINUX_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
+	SELINUX_HOOK_INIT(kernel_create_files_as,
+				selinux_kernel_create_files_as),
+	SELINUX_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
+	SELINUX_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
+	SELINUX_HOOK_INIT(task_setpgid, selinux_task_setpgid),
+	SELINUX_HOOK_INIT(task_getpgid, selinux_task_getpgid),
+	SELINUX_HOOK_INIT(task_getsid, selinux_task_getsid),
+	SELINUX_HOOK_INIT(task_getsecid, selinux_task_getsecid),
+	SELINUX_HOOK_INIT(task_setnice, selinux_task_setnice),
+	SELINUX_HOOK_INIT(task_setioprio, selinux_task_setioprio),
+	SELINUX_HOOK_INIT(task_getioprio, selinux_task_getioprio),
+	SELINUX_HOOK_INIT(task_prlimit, selinux_task_prlimit),
+	SELINUX_HOOK_INIT(task_setrlimit, selinux_task_setrlimit),
+	SELINUX_HOOK_INIT(task_setscheduler, selinux_task_setscheduler),
+	SELINUX_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
+	SELINUX_HOOK_INIT(task_movememory, selinux_task_movememory),
+	SELINUX_HOOK_INIT(task_kill, selinux_task_kill),
+	SELINUX_HOOK_INIT(task_to_inode, selinux_task_to_inode),
+
+	SELINUX_HOOK_INIT(ipc_permission, selinux_ipc_permission),
+	SELINUX_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
+
+	SELINUX_HOOK_INIT(msg_msg_alloc_security,
+				selinux_msg_msg_alloc_security),
+	SELINUX_HOOK_INIT(msg_msg_free_security,
+				selinux_msg_msg_free_security),
+
+	SELINUX_HOOK_INIT(msg_queue_alloc_security,
 			selinux_msg_queue_alloc_security),
-	LSM_HOOK_INIT(msg_queue_free_security, selinux_msg_queue_free_security),
-	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
-	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
-	LSM_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
-	LSM_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
-
-	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
-	LSM_HOOK_INIT(shm_free_security, selinux_shm_free_security),
-	LSM_HOOK_INIT(shm_associate, selinux_shm_associate),
-	LSM_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
-	LSM_HOOK_INIT(shm_shmat, selinux_shm_shmat),
-
-	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
-	LSM_HOOK_INIT(sem_free_security, selinux_sem_free_security),
-	LSM_HOOK_INIT(sem_associate, selinux_sem_associate),
-	LSM_HOOK_INIT(sem_semctl, selinux_sem_semctl),
-	LSM_HOOK_INIT(sem_semop, selinux_sem_semop),
-
-	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
-
-	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
-	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
-
-	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
-	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
-	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
-	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
-	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
-	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
-	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
-
-	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
-	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
-
-	LSM_HOOK_INIT(socket_create, selinux_socket_create),
-	LSM_HOOK_INIT(socket_post_create, selinux_socket_post_create),
-	LSM_HOOK_INIT(socket_bind, selinux_socket_bind),
-	LSM_HOOK_INIT(socket_connect, selinux_socket_connect),
-	LSM_HOOK_INIT(socket_listen, selinux_socket_listen),
-	LSM_HOOK_INIT(socket_accept, selinux_socket_accept),
-	LSM_HOOK_INIT(socket_sendmsg, selinux_socket_sendmsg),
-	LSM_HOOK_INIT(socket_recvmsg, selinux_socket_recvmsg),
-	LSM_HOOK_INIT(socket_getsockname, selinux_socket_getsockname),
-	LSM_HOOK_INIT(socket_getpeername, selinux_socket_getpeername),
-	LSM_HOOK_INIT(socket_getsockopt, selinux_socket_getsockopt),
-	LSM_HOOK_INIT(socket_setsockopt, selinux_socket_setsockopt),
-	LSM_HOOK_INIT(socket_shutdown, selinux_socket_shutdown),
-	LSM_HOOK_INIT(socket_sock_rcv_skb, selinux_socket_sock_rcv_skb),
-	LSM_HOOK_INIT(socket_getpeersec_stream,
+	SELINUX_HOOK_INIT(msg_queue_free_security,
+				selinux_msg_queue_free_security),
+	SELINUX_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
+	SELINUX_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
+	SELINUX_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
+	SELINUX_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
+
+	SELINUX_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
+	SELINUX_HOOK_INIT(shm_free_security, selinux_shm_free_security),
+	SELINUX_HOOK_INIT(shm_associate, selinux_shm_associate),
+	SELINUX_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
+	SELINUX_HOOK_INIT(shm_shmat, selinux_shm_shmat),
+
+	SELINUX_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
+	SELINUX_HOOK_INIT(sem_free_security, selinux_sem_free_security),
+	SELINUX_HOOK_INIT(sem_associate, selinux_sem_associate),
+	SELINUX_HOOK_INIT(sem_semctl, selinux_sem_semctl),
+	SELINUX_HOOK_INIT(sem_semop, selinux_sem_semop),
+
+	SELINUX_HOOK_INIT(d_instantiate, selinux_d_instantiate),
+
+	SELINUX_HOOK_INIT(getprocattr, selinux_getprocattr),
+	SELINUX_HOOK_INIT(setprocattr, selinux_setprocattr),
+
+	SELINUX_HOOK_INIT(ismaclabel, selinux_ismaclabel),
+	SELINUX_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+	SELINUX_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
+	SELINUX_HOOK_INIT(release_secctx, selinux_release_secctx),
+	SELINUX_HOOK_INIT(inode_invalidate_secctx,
+				selinux_inode_invalidate_secctx),
+	SELINUX_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
+	SELINUX_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
+	SELINUX_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
+
+	SELINUX_HOOK_INIT(unix_stream_connect,
+				selinux_socket_unix_stream_connect),
+	SELINUX_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
+
+	SELINUX_HOOK_INIT(socket_create, selinux_socket_create),
+	SELINUX_HOOK_INIT(socket_post_create, selinux_socket_post_create),
+	SELINUX_HOOK_INIT(socket_bind, selinux_socket_bind),
+	SELINUX_HOOK_INIT(socket_connect, selinux_socket_connect),
+	SELINUX_HOOK_INIT(socket_listen, selinux_socket_listen),
+	SELINUX_HOOK_INIT(socket_accept, selinux_socket_accept),
+	SELINUX_HOOK_INIT(socket_sendmsg, selinux_socket_sendmsg),
+	SELINUX_HOOK_INIT(socket_recvmsg, selinux_socket_recvmsg),
+	SELINUX_HOOK_INIT(socket_getsockname, selinux_socket_getsockname),
+	SELINUX_HOOK_INIT(socket_getpeername, selinux_socket_getpeername),
+	SELINUX_HOOK_INIT(socket_getsockopt, selinux_socket_getsockopt),
+	SELINUX_HOOK_INIT(socket_setsockopt, selinux_socket_setsockopt),
+	SELINUX_HOOK_INIT(socket_shutdown, selinux_socket_shutdown),
+	SELINUX_HOOK_INIT(socket_sock_rcv_skb, selinux_socket_sock_rcv_skb),
+	SELINUX_HOOK_INIT(socket_getpeersec_stream,
 			selinux_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dgram),
-	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
-	LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
-	LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
-	LSM_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
-	LSM_HOOK_INIT(sock_graft, selinux_sock_graft),
-	LSM_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
-	LSM_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
-	LSM_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
-	LSM_HOOK_INIT(secmark_relabel_packet, selinux_secmark_relabel_packet),
-	LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
-	LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
-	LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
-	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
-	LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
-	LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
-	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
-	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
-	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+	SELINUX_HOOK_INIT(socket_getpeersec_dgram,
+				selinux_socket_getpeersec_dgram),
+	SELINUX_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
+	SELINUX_HOOK_INIT(sk_free_security, selinux_sk_free_security),
+	SELINUX_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
+	SELINUX_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
+	SELINUX_HOOK_INIT(sock_graft, selinux_sock_graft),
+	SELINUX_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
+	SELINUX_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
+	SELINUX_HOOK_INIT(inet_conn_established,
+				selinux_inet_conn_established),
+	SELINUX_HOOK_INIT(secmark_relabel_packet,
+				selinux_secmark_relabel_packet),
+	SELINUX_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
+	SELINUX_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
+	SELINUX_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
+	SELINUX_HOOK_INIT(tun_dev_alloc_security,
+				selinux_tun_dev_alloc_security),
+	SELINUX_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
+	SELINUX_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
+	SELINUX_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
+	SELINUX_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
+	SELINUX_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
 #ifdef CONFIG_SECURITY_INFINIBAND
-	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
-	LSM_HOOK_INIT(ib_endport_manage_subnet,
+	SELINUX_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
+	SELINUX_HOOK_INIT(ib_endport_manage_subnet,
 		      selinux_ib_endport_manage_subnet),
-	LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
-	LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
+	SELINUX_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
+	SELINUX_HOOK_INIT(ib_free_security, selinux_ib_free_security),
 #endif
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-	LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
-	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
-	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
-	LSM_HOOK_INIT(xfrm_policy_delete_security, selinux_xfrm_policy_delete),
-	LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
-	LSM_HOOK_INIT(xfrm_state_alloc_acquire,
+	SELINUX_HOOK_INIT(xfrm_policy_alloc_security,
+				selinux_xfrm_policy_alloc),
+	SELINUX_HOOK_INIT(xfrm_policy_clone_security,
+				selinux_xfrm_policy_clone),
+	SELINUX_HOOK_INIT(xfrm_policy_free_security,
+				selinux_xfrm_policy_free),
+	SELINUX_HOOK_INIT(xfrm_policy_delete_security,
+				selinux_xfrm_policy_delete),
+	SELINUX_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
+	SELINUX_HOOK_INIT(xfrm_state_alloc_acquire,
 			selinux_xfrm_state_alloc_acquire),
-	LSM_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
-	LSM_HOOK_INIT(xfrm_state_delete_security, selinux_xfrm_state_delete),
-	LSM_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
-	LSM_HOOK_INIT(xfrm_state_pol_flow_match,
+	SELINUX_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
+	SELINUX_HOOK_INIT(xfrm_state_delete_security,
+				selinux_xfrm_state_delete),
+	SELINUX_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
+	SELINUX_HOOK_INIT(xfrm_state_pol_flow_match,
 			selinux_xfrm_state_pol_flow_match),
-	LSM_HOOK_INIT(xfrm_decode_session, selinux_xfrm_decode_session),
+	SELINUX_HOOK_INIT(xfrm_decode_session, selinux_xfrm_decode_session),
 #endif
 
 #ifdef CONFIG_KEYS
-	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
-	LSM_HOOK_INIT(key_free, selinux_key_free),
-	LSM_HOOK_INIT(key_permission, selinux_key_permission),
-	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
+	SELINUX_HOOK_INIT(key_alloc, selinux_key_alloc),
+	SELINUX_HOOK_INIT(key_free, selinux_key_free),
+	SELINUX_HOOK_INIT(key_permission, selinux_key_permission),
+	SELINUX_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
 #endif
 
 #ifdef CONFIG_AUDIT
-	LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
-	LSM_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
-	LSM_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
-	LSM_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
+	SELINUX_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
+	SELINUX_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
+	SELINUX_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
+	SELINUX_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
 #endif
 
 #ifdef CONFIG_BPF_SYSCALL
-	LSM_HOOK_INIT(bpf, selinux_bpf),
-	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
-	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
-	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
-	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
-	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
-	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
+	SELINUX_HOOK_INIT(bpf, selinux_bpf),
+	SELINUX_HOOK_INIT(bpf_map, selinux_bpf_map),
+	SELINUX_HOOK_INIT(bpf_prog, selinux_bpf_prog),
+	SELINUX_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
+	SELINUX_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
+	SELINUX_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
+	SELINUX_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
 };
 
-- 
2.14.1
