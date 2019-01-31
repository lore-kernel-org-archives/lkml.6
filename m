Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C509C4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66DD218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbfAaQws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:52:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733267AbfAaQwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:52:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42A615D61C;
        Thu, 31 Jan 2019 16:52:47 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5214101960A;
        Thu, 31 Jan 2019 16:52:37 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak107 V1] audit: remove unused actx param from audit_rule_match
Date:   Thu, 31 Jan 2019 11:52:11 -0500
Message-Id: <c3bc9d90ed20f1b1cce916636a28f1e85af1afdc.1548953334.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 31 Jan 2019 16:52:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audit_rule_match() struct audit_context *actx parameter is not used
by any in-tree consumers (selinux, apparmour, integrity, smack).

The audit context is an internal audit structure that should only be
accessed by audit accessor functions.

It was part of commit 03d37d25e0f9 ("LSM/Audit: Introduce > generic
Audit LSM hooks") but appears to have never been used.

Remove it.

Please see the github issue
https://github.com/linux-audit/audit-kernel/issues/107

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Passes audit-testsuite.

 include/linux/lsm_hooks.h           |  4 +---
 include/linux/security.h            |  5 ++---
 kernel/auditfilter.c                |  2 +-
 kernel/auditsc.c                    | 21 ++++++++++++---------
 security/apparmor/audit.c           |  3 +--
 security/apparmor/include/audit.h   |  3 +--
 security/integrity/ima/ima.h        |  3 +--
 security/integrity/ima/ima_policy.c |  6 ++----
 security/security.c                 |  6 ++----
 security/selinux/include/audit.h    |  4 +---
 security/selinux/ss/services.c      |  3 +--
 security/smack/smack_lsm.c          |  4 +---
 12 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9a0bdf91e646..d0b5c7a05832 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1344,7 +1344,6 @@
  *	@field contains the field which relates to current LSM.
  *	@op contains the operator that will be used for matching.
  *	@rule points to the audit rule that will be checked against.
- *	@actx points to the audit context associated with the check.
  *	Return 1 if secid matches the rule, 0 if it does not, -ERRNO on failure.
  *
  * @audit_rule_free:
@@ -1764,8 +1763,7 @@
 	int (*audit_rule_init)(u32 field, u32 op, char *rulestr,
 				void **lsmrule);
 	int (*audit_rule_known)(struct audit_krule *krule);
-	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule,
-				struct audit_context *actx);
+	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule);
 	void (*audit_rule_free)(void *lsmrule);
 #endif /* CONFIG_AUDIT */
 
diff --git a/include/linux/security.h b/include/linux/security.h
index dbfb5a66babb..e8febec62ffb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1674,8 +1674,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			      struct audit_context *actx);
+int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1692,7 +1691,7 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 }
 
 static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-				   void *lsmrule, struct audit_context *actx)
+					    void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 26a80a9d43a9..add360b46b38 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1355,7 +1355,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
 					result = security_audit_rule_match(sid,
-							f->type, f->op, f->lsm_rule, NULL);
+						   f->type, f->op, f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 68da71001096..7d37cb1e4aef 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -631,9 +631,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 					need_sid = 0;
 				}
 				result = security_audit_rule_match(sid, f->type,
-				                                  f->op,
-				                                  f->lsm_rule,
-				                                  ctx);
+								   f->op,
+								   f->lsm_rule);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -647,13 +646,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find files that match */
 				if (name) {
 					result = security_audit_rule_match(
-					           name->osid, f->type, f->op,
-					           f->lsm_rule, ctx);
+								name->osid,
+								f->type,
+								f->op,
+								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						if (security_audit_rule_match(n->osid, f->type,
-									      f->op, f->lsm_rule,
-									      ctx)) {
+						if (security_audit_rule_match(
+								n->osid,
+								f->type,
+								f->op,
+								f->lsm_rule)) {
 							++result;
 							break;
 						}
@@ -664,7 +667,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					break;
 				if (security_audit_rule_match(ctx->ipc.osid,
 							      f->type, f->op,
-							      f->lsm_rule, ctx))
+							      f->lsm_rule))
 					++result;
 			}
 			break;
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index eeaddfe0c0fb..5a8b9cded4f2 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -225,8 +225,7 @@ int aa_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
-			struct audit_context *actx)
+int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 {
 	struct aa_audit_rule *rule = vrule;
 	struct aa_label *label;
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index b8c8b1066b0a..ee559bc2acb8 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -192,7 +192,6 @@ static inline int complain_error(int error)
 void aa_audit_rule_free(void *vrule);
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
 int aa_audit_rule_known(struct audit_krule *rule);
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
-			struct audit_context *actx);
+int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
 
 #endif /* __AA_AUDIT_H */
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cc12f3449a72..026163f37ba1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -307,8 +307,7 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 }
 
 static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule,
-					     struct audit_context *actx)
+					     void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bc8a1c8cb3f..26fa9d9723f6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -340,8 +340,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			rc = security_filter_rule_match(osid,
 							rule->lsm[i].type,
 							Audit_equal,
-							rule->lsm[i].rule,
-							NULL);
+							rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
@@ -349,8 +348,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 			rc = security_filter_rule_match(secid,
 							rule->lsm[i].type,
 							Audit_equal,
-							rule->lsm[i].rule,
-							NULL);
+							rule->lsm[i].rule);
 		default:
 			break;
 		}
diff --git a/security/security.c b/security/security.c
index f1b8d2587639..5f954b179a8e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1783,11 +1783,9 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			      struct audit_context *actx)
+int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
-				actx);
+	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 1bdf973433cc..e51a81ffb8c9 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -46,13 +46,11 @@
  *	@field: the field this rule refers to
  *	@op: the operater the rule uses
  *	@rule: pointer to the audit rule to check against
- *	@actx: the audit context (can be NULL) associated with the check
  *
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule,
-			     struct audit_context *actx);
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index dd44126c8d14..0b7e33f6aa59 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3376,8 +3376,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
-			     struct audit_context *actx)
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 {
 	struct selinux_state *state = &selinux_state;
 	struct context *ctxt;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 430d4f35e55c..403513df42fc 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4393,13 +4393,11 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
- * @actx: audit context associated with the check
  *
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule,
-				  struct audit_context *actx)
+static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
-- 
1.8.3.1

