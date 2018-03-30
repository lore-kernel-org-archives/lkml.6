Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeC3Cdj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 22:33:39 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34458 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeC3Cdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 22:33:36 -0400
X-Google-Smtp-Source: AIpwx4+5/9R/5Vze/jcm2AFr3PgJXz1lrCTi/biF42UR2Xo17ZD12KcXxdc/Kd/mIal3WxCDfWsiAw==
Date: Fri, 30 Mar 2018 02:33:33 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, jmorris@namei.org, sds@tycho.nsa.gov,
        paul@paul-moore.com, plautrba@redhat.com
Subject: Re: [PATCH v3 1/1] security: Add mechanism to safely (un)load LSMs
 after boot time
Message-ID: <20180330023331.GA10833@ircssh-2.c.rugged-nimbus-611.internal>
References: <cover.1522357211.git.sargun@sargun.me>
 <5240a81494bbe5be5651379cd9828bda34d764e2.1522357211.git.sargun@sargun.me>
 <3292bbb3-7c9d-f18d-05f3-9b69b3cac922@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3292bbb3-7c9d-f18d-05f3-9b69b3cac922@schaufler-ca.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 02:37:10PM -0700, Casey Schaufler wrote:
> On 3/29/2018 2:14 PM, Sargun Dhillon wrote:
> > This patch introduces a mechanism to add mutable hooks and immutable
> > hooks to the callback chain. It adds an intermediary item to the
> > chain which separates mutable and immutable hooks. Immutable hooks
> > are then marked as read-only, as well as the hook heads. This does
> > not preclude some hooks being able to be mutated (removed).
> >
> > It also wraps the hook unloading, and execution with an SRCU. One
> > SRCU is used across all hooks, as the SRCU struct can be memory
> > intensive, and hook execution time in general should be relatively
> > short.
> >
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > ---
> >  include/linux/lsm_hooks.h  |  23 ++---
> >  security/Kconfig           |   2 +-
> >  security/apparmor/lsm.c    |   2 +-
> >  security/commoncap.c       |   2 +-
> >  security/security.c        | 210 ++++++++++++++++++++++++++++++++++++++-------
> >  security/selinux/hooks.c   |   5 +-
> >  security/smack/smack_lsm.c |   3 +-
> >  security/tomoyo/tomoyo.c   |   3 +-
> >  security/yama/yama_lsm.c   |   2 +-
> >  9 files changed, 196 insertions(+), 56 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 09bc60fb35f1..689e5e72fb38 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -1981,9 +1981,12 @@ extern struct security_hook_heads security_hook_heads;
> >  extern char *lsm_names;
> >  
> >  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> > -				char *lsm);
> > +				char *lsm, bool is_mutable);
> >  
> > -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > +#define __lsm_ro_after_init	__ro_after_init
> > +/* Currently required to handle SELinux runtime hook disable. */
> > +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> > +#define __lsm_mutable_after_init
> >  /*
> >   * Assuring the safety of deleting a security module is up to
> >   * the security module involved. This may entail ordering the
> > @@ -1996,21 +1999,9 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
> >   * disabling their module is a good idea needs to be at least as
> >   * careful as the SELinux team.
> >   */
> > -static inline void security_delete_hooks(struct security_hook_list *hooks,
> > -						int count)
> > -{
> > -	int i;
> > -
> > -	for (i = 0; i < count; i++)
> > -		hlist_del_rcu(&hooks[i].list);
> > -}
> > -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> > -
> > -/* Currently required to handle SELinux runtime hook disable. */
> > -#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> > -#define __lsm_ro_after_init
> > +extern void security_delete_hooks(struct security_hook_list *hooks, int count);
> >  #else
> > -#define __lsm_ro_after_init	__ro_after_init
> > +#define __lsm_mutable_after_init __ro_after_init
> >  #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
> >  
> >  extern int __init security_module_enable(const char *module);
> > diff --git a/security/Kconfig b/security/Kconfig
> > index c4302067a3ad..a3b8b1142e6f 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -32,7 +32,7 @@ config SECURITY
> >  	  If you are unsure how to answer this question, answer N.
> >  
> >  config SECURITY_WRITABLE_HOOKS
> > -	depends on SECURITY
> > +	depends on SECURITY && SRCU
> >  	bool
> >  	default n
> >  
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index 9a65eeaf7dfa..d6cca8169df0 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -1155,7 +1155,7 @@ static int __init apparmor_init(void)
> >  		goto buffers_out;
> >  	}
> >  	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> > -				"apparmor");
> > +				"apparmor", false);
> >  
> >  	/* Report that AppArmor successfully initialized */
> >  	apparmor_initialized = 1;
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 48620c93d697..fe4b0d9d44ce 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -1363,7 +1363,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
> >  void __init capability_add_hooks(void)
> >  {
> >  	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
> > -				"capability");
> > +				"capability", false);
> >  }
> >  
> >  #endif /* CONFIG_SECURITY */
> > diff --git a/security/security.c b/security/security.c
> > index 3cafff61b049..2ddb64864e3e 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -29,6 +29,11 @@
> >  #include <linux/backing-dev.h>
> >  #include <linux/string.h>
> >  #include <net/flow.h>
> > +#include <linux/srcu.h>
> > +#include <linux/mutex.h>
> > +
> > +#define SECURITY_HOOK_COUNT \
> > +	(sizeof(security_hook_heads) / sizeof(struct hlist_head))
> >  
> >  #define MAX_LSM_EVM_XATTR	2
> >  
> > @@ -36,7 +41,10 @@
> >  #define SECURITY_NAME_MAX	10
> >  
> >  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> > +EXPORT_SYMBOL_GPL(security_hook_heads);
> > +
> >  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> > +static DEFINE_MUTEX(security_hook_mutex);
> >  
> >  char *lsm_names;
> >  /* Boot-time LSM user choice */
> > @@ -53,6 +61,103 @@ static void __init do_security_initcalls(void)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> > +DEFINE_STATIC_SRCU(security_hook_srcu);
> > +static struct security_hook_list	null_hooks[SECURITY_HOOK_COUNT];
> > +#define HAS_FUNC(SHL, FUNC)	(SHL->hook.FUNC)
> 
> The HAS_FUNC() macro will work, but it's awkward outside of the
> call_..._hook() macros. I think you should document how to use it
> properly somewhere in here. There are enough cases where the
> call_..._hook() macros aren't used that someone could have trouble
> figuring out how to use it.
> 
> 
What about something like:

 security/security.c | 58 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/security/security.c b/security/security.c
