Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB31AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F362157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F362157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeHXLfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:35:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeHXLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:35:09 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ft72G-0002Wn-Ed; Fri, 24 Aug 2018 10:01:36 +0200
Date:   Fri, 24 Aug 2018 10:01:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()")
 may have revealed another problem
In-Reply-To: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
Message-ID: <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com> <20180824041245.GA2730@lerouge> <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018, Heiner Kallweit wrote:
> On 24.08.2018 06:12, Frederic Weisbecker wrote:
> > On Thu, Aug 16, 2018 at 08:13:03AM +0200, Heiner Kallweit wrote:
> >> Recently I started to get warning "NOHZ: local_softirq_pending 202" and
> >> I think it's related to mentioned commit (didn't bisect it yet).
> >> See log from suspending.
> >>
> >> I have no reason to think the fix is wrong, it may just have revealed
> >> another issue which existed before and was hidden by the bug.
> >>
> >> Rgds, Heiner
> >>
> >> [   75.073353] random: crng init done
> >> [   75.073402] random: 7 urandom warning(s) missed due to ratelimiting
> >> [   78.619564] PM: suspend entry (deep)
> >> [   78.619675] PM: Syncing filesystems ... done.
> >> [   78.653684] Freezing user space processes ... (elapsed 0.002 seconds) done.
> >> [   78.656094] OOM killer disabled.
> >> [   78.656113] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> >> [   78.658177] Suspending console(s) (use no_console_suspend to debug)
> >> [   78.663066] nuvoton-cir 00:07: disabled
> >> [   78.671817] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >> [   78.672210] sd 0:0:0:0: [sda] Stopping disk
> >> [   78.786651] ACPI: Preparing to enter system sleep state S3
> >> [   78.789613] PM: Saving platform NVS memory
> >> [   78.789759] Disabling non-boot CPUs ...
> >> [   78.805154] NOHZ: local_softirq_pending 202
> >> [   78.805182] NOHZ: local_softirq_pending 202
> >> [   78.807102] smpboot: CPU 1 is now offline
> > 
> > I've tried to reproduce with suspend on disk but got unsuccessful.
> > 
> > A small question as I see someone is having a similar issue with a stable
> > release only. On which kernel did you trigger that: upstream or stable?
> > 
> > I'll continue investigating.
> > 
> > Thanks.
> > 
> Affected is recent linux-next, after the commit mentioned in the subject.
> I can work around the warning (not sure whether it's a proper fix),
> see here:
> https://lkml.org/lkml/2018/8/18/272

Can you try the one I posted in this thread:

 https://lkml.kernel.org/r/alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de

Also below for reference.

Thanks,

	tglx

8<----------------
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5b33e2f5c0ed..6aab9d54a331 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -888,7 +888,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
 		static int ratelimit;
 
-		if (ratelimit < 10 &&
+		if (ratelimit < 10 && !in_softirq() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ: local_softirq_pending %02x\n",
 				(unsigned int) local_softirq_pending());
