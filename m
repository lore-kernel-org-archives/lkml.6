Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6FDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2232F2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2232F2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbeHCLg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:36:57 -0400
Received: from foss.arm.com ([217.140.101.70]:40662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbeHCLg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:36:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98DB180D;
        Fri,  3 Aug 2018 02:41:27 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69C913F5B3;
        Fri,  3 Aug 2018 02:41:27 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 340231AE30FD; Fri,  3 Aug 2018 10:41:30 +0100 (BST)
Date:   Fri, 3 Aug 2018 10:41:30 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Matt Sealey <neko@bakuhatsu.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        libc-alpha@sourceware.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <20180803094129.GB17798@arm.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 09:16:39AM +0200, Ard Biesheuvel wrote:
> On 3 August 2018 at 08:35, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> > On Thu, 2 Aug 2018, Matt Sealey wrote:
> >
> >> The easiest explanation for this would be that the memory isn?t mapped
> >> correctly. You can?t use PCIe memory spaces with anything other than
> >> Device-nGnRE or stricter mappings. That?s just differences between the
> >> AMBA and PCIe (posted/unposted) memory models.
> 
> Whoa hold on there.
> 
> Are you saying we cannot have PCIe BAR windows with memory semantics on ARM?
> 
> Most accelerated graphics drivers rely heavily on the ability to map
> the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
> ordinary memory.

Yeah, I'd expect framebuffers to be mapped as normal NC. That should be
fine for prefetchable BARs, no?

Will