index 2ddb64864e3e..bc14125cfc78 100644
--- a/security/security.c
+++ b/security/security.c
@@ -62,9 +62,37 @@ static void __init do_security_initcalls(void)
 }
 
 #ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-DEFINE_STATIC_SRCU(security_hook_srcu);
+/*
+ * With writable hooks, we setup a structure like this:
+ * +------+   +-----------+   +-----------+   +-----------+   +--------------+
+ * |      |   |           |   |           |   |           |   |              |
+ * | HEAD +---> Immutable +---> Immutable +---> Null hook +---> Mutable Hook |
+ * |      |   |  Hook 1   |   |  Hook 2   |   |           |   |              |
+ * +------+   +-----------+   +-----------+   +-----------+   +--------------+
+ *                  |               |                                |
+ *                  v               v                                v
+ *              Callback        Callback                         Callback
+ *
+ * The hooks before to null hook are marked only after kernel initialization.
+ * The null hook, as well as the hooks succeeding it are not marked read only,
+ * therefore allowing them be (un)loaded after initialization time.
+ *
+ * Since the null hook doesn't have a callback, we need to check if a hook
+ * is the null hook prior to invoking it.
+ */
 static struct security_hook_list	null_hooks[SECURITY_HOOK_COUNT];
-#define HAS_FUNC(SHL, FUNC)	(SHL->hook.FUNC)
+DEFINE_STATIC_SRCU(security_hook_srcu);
+
+static inline bool is_null_hook(struct security_hook_list *shl)
+{
+	union {
+		void *cb_ptr;
+		union security_list_options slo;
+	} hook_options;
+
+	hook_options.slo = shl->hook;
+	return !hook_options.cb_ptr;
+}
 
 static inline int lock_lsm(void)
 {
@@ -88,14 +116,9 @@ static inline void unlock_lsm(int idx)
 static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
 {
 	struct security_hook_list *mutable_hook;
-	union {
-		void *cb_ptr;
-		union security_list_options slo;
-	} hook_options;
 
 	hlist_for_each_entry(mutable_hook, hook->head, list) {
-		hook_options.slo = mutable_hook->hook;
-		if (hook_options.cb_ptr)
+		if (!is_null_hook(mutable_hook))
 			continue;
 
 		if (is_mutable)
@@ -139,7 +162,10 @@ void security_delete_hooks(struct security_hook_list *hooks, int count)
 EXPORT_SYMBOL_GPL(security_delete_hooks);
 
 #else
-#define HAS_FUNC(SHL, FUNC)	true
+static inline bool is_null_hook(struct security_hook_list *shl)
+{
+	return false;
+}
 
 static inline int lock_lsm(void)
 {
@@ -309,7 +335,7 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 									\
 		srcu_idx = lock_lsm();					\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
-			if (HAS_FUNC(P, FUNC))				\
+			if (!is_null_hook(P))			\
 				P->hook.FUNC(__VA_ARGS__);		\
 		unlock_lsm(srcu_idx);					\
 	} while (0)
@@ -322,7 +348,7 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			if (HAS_FUNC(P, FUNC)) {		\
+			if (!is_null_hook(P)) {			\
 				RC = P->hook.FUNC(__VA_ARGS__);	\
 				if (RC != 0)			\
 					break;			\
@@ -434,7 +460,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 */
 	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
-		if (!HAS_FUNC(hp, vm_enough_memory))
+		if (is_null_hook(hp))
 			continue;
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
@@ -928,7 +954,7 @@ int security_inode_getsecurity(struct inode *inode, const char *name,
 	 */
 	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		if (!HAS_FUNC(hp, inode_getsecurity))
+		if (is_null_hook(hp))
 			continue;
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
@@ -953,7 +979,7 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
 	 */
 	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
-		if (!HAS_FUNC(hp, inode_setsecurity))
+		if (is_null_hook(hp))
 			continue;
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
 						flags);
@@ -1264,7 +1290,7 @@ int security_task_prctl(int option, unsigned long arg2,
 
 	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
-		if (!HAS_FUNC(hp, task_prctl))
+		if (is_null_hook(hp))
 			continue;
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
@@ -1774,7 +1800,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	hlist_for_each_entry(hp,
 				&security_hook_heads.xfrm_state_pol_flow_match,
 				list) {
-		if (!HAS_FUNC(hp, xfrm_state_pol_flow_match))
+		if (is_null_hook(hp))
 			continue;
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
