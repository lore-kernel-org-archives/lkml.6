Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5950BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4FB20868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4FB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeH2SF2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:05:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2SF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:05:28 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fv18r-0005zy-Ru; Wed, 29 Aug 2018 16:08:18 +0200
Date:   Wed, 29 Aug 2018 16:08:17 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:974
Message-ID: <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-28 18:28:42 [-0500], Grygorii Strashko wrote:
> Hi
Hi,

…
> ===== Log 1 =====
…
> [    0.625149] GICv3: CPU1: found redistributor 1 region 0:0x00000000018a0000
> [    0.625176] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
> [    0.625182] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
> [    0.625189] 1 lock held by swapper/1/0:
> [    0.625193]  #0:  ((pa_lock).lock){+.+.}, at: [<ffff0000081a73e8>] get_page_from_freelist+0x160/0xd20
> [    0.625228] irq event stamp: 0
> [    0.625233] hardirqs last  enabled at (0): [<          (null)>]           (null)
> [    0.625246] hardirqs last disabled at (0): [<ffff0000080c2f50>] copy_process.isra.5.part.6+0x2c0/0x18a8
> [    0.625255] softirqs last  enabled at (0): [<ffff0000080c2f50>] copy_process.isra.5.part.6+0x2c0/0x18a8
> [    0.625260] softirqs last disabled at (0): [<          (null)>]           (null)
> [    0.625263] Preemption disabled at:
> [    0.625274] [<ffff0000080909b8>] secondary_start_kernel+0x80/0x118
> [    0.625286] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.66-rt40-02415-g6a801ed-dirty #5
> [    0.625290] Hardware name: Texas Instruments AM654 Base Board (DT)
> [    0.625295] Call trace:
> [    0.625306] [<ffff000008089d60>] dump_backtrace+0x0/0x400
> [    0.625313] [<ffff00000808a174>] show_stack+0x14/0x20
> [    0.625324] [<ffff0000087db658>] dump_stack+0xac/0xe4
> [    0.625333] [<ffff0000080f26b4>] ___might_sleep+0x154/0x228
> [    0.625342] [<ffff0000087f291c>] rt_spin_lock+0x5c/0x70
> [    0.625350] [<ffff0000081a73e8>] get_page_from_freelist+0x160/0xd20
> [    0.625359] [<ffff0000081a8804>] __alloc_pages_nodemask+0xe4/0xc68
> [    0.625368] [<ffff00000845bb10>] its_allocate_pending_table+0x68/0xa8
> [    0.625375] [<ffff00000845e5b4>] its_cpu_init+0x294/0x374
> [    0.625382] [<ffff00000845b4a4>] gic_cpu_init.part.6+0x15c/0x170
> [    0.625388] [<ffff00000845b4cc>] gic_starting_cpu+0x14/0x20
> [    0.625396] [<ffff0000080c5ad4>] cpuhp_invoke_callback+0x9c/0x260
> [    0.625404] [<ffff0000080c7c38>] notify_cpu_starting+0x70/0xa8
> [    0.625412] [<ffff0000080909e4>] secondary_start_kernel+0xac/0x118
> 
> ===== Log 2 =====
…
> [    0.912050] GICv3: CPU1: found redistributor 1 region 0:0x00000000018a0000
> [    0.912081] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
> [    0.912087] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
> [    0.912092] 1 lock held by swapper/1/0:
> [    0.912096]  #0:  ((pa_lock).lock){+.+.}, at: [<ffff0000081ad194>] get_page_from_freelist+0x154/0xeb0
> [    0.912130] irq event stamp: 0
> [    0.912135] hardirqs last  enabled at (0): [<          (null)>]           (null)
> [    0.912147] hardirqs last disabled at (0): [<ffff0000080c31c0>] copy_process.isra.5.part.6+0x438/0x1920
> [    0.912156] softirqs last  enabled at (0): [<ffff0000080c31c0>] copy_process.isra.5.part.6+0x438/0x1920
> [    0.912160] softirqs last disabled at (0): [<          (null)>]           (null)
> [    0.912164] Preemption disabled at:
> [    0.912175] [<ffff0000080909b8>] secondary_start_kernel+0x80/0x118
> [    0.912188] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.14.66-rt40-02415-g6a801ed-dirty #4
> [    0.912192] Hardware name: Texas Instruments AM654 Base Board (DT)
> [    0.912197] Call trace:
> [    0.912207] [<ffff000008089d60>] dump_backtrace+0x0/0x400
> [    0.912215] [<ffff00000808a174>] show_stack+0x14/0x20
> [    0.912225] [<ffff0000087ecc78>] dump_stack+0xac/0xe4
> [    0.912234] [<ffff0000080f3014>] ___might_sleep+0x154/0x228
> [    0.912245] [<ffff00000880400c>] rt_spin_lock+0x5c/0x70
> [    0.912251] [<ffff0000081ad194>] get_page_from_freelist+0x154/0xeb0
> [    0.912258] [<ffff0000081ae530>] __alloc_pages_nodemask+0x108/0xc88
> [    0.912268] [<ffff000008201d20>] alloc_page_interleave+0x18/0xa0
> [    0.912275] [<ffff0000082023cc>] alloc_pages_current+0xcc/0xe0
> [    0.912287] [<ffff00000846bb00>] its_allocate_pending_table+0x60/0xa0
> [    0.912295] [<ffff00000846e5d8>] its_cpu_init+0x2a0/0x380
> [    0.912303] [<ffff00000846b484>] gic_cpu_init.part.6+0x15c/0x170
> [    0.912311] [<ffff00000846b4ac>] gic_starting_cpu+0x14/0x20

This is fixed by
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/irqchip-gic-v3-its-Make-its_lock-a-raw_spin_lock_t.patch?h=linux-4.18.y-rt-patches
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/irqchip-gic-v3-its-Move-ITS-pend_page-allocation-int.patch?h=linux-4.18.y-rt-patches

in the v4.18 tree. The first patch was merged upstream. The second will
be replaced by the patches Marc Zyngier proposed in 
  https://lkml.kernel.org/r/3302f069-8f4e-8d97-5166-0dec01b43c4c@arm.com

I plan to test + replace those for the next v4.18 release.

Sebastian
