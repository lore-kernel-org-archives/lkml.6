Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CABC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6842170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6842170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeHZK3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:29:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53848 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeHZK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:29:23 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9FC925A;
        Sun, 26 Aug 2018 06:47:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 25/56] locking/lockdep: Do not record IRQ state within lockdep code
Date:   Sun, 26 Aug 2018 08:44:46 +0200
Message-Id: <20180826064233.606624572@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
References: <20180826064232.320669119@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit fcc784be837714a9173b372ff9fb9b514590dad9 ]

While debugging where things were going wrong with mapping
enabling/disabling interrupts with the lockdep state and actual real
enabling and disabling interrupts, I had to silent the IRQ
disabling/enabling in debug_check_no_locks_freed() because it was
always showing up as it was called before the splat was.

Use raw_local_irq_save/restore() for not only debug_check_no_locks_freed()
but for all internal lockdep functions, as they hide useful information
about where interrupts were used incorrectly last.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/lkml/20180404140630.3f4f4c7a@gandalf.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/lockdep.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1253,11 +1253,11 @@ unsigned long lockdep_count_forward_deps
 	this.parent = NULL;
 	this.class = class;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return ret;
 }
@@ -1280,11 +1280,11 @@ unsigned long lockdep_count_backward_dep
 	this.parent = NULL;
 	this.class = class;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return ret;
 }
@@ -4083,7 +4083,7 @@ void debug_check_no_locks_freed(const vo
 	if (unlikely(!debug_locks))
 		return;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
 
@@ -4094,7 +4094,7 @@ void debug_check_no_locks_freed(const vo
 		print_freed_lock_bug(curr, mem_from, mem_from + mem_len, hlock);
 		break;
 	}
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(debug_check_no_locks_freed);
 


