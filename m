Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9903C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0362150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0362150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeHBLbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:31:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36208 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHBLbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:31:22 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flA6J-0002kT-Uz; Thu, 02 Aug 2018 11:40:56 +0200
Date:   Thu, 2 Aug 2018 11:40:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Julien Thierry <julien.thierry@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/4] genirq: Provide basic NMI management for interrupt
 lines
In-Reply-To: <86r2jhw7a1.wl-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1808021137400.2037@nanos.tec.linutronix.de>
References: <1532430427-57151-1-git-send-email-julien.thierry@arm.com> <1532430427-57151-2-git-send-email-julien.thierry@arm.com> <20180801030723.GA31383@voyager> <df8f9f98-a1d3-e871-eec8-d805ff7cf5b7@arm.com> <20180802020320.GC31758@voyager>
 <86tvodw9wz.wl-marc.zyngier@arm.com> <alpine.DEB.2.21.1808020841200.1835@nanos.tec.linutronix.de> <86r2jhw7a1.wl-marc.zyngier@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Marc Zyngier wrote:
> On Thu, 02 Aug 2018 07:55:49 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > On Thu, 2 Aug 2018, Marc Zyngier wrote:
> > > 
> > > If we need to distinguish between the two, then we need two flags. One
> > > that indicates the generation capability, and one that indicates the
> > > forwarding capability.
> > 
> > There is absolutely no reason to expose this on x86, really.
> > 
> > Why?
> > 
> > Because NMI is an utter trainwreck on x86. It's a single entry point
> > without the ability of differentiation from which source the NMI
> > originated. So mapping it to anything generic is just not going to work.
> > 
> > It has absolutely nothing to do with the normal way of vector based
> > interrupt operation and I don't see at all how adding this just because
> > would improve anything on x86. In fact it would create more problems than
> > it solves.
> 
> Fair enough. Does it mean Julien can completely ignore the x86
> requirements for this and focus on something that fit the need of
> architectures where (pseudo-)NMIs can be managed similarly to normal
> interrupts (arm, arm64, sparc...)?

Yes, focussing on "sane" architectures (by some definition of sane) where
the NMI mode is just changing the delivery restrictions allows to still
differentiate from which source the NMI originates.

There is no way to make this work on x86 unless they fundamentally change
the low level exception mechanics. Not going to happen anytime soon. And if
it ever happens then they better implement it in a way which is usable by
software sanely.

Thanks,

	tglx
