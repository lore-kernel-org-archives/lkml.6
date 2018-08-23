Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FBDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363B621564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MR9nIdmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363B621564
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeHXC3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:29:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37046 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHXC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:29:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7NMv7lH118016;
        Thu, 23 Aug 2018 17:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535065027;
        bh=lV3tdLEZA6D/1TkSc1jxOM4HqRMGeXYLokt7c3jVnOE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MR9nIdmgGiNqq6LmZD+8ac/by85TZDDqElSc0VHtKfQioMaOQiiPCZl5CWYxZw3g2
         yXQeNOcBTqt8toB1jEcj9voYNRoIhSyiHt2hDbzaNJVsrYUBxwMGmT+el1hQtMGgLq
         9oHpbi0su/16YfkYJWrSzSrOg3fAVBISu1vKUqDs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7NMv7dA024853;
        Thu, 23 Aug 2018 17:57:07 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 23
 Aug 2018 17:57:07 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 23 Aug 2018 17:57:06 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7NMv6fb026993;
        Thu, 23 Aug 2018 17:57:06 -0500
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com>
Date:   Thu, 23 Aug 2018 17:57:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533077570-9169-1-git-send-email-frederic@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 07/31/2018 05:52 PM, Frederic Weisbecker wrote:
> Before updating the full nohz tick or the idle time on IRQ exit, we
> check first if we are not in a nesting interrupt, whether the inner
> interrupt is a hard or a soft IRQ.
> 
> There is a historical reason for that: the dyntick idle mode used to
> reprogram the tick on IRQ exit, after softirq processing, and there was
> no point in doing that job in the outer nesting interrupt because the
> tick update will be performed through the end of the inner interrupt
> eventually, with even potential new timer updates.
> 
> One corner case could show up though: if an idle tick interrupts a softirq
> executing inline in the idle loop (through a call to local_bh_enable())
> after we entered in dynticks mode, the IRQ won't reprogram the tick
> because it assumes the softirq executes on an inner IRQ-tail. As a
> result we might put the CPU in sleep mode with the tick completely
> stopped whereas a timer can still be enqueued. Indeed there is no tick
> reprogramming in local_bh_enable(). We probably asssumed there was no bh
> disabled section in idle, although there didn't seem to be debug code
> ensuring that.
> 
> Nowadays the nesting interrupt optimization still stands but only concern
> full dynticks. The tick is stopped on IRQ exit in full dynticks mode
> and we want to wait for the end of the inner IRQ to reprogramm the tick.
> But in_interrupt() doesn't make a difference between softirqs executing
> on IRQ tail and those executing inline. What was to be considered a
> corner case in dynticks-idle mode now becomes a serious opportunity for
> a bug in full dynticks mode: if a tick interrupts a task executing
> softirq inline, the tick reprogramming will be ignored and we may exit
> to userspace after local_bh_enable() with an enqueued timer that will
> never fire.
> 
> To fix this, simply keep reprogramming the tick if we are in a hardirq
> interrupting softirq. We can still figure out a way later to restore
> this optimization while excluding inline softirq processing.
> 
> Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Tested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
>   kernel/softirq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 900dcfe..0980a81 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -386,7 +386,7 @@ static inline void tick_irq_exit(void)
>   
>   	/* Make sure that timer wheel updates are propagated */
>   	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> -		if (!in_interrupt())
> +		if (!in_irq())
>   			tick_nohz_irq_exit();
>   	}
>   #endif
> 

This patch was back ported to the Stable linux-4.14.y and It causes regression -
 flood of "NOHZ: local_softirq_pending" messages on all TI boards during boot (NFS boot):

[    4.179796] NOHZ: local_softirq_pending 2c2 in sirq 256
[    4.185051] NOHZ: local_softirq_pending 2c2 in sirq 256

the same is not reproducible with LKML - seems due to changes in tick-sched.c 
__tick_nohz_idle_enter()/tick_nohz_irq_exit().

I've generated backtrace from  can_stop_idle_tick() (see below) and seems this
patch makes tick_nohz_irq_exit() call unconditional in case of nested interrupt:

gic_handle_irq
 |- irq_exit
    |- preempt_count_sub(HARDIRQ_OFFSET); <-- [1]
    |-__do_softirq 
	<irqs enabled>
	|- gic_handle_irq()
	   |- irq_exit()
		|- tick_irq_exit()
		   if (!in_irq()) <-- My understanding is that this condition will be always true due to [1]
			tick_nohz_irq_exit();
			|-__tick_nohz_idle_enter()
			  |- can_stop_idle_tick()

Sry, not sure if my conclusion is right and how can it be fixed.


