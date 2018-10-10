Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B578C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FC72086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FC72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=krieglstein.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJJXTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:19:55 -0400
Received: from krieglstein.org ([176.28.13.145]:49008 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJJXTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:19:55 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 19:19:54 EDT
From:   Tim Sander <tim@krieglstein.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v4.18.12-rt7 stall
Date:   Wed, 10 Oct 2018 17:47:39 +0200
Message-ID: <3528549.VBrINidF4t@dabox>
Organization: Sander and Lightning
In-Reply-To: <20181009160856.eiydl7jvglcao442@linutronix.de>
References: <20181009160856.eiydl7jvglcao442@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just tested this kernel and saw the stall output below. I think there is something
fishy with the ethernet driver. I had one time where it just locked up on
network traffic on issuing "ip a" via serial port on the device. All the problems i see,
seem to be related to network traffic via the socfpga-dwmac stmicro/stmmac.
Platform is pretty dated Intel/Altera Cortex A9 socfpga.

I think this problem is there for a while but since i had problems due to the
watchdog i was not able to detect it.

Best regards
Tim

[  251.440019] INFO: rcu_preempt self-detected stall on CPU
[  251.440036]  1-...!: (21000 ticks this GP) idle=5ae/1/1073741826 softirq=0/0 fqs=0 
[  251.440039]   (t=21000 jiffies g=7702 c=7701 q=346)
[  251.440053] rcu_preempt kthread starved for 21000 jiffies! g7702 c7701 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
[  251.440055] RCU grace-period kthread stack dump:
[  251.440059] rcu_preempt     I    0    11      2 0x00000000
[  251.440066] Backtrace: 
[  251.440086] [<8062d4b0>] (__schedule) from [<8062da30>] (schedule+0x68/0x128)
[  251.440096]  r10:80a1569e r9:87d9a680 r8:80a04100 r7:80055eec r6:87d9a680 r5:80034600
[  251.440100]  r4:80054000
[  251.440111] [<8062d9c8>] (schedule) from [<806306dc>] (schedule_timeout+0x1cc/0x368)
[  251.440116]  r5:80a06488 r4:fffef04c
[  251.440128] [<80630510>] (schedule_timeout) from [<80184fdc>] (rcu_gp_kthread+0x750/0xac0)
[  251.440137]  r10:80a1569e r9:80a04100 r8:00000001 r7:00000003 r6:80a15690 r5:80a1569c
[  251.440140]  r4:80a154c0
[  251.440150] [<8018488c>] (rcu_gp_kthread) from [<801461a8>] (kthread+0x138/0x168)
[  251.440153]  r7:80a154c0
[  251.440163] [<80146070>] (kthread) from [<801010bc>] (ret_from_fork+0x14/0x38)
[  251.440168] Exception stack(0x80055fb0 to 0x80055ff8)
[  251.440174] 5fa0:                                     00000000 00000000 00000000 00000000
[  251.440183] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  251.440189] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  251.440198]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80146070
[  251.440202]  r4:8150fac0 r3:80054000
[  251.440215] NMI backtrace for cpu 1
[  251.440226] CPU: 1 PID: 157 Comm: RawMeasThread Tainted: G        W  O      4.18.12-rt7 #1
[  251.440229] Hardware name: Altera SOCFPGA
[  251.440231] Backtrace: 
[  251.440243] [<8010dda4>] (dump_backtrace) from [<8010e09c>] (show_stack+0x20/0x24)
[  251.440250]  r7:80a573f8 r6:00000000 r5:600d0193 r4:80a573f8
[  251.440264] [<8010e07c>] (show_stack) from [<80616120>] (dump_stack+0xb0/0xdc)
[  251.440278] [<80616070>] (dump_stack) from [<8061cb74>] (nmi_cpu_backtrace+0xc0/0xc4)
[  251.440286]  r9:800d0193 r8:00000180 r7:807017c4 r6:00000001 r5:00000000 r4:00000001
[  251.440296] [<8061cab4>] (nmi_cpu_backtrace) from [<8061ccdc>] (nmi_trigger_cpumask_backtrace+0x164/0x1b0)
[  251.440301]  r5:80a0906c r4:8010fa94
[  251.440312] [<8061cb78>] (nmi_trigger_cpumask_backtrace) from [<8011077c>] (arch_trigger_cpumask_backtrace+0x20/0x24)
[  251.440318]  r7:80a154c0 r6:807017bc r5:80a06534 r4:80a154c0
[  251.440328] [<8011075c>] (arch_trigger_cpumask_backtrace) from [<80187944>] (rcu_dump_cpu_stacks+0xac/0xdc)
[  251.440337] [<80187898>] (rcu_dump_cpu_stacks) from [<801864b0>] (rcu_check_callbacks+0x9e8/0xb08)
[  251.440346]  r10:80a06574 r9:80a154c0 r8:80a06528 r7:80a154c0 r6:07439000 r5:87d9edc0
[  251.440350]  r4:80965dc0 r3:6c2a9c31
[  251.440360] [<80185ac8>] (rcu_check_callbacks) from [<8018e834>] (update_process_times+0x40/0x6c)
[  251.440368]  r10:801a3024 r9:87d9b1a0 r8:87d9b000 r7:0000003a r6:8afdf535 r5:00000001
[  251.440372]  r4:871baa00
[  251.440383] [<8018e7f4>] (update_process_times) from [<801a30ac>] (tick_sched_timer+0x88/0xf4)
[  251.440387]  r5:867cffb0 r4:87d9b310
[  251.440396] [<801a3024>] (tick_sched_timer) from [<8018fc54>] (__hrtimer_run_queues+0x194/0x3e8)
[  251.440403]  r7:80a064b0 r6:867ce000 r5:87d9b060 r4:87d9b310
[  251.440411] [<8018fac0>] (__hrtimer_run_queues) from [<80190648>] (hrtimer_interrupt+0x138/0x2b0)
[  251.440419]  r10:87d9b00c r9:87d9b1a0 r8:ffffffff r7:7fffffff r6:00000003 r5:200d0193
[  251.440422]  r4:87d9b000
[  251.440432] [<80190510>] (hrtimer_interrupt) from [<8011140c>] (twd_handler+0x40/0x50)
[  251.440441]  r10:765b03e0 r9:00000010 r8:80a06d3c r7:00000000 r6:8001a500 r5:00000010
[  251.440444]  r4:00000001
[  251.440454] [<801113cc>] (twd_handler) from [<80178510>] (handle_percpu_devid_irq+0x98/0x2dc)
[  251.440459]  r5:00000010 r4:81503cc0
[  251.440472] [<80178478>] (handle_percpu_devid_irq) from [<8017230c>] (generic_handle_irq+0x34/0x44)
[  251.440480]  r10:765b03e0 r9:90803100 r8:80009000 r7:00000000 r6:00000000 r5:00000010
[  251.440484]  r4:80965208 r3:80178478
[  251.440495] [<801722d8>] (generic_handle_irq) from [<801729e0>] (__handle_domain_irq+0x6c/0xc4)
[  251.440505] [<80172974>] (__handle_domain_irq) from [<80102310>] (gic_handle_irq+0x5c/0xa0)
[  251.440514]  r9:90803100 r8:90802100 r7:867cffb0 r6:9080210c r5:80a06d3c r4:80a3c52c
[  251.440521] [<801022b4>] (gic_handle_irq) from [<80101e58>] (__irq_usr+0x58/0x80)
[  251.440525] Exception stack(0x867cffb0 to 0x867cfff8)
[  251.440532] ffa0:                                     7ee6fce0 765b9000 0003b810 00000000
[  251.440541] ffc0: 7ee6fcd8 7ee6fce0 765b9000 765afdf0 00000000 765aff20 765b03e0 7ee6fc28
[  251.440548] ffe0: 00000000 765afd28 00015c45 000160a2 a00d0030 ffffffff
[  251.440557]  r9:765aff20 r8:10c5387d r7:10c5387d r6:ffffffff r5:a00d0030 r4:000160a2



