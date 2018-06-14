Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 010D3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F37208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F37208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935987AbeFNUXX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:23:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755499AbeFNUXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:23:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EE5C406DE3D;
        Thu, 14 Jun 2018 20:23:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AED5711166FE;
        Thu, 14 Jun 2018 20:23:19 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <aviro@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak59 V1 6/6] audit: extend config_change mark/watch/tree rule changes
Date:   Thu, 14 Jun 2018 16:21:16 -0400
Message-Id: <e3584154c8594cf64e9293ec6f473cdaaabe2954.1529003588.git.rgb@redhat.com>
In-Reply-To: <cover.1529003588.git.rgb@redhat.com>
References: <cover.1529003588.git.rgb@redhat.com>
In-Reply-To: <cover.1529003588.git.rgb@redhat.com>
References: <cover.1529003588.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 14 Jun 2018 20:23:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 14 Jun 2018 20:23:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give a clue as to the source of mark, watch and tree rule changes.

See: https://github.com/linux-audit/audit-kernel/issues/50
See: https://github.com/linux-audit/audit-kernel/issues/59
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.h          |  4 ++--
 kernel/audit_fsnotify.c |  2 +-
 kernel/audit_tree.c     | 24 ++++++++++++------------
 kernel/audit_watch.c    |  6 ++++--
 kernel/auditsc.c        |  4 ++--
 5 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index f39f7aa..5e072f5 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -312,7 +312,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 extern int audit_tag_tree(char *old, char *new);
 extern const char *audit_tree_path(struct audit_tree *tree);
 extern void audit_put_tree(struct audit_tree *tree);
-extern void audit_kill_trees(struct audit_context *context);
+extern void audit_kill_trees(struct audit_context *context, char *trig);
 #else
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
@@ -321,7 +321,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 #define audit_put_tree(tree) (void)0
 #define audit_tag_tree(old, new) -EINVAL
 #define audit_tree_path(rule) ""	/* never called */
-#define audit_kill_trees(context) BUG()
+#define audit_kill_trees(context, trig) BUG()
 #endif
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 1640eb6..c10ba91 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -158,7 +158,7 @@ static void audit_autoremove_mark_rule(struct audit_fsnotify_mark *audit_mark)
 	struct audit_krule *rule = audit_mark->rule;
 	struct audit_entry *entry = container_of(rule, struct audit_entry, rule);
 
-	audit_mark_log_rule_change(audit_mark, "autoremove_rule");
+	audit_mark_log_rule_change(audit_mark, "autoremove_rule(mark)");
 	audit_del_rule(entry);
 }
 
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 2d3e1071..1726cfa 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -493,7 +493,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	return 0;
 }
 
