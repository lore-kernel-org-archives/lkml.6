Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE64C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B102173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546922747;
	bh=0zKmcOyZQlLDqGkpZYh9nPZKjm6SYsLulXSM+DBXKCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UuLKjDiw5cYGukIaozI7MZSAGrbmr6UTmJ5rrQpH9pAfnq5+5qWaTmzJMsLhpbzPw
	 0qox2yzYWvR52PHxUogAayBxtBIUEWUb1gK6iaAh4xVn8QEZGtjnI7AySt0woCZX0U
	 E8vy3LnQuoKyQkfqNhe519coH36ryiq2a6236MAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfAHEpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfAHEpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:45:46 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C682087F;
        Tue,  8 Jan 2019 04:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546922745;
        bh=0zKmcOyZQlLDqGkpZYh9nPZKjm6SYsLulXSM+DBXKCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSOtz8icnEXNBS9Vq4UBT177wLGT5Xl6RDQ4jQZW2QD7GD3Ozq7YBgFJRFzMovGoN
         KlvwOzY+Km9Brv+8AAhpqM2c5RcDwJxR0+gGpTnaj8Y3OgiG7/YiYVULJnmgCZnHJN
         z9SpFif/AxRDoSzJcZ0h6sEbToZpgT0ZUFMPqNO4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH v2 3/3] x86/kprobes: Fix to avoid kretprobe recursion
Date:   Tue,  8 Jan 2019 13:45:22 +0900
Message-Id: <154692272225.1133.799265848498671353.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154692263564.1133.17363562046971295490.stgit@devbox>
References: <154692263564.1133.17363562046971295490.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to avoid kretprobe recursion loop by setting a dummy
kprobes to current_kprobe per-cpu variable.

This bug has been introduced with the asm-coded trampoline
code, since previously it used another kprobe for hooking
the function return placeholder (which only has a nop) and
trampoline handler was called from that kprobe.

This revives the old lost kprobe again.

With this fix, we don't see deadlock anymore.

# echo "r:event_1 __fdget" >> kprobe_events
# echo "r:event_2 _raw_spin_lock_irqsave" >> kprobe_events
# echo 1 > events/kprobes/enable

And you can see that all inner-called kretprobe are skipped.

# cat kprobe_profile
  event_1                                  235               0
  event_2                                19375           19612

The 1st column is recorded count and the 2nd is missed count.
Above shows (event_1 rec) + (event_2 rec) ~= (event_2 missed)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Andrea Righi <righi.andrea@gmail.com>
Fixes: c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/kprobes/core.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 69b6400d1ce2..f4b954ff5b89 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -749,11 +749,16 @@ asm(
 NOKPROBE_SYMBOL(kretprobe_trampoline);
 STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 
+static struct kprobe kretprobe_kprobe = {
+	.addr = (void *)kretprobe_trampoline,
+};
+
 /*
  * Called from kretprobe_trampoline
  */
 static __used void *trampoline_handler(struct pt_regs *regs)
 {
+	struct kprobe_ctlblk *kcb;
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
 	struct hlist_node *tmp;
@@ -763,6 +768,17 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 	void *frame_pointer;
 	bool skipped = false;
 
+	preempt_disable();
+
+	/*
+	 * Set a dummy kprobe for avoiding kretprobe recursion.
+	 * Since kretprobe never run in kprobe handler, kprobe must not
+	 * be running at this point.
+	 */
+	kcb = get_kprobe_ctlblk();
+	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
 	/* fixup registers */
@@ -838,10 +854,9 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 		orig_ret_address = (unsigned long)ri->ret_addr;
 		if (ri->rp && ri->rp->handler) {
 			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
 			ri->ret_addr = correct_ret_addr;
 			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
+			__this_cpu_write(current_kprobe, &kretprobe_kprobe);
 		}
 
 		recycle_rp_inst(ri, &empty_rp);
@@ -857,6 +872,9 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 
 	kretprobe_hash_unlock(current, &flags);
 
+	__this_cpu_write(current_kprobe, NULL);
+	preempt_enable();
+
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);

