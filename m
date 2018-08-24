Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DE7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFDB208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l9IQotrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFDB208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeHXTqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:46:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41230 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:46:15 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7OGAjZO117556;
        Fri, 24 Aug 2018 11:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535127045;
        bh=Gh5G4YTC1MBkOY3btFq4AU+dzmrFIFwJbUY/FKi7R1k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l9IQotrl8dlQIx9v51Pep42a01Q/P5rpMzXX6YRXrImEVKpLdxOWMrUF/bhSQylLW
         EvapNnh2BYXNnCQnGjNyHmDawqmOVvqyv01Qxf17/G4chRZCBgPYJriXjUEmUpL0k/
         5det77ujJWIrhxklwgvSMOT6l4g5IwOSwmn5RCxg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7OGAjd2022809;
        Fri, 24 Aug 2018 11:10:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 24
 Aug 2018 11:10:44 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 24 Aug 2018 11:10:44 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7OGAitb014998;
        Fri, 24 Aug 2018 11:10:44 -0500
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        <stable@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org>
 <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com>
 <20180824061750.GA20523@kroah.com>
 <alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0d63c2bb-f75d-3f79-c19d-bb4ac9a00cd5@ti.com>
Date:   Fri, 24 Aug 2018 11:10:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808240851420.1668@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/24/2018 02:01 AM, Thomas Gleixner wrote:
> On Fri, 24 Aug 2018, Greg KH wrote:
>> On Thu, Aug 23, 2018 at 05:57:06PM -0500, Grygorii Strashko wrote:
>>> This patch was back ported to the Stable linux-4.14.y and It causes regression -
>>>   flood of "NOHZ: local_softirq_pending" messages on all TI boards during boot (NFS boot):
>>>
>>> [    4.179796] NOHZ: local_softirq_pending 2c2 in sirq 256
>>> [    4.185051] NOHZ: local_softirq_pending 2c2 in sirq 256
> 
> This printout is weird. Did you add something here?

yes. 

ff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index da74d2f..a5fad1c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -910,8 +910,9 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 
                if (ratelimit < 100 &&
                    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-                       pr_warn("NOHZ: local_softirq_pending %02x in sirq %d\n",
+                       pr_warn("NOHZ: local_softirq_pending %02x in sirq %lu\n",
                                (unsigned int) local_softirq_pending(), in_softirq());
+                       WARN_ON_ONCE(true);
                        ratelimit++;
                }


> 
>>> the same is not reproducible with LKML - seems due to changes in tick-sched.c
>>> __tick_nohz_idle_enter()/tick_nohz_irq_exit().
>>
>> What changes do you think fixed this?
>>
>>> I've generated backtrace from  can_stop_idle_tick() (see below) and seems this
>>> patch makes tick_nohz_irq_exit() call unconditional in case of nested interrupt:
>>>
>>> gic_handle_irq
>>>   |- irq_exit
>>>      |- preempt_count_sub(HARDIRQ_OFFSET); <-- [1]
>>>      |-__do_softirq
>>> 	<irqs enabled>
>>> 	|- gic_handle_irq()
>>> 	   |- irq_exit()
>>> 		|- tick_irq_exit()
>>> 		   if (!in_irq()) <-- My understanding is that this condition will be always true due to [1]
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
>   	if (unlikely(local_softirq_pending() && cpu_online(cpu))) {
>   		static int ratelimit;
>   
> -		if (ratelimit < 10 &&
> +		if (ratelimit < 10 && !in_softirq() &&
>   		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
>   			pr_warn("NOHZ: local_softirq_pending %02x\n",
>   				(unsigned int) local_softirq_pending());
> 
> 

Yes. i do not see local_softirq_pending messages any more

But one question, just to clarify, after patch "nohz: Fix missing tick reprog while interrupting inline timer softirq"
the tick_nohz_irq_exit() will be called few times in case of nested interrupts (min 2):
gic_handle_irq
 |- irq_exit
    |- preempt_count_sub(HARDIRQ_OFFSET); 
    |-__do_softirq 
	<irqs enabled>
	|- gic_handle_irq()
	   |- irq_exit()
		|- tick_irq_exit()
		   if (!in_irq())
			tick_nohz_irq_exit(); <-- [1]
    |- tick_irq_exit()
	if (!in_irq())
		tick_nohz_irq_exit(); <-- [2]

Is it correct? in 4.14 tick_nohz_irq_exit() is much more complex then in LKML now,
and this is hot path.


-- 
regards,
-grygorii
