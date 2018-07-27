Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE4920857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE4920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbeG0VPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:15:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389225AbeG0VPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80B7F406E885;
        Fri, 27 Jul 2018 19:51:54 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AEAA111E415;
        Fri, 27 Jul 2018 19:51:52 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak59 V2 4/6] audit: hand taken context to audit_kill_trees for syscall logging
Date:   Fri, 27 Jul 2018 15:48:15 -0400
Message-Id: <9d922798e48fc40d3743ce73e01725ac8cdcee04.1532709911.git.rgb@redhat.com>
In-Reply-To: <cover.1532709911.git.rgb@redhat.com>
References: <cover.1532709911.git.rgb@redhat.com>
In-Reply-To: <cover.1532709911.git.rgb@redhat.com>
References: <cover.1532709911.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 19:51:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 19:51:54 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the context is taken from the task in __audit_syscall_exit() and
__audit_free(), hand it to audit_kill_trees() so it can be used to
associate with a syscall record.  This requires adding the context
parameter to kill_rules() rather than using the current audit_context
(which has been taken).

The callers of trim_marked() and evict_chunk() still have their context.

See: https://github.com/linux-audit/audit-kernel/issues/50
See: https://github.com/linux-audit/audit-kernel/issues/59
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.h      |  4 ++--
 kernel/audit_tree.c | 18 ++++++++++--------
 kernel/auditsc.c    |  4 ++--
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 214e149..f39f7aa 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -312,7 +312,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 extern int audit_tag_tree(char *old, char *new);
 extern const char *audit_tree_path(struct audit_tree *tree);
 extern void audit_put_tree(struct audit_tree *tree);
-extern void audit_kill_trees(struct list_head *list);
+extern void audit_kill_trees(struct audit_context *context);
 #else
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
@@ -321,7 +321,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 #define audit_put_tree(tree) (void)0
 #define audit_tag_tree(old, new) -EINVAL
 #define audit_tree_path(rule) ""	/* never called */
-#define audit_kill_trees(list) BUG()
+#define audit_kill_trees(context) BUG()
 #endif
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index f0b7d30..c2281e3 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -493,13 +493,13 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	return 0;
 }
 
-static void audit_tree_log_remove_rule(struct audit_krule *rule)
+static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule)
 {
 	struct audit_buffer *ab;
 
 	if (!audit_enabled)
 		return;
-	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "op=remove_rule");
@@ -510,7 +510,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
 	audit_log_end(ab);
 }
 
-static void kill_rules(struct audit_tree *tree)
+static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 {
 	struct audit_krule *rule, *next;
 	struct audit_entry *entry;
@@ -521,7 +521,7 @@ static void kill_rules(struct audit_tree *tree)
 		list_del_init(&rule->rlist);
 		if (rule->tree) {
 			/* not a half-baked one */
-			audit_tree_log_remove_rule(rule);
+			audit_tree_log_remove_rule(context, rule);
 			if (entry->rule.exe)
 				audit_remove_mark(entry->rule.exe);
 			rule->tree = NULL;
@@ -584,7 +584,7 @@ static void trim_marked(struct audit_tree *tree)
 		tree->goner = 1;
 		spin_unlock(&hash_lock);
 		mutex_lock(&audit_filter_mutex);
-		kill_rules(tree);
+		kill_rules(audit_context(), tree);
 		list_del_init(&tree->list);
 		mutex_unlock(&audit_filter_mutex);
 		prune_one(tree);
@@ -924,8 +924,10 @@ static void audit_schedule_prune(void)
  * ... and that one is done if evict_chunk() decides to delay until the end
  * of syscall.  Runs synchronously.
  */
-void audit_kill_trees(struct list_head *list)
+void audit_kill_trees(struct audit_context *context)
 {
+	struct list_head *list = &context->killed_trees;
+
 	audit_ctl_lock();
 	mutex_lock(&audit_filter_mutex);
 
@@ -933,7 +935,7 @@ void audit_kill_trees(struct list_head *list)
 		struct audit_tree *victim;
 
 		victim = list_entry(list->next, struct audit_tree, list);
-		kill_rules(victim);
+		kill_rules(context, victim);
 		list_del_init(&victim->list);
 
 		mutex_unlock(&audit_filter_mutex);
@@ -972,7 +974,7 @@ static void evict_chunk(struct audit_chunk *chunk)
 		list_del_init(&owner->same_root);
 		spin_unlock(&hash_lock);
 		if (!postponed) {
-			kill_rules(owner);
+			kill_rules(audit_context(), owner);
 			list_move(&owner->list, &prune_list);
 			need_prune = 1;
 		} else {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index fb20746..986c5ce 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1490,7 +1490,7 @@ void __audit_free(struct task_struct *tsk)
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
 		audit_log_exit(context, tsk);
 	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(&context->killed_trees);
+		audit_kill_trees(context);
 
 	audit_free_context(context);
 }
@@ -1577,7 +1577,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
 
 	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(&context->killed_trees);
+		audit_kill_trees(context);
 
 	audit_free_names(context);
 	unroll_tree_refs(context, NULL, 0);
-- 
1.8.3.1

