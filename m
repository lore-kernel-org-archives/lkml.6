Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D1DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A072172E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A072172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeHCJyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:54:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeHCJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:54:49 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flUzq-0003ZR-Hx; Fri, 03 Aug 2018 09:59:38 +0200
Date:   Fri, 3 Aug 2018 09:59:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/4] genirq: Provide basic NMI management for interrupt
 lines
In-Reply-To: <20180803030947.GA12916@voyager>
Message-ID: <alpine.DEB.2.21.1808030952400.1841@nanos.tec.linutronix.de>
References: <1532430427-57151-1-git-send-email-julien.thierry@arm.com> <1532430427-57151-2-git-send-email-julien.thierry@arm.com> <20180801030723.GA31383@voyager> <df8f9f98-a1d3-e871-eec8-d805ff7cf5b7@arm.com> <20180802020320.GC31758@voyager>
 <86tvodw9wz.wl-marc.zyngier@arm.com> <alpine.DEB.2.21.1808020841200.1835@nanos.tec.linutronix.de> <86r2jhw7a1.wl-marc.zyngier@arm.com> <alpine.DEB.2.21.1808021137400.2037@nanos.tec.linutronix.de> <20180803030947.GA12916@voyager>
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

On Thu, 2 Aug 2018, Ricardo Neri wrote:
> On Thu, Aug 02, 2018 at 11:40:55AM +0200, Thomas Gleixner wrote:
> > Yes, focussing on "sane" architectures (by some definition of sane) where
> > the NMI mode is just changing the delivery restrictions allows to still
> > differentiate from which source the NMI originates.
> 
> Let me assume that one can find a way to reliably identify the source of an
> NMI in x86.

This assumption is fundamentally wrong. It wont't work unless Intel decides
to sanitize the whole exception mechanism. We can discuss that once this
happens, but I assume that this will be after my retirement.

> If we cannot use the proposed request_nmi() as it does not fit
> x86, is it acceptable to bypass the existing irq framework and directly
> program the delivery mode as NMI in the relevant hardware (e.g., a register
> holding the MSI data)? For instance, in my initial attempt to have the HPET
> timer to generate NMIs [1]. I could directly write to the FSB Interrupt
> Route Register. In my view, it makes sense because, as you say, in x86 NMIs
> are handled separately from the normal vector based interrupts.

That HPET thing is a dead horse and won't become more alive by adding magic
to the irq core code.

> I guess this would also imply reserving the relevant hardware so that it
> is not used when calling request_irq().

There is nothing to reserve. Code which needs to deal with NMIs is better
written safe and sound and no, we won't expose NMIs to random device driver
code either.

Thanks,

	tglx
