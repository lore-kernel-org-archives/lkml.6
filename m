Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B0D20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B0D20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeLJWSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:18:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbeLJWSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:18:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43171811D7;
        Mon, 10 Dec 2018 22:18:42 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 190C060BF1;
        Mon, 10 Dec 2018 22:18:39 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak59 V3 4/4] audit: extend config_change mark/watch/tree rule changes
Date:   Mon, 10 Dec 2018 17:17:51 -0500
Message-Id: <9e8a94d983219ef650e45082e1bbf3c65a280b6e.1544477629.git.rgb@redhat.com>
In-Reply-To: <cover.1544477629.git.rgb@redhat.com>
References: <cover.1544477629.git.rgb@redhat.com>
In-Reply-To: <cover.1544477629.git.rgb@redhat.com>
References: <cover.1544477629.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 10 Dec 2018 22:18:42 +0000 (UTC)
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
index 6ffb70575082..545dd8fcb036 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -314,7 +314,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 extern int audit_tag_tree(char *old, char *new);
 extern const char *audit_tree_path(struct audit_tree *tree);
 extern void audit_put_tree(struct audit_tree *tree);
-extern void audit_kill_trees(struct audit_context *context);
+extern void audit_kill_trees(struct audit_context *context, char *trig);
 #else
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
@@ -323,7 +323,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
 #define audit_put_tree(tree) (void)0
 #define audit_tag_tree(old, new) -EINVAL
 #define audit_tree_path(rule) ""	/* never called */
-#define audit_kill_trees(context) BUG()
+#define audit_kill_trees(context, trig) BUG()
 #endif
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 37ae95cfb7f4..d25cd3760b5d 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -156,7 +156,7 @@ static void audit_autoremove_mark_rule(struct audit_fsnotify_mark *audit_mark)
 	struct audit_krule *rule = audit_mark->rule;
 	struct audit_entry *entry = container_of(rule, struct audit_entry, rule);
 
-	audit_mark_log_rule_change(audit_mark, "autoremove_rule");
+	audit_mark_log_rule_change(audit_mark, "autoremove_rule:mark");
 	audit_del_rule(entry);
 }
 
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index bf77d265e68e..160169fa45a8 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -524,7 +524,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	return 0;
 }
 
