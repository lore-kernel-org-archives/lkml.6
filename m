Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC2VO2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:14:28 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40934 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeC2VO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:14:26 -0400
X-Google-Smtp-Source: AIpwx48k4KaeAmQz+wOE0WyhUP2o41QepiiSYxvXhQF3DvPRxegdPHt7NbmGT7+ZkE6JA6x1vxnQ5g==
Date: Thu, 29 Mar 2018 21:14:23 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, casey@schaufler-ca.com, jmorris@namei.org,
        sds@tycho.nsa.gov, paul@paul-moore.com, plautrba@redhat.com
Subject: [PATCH v3 1/1] security: Add mechanism to safely (un)load LSMs after
 boot time
Message-ID: <5240a81494bbe5be5651379cd9828bda34d764e2.1522357211.git.sargun@sargun.me>
References: <cover.1522357211.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522357211.git.sargun@sargun.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a mechanism to add mutable hooks and immutable
hooks to the callback chain. It adds an intermediary item to the
chain which separates mutable and immutable hooks. Immutable hooks
are then marked as read-only, as well as the hook heads. This does
not preclude some hooks being able to be mutated (removed).

It also wraps the hook unloading, and execution with an SRCU. One
SRCU is used across all hooks, as the SRCU struct can be memory
intensive, and hook execution time in general should be relatively
short.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
---
 include/linux/lsm_hooks.h  |  23 ++---
 security/Kconfig           |   2 +-
 security/apparmor/lsm.c    |   2 +-
 security/commoncap.c       |   2 +-
 security/security.c        | 210 ++++++++++++++++++++++++++++++++++++++-------
 security/selinux/hooks.c   |   5 +-
 security/smack/smack_lsm.c |   3 +-
 security/tomoyo/tomoyo.c   |   3 +-
 security/yama/yama_lsm.c   |   2 +-
 9 files changed, 196 insertions(+), 56 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 09bc60fb35f1..689e5e72fb38 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1981,9 +1981,12 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+				char *lsm, bool is_mutable);
 
-#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+#define __lsm_ro_after_init	__ro_after_init
+/* Currently required to handle SELinux runtime hook disable. */
+#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
+#define __lsm_mutable_after_init
 /*
  * Assuring the safety of deleting a security module is up to
  * the security module involved. This may entail ordering the
@@ -1996,21 +1999,9 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
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
+extern void security_delete_hooks(struct security_hook_list *hooks, int count);
 #else
-#define __lsm_ro_after_init	__ro_after_init
+#define __lsm_mutable_after_init __ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern int __init security_module_enable(const char *module);
diff --git a/security/Kconfig b/security/Kconfig
index c4302067a3ad..a3b8b1142e6f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -32,7 +32,7 @@ config SECURITY
 	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_WRITABLE_HOOKS
-	depends on SECURITY
+	depends on SECURITY && SRCU
 	bool
 	default n
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9a65eeaf7dfa..d6cca8169df0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1155,7 +1155,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				"apparmor", false);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 48620c93d697..fe4b0d9d44ce 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1363,7 +1363,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 void __init capability_add_hooks(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+				"capability", false);
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/security.c b/security/security.c
index 3cafff61b049..2ddb64864e3e 100644
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
 
@@ -36,7 +41,10 @@
 #define SECURITY_NAME_MAX	10
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+EXPORT_SYMBOL_GPL(security_hook_heads);
+
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+static DEFINE_MUTEX(security_hook_mutex);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
@@ -53,6 +61,103 @@ static void __init do_security_initcalls(void)
 	}
 }
 
+#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
+DEFINE_STATIC_SRCU(security_hook_srcu);
+static struct security_hook_list	null_hooks[SECURITY_HOOK_COUNT];
+#define HAS_FUNC(SHL, FUNC)	(SHL->hook.FUNC)
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
+/*
+ * This has to look for the null hook in the hook list by looking for
+ * a security_hook_list with a NULL callback on the callback chain.
+ *
+ * If is_mutable is set, the hook must be installed after the
+ * null hook. It is the caller's responsibility to ensure that
+ * they only load immutable hooks at boot time, and to not
+ * attempt to unload them.
+ */
+static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
+{
+	struct security_hook_list *mutable_hook;
+	union {
+		void *cb_ptr;
+		union security_list_options slo;
+	} hook_options;
+
+	hlist_for_each_entry(mutable_hook, hook->head, list) {
+		hook_options.slo = mutable_hook->hook;
+		if (hook_options.cb_ptr)
+			continue;
+
+		if (is_mutable)
+			hlist_add_behind_rcu(&hook->list, &mutable_hook->list);
+		else
+			hlist_add_before_rcu(&hook->list, &mutable_hook->list);
+		return;
+	}
+
+	panic("Unable to install hook, cannot find mutable hook\n");
+}
+
+/*
+ * The mutable hooks exist as a mechanism to transition from the read-only
+ * set of hooks to the mutable set of hooks.
+ */
+static void __init setup_mutable_hooks(void)
+{
+	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
+	struct security_hook_list *shl;
+	int i;
+
+	for (i = 0; i < SECURITY_HOOK_COUNT; i++) {
+		shl = &null_hooks[i];
+		shl->head = &list[i];
+		hlist_add_head_rcu(&shl->list, shl->head);
+	}
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
+#else
+#define HAS_FUNC(SHL, FUNC)	true
+
+static inline int lock_lsm(void)
+{
+	return 0;
+}
+
+static inline void unlock_lsm(int idx) {}
+
+static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
+{
+	WARN_ONCE(is_mutable,
+			"Mutable hook loaded with writable hooks disabled");
+	hlist_add_tail_rcu(&hook->list, hook->head);
+}
+
+static void __init setup_mutable_hooks(void) {}
+#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
+
 /**
  * security_init - initializes the security framework
  *
@@ -60,14 +165,9 @@ static void __init do_security_initcalls(void)
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
 
+	setup_mutable_hooks();
 	/*
 	 * Load minor LSMs, with the capability module always first.
 	 */
@@ -153,21 +253,26 @@ int __init security_module_enable(const char *module)
  * @hooks: the hooks to add
  * @count: the number of hooks to add
  * @lsm: the name of the security module
+ * @is_mutable: is this hook mutable after kernel init
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+void security_add_hooks(struct security_hook_list *hooks, int count,
+				char *lsm, bool is_mutable)
 {
 	int i;
 
+	mutex_lock(&security_hook_mutex);
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		security_add_hook(&hooks[i], is_mutable);
 	}
+	mutex_unlock(&security_hook_mutex);
+
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
 }
