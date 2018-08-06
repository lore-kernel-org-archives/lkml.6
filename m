Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00888C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31B121A5B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31B121A5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeHFTYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:24:04 -0400
Received: from foss.arm.com ([217.140.101.70]:42578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729749AbeHFTYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:24:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78CF80D;
        Mon,  6 Aug 2018 10:14:01 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D249E3F5D0;
        Mon,  6 Aug 2018 10:13:59 -0700 (PDT)
Date:   Mon, 6 Aug 2018 18:13:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Matt Sealey <neko@bakuhatsu.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <20180806171356.kk45vd7n5bdi6ka3@armageddon.cambridge.arm.com>
References: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 05:47:36PM +0200, Ard Biesheuvel wrote:
> On 6 August 2018 at 14:42, Robin Murphy <robin.murphy@arm.com> wrote:
> > On 06/08/18 11:25, Mikulas Patocka wrote:
> > [...]
> >>>
> >>> None of this explains why some transactions fail to make it across
> >>> entirely. The overlapping writes in question write the same data to
> >>> the memory locations that are covered by both, and so the ordering in
> >>> which the transactions are received should not affect the outcome.
> >>
> >> You're right that the corruption couldn't be explained just by reordering
> >> writes. My hypothesis is that the PCIe controller tries to disambiguate
> >> the overlapping writes, but the disambiguation logic was not tested and it
> >> is buggy. If there's a barrier between the overlapping writes, the PCIe
> >> controller won't see any overlapping writes, so it won't trigger the
> >> faulty disambiguation logic and it works.
> >>
> >> Could the ARM engineers look if there's some chicken bit in Cortex-A72
> >> that could insert barriers between non-cached writes automatically?
> >
> > I don't think there is, and even if there was I imagine it would have a
> > pretty hideous effect on non-coherent DMA buffers and the various other
> > places in which we have Normal-NC mappings of actual system RAM.
> 
> Looking at the A72 manual, there is one chicken bit that looks like it
> may be related:
> 
> CPUACTLR_EL1 bit #50:
> 
> 0 Enables store streaming on NC/GRE memory type. This is the reset value.
> 1 Disables store streaming on NC/GRE memory type.
> 
> so putting something like
> 
> mrs x0, S3_1_C15_C2_0
> orr x0, x0, #(1 << 50)
> msr S3_1_C15_C2_0, x0
> 
> in __cpu_setup() would be worth a try.

Note that access to this register may be disabled at EL3 by firmware
(ACTLR_EL3.CPUACTLR).

FWIW, Mikulas' test seems to run fine on a ThunderX1 with AMD
FirePro W2100 (on /dev/fb1)

-- 
Catalin
