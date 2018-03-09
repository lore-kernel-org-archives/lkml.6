Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeCIMhn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeCIMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:37:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B8421723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH -tip 4/9] kprobes: Ignore break_handler
Date: Fri,  9 Mar 2018 21:37:17 +0900
Message-Id: <152059903731.4214.9268892607457902327.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152059891712.4214.9539716544254881611.stgit@devbox>
References: <152059891712.4214.9539716544254881611.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore break_handler related code because it was only
used by jprobe and jprobe is removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/kprobes.txt |    2 +-
 kernel/kprobes.c          |   39 +++++----------------------------------
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 22208bf2386d..94df43224c6c 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -262,7 +262,7 @@ is optimized, that modification is ignored.  Thus, if you want to
 tweak the kernel's execution path, you need to suppress optimization,
 using one of the following techniques:
 
-- Specify an empty function for the kprobe's post_handler or break_handler.
+- Specify an empty function for the kprobe's post_handler.
 
 or
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6d5a7c29cf99..889986ee3d06 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -627,8 +627,8 @@ static void optimize_kprobe(struct kprobe *p)
 	    (kprobe_disabled(p) || kprobes_all_disarmed))
 		return;
 
-	/* Both of break_handler and post_handler are not supported. */
-	if (p->break_handler || p->post_handler)
+	/* kprobes with post_handler can not be optimized */
+	if (p->post_handler)
 		return;
 
 	op = container_of(p, struct optimized_kprobe, kp);
@@ -1116,20 +1116,6 @@ static int aggr_fault_handler(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(aggr_fault_handler);
 
-static int aggr_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe *cur = __this_cpu_read(kprobe_instance);
-	int ret = 0;
-
-	if (cur && cur->break_handler) {
-		if (cur->break_handler(cur, regs))
-			ret = 1;
-	}
-	reset_kprobe_instance();
-	return ret;
-}
-NOKPROBE_SYMBOL(aggr_break_handler);
-
 /* Walks the list and increments nmissed count for multiprobe case */
 void kprobes_inc_nmissed_count(struct kprobe *p)
 {
@@ -1270,24 +1256,15 @@ static void cleanup_rp_inst(struct kretprobe *rp)
 }
 NOKPROBE_SYMBOL(cleanup_rp_inst);
 
-/*
-* Add the new probe to ap->list. Fail if this is the
-* second break_handler at the address
-*/
+/* Add the new probe to ap->list */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	BUG_ON(kprobe_gone(ap) || kprobe_gone(p));
 
-	if (p->break_handler || p->post_handler)
+	if (p->post_handler)
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 
-	if (p->break_handler) {
-		if (ap->break_handler)
-			return -EEXIST;
-		list_add_tail_rcu(&p->list, &ap->list);
-		ap->break_handler = aggr_break_handler;
-	} else
-		list_add_rcu(&p->list, &ap->list);
+	list_add_rcu(&p->list, &ap->list);
 	if (p->post_handler && !ap->post_handler)
 		ap->post_handler = aggr_post_handler;
 
@@ -1310,8 +1287,6 @@ static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 	/* We don't care the kprobe which has gone. */
 	if (p->post_handler && !kprobe_gone(p))
 		ap->post_handler = aggr_post_handler;
-	if (p->break_handler && !kprobe_gone(p))
-		ap->break_handler = aggr_break_handler;
 
 	INIT_LIST_HEAD(&ap->list);
 	INIT_HLIST_NODE(&ap->hlist);
@@ -1706,8 +1681,6 @@ static int __unregister_kprobe_top(struct kprobe *p)
 		goto disarmed;
 	else {
 		/* If disabling probe has special handlers, update aggrprobe */
-		if (p->break_handler && !kprobe_gone(p))
-			ap->break_handler = NULL;
 		if (p->post_handler && !kprobe_gone(p)) {
 			list_for_each_entry_rcu(list_p, &ap->list, list) {
 				if ((list_p != p) && (list_p->post_handler))
@@ -1911,7 +1884,6 @@ int register_kretprobe(struct kretprobe *rp)
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 	rp->kp.fault_handler = NULL;
-	rp->kp.break_handler = NULL;
 
 	/* Pre-allocate memory for max kretprobe instances */
 	if (rp->maxactive <= 0) {
@@ -2034,7 +2006,6 @@ static void kill_kprobe(struct kprobe *p)
 		list_for_each_entry_rcu(kp, &p->list, list)
 			kp->flags |= KPROBE_FLAG_GONE;
 		p->post_handler = NULL;
-		p->break_handler = NULL;
 		kill_optimized_kprobe(p);
 	}
 	/*
