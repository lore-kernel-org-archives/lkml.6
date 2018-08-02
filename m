Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5099C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECA1208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECA1208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeHBIpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:45:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeHBIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:45:38 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fl7WY-0008WJ-CP; Thu, 02 Aug 2018 08:55:50 +0200
Date:   Thu, 2 Aug 2018 08:55:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Julien Thierry <julien.thierry@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/4] genirq: Provide basic NMI management for interrupt
 lines
In-Reply-To: <86tvodw9wz.wl-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1808020841200.1835@nanos.tec.linutronix.de>
References: <1532430427-57151-1-git-send-email-julien.thierry@arm.com> <1532430427-57151-2-git-send-email-julien.thierry@arm.com> <20180801030723.GA31383@voyager> <df8f9f98-a1d3-e871-eec8-d805ff7cf5b7@arm.com> <20180802020320.GC31758@voyager>
 <86tvodw9wz.wl-marc.zyngier@arm.com>
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

On Thu, 2 Aug 2018, Marc Zyngier wrote:
> On Thu, 02 Aug 2018 03:03:20 +0100,
> Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > On Wed, Aug 01, 2018 at 04:09:59PM +0100, Julien Thierry wrote:
> > > >
> > > >I don't think this works in x86 because the local APIC irq_chip is the
> > > >root of the hierarchy; the rest of the irq_chips are children of it.
> > > >Furthermore, the delivery mode (i.e., regular interrupt vs NMI) is set in
> > > >these children controllers, either MSI or interrupt remapping.
> > > >
> > > >Instead, could it be possible to determine if NMI mode is supported by
> > > >checking if any of the parents of the irq_data supports NMI mode? If it
> > > >has to be the root, perhaps a flag can indicate irq_supports_nmi() about
> > > >this restriction.
> > > >
> > > 
> > > I see, I'm not very sure how to deal with the semantics here. Does it make
> > > sense for an irqchip to be able to deliver NMIs if its parent doesn't?
> > 
> > I think it does not make sense. 
> > 
> > > 
> > > If we want to handle NMI in and irqchip hierachy, shouldn't all irqchips
> > > between the one delivering the NMI and the root irqchip also be able to
> > > deliver NMIs? (Or is it the other way around and an irqchip can deliver an
> > > NMI if all its children irqchip are also able to deliver an NMI?)
> > 
> > At least in APIC, all the irq_chips support NMI delivery. However only one
> > of them will generate the NMI interrupt message, the rest (e.g., the local
> > APIC) will only relay it to the CPU.
> > 
> > So yes, I agree that the whole hierarchy should support NMI delivery, but
> > the chip generating the NMI is not necessarily the root chip.
> > 
> > One question that I have is that whether the new flag IRQCHIP_SUPPORTS_NMI
> > should be added to irq_chips that only relay NMIs or only to those from
> > which an NMI can be requested.
> 
> If we need to distinguish between the two, then we need two flags. One
> that indicates the generation capability, and one that indicates the
> forwarding capability.

There is absolutely no reason to expose this on x86, really.

Why?

Because NMI is an utter trainwreck on x86. It's a single entry point
without the ability of differentiation from which source the NMI
originated. So mapping it to anything generic is just not going to work.

It has absolutely nothing to do with the normal way of vector based
interrupt operation and I don't see at all how adding this just because
would improve anything on x86. In fact it would create more problems than
it solves.

Thanks,

	tglx

