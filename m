Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A84C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D48219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D48219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeHHRe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:34:56 -0400
Received: from foss.arm.com ([217.140.101.70]:40534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeHHRe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59A3C18A;
        Wed,  8 Aug 2018 08:14:50 -0700 (PDT)
Received: from iMac.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 180543F5D4;
        Wed,  8 Aug 2018 08:14:47 -0700 (PDT)
Date:   Wed, 8 Aug 2018 16:14:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Richard Earnshaw (lists)" <Richard.Earnshaw@arm.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        libc-alpha@sourceware.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>, linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <20180808151444.GF24736@iMac.local>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808113927.GA24736@iMac.local>
 <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
 <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 04:01:12PM +0100, Richard Earnshaw wrote:
> On 08/08/18 15:12, Mikulas Patocka wrote:
> > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> >> On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> >>> 	while (1) {
> >>> 		start = (unsigned)random() % (LEN + 1);
> >>> 		end = (unsigned)random() % (LEN + 1);
> >>> 		if (start > end)
> >>> 			continue;
> >>> 		for (i = start; i < end; i++)
> >>> 			data[i] = val++;
> >>> 		memcpy(map + start, data + start, end - start);
> >>> 		if (memcmp(map, data, LEN)) {
> >>
> >> It may be worth trying to do a memcmp(map+start, data+start, end-start)
> >> here to see whether the hazard logic fails when the writes are unaligned
> >> but the reads are not.
> >>
> >> This problem may as well appear if you do byte writes and read longs
> >> back (and I consider this a hardware problem on this specific board).
> > 
> > I triad to insert usleep(10000) between the memcpy and memcmp, but the 
> > same corruption occurs. So, it can't be read-after-write hazard. It is 
> > caused by the improper handling of hazard between the overlapping writes 
> > inside memcpy.
> 
> I don't think you've told us what form the corruption takes.  Does it
> lose some bytes?  Modify values beyond the copy range?  Write completely
> arbitrary values?

From this message:

https://lore.kernel.org/lkml/alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com/

- failing to write a few bytes
- writing a few bytes that were written 16 bytes before
- writing a few bytes that were written 16 bytes after

> The overlapping writes in memcpy never write different values to the
> same location, so I still feel this must be some sort of HW issue, not a
> SW one.

So do I (my interpretation is that it combines or rather skips some of
the writes to the same 16-byte address as it ignores the data strobes).

-- 
Catalin
