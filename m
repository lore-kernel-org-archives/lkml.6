Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF339ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4C820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4C820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeGTLNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:13:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbeGTLNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:13:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07B2A7A9;
        Fri, 20 Jul 2018 03:25:56 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE75D3F5B3;
        Fri, 20 Jul 2018 03:25:54 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:25:52 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Qais Yousef <Qais.Yousef@arm.com>
Subject: Re: arm: v4.18-rc5 with cpuidle on TC2 (A7 boot) spectre v2 issue
Message-ID: <20180720102552.GC19287@e105550-lin.cambridge.arm.com>
References: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
 <20180719100109.GH17271@n2100.armlinux.org.uk>
 <20180719133222.GL17271@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719133222.GL17271@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 02:32:22PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 19, 2018 at 11:01:10AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 19, 2018 at 11:42:50AM +0200, Dietmar Eggemann wrote:
> > > Hi,
> > > 
> > > running v4.18-rc5 (plus still missing "power: vexpress: fix corruption in
> > > notifier registration", otherwise I get this rcu_sched stall issue) on TC2
> > > (A7 boot) with vanilla multi_v7_defconfig plus
> > > CONFIG_ARM_BIG_LITTLE_CPUIDLE=y gives me continuous:
> > > 
> > > ...
> > >  CPUX: Spectre v2: incorrect context switching function, system vulnerable
> > > ...
> > > 
> > > messages.
> > > 
> > > Work around is to disable CONFIG_HARDEN_BRANCH_PREDICTOR.
> > 
> > or disable big.Little if you want the hardening.
> > 
> > The choices are currently either protection against Spectre or big.Little
> > support since the two are mutually exclusive at the moment.
> 
> An alternative would be to give the patches in the attachment a test.
> They're not finished yet, so I haven't sent them out, but still worth
> testing.

Thanks for sharing. I can confirm that your patches do cure the flood of warnings.

TC2 booting on A7:

[    0.002922] CPU: Testing write buffer coherency: ok
[    0.003347] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.004022] Setting up static identity map for 0x80100000 - 0x80100060
[    0.004265] ARM CCI driver probed
[    0.004648] TC2 power management initialized
[    0.004930] Hierarchical SRCU implementation.
[    0.006956] smp: Bringing up secondary CPUs ...
[    0.008712] CPU1: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.008720] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.009934] CPU2: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.009940] CPU2: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.011147] CPU3: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.012350] CPU4: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.012468] smp: Brought up 1 node, 5 CPUs
[    0.012490] SMP: Total of 5 processors activated (240.00 BogoMIPS).
[    0.012499] CPU: All CPU(s) started in SVC mode.

TC2 booting on A15:

[    0.002045] CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.002311] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.002809] Setting up static identity map for 0x80100000 - 0x80100060
[    0.003000] ARM CCI driver probed
[    0.003408] TC2 power management initialized
[    0.003637] Hierarchical SRCU implementation.
[    0.005177] smp: Bringing up secondary CPUs ...
[    0.006170] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.006176] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.008137] CPU2: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.009304] CPU3: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.010405] CPU4: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.010537] smp: Brought up 1 node, 5 CPUs
[    0.010562] SMP: Total of 5 processors activated (240.00 BogoMIPS).
[    0.010572] CPU: All CPU(s) started in SVC mode.

No further warnings for either configuration.

For reference, this a partial output from later in the boot process when
booting on A7 with 4.18-rc5 _without_ your patches:

[    5.576176] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    5.601689] cpu cpu0: bL_cpufreq_init: CPU 0 initialized
[    5.618670] cpu cpu1: bL_cpufreq_init: CPU 1 initialized
[    5.635583] arm_big_little: bL_cpufreq_register: Registered platform driver: vexpress-spc
[    5.661112] mmci-pl18x 1c050000.mmci: Got CD GPIO
[    5.675235] mmci-pl18x 1c050000.mmci: Got WP GPIO
[    5.687783] CPU2: Spectre v2: incorrect context switching function, system vulnerable
[    5.689623] mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 26,27 (pio)
[    5.713217] CPU1: Spectre v2: incorrect context switching function, system vulnerable
[    5.718044] CPU2: Spectre v2: incorrect context switching function, system vulnerable
[    5.727896] CPU2: Spectre v2: incorrect context switching function, system vulnerable
