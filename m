Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B328218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545893609;
	bh=9eIGzhddGNYcYoIzRd86sDvdRzSYgc2Y+c4UwWHwtqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K8QYkMwB2d+i5FD6+hrpmDY9CWZu+D0k2psEQ1PcdBItDtVMGVicTk2vmxj8FP7CW
	 46hIIUxOjYQSK3Rh2gLz/lxDWXfQhkf+LXTOaviAGm/JtY/sX3YRHV+H63UkB78V+h
	 Q+MVlJnLzdoBFfeKxEb4FFHNd1+hw74W5wNbt4F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeL0Gx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbeL0Gx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:53:28 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C88A214AE;
        Thu, 27 Dec 2018 06:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545893606;
        bh=9eIGzhddGNYcYoIzRd86sDvdRzSYgc2Y+c4UwWHwtqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ColcMETKtvV0kIKFESY9QGxYBE007pEwmcNLNnhKXFkPgd/QNoHU16l9xy5xaXMqW
         Elom9v8gjp8LKlO22cTIdMtlNSoIPkXU//E+1yhSvYr/blQkryICxCAx3aNNrgDdp0
         qW5U1xKubFxbsgIbppsnOiWgOSsZX13IVBE9R4Ik=
Date:   Thu, 27 Dec 2018 07:53:23 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
Message-ID: <20181227065321.GA3749@lerouge>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:58:54PM +0200, Heiner Kallweit wrote:
> On 28.09.2018 15:18, Frederic Weisbecker wrote:
> > On Thu, Sep 27, 2018 at 06:05:46PM +0200, Thomas Gleixner wrote:
> >> On Tue, 28 Aug 2018, Frederic Weisbecker wrote:
> >>> On Fri, Aug 24, 2018 at 07:06:32PM +0200, Heiner Kallweit wrote:
> >>>> I tested it and Frederic is right, it doesn't help. Can it be somehow related to
> >>>> the cpu being brought down during suspend? Because I get the warning only during
> >>>> suspend when the cpu is inactive already (but still online).
> >>>
> >>> It's hard to tell, I haven't been able to reproduce on suspend to disk/mem.
> >>>
> >>> Does this script eventually trigger it after some time?
> >>
> >> Any update to this?
> > 
> > Heiner? Can you please test the script I sent to you?
> > 
> > Thanks.
> > 
> Sorry, took some time .. And yes, running your script triggers the message too.
> 
> [   25.646015] x86: Booting SMP configuration:
> [   25.646044] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.664491] smpboot: CPU 1 is now offline
> [   25.679299] x86: Booting SMP configuration:
> [   25.679329] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.698449] smpboot: CPU 1 is now offline
> [   25.711698] x86: Booting SMP configuration:
> [   25.711727] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.729185] NOHZ: local_softirq_pending 202
> [   25.729229] NOHZ: local_softirq_pending 202
> [   25.730759] smpboot: CPU 1 is now offline
> [   25.744053] x86: Booting SMP configuration:
> [   25.744083] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.762520] smpboot: CPU 1 is now offline
> [   25.776834] x86: Booting SMP configuration:
> [   25.776863] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.794189] NOHZ: local_softirq_pending 202
> [   25.796672] smpboot: CPU 1 is now offline
> [   25.805970] x86: Booting SMP configuration:
> [   25.805999] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.827360] smpboot: CPU 1 is now offline
> [   25.839043] x86: Booting SMP configuration:
> [   25.839073] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.858184] NOHZ: local_softirq_pending 202
> [   25.862182] smpboot: CPU 1 is now offline
> [   25.873759] x86: Booting SMP configuration:
> [   25.873789] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [   25.893385] smpboot: CPU 1 is now offline
> 

Sorry, I got sidetracked and almost forgot about it.

So this is triggered by CPU hotplug. At some point the CPU has an
opportunity to go idle and for some reason the timer softirq is still
pending. We need to know which timer this is about and why the timer
softirq keeps pending.

I'm going to need your help again. Can you please run the following (possibly
repeat until it triggers the bug) ?

   echo 1 > /sys/devices/system/cpu/cpu1/online

   # Pause and reset tracing
   echo 0 > /sys/kernel/debug/tracing/tracing_on
   echo > /sys/kernel/debug/tracing/trace

   # Turn on relevant events
   echo 1 > /sys/kernel/debug/tracing/events/timer/timer_*/enable
   echo 1 > /sys/kernel/debug/tracing/events/irq/softirq_*/enable
   echo 1 > /sys/kernel/debug/tracing/tracing_on

   # Trigger
   echo 0 > /sys/devices/system/cpu/cpu1/online

   echo 0 > /sys/kernel/debug/tracing/tracing_on

And please apply the following patch before. With all that I'll have the
relevant informations stored in /sys/kernel/debug/tracing/per_cpu/cpu1/trace
Please send its content to me. Thanks!

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 69e673b..0e57a3b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -892,6 +892,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ: local_softirq_pending %02x\n",
 				(unsigned int) local_softirq_pending());
+			trace_dump_stack(0);
 			ratelimit++;
 		}
 		return false;

