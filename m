Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeDIDjP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 23:39:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:46429 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeDIDjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 23:39:11 -0400
Message-Id: <201804090338.w393crfv005435@www262.sakura.ne.jp>
Subject: Re: [PATCH v5 1/1] security: Add mechanism to safely (un)load LSMs after
 boot time
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: Sargun Dhillon <sargun@sargun.me>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com, jmorris@namei.org, oiaohm@gmail.com,
        igor.stoppa@huawei.com
MIME-Version: 1.0
Date: Mon, 09 Apr 2018 12:38:53 +0900
References: <20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested changes on top of your patch:

  Replace "struct hlist_head *head" in "struct security_hook_list" with
  "const unsigned int offset" because there is no need to initialize with
  address of the immutable/mutable chains.

  Remove LSM_HOOK_INIT_MUTABLE() by embedding just offset (in bytes) from
  head of "struct security_hook_heads" into "struct security_hook_list"->offset.

  Make "struct security_hook_heads security_hook_heads" and
  "struct security_hook_heads security_hook_heads_mutable" local variables.

  Rename "struct security_hook_heads security_hook_heads" to
  "struct security_hook_heads security_mutable_hook_heads" and mark it as
  __ro_after_init.

  Add the fourth argument to security_add_hooks() which specifies to which
  chain (security_{mutable|immutable}_hook_heads) to connect.

  Make all built-in LSM modules (except SELinux if
  CONFIG_SECURITY_SELINUX_DISABLE=y) be connected to
  security_immutable_hook_heads.

  Rename __lsm_ro_after_init to __selinux_ro_after_init which is local to
  SELinux.

  Mark "struct security_hook_list"->hook const because it won't change.

  Mark "struct security_hook_list"->lsm const because none of
  security_add_hooks() callers are ready to modify the third argument.

  Remove SECURITY_HOOK_COUNT and "struct security_hook_list"->owner and
  the exception in randomize_layout_plugin.c because preventing module
  unloading won't work as expected.

---
 include/linux/lsm_hooks.h                     |  23 +-
 scripts/gcc-plugins/randomize_layout_plugin.c |   2 -
 security/apparmor/lsm.c                       |   4 +-
 security/commoncap.c                          |   4 +-
 security/loadpin/loadpin.c                    |   5 +-
 security/security.c                           |  52 +--
 security/selinux/hooks.c                      | 437 +++++++++++++-------------
 security/smack/smack_lsm.c                    |   5 +-
 security/tomoyo/tomoyo.c                      |   5 +-
 security/yama/yama_lsm.c                      |   4 +-
 10 files changed, 265 insertions(+), 276 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9cd7527..13d9d3a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2006,11 +2006,10 @@ struct security_hook_heads {
  * For use with generic list macros for common operations.
  */
 struct security_hook_list {
-	struct hlist_node		list;
-	struct hlist_head		*head;
-	union security_list_options	hook;
-	char				*lsm;
-	struct module			*owner;
+	struct hlist_node			list;
+	const unsigned int			offset;
+	const union security_list_options	hook;
+	const char				*lsm;
 } __randomize_layout;
 
 /*
@@ -2021,26 +2020,16 @@ struct security_hook_list {
  */
 #define LSM_HOOK_INIT(HEAD, HOOK) \
 	{						\
-		.head = &security_hook_heads.HEAD,	\
+		.offset = offsetof(struct security_hook_heads, HEAD), \
 		.hook = { .HEAD = HOOK },		\
-		.owner = THIS_MODULE,			\
 	}
-extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+			       const char *lsm, const bool dynamic);
 
-#define __lsm_ro_after_init	__ro_after_init
 /* Used to facilitate runtime hook unloading, and loading */
 #ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-#define LSM_HOOK_INIT_MUTABLE(HEAD, HOOK) \
