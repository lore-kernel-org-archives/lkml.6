Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeEKAx1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:53:27 -0400
Received: from sonic311-29.consmr.mail.ne1.yahoo.com ([66.163.188.210]:34622
        "EHLO sonic311-29.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751989AbeEKAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:53:25 -0400
X-YMail-OSG: OUKYjRkVM1lAJANRLXzNt60ysl6w6rx1zrNHyP6s2xhohW8jH2u0RANBYblYtLX
 MuSZfzcY.JeOW84kBHSPdqFhDzq0RuF5FWZWekOjKJ9ymGb8nVwH5n7bQbhjRdecHNONfH5YYYC0
 ZkyPBvC0kNQROgs3jpH1.YmX_lmBdxrqVFbVJhCI.SzuaSQd_evSmyk44511ffkU9ECwOE.wgyRO
 nCTXk.mLHH85BfaDys90C8snxF237lx51KVbv6Wrkavkgp.KTStmc6j9B2Xk8c6pC76r0fGLwpLk
 AWEwFK3VqnV96silBnKbcV2epFEWyQ4vbc5.xQH1cbpPWqd.U1CszwNUAK.Ss05q1KFrebqSyc.s
 LdLNkskIvH0JsPjSY6yiNZdttyt0Q4WxyUuJMf63asn6KRTRWDB5zi7nMF8V0bAU9gIOvxFTYdbB
 u8602lpjaAxYeLu1pn_xfa_M3aH8q8ZUzzJ9xX_DxlolRtHZ_y7Tzb8gkS5r.OlaL0A3B.55AwOa
 CvMvT6SYN8ZbO1O6ZnqbI5yaV7igW84Gopsk05y8tYEUE7rmWOjUdWwjHQ4mfX2ZLdywaBx0HHUg
 nik6EvuMFSV0KbjsCTiYh3o19tuRZJhPVQpF6BPuVBpjrW8YMudm6KzEVIr_9i6TWaIdvKDk1Y9y
 ErTU-
Subject: [PATCH 07/23] LSM: Infrastructure management of the task security
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1c87b84c-50ef-a81d-b428-03b03ec74423@schaufler-ca.com>
Date: Thu, 10 May 2018 17:53:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 14:08:37 -0700
Subject: [PATCH 07/23] LSM: Infrastructure management of the task security
 blob

Move management of the task_struct->security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h        |  2 ++
 security/apparmor/include/task.h | 18 +++-----------
 security/apparmor/lsm.c          | 15 +++--------
 security/security.c              | 54 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2268e43709d4..3ba96e406827 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2017,6 +2017,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
+	int	lbs_task;
 };
 
 /*
@@ -2082,6 +2083,7 @@ extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
 
 #ifdef CONFIG_SECURITY
 void lsm_early_cred(struct cred *cred);
+void lsm_early_task(struct task_struct *task);
 #endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index 55edaa1d83f8..039c1e60887a 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -14,7 +14,10 @@
 #ifndef __AA_TASK_H
 #define __AA_TASK_H
 
-#define task_ctx(X) ((X)->security)
+static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
+{
+	return task->security;
+}
 
 /*
  * struct aa_task_ctx - information for current task label change
@@ -36,17 +39,6 @@ int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
 struct aa_label *aa_get_task_label(struct task_struct *task);
 
-/**
- * aa_alloc_task_ctx - allocate a new task_ctx
- * @flags: gfp flags for allocation
- *
- * Returns: allocated buffer or NULL on failure
- */
-static inline struct aa_task_ctx *aa_alloc_task_ctx(gfp_t flags)
-{
-	return kzalloc(sizeof(struct aa_task_ctx), flags);
-}
-
 /**
  * aa_free_task_ctx - free a task_ctx
  * @ctx: task_ctx to free (MAYBE NULL)
@@ -57,8 +49,6 @@ static inline void aa_free_task_ctx(struct aa_task_ctx *ctx)
 		aa_put_label(ctx->nnp);
 		aa_put_label(ctx->previous);
 		aa_put_label(ctx->onexec);
-
-		kzfree(ctx);
 	}
 }
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e986a0eed01e..5fee6ab3786e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -90,19 +90,14 @@ static void apparmor_task_free(struct task_struct *task)
 {
 
 	aa_free_task_ctx(task_ctx(task));
-	task_ctx(task) = NULL;
 }
 
 static int apparmor_task_alloc(struct task_struct *task,
 			       unsigned long clone_flags)
 {
-	struct aa_task_ctx *new = aa_alloc_task_ctx(GFP_KERNEL);
-
-	if (!new)
-		return -ENOMEM;
+	struct aa_task_ctx *new = task_ctx(task);
 
 	aa_dup_task_ctx(new, task_ctx(current));
-	task_ctx(task) = new;
 
 	return 0;
 }
@@ -1123,6 +1118,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 struct lsm_blob_sizes apparmor_blob_sizes = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
 	.lbs_file = sizeof(struct aa_file_ctx),
+	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
@@ -1439,15 +1435,10 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
 static int __init set_init_ctx(void)
 {
 	struct cred *cred = (struct cred *)current->real_cred;
-	struct aa_task_ctx *ctx;
-
-	ctx = aa_alloc_task_ctx(GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
 
 	lsm_early_cred(cred);
+	lsm_early_task(current);
 	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
-	task_ctx(current) = ctx;
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index ee77af08086b..b414186ad45f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -108,6 +108,7 @@ int __init security_init(void)
 #ifdef CONFIG_SECURITY_LSM_DEBUG
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
+	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 #endif
 
 	return 0;
@@ -283,6 +284,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 {
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
 /**
@@ -306,6 +308,46 @@ int lsm_file_alloc(struct file *file)
 	return 0;
 }
 
+/**
+ * lsm_task_alloc - allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_task_alloc(struct task_struct *task)
+{
+	if (blob_sizes.lbs_task == 0) {
+		task->security = NULL;
+		return 0;
+	}
+
+	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
+	if (task->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * lsm_early_task - during initialization allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules if it's not already there
+ */
+void lsm_early_task(struct task_struct *task)
+{
+	int rc;
+
+	if (task == NULL)
+		panic("%s: task cred.\n", __func__);
+	if (task->security != NULL)
+		return;
+	rc = lsm_task_alloc(task);
+	if (rc)
+		panic("%s: Early task alloc failed.\n", __func__);
+}
+
 /*
  * Hook list operation macros.
  *
@@ -1112,12 +1154,22 @@ int security_file_open(struct file *file, const struct cred *cred)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
-	return call_int_hook(task_alloc, 0, task, clone_flags);
+	int rc = lsm_task_alloc(task);
+
+	if (rc)
+		return rc;
+	rc = call_int_hook(task_alloc, 0, task, clone_flags);
+	if (unlikely(rc))
+		security_task_free(task);
+	return rc;
 }
 
 void security_task_free(struct task_struct *task)
 {
 	call_void_hook(task_free, task);
+
+	kfree(task->security);
+	task->security = NULL;
 }
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-- 
2.14.3