+EXPORT_SYMBOL_GPL(security_add_hooks);
 
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
@@ -197,25 +302,34 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
  *	This is a hook that returns a value.
  */
 
-#define call_void_hook(FUNC, ...)				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
+#define call_void_hook(FUNC, ...)					\
+	do {								\
+		struct security_hook_list *P;				\
+		int srcu_idx;						\
+									\
+		srcu_idx = lock_lsm();					\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
-			P->hook.FUNC(__VA_ARGS__);		\
+			if (HAS_FUNC(P, FUNC))				\
+				P->hook.FUNC(__VA_ARGS__);		\
+		unlock_lsm(srcu_idx);					\
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
+	int srcu_idx, RC = IRC;					\
+								\
+	srcu_idx = lock_lsm();					\
 	do {							\
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
-				break;				\
+			if (HAS_FUNC(P, FUNC)) {		\
+				RC = P->hook.FUNC(__VA_ARGS__);	\
+				if (RC != 0)			\
+					break;			\
+			}					\
 		}						\
 	} while (0);						\
+	unlock_lsm(srcu_idx);					\
 	RC;							\
 })
 
@@ -309,6 +423,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
 	int rc;
+	int srcu_idx;
 
 	/*
 	 * The module will respond with a positive value if
@@ -317,13 +432,17 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+		if (!HAS_FUNC(hp, vm_enough_memory))
+			continue;
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
 			break;
 		}
 	}
+	unlock_lsm(srcu_idx);
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -795,43 +914,58 @@ int security_inode_killpriv(struct dentry *dentry)
 	return call_int_hook(inode_killpriv, 0, dentry);
 }
 
-int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+int security_inode_getsecurity(struct inode *inode, const char *name,
+					void **buffer, bool alloc)
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
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
+		if (!HAS_FUNC(hp, inode_getsecurity))
+			continue;
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-	return -EOPNOTSUPP;
+	unlock_lsm(srcu_idx);
+	return rc;
 }
 
-int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
+int security_inode_setsecurity(struct inode *inode, const char *name,
+					const void *value, size_t size,
+					int flags)
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
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
+		if (!HAS_FUNC(hp, inode_setsecurity))
+			continue;
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-								flags);
+						flags);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-	return -EOPNOTSUPP;
+	unlock_lsm(srcu_idx);
+	return rc;
 }
 
+
+
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1119,14 +1253,19 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 	return call_int_hook(task_kill, 0, p, info, sig, secid);
 }
 
-int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			 unsigned long arg4, unsigned long arg5)
+int security_task_prctl(int option, unsigned long arg2,
+				 unsigned long arg3, unsigned long arg4,
+				 unsigned long arg5)
 {
 	int thisrc;
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
+	int srcu_idx;
 
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+		if (!HAS_FUNC(hp, task_prctl))
+			continue;
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
@@ -1134,6 +1273,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+	unlock_lsm(srcu_idx);
 	return rc;
 }
 
@@ -1614,11 +1754,12 @@ int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
-				       struct xfrm_policy *xp,
-				       const struct flowi *fl)
+						struct xfrm_policy *xp,
+						const struct flowi *fl)
 {
 	struct security_hook_list *hp;
 	int rc = 1;
+	int srcu_idx;
 
 	/*
 	 * Since this function is expected to return 0 or 1, the judgment
@@ -1629,11 +1770,16 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
+	srcu_idx = lock_lsm();
+	hlist_for_each_entry(hp,
+				&security_hook_heads.xfrm_state_pol_flow_match,
 				list) {
+		if (!HAS_FUNC(hp, xfrm_state_pol_flow_match))
+			continue;
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
+	unlock_lsm(srcu_idx);
 	return rc;
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8644d864e3c1..f05184a3a7a6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6393,7 +6393,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
-static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list selinux_hooks[] __lsm_mutable_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
@@ -6651,7 +6651,8 @@ static __init int selinux_init(void)
 					    0, SLAB_PANIC, NULL);
 	avc_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux",
+				IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE));
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 03fdecba93bb..7a9f1bb06c8e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4902,7 +4902,8 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack",
+				false);
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 213b8c593668..ba74fab0e9a5 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -543,7 +543,8 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo",
+				false);
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	cred->security = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..04c9aed9e951 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -480,6 +480,6 @@ static inline void yama_init_sysctl(void) { }
 void __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama", false);
 	yama_init_sysctl();
 }
-- 
2.14.1
