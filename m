Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeCGHX3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 02:23:29 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35246 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCGHXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 02:23:22 -0500
X-Google-Smtp-Source: AG47ELsJtTsnX/bvJcVnxjg0pb20rxhsAwbMx1BkFqPfMNoc7CM+MOfhdI7LR78O+zQLnrfXgTkVzQ==
Date: Wed, 7 Mar 2018 07:23:19 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, casey@schaufler-ca.com
Subject: [PATCH v4 2/3] security: Expose a mechanism to load lsm hooks
 dynamically at runtime
Message-ID: <9ffcc4fb12bcdb4785be013b51b5177069cd2686.1520407240.git.sargun@sargun.me>
References: <cover.1520407240.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520407240.git.sargun@sargun.me>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dynamic security hooks. These hooks are designed to allow
for safe runtime loading.

These hooks are only run after all built-in, and major LSMs are run.
The LSMs enabled by this feature must be minor LSMs, but they can poke
at the security blobs, as the blobs should be initialized by the time
their callback happens.

There should be little runtime performance overhead for this feature,
as it's protected behind static_keys, which are disabled by default,
and are only enabled per-hook at runtime, when a module is loaded.

Currently, the hook heads are separated for dynamic hooks, because
it is not read-only like the hooks which are loaded at runtime.

Some hooks are blacklisted, and attempting to load an LSM with any
of them in use will fail.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h |  26 +++++-
 security/Kconfig          |   9 +++
 security/inode.c          |  13 ++-
 security/security.c       | 198 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 234 insertions(+), 12 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d28c7f5b01c1..4e6351957dff 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
+#include <linux/module.h>
 
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -1968,6 +1969,9 @@ struct security_hook_list {
 	enum lsm_hook			head_idx;
 	union security_list_options	hook;
 	char				*lsm;
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	struct module			*owner;
+#endif
 } __randomize_layout;
 
 /*
@@ -1976,11 +1980,29 @@ struct security_hook_list {
  * care of the common case and reduces the amount of
  * text involved.
  */
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+#define LSM_HOOK_INIT(HEAD, HOOK)		\
+	{					\
+		.head_idx = HOOK_IDX(HEAD),	\
+		.hook = { .HEAD = HOOK },	\
+		.owner = THIS_MODULE,		\
+	}
+
+#else
 #define LSM_HOOK_INIT(HEAD, HOOK) \
 	{ .head_idx = HOOK_IDX(HEAD), .hook = { .HEAD = HOOK } }
+#endif
 
-extern char *lsm_names;
-
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+extern int security_add_dynamic_hooks(struct security_hook_list *hooks,
+				      int count, char *lsm);
+#else
+static inline int security_add_dynamic_hooks(struct security_hook_list *hooks,
+					     int count, char *lsm)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
diff --git a/security/Kconfig b/security/Kconfig
index c4302067a3ad..481b93b0d4d9 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -36,6 +36,15 @@ config SECURITY_WRITABLE_HOOKS
 	bool
 	default n
 
+config SECURITY_DYNAMIC_HOOKS
+	bool "Runtime loadable (minor) LSMs via LKMs"
+	depends on SECURITY && SRCU
+	help
+	  This enables LSMs which live in LKMs, and supports loading, and
+	  unloading them safely at runtime. These LSMs must be minor LSMs.
+	  They cannot circumvent the built-in LSMs.
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
 	help
diff --git a/security/inode.c b/security/inode.c
index 8dd9ca8848e4..89be07b044a5 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,10 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/mutex.h>
+
+extern char *lsm_names;
+extern struct mutex lsm_lock;
 
 static struct vfsmount *mount;
 static int mount_count;
@@ -312,8 +316,13 @@ static struct dentry *lsm_dentry;
 static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
 			loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, lsm_names,
