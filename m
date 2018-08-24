Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E492C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0980A2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP7PoMx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0980A2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeHXSFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeHXSFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:05:55 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97AAF208B7;
        Fri, 24 Aug 2018 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535121060;
        bh=hsTsbIMfF+6ijLVnBqttEZiXCMTpgyfadtbOuAHc1mE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UP7PoMx7VYNVwp2k5J/BVGuoP5fH+Y5j22rUuNc0qWNA+UDAgeAVeBFNiliBuFjYj
         REqHTiw3KZ9m848Ha5+UStemSRPcQ7g2rRqj8/g+P70oHNoSpfJHjuo+2NEWbvTZGa
         Czj624fKPpWgWovvW1KFkLgnqu33idusd65ZYN08=
Date:   Fri, 24 Aug 2018 16:30:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
Message-ID: <20180824143056.GC2730@lerouge>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 10:01:35AM +0200, Thomas Gleixner wrote:
> On Fri, 24 Aug 2018, Heiner Kallweit wrote:
> > On 24.08.2018 06:12, Frederic Weisbecker wrote:
> > > On Thu, Aug 16, 2018 at 08:13:03AM +0200, Heiner Kallweit wrote:
> > >> Recently I started to get warning "NOHZ: local_softirq_pending 202" and
> > >> I think it's related to mentioned commit (didn't bisect it yet).
> > >> See log from suspending.
> > >>
> > >> I have no reason to think the fix is wrong, it may just have revealed
> > >> another issue which existed before and was hidden by the bug.
> > >>
> > >> Rgds, Heiner
> > >>
> > >> [   75.073353] random: crng init done
> > >> [   75.073402] random: 7 urandom warning(s) missed due to ratelimiting
> > >> [   78.619564] PM: suspend entry (deep)
> > >> [   78.619675] PM: Syncing filesystems ... done.
> > >> [   78.653684] Freezing user space processes ... (elapsed 0.002 seconds) done.
> > >> [   78.656094] OOM killer disabled.
> > >> [   78.656113] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > >> [   78.658177] Suspending console(s) (use no_console_suspend to debug)
> > >> [   78.663066] nuvoton-cir 00:07: disabled
> > >> [   78.671817] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > >> [   78.672210] sd 0:0:0:0: [sda] Stopping disk
> > >> [   78.786651] ACPI: Preparing to enter system sleep state S3
> > >> [   78.789613] PM: Saving platform NVS memory
> > >> [   78.789759] Disabling non-boot CPUs ...
> > >> [   78.805154] NOHZ: local_softirq_pending 202
> > >> [   78.805182] NOHZ: local_softirq_pending 202
> > >> [   78.807102] smpboot: CPU 1 is now offline
> > > 
> > > I've tried to reproduce with suspend on disk but got unsuccessful.
> > > 
> > > A small question as I see someone is having a similar issue with a stable
> > > release only. On which kernel did you trigger that: upstream or stable?
> > > 
> > > I'll continue investigating.
> > > 
> > > Thanks.
> > > 
> > Affected is recent linux-next, after the commit mentioned in the subject.
> > I can work around the warning (not sure whether it's a proper fix),
> > see here:
> > https://lkml.org/lkml/2018/8/18/272
> 
> Can you try the one I posted in this thread:
> 
>  https://lkml.kernel.org/r/alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de
> 
> Also below for reference.
> 
> Thanks,
> 
> 	tglx
> 
> 8<----------------
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 5b33e2f5c0ed..6aab9d54a331 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -888,7 +888,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
>  	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
>  		static int ratelimit;
>  
> -		if (ratelimit < 10 &&
> +		if (ratelimit < 10 && !in_softirq() &&
>  		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
>  			pr_warn("NOHZ: local_softirq_pending %02x\n",
>  				(unsigned int) local_softirq_pending());

I fear it may not work in his case because it happens in -next and we don't stop
the idle tick from IRQ tail anymore. So we shouldn't be interrupting a softirq
in this path. Still it's worth trying, I may well be missing something.

Thanks.
