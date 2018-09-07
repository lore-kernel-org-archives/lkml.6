Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E12C04ABF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C123C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C123C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeIHBmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbeIHBmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:16 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960702088E;
        Fri,  7 Sep 2018 20:59:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNqn-0001vO-LJ; Fri, 07 Sep 2018 16:59:33 -0400
Message-Id: <20180907205933.547534163@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:59:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 23/24] Revert "softirq: keep the softirq pending check RT-only"
References: <20180907205857.262840394@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

This reverts commit 5536f5491a2e098ba34995662dfc0e82d66d65c9.

Sebastian says that the stable commits:

 0a0e0829f9901 ("nohz: Fix missing tick reprogram when interrupting an inline softirq")
 80d20d35af1ed ("nohz: Fix local_timer_softirq_pending()")

Make this commit obsolete, thus it should be reverted.

Link: http://lkml.kernel.org/r/20180906193028.jvyp2dj3rto4ax7s@linutronix.de

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/softirq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 996b03fb8c53..ec801952785a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -842,13 +842,8 @@ static inline void tick_irq_exit(void)
 	int cpu = smp_processor_id();
 
 	/* Make sure that timer wheel updates are propagated */
-#ifdef CONFIG_PREEMPT_RT_BASE
 	if ((idle_cpu(cpu) || tick_nohz_full_cpu(cpu)) &&
-	    !need_resched() && !local_softirq_pending())
-#else
-	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu))
-#endif
-	{
+	    !need_resched() && !local_softirq_pending()) {
 		if (!in_irq())
 			tick_nohz_irq_exit();
 	}
-- 
2.18.0