-static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule)
+static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule, char *trig)
 {
 	struct audit_buffer *ab;
 
@@ -502,7 +502,7 @@ static void audit_tree_log_remove_rule(struct audit_context *context, struct aud
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
-	audit_log_format(ab, "op=remove_rule");
+	audit_log_format(ab, "op=remove_rule(tree:%s)", trig);
 	audit_log_format(ab, " dir=");
 	audit_log_untrustedstring(ab, rule->tree->pathname);
 	audit_log_key(ab, rule->filterkey);
@@ -510,7 +510,7 @@ static void audit_tree_log_remove_rule(struct audit_context *context, struct aud
 	audit_log_end(ab);
 }
 
-static void kill_rules(struct audit_context *context, struct audit_tree *tree)
+static void kill_rules(struct audit_context *context, struct audit_tree *tree, char *trig)
 {
 	struct audit_krule *rule, *next;
 	struct audit_entry *entry;
@@ -521,7 +521,7 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 		list_del_init(&rule->rlist);
 		if (rule->tree) {
 			/* not a half-baked one */
-			audit_tree_log_remove_rule(context, rule);
+			audit_tree_log_remove_rule(context, rule, trig);
 			if (entry->rule.exe)
 				audit_remove_mark(entry->rule.exe);
 			rule->tree = NULL;
@@ -551,7 +551,7 @@ static void prune_one(struct audit_tree *victim)
 
 /* trim the uncommitted chunks from tree */
 
-static void trim_marked(struct audit_tree *tree)
+static void trim_marked(struct audit_tree *tree, char *trig)
 {
 	struct list_head *p, *q;
 	spin_lock(&hash_lock);
@@ -584,7 +584,7 @@ static void trim_marked(struct audit_tree *tree)
 		tree->goner = 1;
 		spin_unlock(&hash_lock);
 		mutex_lock(&audit_filter_mutex);
-		kill_rules(audit_context(), tree);
+		kill_rules(audit_context(), tree, trig);
 		list_del_init(&tree->list);
 		mutex_unlock(&audit_filter_mutex);
 		prune_one(tree);
@@ -665,7 +665,7 @@ void audit_trim_trees(void)
 				node->index &= ~(1U<<31);
 		}
 		spin_unlock(&hash_lock);
-		trim_marked(tree);
+		trim_marked(tree, "trim");
 		drop_collected_mounts(root_mnt);
 skip_it:
 		put_tree(tree);
@@ -798,7 +798,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
 			node->index &= ~(1U<<31);
 		spin_unlock(&hash_lock);
 	} else {
-		trim_marked(tree);
+		trim_marked(tree, "add");
 		goto Err;
 	}
 
@@ -900,7 +900,7 @@ int audit_tag_tree(char *old, char *new)
 				node->index &= ~(1U<<31);
 			spin_unlock(&hash_lock);
 		} else {
-			trim_marked(tree);
+			trim_marked(tree, "equiv");
 		}
 
 		put_tree(tree);
@@ -924,7 +924,7 @@ static void audit_schedule_prune(void)
  * ... and that one is done if evict_chunk() decides to delay until the end
  * of syscall.  Runs synchronously.
  */
-void audit_kill_trees(struct audit_context *context)
+void audit_kill_trees(struct audit_context *context, char *trig)
 {
 	struct list_head *list = &context->killed_trees;
 
@@ -935,7 +935,7 @@ void audit_kill_trees(struct audit_context *context)
 		struct audit_tree *victim;
 
 		victim = list_entry(list->next, struct audit_tree, list);
-		kill_rules(context, victim);
+		kill_rules(context, victim, trig);
 		list_del_init(&victim->list);
 
 		mutex_unlock(&audit_filter_mutex);
@@ -974,7 +974,7 @@ static void evict_chunk(struct audit_chunk *chunk)
 		list_del_init(&owner->same_root);
 		spin_unlock(&hash_lock);
 		if (!postponed) {
-			kill_rules(audit_context(), owner);
+			kill_rules(audit_context(), owner, "evict");
 			list_move(&owner->list, &prune_list);
 			need_prune = 1;
 		} else {
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index da2978b..693d0a8 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -317,7 +317,9 @@ static void audit_update_watch(struct audit_parent *parent,
 			if (oentry->rule.exe)
 				audit_remove_mark(oentry->rule.exe);
 
-			audit_watch_log_rule_change(r, owatch, "updated_rules");
+			audit_watch_log_rule_change(r, owatch, invalidating ?
+						    "updated_rules(watch:inval)" :
+						    "updated_rules(watch:set)");
 
 			call_rcu(&oentry->rcu, audit_free_rule_rcu);
 		}
@@ -345,7 +347,7 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
 	list_for_each_entry_safe(w, nextw, &parent->watches, wlist) {
 		list_for_each_entry_safe(r, nextr, &w->rules, rlist) {
 			e = container_of(r, struct audit_entry, rule);
-			audit_watch_log_rule_change(r, w, "remove_rule");
+			audit_watch_log_rule_change(r, w, "remove_rule(watch:parent)");
 			if (e->rule.exe)
 				audit_remove_mark(e->rule.exe);
 			list_del(&r->rlist);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d56aead..32428a3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1486,7 +1486,7 @@ void __audit_free(struct task_struct *tsk)
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
 		audit_log_exit(context, tsk);
 	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(context);
+		audit_kill_trees(context, "free");
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT) {
 		struct audit_buffer *ab;
 
@@ -1577,7 +1577,7 @@ void __audit_syscall_exit(int success, long return_code)
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
 		audit_log_exit(context, current);
 	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(context);
+		audit_kill_trees(context, "exit");
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT) {
 		struct audit_buffer *ab;
 
-- 
1.8.3.1

