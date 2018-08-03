Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB6C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E91C216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E91C216EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeHCFJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:09:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:63817 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbeHCFJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:09:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="80111841"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2018 20:15:00 -0700
Date:   Thu, 2 Aug 2018 20:09:47 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/4] genirq: Provide basic NMI management for interrupt
 lines
Message-ID: <20180803030947.GA12916@voyager>
References: <1532430427-57151-1-git-send-email-julien.thierry@arm.com>
 <1532430427-57151-2-git-send-email-julien.thierry@arm.com>
 <20180801030723.GA31383@voyager>
 <df8f9f98-a1d3-e871-eec8-d805ff7cf5b7@arm.com>
 <20180802020320.GC31758@voyager>
 <86tvodw9wz.wl-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1808020841200.1835@nanos.tec.linutronix.de>
 <86r2jhw7a1.wl-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1808021137400.2037@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808021137400.2037@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:40:55AM +0200, Thomas Gleixner wrote:
> On Thu, 2 Aug 2018, Marc Zyngier wrote:
> > On Thu, 02 Aug 2018 07:55:49 +0100,
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > 
> > > On Thu, 2 Aug 2018, Marc Zyngier wrote:
> > > > 
> > > > If we need to distinguish between the two, then we need two flags. One
> > > > that indicates the generation capability, and one that indicates the
> > > > forwarding capability.
> > > 
> > > There is absolutely no reason to expose this on x86, really.
> > > 
> > > Why?
> > > 
> > > Because NMI is an utter trainwreck on x86. It's a single entry point
> > > without the ability of differentiation from which source the NMI
> > > originated. So mapping it to anything generic is just not going to work.
> > > 
> > > It has absolutely nothing to do with the normal way of vector based
> > > interrupt operation and I don't see at all how adding this just because
> > > would improve anything on x86. In fact it would create more problems than
> > > it solves.
> > 
> > Fair enough. Does it mean Julien can completely ignore the x86
> > requirements for this and focus on something that fit the need of
> > architectures where (pseudo-)NMIs can be managed similarly to normal
> > interrupts (arm, arm64, sparc...)?
> 
> Yes, focussing on "sane" architectures (by some definition of sane) where
> the NMI mode is just changing the delivery restrictions allows to still
> differentiate from which source the NMI originates.

Let me assume that one can find a way to reliably identify the source of an
NMI in x86. If we cannot use the proposed request_nmi() as it does not fit
x86, is it acceptable to bypass the existing irq framework and directly
program the delivery mode as NMI in the relevant hardware (e.g., a register
holding the MSI data)? For instance, in my initial attempt to have the HPET
timer to generate NMIs [1]. I could directly write to the FSB Interrupt
Route Register. In my view, it makes sense because, as you say, in x86 NMIs
are handled separately from the normal vector based interrupts.

I guess this would also imply reserving the relevant hardware so that it
is not used when calling request_irq().

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/patchwork/cover/953394/

