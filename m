Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F67DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A444208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ2CHAXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A444208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeH1GPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeH1GPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:15:11 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D35C2084C;
        Tue, 28 Aug 2018 02:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535423149;
        bh=f53YcoBdQlnMX0T3h5u2LbWAVRs9EUayMMp/75ouAPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQ2CHAXjrPU2fJbn9TCulQBk+5vF1HFeW9D8fcU5EqKWjdLRiXziZxrQa3rsVuTCT
         UY9ythDb1fkmQoZOAGJv4ItZD70SNKv1zMogeWv0VxzEX3oTZ9ZRpXtO3nmUWb6PT+
         UlshwmlI0Mv2VbxeIcWL/JKSrmhwzX3e2Lkby/10=
Date:   Tue, 28 Aug 2018 04:25:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
Message-ID: <20180828022545.GA25943@lerouge>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 24, 2018 at 07:06:32PM +0200, Heiner Kallweit wrote:
> On 24.08.2018 16:30, Frederic Weisbecker wrote:
> >> Can you try the one I posted in this thread:
> >>
> >>  https://lkml.kernel.org/r/alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de
> >>
> >> Also below for reference.
> >>
> >> Thanks,
> >>
> >> 	tglx
> >>
> >> 8<----------------
> >> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> >> index 5b33e2f5c0ed..6aab9d54a331 100644
> >> --- a/kernel/time/tick-sched.c
> >> +++ b/kernel/time/tick-sched.c
> >> @@ -888,7 +888,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
> >>  	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
> >>  		static int ratelimit;
> >>  
> >> -		if (ratelimit < 10 &&
> >> +		if (ratelimit < 10 && !in_softirq() &&
> >>  		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
> >>  			pr_warn("NOHZ: local_softirq_pending %02x\n",
> >>  				(unsigned int) local_softirq_pending());
> > 
> > I fear it may not work in his case because it happens in -next and we don't stop
> > the idle tick from IRQ tail anymore. So we shouldn't be interrupting a softirq
> > in this path. Still it's worth trying, I may well be missing something.
> > 
> > Thanks.
> > 
> I tested it and Frederic is right, it doesn't help. Can it be somehow related to
> the cpu being brought down during suspend? Because I get the warning only during
> suspend when the cpu is inactive already (but still online).

It's hard to tell, I haven't been able to reproduce on suspend to disk/mem.

Does this script eventually trigger it after some time?


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hotplug_fun

#!/bin/bash

do_hotplug()
{
	for i in $(seq 1 $2)
	do
		echo $1 > /sys/devices/system/cpu/cpu$i/online
	done
}

LAST_CPU=$(($(nproc)-1))

while true
do
	do_hotplug 0 $LAST_CPU
	do_hotplug 1 $LAST_CPU
done

--W/nzBZO5zC0uMSeA--
