Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D969217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dpqY5X9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbfBRRkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:40:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388679AbfBRRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nZIBjTJMljRgQbUILCO9kyTlnGBEtW3IPhntGgIRl3M=; b=dpqY5X9V238t8oQt8rRxWkMpqi
        d4+mN31PwW3+9mQM7zhkhJaon83X7L4RbXR2RM+qxMIq02hRHoM2wVnHEr/vtwg1V/lLYYgkY3lAh
        nTF0/stfLUNMSkYRNvmf4QjZHhaivJvpyYf4+EqYhO2tRplse1OJGIZ/CBDdi28xD3tJbDaiwuXBf
        VDCeCTdKDWiUruKbR9Z/bmHKiNFW4optTiDYBNswTcV9XyPAm/WU2XCKMrqtk7wEAGQ1uokMpjxIZ
        un5m4/lk1CSvcu6a/GBLm2w31h25Av+y+9J1N/SAbcvNSfnCfTOG2BJVaPQPJKpe/yO/rVSVf2nr2
        R4YPqkZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu3-0005zE-9r; Mon, 18 Feb 2019 17:40:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4C7492848B880; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.726709470@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 14/16] sched/fair: Add a few assertions
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6208,6 +6208,11 @@ static int select_idle_sibling(struct ta
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
+	/*
+	 * per-cpu select_idle_mask usage
+	 */
+	lockdep_assert_irqs_disabled();
+
 	if (available_idle_cpu(target))
 		return target;
 
@@ -6635,8 +6640,6 @@ static int find_energy_efficient_cpu(str
  * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
  *
  * Returns the target CPU number.
- *
- * preempt must be disabled.
  */
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
@@ -6647,6 +6650,11 @@ select_task_rq_fair(struct task_struct *
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
+	/*
+	 * required for stable ->cpus_allowed
+	 */
+	lockdep_assert_held(&p->pi_lock);
+
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
 


