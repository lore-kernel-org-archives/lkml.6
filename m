Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19DEECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C29208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KXIZD+NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C29208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeGMK4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:56:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39460 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeGMK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2JcGuKPNfIcPaRF9Ntt4esu34k1ozj0sCQpV6FSjcqE=; b=KXIZD+NJdonBNeTe6VOeZCvOk
        7v1CYL/NRAxtRDjumuwrg/Krx8zOAvHfLU/cv/V6mOeClT5cCD4CcQnsVBWB2OPhS1NBqbWDftamE
        zqHYoq03pQiWoFE4CJOJdqwXGyZPwxeElM3pd/lI+h8jC4sucFbvk8Jp3RJ8g9ecMq8bauHRmtW6s
        l3sCog8h64gseuZXUgb9Rm8x6GzinKXdlvZlP6Ja3B1M3abmGOV3IuEpsljBpo1m0RFOHnBqdbd+Z
        OeGlvHUMGrxGXm6cOKm8SJYrtE/W7wbs1fzhci5ivRjmORJ3VuDgjb6EqzOY544TdlySVPWhvRaWn
        yUJHU36Ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdvWc-0006dW-WF; Fri, 13 Jul 2018 10:42:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F8AA20298BAE; Fri, 13 Jul 2018 12:42:08 +0200 (CEST)
Date:   Fri, 13 Jul 2018 12:42:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, LKP <lkp@01.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [LKP] [lkp-robot] 9cf57731b6 [ 8.051016] WARNING: CPU: 1 PID: 58
 at lib/list_debug.c:28 __list_add_valid
Message-ID: <20180713104208.GW2494@hirez.programming.kicks-ass.net>
References: <20180711060753.GC17385@shao2-debian>
 <20180711123436.GD2476@hirez.programming.kicks-ass.net>
 <85eb9dd4-2a20-9c2a-d805-e38cf749f187@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85eb9dd4-2a20-9c2a-d805-e38cf749f187@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:32:41PM +0800, Rong Chen wrote:
> Thanks, it's fixed with the patch.

Ingo, could you merge?

---
Subject: watchdog/softlockup: Fix cpu_stop_queue_work double-queue
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 11 Jul 2018 14:34:36 +0200

When scheduling is delayed for longer than the softlockup interrupt
period it is possible to double-queue the cpu_stop_work, causing list
corruption.

Cure this by adding a completion to track the cpu_stop_work's
progress.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Rong Chen <rong.a.chen@intel.com>
Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/watchdog.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b81f777838d5..5470dce212c0 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -330,6 +330,9 @@ static void watchdog_interrupt_count(void)
 	__this_cpu_inc(hrtimer_interrupts);
 }
 
+static DEFINE_PER_CPU(struct completion, softlockup_completion);
+static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
+
 /*
  * The watchdog thread function - touches the timestamp.
  *
@@ -343,12 +346,11 @@ static int softlockup_fn(void *data)
 	__this_cpu_write(soft_lockup_hrtimer_cnt,
 			 __this_cpu_read(hrtimer_interrupts));
 	__touch_watchdog();
+	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
 }
 
-static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
-
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
@@ -364,9 +366,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	watchdog_interrupt_count();
 
 	/* kick the softlockup detector */
-	stop_one_cpu_nowait(smp_processor_id(),
-			softlockup_fn, NULL,
-			this_cpu_ptr(&softlockup_stop_work));
+	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
+		reinit_completion(this_cpu_ptr(&softlockup_completion));
+		stop_one_cpu_nowait(smp_processor_id(),
+				softlockup_fn, NULL,
+				this_cpu_ptr(&softlockup_stop_work));
+	}
 
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
@@ -467,9 +472,13 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 static void watchdog_enable(unsigned int cpu)
 {
 	struct hrtimer *hrtimer = this_cpu_ptr(&watchdog_hrtimer);
+	struct completion *done = this_cpu_ptr(&softlockup_completion);
 
 	WARN_ON_ONCE(cpu != smp_processor_id());
 
+	init_completion(done);
+	complete(done);
+
 	/*
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
@@ -499,6 +508,7 @@ static void watchdog_disable(unsigned int cpu)
 	 */
 	watchdog_nmi_disable(cpu);
 	hrtimer_cancel(hrtimer);
+	wait_for_completion(this_cpu_ptr(&softlockup_completion));
 }
 
 static int softlockup_stop_fn(void *data)
