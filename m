Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6492C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BFC21477
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BFC21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeIXDSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:18:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIXDSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:18:06 -0400
Received: from tmo-108-1.customers.d1-online.com ([80.187.108.1] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g4BmV-00023s-Kh; Sun, 23 Sep 2018 23:19:07 +0200
Date:   Sun, 23 Sep 2018 23:19:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rob Prowel <rprowel@comcast.net>
cc:     linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon bogus performance value causing RCU stalls?
In-Reply-To: <6243f7cc-1a80-db0b-4765-fa12bda9b06a@comcast.net>
Message-ID: <alpine.DEB.2.21.1809232314460.1398@nanos.tec.linutronix.de>
References: <6243f7cc-1a80-db0b-4765-fa12bda9b06a@comcast.net>
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

On Sun, 23 Sep 2018, Rob Prowel wrote:
> Sep 23 01:51:28 files kernel: INFO: rcu_sched detected stalls on CPUs/tasks:
> Sep 23 01:51:28 files kernel:         1-...!: (0 ticks this GP) idle=27c/0/0
> softirq=35425/35425 fqs=0
> Sep 23 01:51:28 files kernel:         (detected by 0, t=60009 jiffies,
> g=20812, c=20811, q=121)
> Sep 23 01:51:28 files kernel: Sending NMI from CPU 0 to CPUs 1:
> Sep 23 01:51:28 files kernel: NMI backtrace for cpu 1 skipped: idling at
> native_safe_halt+0x2/0x10
> Sep 23 01:51:28 files kernel: rcu_sched kthread starved for 60009 jiffies!
> g20812 c20811 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
> Sep 23 01:51:28 files kernel: RCU grace-period kthread stack dump:
> Sep 23 01:51:28 files kernel: rcu_sched       I    0    10      2 0x80000000
> Sep 23 01:51:33 files kernel: Call Trace:
> Sep 23 01:51:33 files kernel:  ? __schedule+0x25c/0x860
> Sep 23 01:51:33 files kernel:  schedule+0x28/0x80
> Sep 23 01:51:33 files kernel:  schedule_timeout+0x174/0x370
> Sep 23 01:51:33 files kernel:  ? __next_timer_interrupt+0xc0/0xc0
> Sep 23 01:51:33 files kernel:  rcu_gp_kthread+0x4b6/0x8c0
> Sep 23 01:51:33 files kernel:  ?
> _synchronize_rcu_expedited.constprop.68+0x310/0x310
> Sep 23 01:51:33 files kernel:  kthread+0x113/0x130
> Sep 23 01:51:33 files kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
> Sep 23 01:51:33 files kernel:  ret_from_fork+0x35/0x40
> 
> -----------------------------------------------------------------------
> 
> The kernel reported bogoMIPS for the cores are as follows:
> 
> $ grep bogo /proc/cpuinfo
> bogomips        : 4219.49
> bogomips        : 184253.06
> $
> 
> What is that value for the second Athlon core (seems extremely bogus), and
> would/could that be the reason for the schedule_timeouts?  This bogus value
> also shows up in the bootup log when the second core is activated.  Seems to
> be AMD specific, as the values are correct on my Xeon machines.

That's a 32bit machine I assume. 

> Kernel is a stock Fedora 4.18.7-100 release.  Machine is an old Dell Experion
> that I've repurposed as a fileserver and postgresql machine.
> 
> Other than RTFM, or please build a bunch of kernels from source on your slow
> machine, using differing config options to help track down the cause of
> this...any thoughts about a solution?

Yes. This was decoded recently as an issue on 32bit due to a calculation
which is based on 'unsigned long' but requires to be 64bit wide.

It's in the 4.18.8 stable kernel, which should be available from your
fedora repo anytime soon.

Thanks,

	tglx