-		strlen(lsm_names));
+	ssize_t ret;
+
+	mutex_lock(&lsm_lock);
+	ret = simple_read_from_buffer(buf, count, ppos, lsm_names,
+				      strlen(lsm_names));
+	mutex_unlock(&lsm_lock);
+	return ret;
 }
 
 static const struct file_operations lsm_ops = {
diff --git a/security/security.c b/security/security.c
index b9fb297b824e..492d44dd0549 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <net/flow.h>
+#include <linux/mutex.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -36,10 +37,18 @@
 #define SECURITY_NAME_MAX	10
 
 static struct list_head security_hook_heads[__MAX_LSM_HOOK] __lsm_ro_after_init;
-static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
-
 #define HOOK_HEAD(NAME)	(&security_hook_heads[HOOK_IDX(NAME)])
 
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+static struct list_head dynamic_security_hook_heads[__MAX_LSM_HOOK];
+static struct srcu_struct dynamic_hook_srcus[__MAX_LSM_HOOK];
+#define DYNAMIC_HOOK_HEAD(NAME)	(&dynamic_security_hook_heads[HOOK_IDX(NAME)])
+#define DYNAMIC_HOOK_SRCU(NAME)	(&dynamic_hook_srcus[HOOK_IDX(NAME)])
+DEFINE_STATIC_KEY_ARRAY_FALSE(dynamic_hook_keys, __MAX_LSM_HOOK);
+#endif
+static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
+
+DEFINE_MUTEX(lsm_lock);
 char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -55,6 +64,23 @@ static void __init do_security_initcalls(void)
 	}
 }
 
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+static void security_init_dynamic_hooks(void)
+{
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(dynamic_security_hook_heads); i++) {
+		INIT_LIST_HEAD(&dynamic_security_hook_heads[i]);
+		err = init_srcu_struct(&dynamic_hook_srcus[i]);
+		if (err)
+			panic("%s: Could not initialize SRCU - %d\n",
+			      __func__, err);
+	}
+}
+#else
+static inline void security_init_dynamic_hooks(void) {};
+#endif
+
 /**
  * security_init - initializes the security framework
  *
@@ -66,6 +92,7 @@ int __init security_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(security_hook_heads); i++)
 		INIT_LIST_HEAD(&security_hook_heads[i]);
+	security_init_dynamic_hooks();
 	pr_info("Security Framework initialized\n");
 
 	/*
@@ -172,6 +199,64 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		panic("%s - Cannot get early memory.\n", __func__);
 }
 
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+static int hook_allowed(enum lsm_hook hook_idx)
+{
+	switch (hook_idx) {
+	case HOOK_IDX(inode_getsecurity):
+	case HOOK_IDX(inode_setsecurity):
+	case HOOK_IDX(xfrm_state_pol_flow_match):
+		return -EPERM;
+	default:
+		return 0;
+	}
+}
+/**
+ * security_add_dynamic_hooks:
+ *	Register a dynamically loadable module's security hooks.
+ *
+ * @hooks: the hooks to add
+ * @count: the number of hooks to add
+ * @lsm: the name of the security module
+ *
+ * Returns:
+ * 0 if successful
+ * else errno, and no hooks will be installed
+ */
+int security_add_dynamic_hooks(struct security_hook_list *hooks, int count,
+				char *lsm)
+{
+	enum lsm_hook hook_idx;
+	int ret = 0, i;
+
+	for (i = 0; i < count; i++) {
+		ret = hook_allowed(hooks[i].head_idx);
+		if (ret)
+			return ret;
+	}
+
+	mutex_lock(&lsm_lock);
+	ret = lsm_append(lsm, &lsm_names);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < count; i++) {
+		WARN_ON(!try_module_get(hooks[i].owner));
+		hooks[i].lsm = lsm;
+		hook_idx = hooks[i].head_idx;
+		list_add_tail_rcu(&hooks[i].list,
+				  &dynamic_security_hook_heads[hook_idx]);
+		static_branch_enable(&dynamic_hook_keys[hook_idx]);
+	}
+
+out:
+	mutex_unlock(&lsm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(security_add_dynamic_hooks);
+#endif
+
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
 	return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
@@ -200,14 +285,69 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
  *	This is a hook that returns a value.
  */
 
-#define call_void_hook(FUNC, ...)				\
+#define call_void_hook_builtin(FUNC, ...) do {			\
+	struct security_hook_list *P;				\
+	list_for_each_entry(P, HOOK_HEAD(FUNC), list)		\
+		P->hook.FUNC(__VA_ARGS__);			\
+} while (0)
+
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+#define IS_DYNAMIC_HOOK_ENABLED(FUNC)				\
+	(static_branch_unlikely(&dynamic_hook_keys[HOOK_IDX(FUNC)]))
+
+#define call_void_hook_dynamic(FUNC, ...) ({			\
+	struct security_hook_list *P;				\
+	int idx;						\
+								\
+	idx = srcu_read_lock(DYNAMIC_HOOK_SRCU(FUNC));		\
+	list_for_each_entry_rcu(P,				\
+				DYNAMIC_HOOK_HEAD(FUNC),	\
+				list) {				\
+		P->hook.FUNC(__VA_ARGS__);			\
+	}							\
+	srcu_read_unlock(DYNAMIC_HOOK_SRCU(FUNC), idx);		\
+})
+
+#define call_void_hook(FUNC, ...)	\
+	do {				\
+		call_void_hook_builtin(FUNC, __VA_ARGS__);	\
+		if (!IS_DYNAMIC_HOOK_ENABLED(FUNC))		\
+			break;					\
+		call_void_hook_dynamic(FUNC, __VA_ARGS__);	\
+	} while (0)
+
+#define call_int_hook(FUNC, IRC, ...) ({			\
+	bool continue_iteration = true;				\
+	int RC = IRC, idx;					\
 	do {							\
 		struct security_hook_list *P;			\
 								\
-		list_for_each_entry(P, HOOK_HEAD(FUNC), list)	\
-			P->hook.FUNC(__VA_ARGS__);		\
-	} while (0)
+		list_for_each_entry(P, HOOK_HEAD(FUNC), list) { \
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (RC != 0) {				\
+				continue_iteration = false;	\
+				break;				\
+			}					\
+		}						\
+		if (!IS_DYNAMIC_HOOK_ENABLED(FUNC))		\
+			break;					\
+		if (!continue_iteration)			\
+			break;					\
+		idx = srcu_read_lock(DYNAMIC_HOOK_SRCU(FUNC));	\
+		list_for_each_entry_rcu(P,			\
+					DYNAMIC_HOOK_HEAD(FUNC), \
+					list) {			\
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (RC != 0)				\
+				break;				\
+		}						\
+		srcu_read_unlock(DYNAMIC_HOOK_SRCU(FUNC), idx);	\
+	} while (0);						\
+	RC;							\
+})
 
