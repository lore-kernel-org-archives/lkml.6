Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A2F2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Za/gXSoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A2F2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeICLoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:44:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeICLoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yBsUIgUoPik/3KlRQnmvHUuE/MeBnkctniuaPTCzbnI=; b=Za/gXSoZ3ZVUXNP7dfKHpEA+O
        svel1f2Nt5sVDsOmXMIyqIqsOxBNOjixuHveXZVy5bv5Mtl0jDUxDMSSqAv6ROipNIinYDGqF9fqP
        5LgLWgOeJlZBmx6XCFb1o+NCZMYbl8GyBWYYJ3O+68+jMY6Ey85kNScISyR0JJbdl+auEJymnNzw9
        VzqWkGOrSnwzGRyKEStG2hT4GYCfOQZNCWpWBkd6CvpdfzOnsTYHAGtfE5zuGQlfP+eT9C/DsXpjx
        dwG2aaMkH6DrAEmbdfVPywudeoEa65j9mXEn8uCtLp+8rQDdvXC5e7eHThxAHjmJUxRRoX1cF7szo
        HYEmsdc4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwjEU-0003h7-3E; Mon, 03 Sep 2018 07:25:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DD8B205F864C; Mon,  3 Sep 2018 09:25:06 +0200 (CEST)
Date:   Mon, 3 Sep 2018 09:25:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kevin Shanahan <kevin@shanahan.id.au>
Cc:     Siegfried Metz <frame@mailbox.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com, viktor_jaegerskuepper@freenet.de
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
Message-ID: <20180903072506.GS24124@hirez.programming.kicks-ass.net>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
 <20180901022125.GO4941@tuon.disenchant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901022125.GO4941@tuon.disenchant.local>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 11:51:26AM +0930, Kevin Shanahan wrote:
> On Thu, Aug 30, 2018 at 03:04:39PM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 30, 2018 at 12:55:30PM +0200, Siegfried Metz wrote:
> > > Dear kernel developers,
> > > 
> > > since mainline kernel 4.18 (up to the latest mainline kernel 4.18.5)
> > > Intel Core 2 Duo processors are affected by boot stalling early in the
> > > boot process. As it is so early there is no dmesg output (or any log).
> > > 
> > > A few users in the Arch Linux community used git bisect and tracked the
> > > issue down to this the bad commit:
> > > 7197e77abcb65a71d0b21d67beb24f153a96055e clocksource: Remove kthread
> > 
> > I just dug out my core2duo laptop (Lenovo T500) and build a tip/master
> > kernel for it (x86_64 debian distro .config).
> > 
> > Seems to boot just fine.. 3/3 so far.
> > 
> > Any other clues?
> 
> One additional data point, my affected system is a Dell Latitude E6400
> laptop which has a P8400 CPU:
> 
>   vendor_id     : GenuineIntel
>   cpu family    : 6
>   model         : 23
>   model name    : Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz
>   stepping      : 6
>   microcode     : 0x610
> 
> Judging from what is being discussed in the Arch forums, it does seem
> to related to the CPU having unstable TSC and transitioning to another
> clock source.

Yes; Core2 doesn't have stable TSC.

> Workarounds that seem to be reliable are either booting
> with clocksource=<something_not_tsc> or with nosmp.

nosmp is weird; because even on UP TSC should stop in C state.

processor_idle (acpi_idle) should mark the TSC as unstable on Core2 when
it loads (does so on my T500).

> One person did point out that the commit that introduced the kthread
> did so to remove a deadlock - is the circular locking dependency
> mentioned in that commit still relevant?
> 
> commit 01548f4d3e8e94caf323a4f664eb347fd34a34ab
> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date:   Tue Aug 18 17:09:42 2009 +0200
> 
>     clocksource: Avoid clocksource watchdog circular locking dependency
> 
>     stop_machine from a multithreaded workqueue is not allowed because
>     of a circular locking dependency between cpu_down and the workqueue
>     execution. Use a kernel thread to do the clocksource downgrade.

I cannot find stop_machine usage there; either it went away or I need to
like wake up.
