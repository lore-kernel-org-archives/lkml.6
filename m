Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614F6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A96621567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1yWt30O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A96621567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeHXSCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeHXSCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:02:11 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D39B208CB;
        Fri, 24 Aug 2018 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535120837;
        bh=aavINfquTo50rgO/Rmdx/0lbTyr2PL7JRu363bKElw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1yWt30OdAK+pF45C5tRhNAPX+gbjyscbUX0uRyn9abVYSjnxpcLSJYi2celpPaq1
         wVC2yUrAIKCGcT/FOwjYYYWM4liGdEDpMEDwefk91MBxFlPxacJQCGZ3Rq48/mgGFo
         zBm3394NJfLcf/tggnWKYS0RcJlMGvqrYOul9OS0=
Date:   Fri, 24 Aug 2018 16:27:15 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
Message-ID: <20180824142713.GB2730@lerouge>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org>
 <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com>
 <20180824061750.GA20523@kroah.com>
 <alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 09:01:02AM +0200, Thomas Gleixner wrote:
> On Fri, 24 Aug 2018, Greg KH wrote:
> > On Thu, Aug 23, 2018 at 05:57:06PM -0500, Grygorii Strashko wrote:
> > > This patch was back ported to the Stable linux-4.14.y and It causes regression -
> > >  flood of "NOHZ: local_softirq_pending" messages on all TI boards during boot (NFS boot):
> > > 
> > > [    4.179796] NOHZ: local_softirq_pending 2c2 in sirq 256
> > > [    4.185051] NOHZ: local_softirq_pending 2c2 in sirq 256
> 
> This printout is weird. Did you add something here?
> 
> > > the same is not reproducible with LKML - seems due to changes in tick-sched.c 
> > > __tick_nohz_idle_enter()/tick_nohz_irq_exit().
> > 
> > What changes do you think fixed this?
> > 
> > > I've generated backtrace from  can_stop_idle_tick() (see below) and seems this
> > > patch makes tick_nohz_irq_exit() call unconditional in case of nested interrupt:
> > > 
> > > gic_handle_irq
> > >  |- irq_exit
> > >     |- preempt_count_sub(HARDIRQ_OFFSET); <-- [1]
> > >     |-__do_softirq 
> > > 	<irqs enabled>
> > > 	|- gic_handle_irq()
> > > 	   |- irq_exit()
> > > 		|- tick_irq_exit()
> > > 		   if (!in_irq()) <-- My understanding is that this condition will be always true due to [1]
> 
> Correct, but that's not the problem. The issue is that this happens in a
> softirq disabled region. Does the below fix it?
> 
> Thanks,
> 
> 	tglx
> 
> 8<--------------------
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
> 
> 

Good catch! In 4.14 Rafael hadn't yet changed the path where we stop the idle tick.
We were still stopping it from irq exit and so we could do that while interrupting a
softirq. So we may need to backport this along with "nohz: Fix missing tick reprogram
when interrupting an inline softirq".