-static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule)
+static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule, char *trig)
 {
 	struct audit_buffer *ab;
 
@@ -533,14 +533,14 @@ static void audit_tree_log_remove_rule(struct audit_context *context, struct aud
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
-	audit_log_format(ab, "op=remove_rule dir=");
+	audit_log_format(ab, "op=remove_rule:tree:%s dir=", trig);
 	audit_log_untrustedstring(ab, rule->tree->pathname);
 	audit_log_key(ab, rule->filterkey);
 	audit_log_format(ab, " list=%d res=1", rule->listnr);
 	audit_log_end(ab);
 }
 
-static void kill_rules(struct audit_context *context, struct audit_tree *tree)
+static void kill_rules(struct audit_context *context, struct audit_tree *tree, char *trig)
 {
 	struct audit_krule *rule, *next;
 	struct audit_entry *entry;
@@ -551,7 +551,7 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 		list_del_init(&rule->rlist);
 		if (rule->tree) {
 			/* not a half-baked one */
-			audit_tree_log_remove_rule(context, rule);
+			audit_tree_log_remove_rule(context, rule, trig);
 			if (entry->rule.exe)
 				audit_remove_mark(entry->rule.exe);
 			rule->tree = NULL;
@@ -607,7 +607,7 @@ static void prune_one(struct audit_tree *victim)
 
 /* trim the uncommitted chunks from tree */
 
-static void trim_marked(struct audit_tree *tree)
+static void trim_marked(struct audit_tree *tree, char *trig)
 {
 	struct list_head *p, *q;
 	spin_lock(&hash_lock);
@@ -633,7 +633,7 @@ static void trim_marked(struct audit_tree *tree)
 		tree->goner = 1;
 		spin_unlock(&hash_lock);
 		mutex_lock(&audit_filter_mutex);
-		kill_rules(audit_context(), tree);
+		kill_rules(audit_context(), tree, trig);
 		list_del_init(&tree->list);
 		mutex_unlock(&audit_filter_mutex);
 		prune_one(tree);
@@ -714,7 +714,7 @@ void audit_trim_trees(void)
 				node->index &= ~(1U<<31);
 		}
 		spin_unlock(&hash_lock);
-		trim_marked(tree);
+		trim_marked(tree, "trim");
 		drop_collected_mounts(root_mnt);
 skip_it:
 		put_tree(tree);
@@ -847,7 +847,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
 			node->index &= ~(1U<<31);
 		spin_unlock(&hash_lock);
 	} else {
-		trim_marked(tree);
+		trim_marked(tree, "add");
 		goto Err;
 	}
 
@@ -949,7 +949,7 @@ int audit_tag_tree(char *old, char *new)
 				node->index &= ~(1U<<31);
 			spin_unlock(&hash_lock);
 		} else {
-			trim_marked(tree);
+			trim_marked(tree, "equiv");
 		}
 
 		put_tree(tree);
@@ -973,7 +973,7 @@ static void audit_schedule_prune(void)
  * ... and that one is done if evict_chunk() decides to delay until the end
  * of syscall.  Runs synchronously.
  */
-void audit_kill_trees(struct audit_context *context)
+void audit_kill_trees(struct audit_context *context, char *trig)
 {
 	struct list_head *list = &context->killed_trees;
 
@@ -984,7 +984,7 @@ void audit_kill_trees(struct audit_context *context)
 		struct audit_tree *victim;
 
 		victim = list_entry(list->next, struct audit_tree, list);
-		kill_rules(context, victim);
+		kill_rules(context, victim, trig);
 		list_del_init(&victim->list);
 
 		mutex_unlock(&audit_filter_mutex);
@@ -1019,7 +1019,7 @@ static void evict_chunk(struct audit_chunk *chunk)
 		list_del_init(&owner->same_root);
 		spin_unlock(&hash_lock);
 		if (!postponed) {
-			kill_rules(audit_context(), owner);
+			kill_rules(audit_context(), owner, "evict");
 			list_move(&owner->list, &prune_list);
 			need_prune = 1;
 		} else {
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index e8d1adeb2223..f8a5770c6c8c 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -315,7 +315,9 @@ static void audit_update_watch(struct audit_parent *parent,
 			if (oentry->rule.exe)
 				audit_remove_mark(oentry->rule.exe);
 
-			audit_watch_log_rule_change(r, owatch, "updated_rules");
+			audit_watch_log_rule_change(r, owatch, invalidating ?
+						    "updated_rules:watch:inval" :
+						    "updated_rules:watch:set");
 
 			call_rcu(&oentry->rcu, audit_free_rule_rcu);
 		}
@@ -343,7 +345,7 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
 	list_for_each_entry_safe(w, nextw, &parent->watches, wlist) {
 		list_for_each_entry_safe(r, nextr, &w->rules, rlist) {
 			e = container_of(r, struct audit_entry, rule);
-			audit_watch_log_rule_change(r, w, "remove_rule");
+			audit_watch_log_rule_change(r, w, "remove_rule:watch:parent");
 			if (e->rule.exe)
 				audit_remove_mark(e->rule.exe);
 			list_del(&r->rlist);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b585ceb2f7a2..8592448f1d8f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1445,7 +1445,7 @@ void __audit_free(struct task_struct *tsk)
 		return;
 
 	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(context);
+		audit_kill_trees(context, "free");
 
 	/* We are called either by do_exit() or the fork() error handling code;
 	 * in the former case tsk == current and in the latter tsk is a
@@ -1538,7 +1538,7 @@ void __audit_syscall_exit(int success, long return_code)
 		return;
 
 	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(context);
+		audit_kill_trees(context, "exit");
 
 	if (!context->dummy && context->in_syscall) {
 		if (success)
-- 
1.8.3.1

