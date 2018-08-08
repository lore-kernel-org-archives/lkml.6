Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3466EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D738C2174A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D738C2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeHHOgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:36:13 -0400
Received: from foss.arm.com ([217.140.101.70]:37918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbeHHOgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:36:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE795ED1;
        Wed,  8 Aug 2018 05:16:46 -0700 (PDT)
Received: from iMac.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC0E93F5D0;
        Wed,  8 Aug 2018 05:16:44 -0700 (PDT)
Date:   Wed, 8 Aug 2018 13:16:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Matt Sealey <neko@bakuhatsu.net>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <20180808121641.GB24736@iMac.local>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Fri, Aug 03, 2018 at 03:44:44PM -0500, Matt Sealey wrote:
> On 3 August 2018 at 13:25, Mikulas Patocka <mpatocka@redhat.com> wrote:
> > On Fri, 3 Aug 2018, Ard Biesheuvel wrote:
> >> Are we still talking about overlapping unaligned accesses here? Or do
> >> you see other failures as well?
> >
> > Yes - it is caused by overlapping unaligned accesses inside memcpy.
> > When I put "dmb sy" between the overlapping accesses in
> > glibc/sysdeps/aarch64/memcpy.S, this program doesn't detect any
> > memory corruption.
> 
> It is a symptom of generating reorderable accesses inside memcpy. It's nothing
> to do with alignment, per se (see below). A dmb sy just hides the symptoms.
> 
> What we're talking about here - yes, Ard, within certain amounts of
> reason - is that you cannot use PCI BAR memory as 'Normal' - certainly
> never cacheable memory, but Normal NC isn't good either. That is that
> your CPU cannot post writes or reads towards PCI memory spaces unless
> it is dealing with it as Device memory or very strictly controlled use
> of Normal Non-Cacheable.

I disagree that it's not possible to use Normal NC on prefetchable BARs.
This particular case looks more like a hardware issue to me as other
platforms don't exhibit the same behaviour.

Note that allowing Normal NC mapping of prefetchable BARs together with
unaliagned accesses is also a requirement for SBSA-compliant platforms
([1]; though I don't find the text in D.2 very clear).

> >> > I tried to run it on system RAM mapped with the NC attribute and I didn't
> >> > get any corruption - that suggests the the bug may be in the PCIE
> >> > subsystem.
> 
> Pure fluke.

Do you mean you don't expect Mikulas' test to run fine on system RAM
with Normal NC mapping? We would have bigger issues if this was the
case.

> I'll give a simple explanation. The Arm Architecture defines
> single-copy and multi-copy atomic transactions. You can treat
> 'single-copy' to mean that that transaction cannot be made partial, or
> reordered within itself, i.e. it must modify memory (if it is a store)
> in a single swift effort and any future reads from that memory must
> return the FULL result of that write.
> 
> Multi-copy means it can be resized and reordered a bit. Will Deacon is
> going to crucify me for simplifying it, but.. let's proceed with a
> poor example:

Not sure about Will but I think you got them wrong ;). The single/multi
copy atomicity is considered in respect to (multiple) observers, a.k.a.
masters, and nothing to do with reordering a bit (see B2.2 in the ARMv8
ARM).

> STR X0,[X1] on a 32-bit bus cannot ever be single-copy atomic, because
> you cannot write 64-bits of data on a 32-bit bus in a single,
> unbreakable transaction. This is because from one bus cycle to the
> next, one half of the transaction will be in a different place. Your
> interconnect will have latched and buffered 32-bits and the CPU is
> holding the other.

It depends on the implementation, interconnect, buses. Since single-copy
atomicity refers to master accesses, the above transaction could be a
burst of two 32-bit writes and treated atomically by the interconnect
(i.e. not interruptible).

> STP X0, X1, [X2] on a 64-bit bus can be single-copy atomic with
> respect to the element size. But it is on the whole multi-copy atomic
> - that is to say that it can provide a single transaction with
> multiple elements which are transmitted, and those elements could be
> messed with on the way down the pipe.

This has nothing to do with multi-copy atomicity which actually refers
to multiple observers seeing the same write. The ARM architecture is not
exactly multi-copy atomic anyway (rather "other-multi-copy atomic").

Architecturally, STP is treated as two single-copy accesses (as you
mentioned already).

Anyway, the single/multiple copy atomicity is irrelevant for the C test
from Mikulas where you have the same observer (the CPU) writing and
reading the memory. I wonder whether writing a byte and reading a long
back would show similar corruption.

> And the granularity of the hazarding in your system, from the CPU
> store buffer to the bus interface to the interconnect buffering to the
> PCIe bridge to the PCIe EP is.. what? Not the same all the way down,
> I'll bet you.

I think hazarding is what goes wrong here, especially since with
overlapping unaligned addresses. However, I disagree that it is
impossible to implement this properly on a platform with PCIe so that
Normal NC mappings can be used.

Thanks.

[1] https://developer.arm.com/docs/den0029/latest/server-base-system-architecture

-- 
Catalin
