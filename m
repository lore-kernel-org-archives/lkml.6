Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAAE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAAE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJKAbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:31:47 -0400
Received: from foss.arm.com ([217.140.101.70]:55664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeJKAbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:31:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA7901596;
        Wed, 10 Oct 2018 10:08:43 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B89A3F5B3;
        Wed, 10 Oct 2018 10:08:43 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5BF331AE088A; Wed, 10 Oct 2018 18:08:43 +0100 (BST)
Date:   Wed, 10 Oct 2018 18:08:43 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>, matthias.bgg@kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        robert.richter@cavium.com, suzuki.poulose@arm.com,
        shankerd@codeaurora.org, xiexiuqi@huawei.com, Dave.Martin@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
Message-ID: <20181010170842.GD16512@arm.com>
References: <20180912095232.2110-1-matthias.bgg@kernel.org>
 <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
 <95733d12-ee1d-9874-16a7-c614cc0ce8cd@arm.com>
 <8ef6b381-e170-30de-ad0e-fae8ccf189e5@suse.com>
 <1d227152-2770-3e93-f78c-71e7a3b4fe76@arm.com>
 <93532c6a-0a84-4063-3f9f-171490985cbb@gmail.com>
 <86y3bctoc5.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86y3bctoc5.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 04:17:30PM +0100, Marc Zyngier wrote:
> On Fri, 05 Oct 2018 15:13:48 +0100,
> Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > 
> > 
> > 
> > On 05/10/2018 15:42, Marc Zyngier wrote:
> > > On 05/10/18 13:33, Matthias Brugger wrote:
> > >>
> > >>
> > >> On 05/10/2018 12:55, Marc Zyngier wrote:
> > >>> Hi Matthias,
> > >>>
> > >>> On 04/10/18 23:11, Matthias Brugger wrote:
> > >>>> Friendly reminder, if anyone has any comment on the patch :)
> > >>>>
> > >>>> On 9/12/18 11:52 AM, matthias.bgg@kernel.org wrote:
> > >>>>> From: Matthias Brugger <mbrugger@suse.com>
> > >>>>>
> > >>>>> Some hardware does not implement two-level page tables so that
> > >>>>> the amount of contigious memory needed by the baser is bigger
> > >>>>> then the zone order. This is a known problem on Cavium Thunderx
> > >>>>> with 4K page size.
> > >>>>>
> > >>>>> We fix this by adding an errata which allocates the memory early
> > >>>>> in the boot cycle, using the memblock allocator.
> > >>>>>
> > >>>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > >>>>> ---
> > >>>>>    arch/arm64/Kconfig               | 12 ++++++++
> > >>>>>    arch/arm64/include/asm/cpucaps.h |  3 +-
> > >>>>>    arch/arm64/kernel/cpu_errata.c   | 33 +++++++++++++++++++++
> > >>>>>    drivers/irqchip/irq-gic-v3-its.c | 50 ++++++++++++++++++++------------
> > >>>>>    4 files changed, 79 insertions(+), 19 deletions(-)
> > >>>
> > >>> My only comment would be to state how much I dislike both the HW and the
> > >>> patch... ;-) The idea that we have some erratum that depends on the page size
> > >>> doesn't feel good at all.
> > >>>
> > >>
> > >> Well ugly HW needs ugly patches ;-)
> > >>
> > >>>>>
> > >>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > >>>>> index 1b1a0e95c751..dfd9fe08f0b2 100644
> > >>>>> --- a/arch/arm64/Kconfig
> > >>>>> +++ b/arch/arm64/Kconfig
> > >>>>> @@ -597,6 +597,18 @@ config QCOM_FALKOR_ERRATUM_E1041
> > >>>>>            If unsure, say Y.
> > >>>>>    +config CAVIUM_ALLOC_ITS_TABLE_EARLY
> > >>>>> +    bool "Cavium Thunderx: Allocate the its table early"
> > >>>>> +    default y
> > >>>>> +    depends on ARM64_4K_PAGES && FORCE_MAX_ZONEORDER < 13
> > >>>
> > >>> Here's a though: Why don't we ensure that FORCE_MAX_ZONEORDER is such as we
> > >>> could always allocate the same amount of memory, no matter what the page size
> > >>> is? That, or bump FORCE_MAX_ZONEORDER to 13 if the kernel includes support
> > >>> for TX1.
> > >>>
> > >>
> > >> Bumping FORCE_MAX_ZONEORDER when TX1 is supported was proposed here:
> > >> https://patchwork.kernel.org/patch/6322281/
> > >>
> > >> To bring in some more history, the CMA approach ended with this discussion:
> > >> https://patchwork.kernel.org/patch/9888041/
> > >>
> > >>> Any of this of course requires buy-in from the arm64 maintainers, as this is
> > >>> quite a departure from the way things work so far.
> > >>>
> > >>
> > >> With my distribution head on, I would prefer a solution that does not change
> > >> FORCE_MAX_ZONEORDER. That's how I came to the idea providing a third solution to
> > >> the same problem :)
> > > 
> > > Why is that a problem? What impact does this have on your favourite distro?
> > > 
> > 
> > The impact is on changing FORCE_MAX_ZONEORDER on an already released
> > kernel will break Kernel ABI and with that all external modules. I
> > know that's nothing upstream cares too much about, but the distros
> > do :)
> 
> Unfortunately, that's something you're bringing upon yourself, and I'm
> afraid I can't really take this into account. You could always bump
> that ABI if you really want to support this platform as, at the end of
> the day, this is something you're in control of.
> 
> But I'd really like to hear what Catalin or Will think of this (Will
> wasn't massively impressed by this 3 years ago, and I wonder if his
> approach has changed since).

I don't see anything that changes my opinion here, and the reality is
that bumping FORCE_MAX_ZONEORDER doesn't guarantee anything about the
allocation succeeding. I'm also hesitant to punish other platforms
(including TX2!) because of this TX1 "feature".

One thing I'm unsure about is why the CMA approach failed; the link
above is a complain about the use of subsys_initcall() afaict.

Will