-	{							\
-		.head = &security_hook_heads_mutable.HEAD,	\
-		.hook = { .HEAD = HOOK },			\
-		.owner = THIS_MODULE,				\
-	}
-extern struct security_hook_heads security_hook_heads_mutable;
 /*
  * Assuring the safety of deleting a security module is up to
  * the security module involved. This may entail ordering the
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 6d5bbd3..d941389 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -52,8 +52,6 @@ struct whitelist_entry {
 	{ "net/unix/af_unix.c", "unix_skb_parms", "char" },
 	/* big_key payload.data struct splashing */
 	{ "security/keys/big_key.c", "path", "void *" },
-	/* walk struct security_hook_heads as an array of struct hlist_head */
-	{ "security/security.c", "hlist_head", "security_hook_heads" },
 	{ }
 };
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index cf00c85..0eb4e1b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1118,7 +1118,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 		ctx->label = aa_get_current_label();
 }
 
-static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
 	LSM_HOOK_INIT(capget, apparmor_capget),
@@ -1563,7 +1563,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+			   "apparmor", false);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 48620c9..757a811 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
-struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
+struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
 	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
@@ -1363,7 +1363,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 void __init capability_add_hooks(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   "capability", false);
 }
 
 #endif /* CONFIG_SECURITY */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5fa1912..29306d8 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -173,7 +173,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	return 0;
 }
 
-static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list loadpin_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
@@ -181,7 +181,8 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 void __init loadpin_add_hooks(void)
 {
 	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin",
+			   false);
 }
 
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
diff --git a/security/security.c b/security/security.c
index ca93ed4..61117ee 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,15 +32,12 @@
 #include <linux/srcu.h>
 #include <linux/mutex.h>
 
-#define SECURITY_HOOK_COUNT \
-	(sizeof(security_hook_heads) / sizeof(struct hlist_head))
-
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+static struct security_hook_heads security_immutable_hook_heads __ro_after_init;
 
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 static DEFINE_MUTEX(security_hook_mutex);
@@ -60,7 +57,8 @@ static void __init do_security_initcalls(void)
 	}
 }
 #define FOR_EACH_SECURITY_HOOK(ITERATOR, HEAD) \
-	hlist_for_each_entry(ITERATOR, &security_hook_heads.HEAD, list)
+	hlist_for_each_entry(ITERATOR, &security_immutable_hook_heads.HEAD, \
+			     list)
 
 #ifdef CONFIG_SECURITY_WRITABLE_HOOKS
 /*
@@ -68,8 +66,7 @@ static void __init do_security_initcalls(void)
  * security_hook_heads. These security_hook_heads will only be executed
  * if all immutable hooks are executed successfully.
  */
-struct security_hook_heads security_hook_heads_mutable;
-EXPORT_SYMBOL_GPL(security_hook_heads_mutable);
+static struct security_hook_heads security_mutable_hook_heads;
 DEFINE_STATIC_SRCU(security_hook_srcu);
 
 /*
@@ -83,21 +80,11 @@ static void __init do_security_initcalls(void)
 
 static void lock_existing_hooks(void)
 {
-	struct hlist_head *list = (struct hlist_head *)
-					&security_hook_heads_mutable;
-	struct security_hook_list *P;
-	int i;
-
 	/*
-	 * Prevent module unloading while we're doing this
-	 * try_module_get may fail (safely), if the module
-	 * is already unloading -- allow that.
+	 * TODO: try_module_get() does not prevent forced module unloading
+	 * (CONFIG_MODULE_FORCE_UNLOAD=y). We need to add a hook into
+	 * delete_module() and check if it is an LSM module.
 	 */