+#else
+#define call_void_hook	call_void_hook_builtin
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	do {							\
@@ -221,6 +361,7 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 	} while (0);						\
 	RC;							\
 })
+#endif
 
 /* Security operations */
 
@@ -312,6 +453,9 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
 	int rc;
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	int idx;
+#endif
 
 	/*
 	 * The module will respond with a positive value if
@@ -324,9 +468,25 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
-			break;
+			goto out;
 		}
 	}
+
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	if (!IS_DYNAMIC_HOOK_ENABLED(vm_enough_memory))
+		goto out;
+	idx = srcu_read_lock(DYNAMIC_HOOK_SRCU(vm_enough_memory));
+	list_for_each_entry_rcu(hp, DYNAMIC_HOOK_HEAD(vm_enough_memory),
+				list) {
+		rc = hp->hook.vm_enough_memory(mm, pages);
+		if (rc <= 0) {
+			cap_sys_admin = 0;
+			goto out;
+		}
+	}
+	srcu_read_unlock(DYNAMIC_HOOK_SRCU(vm_enough_memory), idx);
+#endif
+out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -1128,15 +1288,36 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	int thisrc;
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	int idx;
+#endif
 
 	list_for_each_entry(hp, HOOK_HEAD(task_prctl), list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
 			if (thisrc != 0)
-				break;
+				goto out;
 		}
 	}
+
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	if (!IS_DYNAMIC_HOOK_ENABLED(task_prctl))
+		goto out;
+	idx = srcu_read_lock(DYNAMIC_HOOK_SRCU(task_prctl));
+	list_for_each_entry_rcu(hp, DYNAMIC_HOOK_HEAD(task_prctl),
+				list) {
+		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+		if (thisrc != -ENOSYS) {
+			rc = thisrc;
+			if (thisrc != 0)
+				goto out_unlock;
+		}
+	}
+out_unlock:
+	srcu_read_unlock(DYNAMIC_HOOK_SRCU(task_prctl), idx);
+#endif
+out:
 	return rc;
 }
 
@@ -1636,6 +1817,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
+
 	return rc;
 }
 
-- 
2.14.1