[    3.842320] NOHZ: local_softirq_pending 40 in sirq 256
[    3.847485] ------------[ cut here ]------------
[    3.852133] WARNING: CPU: 0 PID: 0 at kernel/time/tick-sched.c:915 __tick_nohz_idle_enter+0x4b8/0x568
[    3.861393] Modules linked in:
[    3.864469] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.66-01768-gc26f664-dirty #311
[    3.872506] Hardware name: Generic DRA74X (Flattened Device Tree)
[    3.878623] Backtrace: 
[    3.881091] [<c010c050>] (dump_backtrace) from [<c010c320>] (show_stack+0x18/0x1c)
[    3.888696]  r7:00000009 r6:600f0193 r5:00000000 r4:c0c5fca4
[    3.894386] [<c010c308>] (show_stack) from [<c07ad028>] (dump_stack+0x8c/0xa0)
[    3.901645] [<c07acf9c>] (dump_stack) from [<c012e558>] (__warn+0xec/0x104)
[    3.908638]  r7:00000009 r6:c0996d08 r5:00000000 r4:00000000
[    3.914329] [<c012e46c>] (__warn) from [<c012e628>] (warn_slowpath_null+0x28/0x30)
[    3.921933]  r9:00000000 r8:e4e1f7de r7:c0c8c1d8 r6:c0c65180 r5:00000000 r4:eed408e8
[    3.929715] [<c012e600>] (warn_slowpath_null) from [<c01a9780>] (__tick_nohz_idle_enter+0x4b8/0x568)
[    3.938890] [<c01a92c8>] (__tick_nohz_idle_enter) from [<c01a9c74>] (tick_nohz_irq_exit+0x2c/0x30)
[    3.947890]  r10:c0c01f50 r9:c0c00000 r8:ee008000 r7:00000000 r6:c0c01ee0 r5:00000048
[    3.955752]  r4:c0b62afc
[    3.958301] [<c01a9c48>] (tick_nohz_irq_exit) from [<c0133748>] (irq_exit+0xf4/0x144)
[    3.966173] [<c0133654>] (irq_exit) from [<c0181e6c>] (__handle_domain_irq+0x68/0xbc)
[    3.974043] [<c0181e04>] (__handle_domain_irq) from [<c0101508>] (gic_handle_irq+0x44/0x80)
[    3.982432]  r9:c0c00000 r8:fa213000 r7:fa212000 r6:c0c01dd0 r5:fa21200c r4:c0c03ff0
[    3.990211] [<c01014c4>] (gic_handle_irq) from [<c010cf4c>] (__irq_svc+0x6c/0xa8)
[    3.997726] Exception stack(0xc0c01dd0 to 0xc0c01e18)
[    4.002800] 1dc0:                                     00000000 c0c65180 00000000 00000000
[    4.011017] 1de0: 00000280 00000013 c0c00000 00000000 ee008000 c0c00000 c0c01f50 c0c01e7c
[    4.019232] 1e00: c0c01e80 c0c01e20 c0133730 c01015dc 600f0113 ffffffff
[    4.025877]  r9:c0c00000 r8:ee008000 r7:c0c01e04 r6:ffffffff r5:600f0113 r4:c01015dc
[    4.033659] [<c0101548>] (__do_softirq) from [<c0133730>] (irq_exit+0xdc/0x144)
[    4.041002]  r10:c0c01f50 r9:c0c00000 r8:ee008000 r7:00000000 r6:00000000 r5:00000013
[    4.048863]  r4:c0b62afc
[    4.051414] [<c0133654>] (irq_exit) from [<c0181e6c>] (__handle_domain_irq+0x68/0xbc)
[    4.059280] [<c0181e04>] (__handle_domain_irq) from [<c0101508>] (gic_handle_irq+0x44/0x80)
[    4.067670]  r9:c0c00000 r8:fa213000 r7:fa212000 r6:c0c01ee0 r5:fa21200c r4:c0c03ff0
[    4.075448] [<c01014c4>] (gic_handle_irq) from [<c010cf4c>] (__irq_svc+0x6c/0xa8)
[    4.082963] Exception stack(0xc0c01ee0 to 0xc0c01f28)
[    4.088041] 1ee0: 00000001 00000000 fe600000 00000000 c0c00000 c0c03cc8 c0c03c68 c0b623b8
[    4.096258] 1f00: 00000000 00000000 c0c01f50 c0c01f3c c0c01f1c c0c01f30 c0120f14 c0108ae4
[    4.104469] 1f20: 600f0013 ffffffff
[    4.107975]  r9:c0c00000 r8:00000000 r7:c0c01f14 r6:ffffffff r5:600f0013 r4:c0108ae4
[    4.115760] [<c0108abc>] (arch_cpu_idle) from [<c07c6a14>] (default_idle_call+0x28/0x34)
[    4.123894] [<c07c69ec>] (default_idle_call) from [<c016e4a4>] (do_idle+0x180/0x214)
[    4.131676] [<c016e324>] (do_idle) from [<c016e7fc>] (cpu_startup_entry+0x20/0x24)
[    4.139283]  r10:effff7c0 r9:c0b48a30 r8:c0c64000 r7:c0c03c40 r6:ffffffff r5:00000002
[    4.147146]  r4:000000be
[    4.149698] [<c016e7dc>] (cpu_startup_entry) from [<c07c12e4>] (rest_init+0xd8/0xdc)
[    4.157483] [<c07c120c>] (rest_init) from [<c0b00d8c>] (start_kernel+0x3cc/0x3d8)
[    4.164997]  r5:c0c64000 r4:c0c6404c
[    4.168592] [<c0b009c0>] (start_kernel) from [<8000807c>] (0x8000807c)
[    4.175148] ---[ end trace 9c10a64bf81ad3fe ]---


-- 
regards,
-grygorii