-	mutex_lock(&module_mutex);
-	for (i = 0; i < SECURITY_HOOK_COUNT; i++)
-		hlist_for_each_entry(P, &list[i], list)
-			try_module_get(P->owner);
-	mutex_unlock(&module_mutex);
 }
 
 static int allow_unload_hooks_set(const char *val,
@@ -171,7 +158,7 @@ void security_delete_hooks(struct security_hook_list *hooks, int count)
 EXPORT_SYMBOL_GPL(security_delete_hooks);
 
 #define FOR_EACH_SECURITY_HOOK_MUTABLE(ITERATOR, HEAD) \
-	hlist_for_each_entry(ITERATOR, &security_hook_heads_mutable.HEAD, list)
+	hlist_for_each_entry(ITERATOR, &security_mutable_hook_heads.HEAD, list)
 #else
 static inline int lock_lsm(void)
 {
@@ -232,7 +219,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
 	return !strcmp(last, lsm);
 }
 
-static int lsm_append(char *new, char **result)
+static int lsm_append(const char *new, char **result)
 {
 	char *cp;
 
@@ -279,19 +266,32 @@ int __init security_module_enable(const char *module)
  * @hooks: the hooks to add
  * @count: the number of hooks to add
  * @lsm: the name of the security module
+ * @dynamic: True if dynamic registration and/or unregistration is needed.
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void security_add_hooks(struct security_hook_list *hooks, int count, char *lsm)
+void security_add_hooks(struct security_hook_list *hooks, int count,
+			const char *lsm, const bool dynamic)
 {
 	int i;
 
 	mutex_lock(&security_hook_mutex);
 	for (i = 0; i < count; i++) {
+		unsigned long offset = hooks[i].offset;
+		struct hlist_head *head;
+
+		BUG_ON(offset > sizeof(struct security_hook_heads)
+		       - sizeof(struct hlist_head));
+		if (!IS_ENABLED(CONFIG_SECURITY_WRITABLE_HOOKS) || !dynamic)
+			head = (struct hlist_head *)
+				(((char *) &security_immutable_hook_heads)
+				 + offset);
+		else
+			head = (struct hlist_head *)
+				(((char *) &security_mutable_hook_heads)
+				 + offset);
 		hooks[i].lsm = lsm;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-		if (!allow_unload_hooks)
-			WARN_ON(!try_module_get(hooks[i].owner));
+		hlist_add_tail_rcu(&hooks[i].list, head);
 	}
 	mutex_unlock(&security_hook_mutex);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 95239a2..109d3d0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6851,244 +6851,242 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 #define __selinux_ro_after_init
-#define SELINUX_HOOK_INIT LSM_HOOK_INIT_MUTABLE
 #else
-#define __selinux_ro_after_init	__lsm_ro_after_init
-#define SELINUX_HOOK_INIT LSM_HOOK_INIT 
+#define __selinux_ro_after_init	__ro_after_init
 #endif
 
-static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
-	SELINUX_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
-	SELINUX_HOOK_INIT(binder_transaction, selinux_binder_transaction),
-	SELINUX_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
-	SELINUX_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
-
-	SELINUX_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
-	SELINUX_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
-	SELINUX_HOOK_INIT(capget, selinux_capget),
-	SELINUX_HOOK_INIT(capset, selinux_capset),
-	SELINUX_HOOK_INIT(capable, selinux_capable),
-	SELINUX_HOOK_INIT(quotactl, selinux_quotactl),
-	SELINUX_HOOK_INIT(quota_on, selinux_quota_on),
-	SELINUX_HOOK_INIT(syslog, selinux_syslog),
-	SELINUX_HOOK_INIT(vm_enough_memory, selinux_vm_enough_memory),
-
-	SELINUX_HOOK_INIT(netlink_send, selinux_netlink_send),
-
-	SELINUX_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
-	SELINUX_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
-	SELINUX_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
-
-	SELINUX_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
-	SELINUX_HOOK_INIT(sb_free_security, selinux_sb_free_security),
-	SELINUX_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),
-	SELINUX_HOOK_INIT(sb_remount, selinux_sb_remount),
-	SELINUX_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
-	SELINUX_HOOK_INIT(sb_show_options, selinux_sb_show_options),
-	SELINUX_HOOK_INIT(sb_statfs, selinux_sb_statfs),
-	SELINUX_HOOK_INIT(sb_mount, selinux_mount),
-	SELINUX_HOOK_INIT(sb_umount, selinux_umount),
-	SELINUX_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
-	SELINUX_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
-	SELINUX_HOOK_INIT(sb_parse_opts_str, selinux_parse_opts_str),
-
-	SELINUX_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
-	SELINUX_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
-
-	SELINUX_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
-	SELINUX_HOOK_INIT(inode_free_security, selinux_inode_free_security),
-	SELINUX_HOOK_INIT(inode_init_security, selinux_inode_init_security),
-	SELINUX_HOOK_INIT(inode_create, selinux_inode_create),
-	SELINUX_HOOK_INIT(inode_link, selinux_inode_link),
-	SELINUX_HOOK_INIT(inode_unlink, selinux_inode_unlink),
-	SELINUX_HOOK_INIT(inode_symlink, selinux_inode_symlink),
-	SELINUX_HOOK_INIT(inode_mkdir, selinux_inode_mkdir),
-	SELINUX_HOOK_INIT(inode_rmdir, selinux_inode_rmdir),
-	SELINUX_HOOK_INIT(inode_mknod, selinux_inode_mknod),
-	SELINUX_HOOK_INIT(inode_rename, selinux_inode_rename),
-	SELINUX_HOOK_INIT(inode_readlink, selinux_inode_readlink),
-	SELINUX_HOOK_INIT(inode_follow_link, selinux_inode_follow_link),
-	SELINUX_HOOK_INIT(inode_permission, selinux_inode_permission),
-	SELINUX_HOOK_INIT(inode_setattr, selinux_inode_setattr),
-	SELINUX_HOOK_INIT(inode_getattr, selinux_inode_getattr),
-	SELINUX_HOOK_INIT(inode_setxattr, selinux_inode_setxattr),
-	SELINUX_HOOK_INIT(inode_post_setxattr, selinux_inode_post_setxattr),
-	SELINUX_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
-	SELINUX_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
-	SELINUX_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
-	SELINUX_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
-	SELINUX_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
-	SELINUX_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
-	SELINUX_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
-	SELINUX_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
-	SELINUX_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
-
-	SELINUX_HOOK_INIT(file_permission, selinux_file_permission),
-	SELINUX_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
-	SELINUX_HOOK_INIT(file_free_security, selinux_file_free_security),
-	SELINUX_HOOK_INIT(file_ioctl, selinux_file_ioctl),
-	SELINUX_HOOK_INIT(mmap_file, selinux_mmap_file),
-	SELINUX_HOOK_INIT(mmap_addr, selinux_mmap_addr),
-	SELINUX_HOOK_INIT(file_mprotect, selinux_file_mprotect),
-	SELINUX_HOOK_INIT(file_lock, selinux_file_lock),
-	SELINUX_HOOK_INIT(file_fcntl, selinux_file_fcntl),
-	SELINUX_HOOK_INIT(file_set_fowner, selinux_file_set_fowner),
-	SELINUX_HOOK_INIT(file_send_sigiotask, selinux_file_send_sigiotask),
-	SELINUX_HOOK_INIT(file_receive, selinux_file_receive),
-
-	SELINUX_HOOK_INIT(file_open, selinux_file_open),
-
-	SELINUX_HOOK_INIT(task_alloc, selinux_task_alloc),
-	SELINUX_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
-	SELINUX_HOOK_INIT(cred_free, selinux_cred_free),
-	SELINUX_HOOK_INIT(cred_prepare, selinux_cred_prepare),
-	SELINUX_HOOK_INIT(cred_transfer, selinux_cred_transfer),
-	SELINUX_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
-	SELINUX_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
-	SELINUX_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
-	SELINUX_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
-	SELINUX_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
-	SELINUX_HOOK_INIT(task_setpgid, selinux_task_setpgid),
-	SELINUX_HOOK_INIT(task_getpgid, selinux_task_getpgid),
-	SELINUX_HOOK_INIT(task_getsid, selinux_task_getsid),
-	SELINUX_HOOK_INIT(task_getsecid, selinux_task_getsecid),
-	SELINUX_HOOK_INIT(task_setnice, selinux_task_setnice),
-	SELINUX_HOOK_INIT(task_setioprio, selinux_task_setioprio),
-	SELINUX_HOOK_INIT(task_getioprio, selinux_task_getioprio),
-	SELINUX_HOOK_INIT(task_prlimit, selinux_task_prlimit),
-	SELINUX_HOOK_INIT(task_setrlimit, selinux_task_setrlimit),
-	SELINUX_HOOK_INIT(task_setscheduler, selinux_task_setscheduler),
-	SELINUX_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
-	SELINUX_HOOK_INIT(task_movememory, selinux_task_movememory),
-	SELINUX_HOOK_INIT(task_kill, selinux_task_kill),
-	SELINUX_HOOK_INIT(task_to_inode, selinux_task_to_inode),
-
-	SELINUX_HOOK_INIT(ipc_permission, selinux_ipc_permission),
-	SELINUX_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
-
-	SELINUX_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
-	SELINUX_HOOK_INIT(msg_msg_free_security, selinux_msg_msg_free_security),
-
-	SELINUX_HOOK_INIT(msg_queue_alloc_security,
+static struct security_hook_list selinux_hooks[] __selinux_ro_after_init = {
+	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
+	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
+	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
+	LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
+
+	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
+	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(capget, selinux_capget),
+	LSM_HOOK_INIT(capset, selinux_capset),
+	LSM_HOOK_INIT(capable, selinux_capable),
+	LSM_HOOK_INIT(quotactl, selinux_quotactl),
+	LSM_HOOK_INIT(quota_on, selinux_quota_on),
+	LSM_HOOK_INIT(syslog, selinux_syslog),
+	LSM_HOOK_INIT(vm_enough_memory, selinux_vm_enough_memory),
+
+	LSM_HOOK_INIT(netlink_send, selinux_netlink_send),
+
+	LSM_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
+	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
+	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
+
+	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
+	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
+	LSM_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),
+	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
+	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
+	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
+	LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
+	LSM_HOOK_INIT(sb_mount, selinux_mount),
+	LSM_HOOK_INIT(sb_umount, selinux_umount),
+	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
+	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
+	LSM_HOOK_INIT(sb_parse_opts_str, selinux_parse_opts_str),
+
+	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
+	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
+
+	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
+	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
+	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_create, selinux_inode_create),
+	LSM_HOOK_INIT(inode_link, selinux_inode_link),
+	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
+	LSM_HOOK_INIT(inode_symlink, selinux_inode_symlink),
+	LSM_HOOK_INIT(inode_mkdir, selinux_inode_mkdir),
+	LSM_HOOK_INIT(inode_rmdir, selinux_inode_rmdir),
+	LSM_HOOK_INIT(inode_mknod, selinux_inode_mknod),
+	LSM_HOOK_INIT(inode_rename, selinux_inode_rename),
+	LSM_HOOK_INIT(inode_readlink, selinux_inode_readlink),
+	LSM_HOOK_INIT(inode_follow_link, selinux_inode_follow_link),
+	LSM_HOOK_INIT(inode_permission, selinux_inode_permission),
+	LSM_HOOK_INIT(inode_setattr, selinux_inode_setattr),
+	LSM_HOOK_INIT(inode_getattr, selinux_inode_getattr),
+	LSM_HOOK_INIT(inode_setxattr, selinux_inode_setxattr),
+	LSM_HOOK_INIT(inode_post_setxattr, selinux_inode_post_setxattr),
+	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
+	LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
+	LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
+	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
+	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
+	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),
+	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
+	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
+	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
+
+	LSM_HOOK_INIT(file_permission, selinux_file_permission),
+	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
+	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
+	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
+	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
+	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
+	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
+	LSM_HOOK_INIT(file_lock, selinux_file_lock),
+	LSM_HOOK_INIT(file_fcntl, selinux_file_fcntl),
+	LSM_HOOK_INIT(file_set_fowner, selinux_file_set_fowner),
+	LSM_HOOK_INIT(file_send_sigiotask, selinux_file_send_sigiotask),
+	LSM_HOOK_INIT(file_receive, selinux_file_receive),
+
+	LSM_HOOK_INIT(file_open, selinux_file_open),
+
+	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
+	LSM_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
+	LSM_HOOK_INIT(cred_free, selinux_cred_free),
+	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
+	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
+	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
+	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
+	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
+	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
+	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
+	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
+	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
+	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
+	LSM_HOOK_INIT(task_getsecid, selinux_task_getsecid),
+	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
+	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
+	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
+	LSM_HOOK_INIT(task_prlimit, selinux_task_prlimit),
+	LSM_HOOK_INIT(task_setrlimit, selinux_task_setrlimit),
+	LSM_HOOK_INIT(task_setscheduler, selinux_task_setscheduler),
+	LSM_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
+	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
+	LSM_HOOK_INIT(task_kill, selinux_task_kill),
+	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
+
+	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
+	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
+
+	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
+	LSM_HOOK_INIT(msg_msg_free_security, selinux_msg_msg_free_security),
+
+	LSM_HOOK_INIT(msg_queue_alloc_security,
 			selinux_msg_queue_alloc_security),
-	SELINUX_HOOK_INIT(msg_queue_free_security, selinux_msg_queue_free_security),
-	SELINUX_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
-	SELINUX_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
-	SELINUX_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
-	SELINUX_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
-
-	SELINUX_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
-	SELINUX_HOOK_INIT(shm_free_security, selinux_shm_free_security),
-	SELINUX_HOOK_INIT(shm_associate, selinux_shm_associate),
-	SELINUX_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
-	SELINUX_HOOK_INIT(shm_shmat, selinux_shm_shmat),
-
-	SELINUX_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
-	SELINUX_HOOK_INIT(sem_free_security, selinux_sem_free_security),
-	SELINUX_HOOK_INIT(sem_associate, selinux_sem_associate),
-	SELINUX_HOOK_INIT(sem_semctl, selinux_sem_semctl),
-	SELINUX_HOOK_INIT(sem_semop, selinux_sem_semop),
-
-	SELINUX_HOOK_INIT(d_instantiate, selinux_d_instantiate),
-
-	SELINUX_HOOK_INIT(getprocattr, selinux_getprocattr),
-	SELINUX_HOOK_INIT(setprocattr, selinux_setprocattr),
-
-	SELINUX_HOOK_INIT(ismaclabel, selinux_ismaclabel),
-	SELINUX_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
-	SELINUX_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
-	SELINUX_HOOK_INIT(release_secctx, selinux_release_secctx),
-	SELINUX_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
-	SELINUX_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
-	SELINUX_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
-	SELINUX_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
-
-	SELINUX_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
-	SELINUX_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
-
-	SELINUX_HOOK_INIT(socket_create, selinux_socket_create),
-	SELINUX_HOOK_INIT(socket_post_create, selinux_socket_post_create),
-	SELINUX_HOOK_INIT(socket_bind, selinux_socket_bind),
-	SELINUX_HOOK_INIT(socket_connect, selinux_socket_connect),
-	SELINUX_HOOK_INIT(socket_listen, selinux_socket_listen),
-	SELINUX_HOOK_INIT(socket_accept, selinux_socket_accept),
-	SELINUX_HOOK_INIT(socket_sendmsg, selinux_socket_sendmsg),
-	SELINUX_HOOK_INIT(socket_recvmsg, selinux_socket_recvmsg),
-	SELINUX_HOOK_INIT(socket_getsockname, selinux_socket_getsockname),
-	SELINUX_HOOK_INIT(socket_getpeername, selinux_socket_getpeername),
-	SELINUX_HOOK_INIT(socket_getsockopt, selinux_socket_getsockopt),
-	SELINUX_HOOK_INIT(socket_setsockopt, selinux_socket_setsockopt),
-	SELINUX_HOOK_INIT(socket_shutdown, selinux_socket_shutdown),
-	SELINUX_HOOK_INIT(socket_sock_rcv_skb, selinux_socket_sock_rcv_skb),
-	SELINUX_HOOK_INIT(socket_getpeersec_stream,
+	LSM_HOOK_INIT(msg_queue_free_security, selinux_msg_queue_free_security),
+	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
+	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
+	LSM_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
+	LSM_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
+
+	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
+	LSM_HOOK_INIT(shm_free_security, selinux_shm_free_security),
+	LSM_HOOK_INIT(shm_associate, selinux_shm_associate),
+	LSM_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
+	LSM_HOOK_INIT(shm_shmat, selinux_shm_shmat),
+
+	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
+	LSM_HOOK_INIT(sem_free_security, selinux_sem_free_security),
+	LSM_HOOK_INIT(sem_associate, selinux_sem_associate),
+	LSM_HOOK_INIT(sem_semctl, selinux_sem_semctl),
+	LSM_HOOK_INIT(sem_semop, selinux_sem_semop),
+
+	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
+
+	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
+	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
+
+	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
+	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
+	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
+	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
+	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
+	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
+	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
+
+	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
+	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
+
+	LSM_HOOK_INIT(socket_create, selinux_socket_create),
+	LSM_HOOK_INIT(socket_post_create, selinux_socket_post_create),
+	LSM_HOOK_INIT(socket_bind, selinux_socket_bind),
+	LSM_HOOK_INIT(socket_connect, selinux_socket_connect),
+	LSM_HOOK_INIT(socket_listen, selinux_socket_listen),
+	LSM_HOOK_INIT(socket_accept, selinux_socket_accept),
+	LSM_HOOK_INIT(socket_sendmsg, selinux_socket_sendmsg),
+	LSM_HOOK_INIT(socket_recvmsg, selinux_socket_recvmsg),
+	LSM_HOOK_INIT(socket_getsockname, selinux_socket_getsockname),
+	LSM_HOOK_INIT(socket_getpeername, selinux_socket_getpeername),
+	LSM_HOOK_INIT(socket_getsockopt, selinux_socket_getsockopt),
+	LSM_HOOK_INIT(socket_setsockopt, selinux_socket_setsockopt),
+	LSM_HOOK_INIT(socket_shutdown, selinux_socket_shutdown),
+	LSM_HOOK_INIT(socket_sock_rcv_skb, selinux_socket_sock_rcv_skb),
+	LSM_HOOK_INIT(socket_getpeersec_stream,
 			selinux_socket_getpeersec_stream),
-	SELINUX_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dgram),
-	SELINUX_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
-	SELINUX_HOOK_INIT(sk_free_security, selinux_sk_free_security),
-	SELINUX_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
-	SELINUX_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
-	SELINUX_HOOK_INIT(sock_graft, selinux_sock_graft),
-	SELINUX_HOOK_INIT(sctp_assoc_request, selinux_sctp_assoc_request),
-	SELINUX_HOOK_INIT(sctp_sk_clone, selinux_sctp_sk_clone),
-	SELINUX_HOOK_INIT(sctp_bind_connect, selinux_sctp_bind_connect),
-	SELINUX_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
-	SELINUX_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
-	SELINUX_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
-	SELINUX_HOOK_INIT(secmark_relabel_packet, selinux_secmark_relabel_packet),
-	SELINUX_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
-	SELINUX_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
-	SELINUX_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
-	SELINUX_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
-	SELINUX_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
-	SELINUX_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
-	SELINUX_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
-	SELINUX_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
-	SELINUX_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+	LSM_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dgram),
+	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
+	LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
+	LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
+	LSM_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
+	LSM_HOOK_INIT(sock_graft, selinux_sock_graft),
+	LSM_HOOK_INIT(sctp_assoc_request, selinux_sctp_assoc_request),
+	LSM_HOOK_INIT(sctp_sk_clone, selinux_sctp_sk_clone),
+	LSM_HOOK_INIT(sctp_bind_connect, selinux_sctp_bind_connect),
+	LSM_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
+	LSM_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
+	LSM_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
+	LSM_HOOK_INIT(secmark_relabel_packet, selinux_secmark_relabel_packet),
+	LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
+	LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
+	LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
+	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
+	LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
+	LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
+	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
+	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
+	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
 #ifdef CONFIG_SECURITY_INFINIBAND
