Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A29C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C724E20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C724E20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeIFUa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbeIFUa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:30:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35F52075B;
        Thu,  6 Sep 2018 15:54:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fxwbq-0000I9-Ro; Thu, 06 Sep 2018 11:54:18 -0400
Message-Id: <20180906155217.201016180@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 06 Sep 2018 11:52:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] [GIT PULL] tracing: Fix two annoying bugs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This fixes two bugs:

 - The first one is a side effect caused by using SRCU for rcuidle
   tracepoints. It seems that perf was depending on the rcuidle
   tracepoints to make RCU watch when it wasn't. The real fix will
   be to have perf use SRCU instead of depending on RCU watching,
   but that can't be done until SRCU is safe to use in NMI context
   (Paul's working on that).

 - The second bug fix is for a bug that's been periodically making
   my tests fail randomly for some time. I haven't had time to track
   it down, but finally have. It has to do with stressing NMIs (via perf)
   while enabling or disabling ftrace function handling with lockdep
   enabled. If an interrupt happens and just as it returns, it sets
   lockdep back to "interrupts enabled" but before it returns an NMI
   is triggered, and if this happens while printk_nmi_enter has a
   breakpoint attached to it (because ftrace is converting it to or from
   nop to call fentry), the breakpoint trap also calls into lockdep,
   and since returning from the NMI to a interrupt handler, interrupts
   were disabled when the NMI went off, lockdep keeps its state as
   interrupts disabled when it returns back from the interrupt handler
   where interrupts are enabled. This causes lockdep_assert_irqs_enabled()
   to trigger a false positive.

Please pull the latest trace-v4.19-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.19-rc2

Tag SHA1: 0564bf12a919d435afdcc74bd015f9249dd572db
Head SHA1: d1c392c9e2a301f38998a353f467f76414e38725


Steven Rostedt (VMware) (2):
      tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints
      printk/tracing: Do not trace printk_nmi_enter()

----
 include/linux/tracepoint.h  | 8 ++++++--
 kernel/printk/printk_safe.c | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)
