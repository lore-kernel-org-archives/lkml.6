Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1696C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D7820659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="irKXv4BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfANNQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:16:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANNQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5qxlB5yVFnLIYJWYI2HjyNUfc3CosETsxxmc3JKM1w0=; b=irKXv4BDnRUorl6Y5U1Hotgen
        QH1IIsc/J7YaVfstbuxE92jRuGOVRI58o2IMY8jJ7HySJZOzyz2Qmm58jK1bOvrWagPITe/z3ZDLP
        hsCRF6pYbfNFl0cuNAauRSwzmST80ETAyDI1dZv2c3/c0aOf8oGpoelzsZXRm9bk/RmjDCUxr7jKY
        xe1Af0n/roLTECU2fX1D1bP/TDLzqInSp3848cl/uXI/r7upq5BFG61873CU6BkViVfzzcM+dzIS/
        haCZzmVg/4NWwkgXH+3FaCR81s1juf1k9TbdWqpzw9ebeT2yJq//UYdRj9MHZ8AbVP/XiSElSpgVP
        NIWAzd32w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj26B-0007W3-D1; Mon, 14 Jan 2019 13:16:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A65B200A65EE; Mon, 14 Jan 2019 14:16:13 +0100 (CET)
Date:   Mon, 14 Jan 2019 14:16:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Morse <james.morse@arm.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: Question about qspinlock nest
Message-ID: <20190114131613.GB10486@hirez.programming.kicks-ass.net>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
 <d06126a1-1db8-f937-2084-2c1234b6f56f@arm.com>
 <20190110201217.GH2861@worktop.programming.kicks-ass.net>
 <a270215d-ec5a-8b8a-3786-c0480b640abc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a270215d-ec5a-8b8a-3786-c0480b640abc@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 06:32:58PM +0000, James Morse wrote:
> Hi Peter,
> 
> On 10/01/2019 20:12, Peter Zijlstra wrote:
> > On Thu, Jan 10, 2019 at 06:25:57PM +0000, James Morse wrote:
> > 
> >> On arm64 if all the RAS and psuedo-NMI patches land, our worst-case interleaving
> >> jumps to at least 7. The culprit is APEI using spinlocks to protect fixmap slots.
> >>
> >> I have an RFC to bump the number of node bits from 2 to 3, but as this is APEI
> >> four times, it may be preferable to make it use something other than spinlocks.
> 
> >> The worst-case order is below. Each one masks those before it:
> >> 1. process context
> >> 2. soft-irq
> >> 3. hard-irq
> >> 4. psuedo-nmi [0]
> >>    - using the irqchip priorities to configure some IRQs as NMI.
> >> 5. SError [1]
> >>    - a bit like an asynchronous MCE. ACPI allows this to convey CPER records,
> >>      requiring an APEI call.
> >> 6&7. SDEI [2]
> >>      - a firmware triggered software interrupt, only its two of them, either of
> >>        which could convey CPER records.
> >> 8. Synchronous external abort
> >>    - again, similar to MCE. There are systems using this with APEI.
> 
> > The thing is, everything non-maskable (NMI like) really should not be
> > using spinlocks at all.
> > 
> > I otherwise have no clue about wth APEI is, but it sounds like horrible
> > crap ;-)
> 
> I think you've called it that before!: its that GHES thing in drivers/acpi/apei.
> 
> What is the alternative? bit_spin_lock()?
> These things can happen independently on multiple CPUs. On arm64 these NMIlike
> things don't affect all CPUs like they seem to on x86.

It has nothing to do with how many CPUs are affected. It has everything
to do with not being maskable.

What avoids the trivial self-recursion:

  spin_lock(&)
  <NMI>
    spin_lock(&x)
     ... wait forever more ...
  </NMI>
  spin_unlock(&x)

?

Normally for actual maskable interrupts, we use:

  spin_lock_irq(&x)
  // our IRQ cannot happen here because: masked
  spin_unlock_irq(&x)

But non-maskable, has, per definition, a wee issue there.

Non-maskable MUST NOT _EVAH_ use any form of spinlocks, they're
fundamentally incompatible. Non-maskable interrupts must employ
wait-free atomic constructs.
