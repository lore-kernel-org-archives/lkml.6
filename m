Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3855C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C372083A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C372083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shanahan.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeIAGoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 02:44:02 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:55719 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbeIAGoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 02:44:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BY/QCh299ZAPQbsjFehV8ngy+DdYdpjj4BmDKCBEQBhHoEAgKEPlgDAQEBAQECDwEBATJPhR4BBTocIxALFAQJExIPBRgNJBMUigmuGYtugy2IbIE9AYMPhiwFkUaBEI5ulF0NcpIelyRWgQ9TIRmFb4IHMDeLVgEBAQ
X-IronPort-SPAM: SPAM
Received: from pa49-178-27-244.pa.nsw.optusnet.com.au (HELO mail.disenchant.local) ([49.178.27.244])
  by ipmail06.adl6.internode.on.net with ESMTP; 01 Sep 2018 12:03:42 +0930
Received: by mail.disenchant.local (Postfix, from userid 1000)
        id 37429A380D; Sat,  1 Sep 2018 11:51:26 +0930 (ACST)
Date:   Sat, 1 Sep 2018 11:51:26 +0930
From:   Kevin Shanahan <kevin@shanahan.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Siegfried Metz <frame@mailbox.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com, viktor_jaegerskuepper@freenet.de
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
Message-ID: <20180901022125.GO4941@tuon.disenchant.local>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830130439.GM24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 03:04:39PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 30, 2018 at 12:55:30PM +0200, Siegfried Metz wrote:
> > Dear kernel developers,
> > 
> > since mainline kernel 4.18 (up to the latest mainline kernel 4.18.5)
> > Intel Core 2 Duo processors are affected by boot stalling early in the
> > boot process. As it is so early there is no dmesg output (or any log).
> > 
> > A few users in the Arch Linux community used git bisect and tracked the
> > issue down to this the bad commit:
> > 7197e77abcb65a71d0b21d67beb24f153a96055e clocksource: Remove kthread
> 
> I just dug out my core2duo laptop (Lenovo T500) and build a tip/master
> kernel for it (x86_64 debian distro .config).
> 
> Seems to boot just fine.. 3/3 so far.
> 
> Any other clues?

One additional data point, my affected system is a Dell Latitude E6400
laptop which has a P8400 CPU:

  vendor_id     : GenuineIntel
  cpu family    : 6
  model         : 23
  model name    : Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz
  stepping      : 6
  microcode     : 0x610

Judging from what is being discussed in the Arch forums, it does seem
to related to the CPU having unstable TSC and transitioning to another
clock source.  Workarounds that seem to be reliable are either booting
with clocksource=<something_not_tsc> or with nosmp.

One person did point out that the commit that introduced the kthread
did so to remove a deadlock - is the circular locking dependency
mentioned in that commit still relevant?

commit 01548f4d3e8e94caf323a4f664eb347fd34a34ab
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Tue Aug 18 17:09:42 2009 +0200

    clocksource: Avoid clocksource watchdog circular locking dependency

    stop_machine from a multithreaded workqueue is not allowed because
    of a circular locking dependency between cpu_down and the workqueue
    execution. Use a kernel thread to do the clocksource downgrade.

    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: john stultz <johnstul@us.ibm.com>
    LKML-Reference: <20090818170942.3ab80c91@skybase>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,
Kevin.