-	SELINUX_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
-	SELINUX_HOOK_INIT(ib_endport_manage_subnet,
+	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
+	LSM_HOOK_INIT(ib_endport_manage_subnet,
 		      selinux_ib_endport_manage_subnet),
-	SELINUX_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
-	SELINUX_HOOK_INIT(ib_free_security, selinux_ib_free_security),
+	LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
+	LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
 #endif
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-	SELINUX_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
-	SELINUX_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
-	SELINUX_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
-	SELINUX_HOOK_INIT(xfrm_policy_delete_security, selinux_xfrm_policy_delete),
-	SELINUX_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
-	SELINUX_HOOK_INIT(xfrm_state_alloc_acquire,
+	LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
+	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
+	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
+	LSM_HOOK_INIT(xfrm_policy_delete_security, selinux_xfrm_policy_delete),
+	LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
+	LSM_HOOK_INIT(xfrm_state_alloc_acquire,
 			selinux_xfrm_state_alloc_acquire),
-	SELINUX_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
-	SELINUX_HOOK_INIT(xfrm_state_delete_security, selinux_xfrm_state_delete),
-	SELINUX_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
-	SELINUX_HOOK_INIT(xfrm_state_pol_flow_match,
+	LSM_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
+	LSM_HOOK_INIT(xfrm_state_delete_security, selinux_xfrm_state_delete),
+	LSM_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
+	LSM_HOOK_INIT(xfrm_state_pol_flow_match,
 			selinux_xfrm_state_pol_flow_match),
-	SELINUX_HOOK_INIT(xfrm_decode_session, selinux_xfrm_decode_session),
+	LSM_HOOK_INIT(xfrm_decode_session, selinux_xfrm_decode_session),
 #endif
 
 #ifdef CONFIG_KEYS
-	SELINUX_HOOK_INIT(key_alloc, selinux_key_alloc),
-	SELINUX_HOOK_INIT(key_free, selinux_key_free),
-	SELINUX_HOOK_INIT(key_permission, selinux_key_permission),
-	SELINUX_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
+	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
+	LSM_HOOK_INIT(key_free, selinux_key_free),
+	LSM_HOOK_INIT(key_permission, selinux_key_permission),
+	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
 #endif
 
 #ifdef CONFIG_AUDIT
-	SELINUX_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
-	SELINUX_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
-	SELINUX_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
-	SELINUX_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
+	LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
+	LSM_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
+	LSM_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
+	LSM_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
 #endif
 
 #ifdef CONFIG_BPF_SYSCALL
-	SELINUX_HOOK_INIT(bpf, selinux_bpf),
-	SELINUX_HOOK_INIT(bpf_map, selinux_bpf_map),
-	SELINUX_HOOK_INIT(bpf_prog, selinux_bpf_prog),
-	SELINUX_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
-	SELINUX_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
-	SELINUX_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
-	SELINUX_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
+	LSM_HOOK_INIT(bpf, selinux_bpf),
+	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
+	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
+	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
+	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
+	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
+	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
 };
 
@@ -7131,7 +7129,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux",
+			   IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE));
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0b41483..02b8158 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4623,7 +4623,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	return 0;
 }
 
-static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
@@ -4842,7 +4842,8 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack",
+			   false);
 
 	return 0;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 213b8c5..3b8ee5d 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -497,7 +497,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
  */
-static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_alloc_blank, tomoyo_cred_alloc_blank),
 	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, tomoyo_cred_transfer),
@@ -543,7 +543,8 @@ static int __init tomoyo_init(void)
 	if (!security_module_enable("tomoyo"))
 		return 0;
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo",
+			   false);
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
 	cred->security = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a..21b64a6 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -423,7 +423,7 @@ int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
-static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list yama_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
 	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
@@ -480,6 +480,6 @@ static inline void yama_init_sysctl(void) { }
 void __init yama_add_hooks(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama", false);
 	yama_init_sysctl();
 }
-- 
1.8.3.1
