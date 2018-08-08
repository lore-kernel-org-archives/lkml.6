Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B699DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615B8219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615B8219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHHQsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:48:53 -0400
Received: from foss.arm.com ([217.140.101.70]:39662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHHQsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:48:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E188C7A9;
        Wed,  8 Aug 2018 07:28:57 -0700 (PDT)
Received: from iMac.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDB563F5D4;
        Wed,  8 Aug 2018 07:28:55 -0700 (PDT)
Date:   Wed, 8 Aug 2018 15:28:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
Message-ID: <20180808142852.GD24736@iMac.local>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808113927.GA24736@iMac.local>
 <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:12:27AM -0400, Mikulas Patocka wrote:
> On Wed, 8 Aug 2018, Catalin Marinas wrote:
> > On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> > > 	while (1) {
> > > 		start = (unsigned)random() % (LEN + 1);
> > > 		end = (unsigned)random() % (LEN + 1);
> > > 		if (start > end)
> > > 			continue;
> > > 		for (i = start; i < end; i++)
> > > 			data[i] = val++;
> > > 		memcpy(map + start, data + start, end - start);
> > > 		if (memcmp(map, data, LEN)) {
> > 
> > It may be worth trying to do a memcmp(map+start, data+start, end-start)
> > here to see whether the hazard logic fails when the writes are unaligned
> > but the reads are not.
> > 
> > This problem may as well appear if you do byte writes and read longs
> > back (and I consider this a hardware problem on this specific board).
> 
> I triad to insert usleep(10000) between the memcpy and memcmp, but the 
> same corruption occurs. So, it can't be read-after-write hazard. It is 
> caused by the improper handling of hazard between the overlapping writes 
> inside memcpy.

It could get it wrong between subsequent writes to the same 64-bit range
(e.g. the address & ~63 is the same but the data strobes for which bytes
to write are different). If it somehow thinks that it's a
write-after-write hazard even though the strobes are different, it could
cancel one of the writes.

It may be worth trying with a byte-only memcpy() function while keeping
the default memcmp().

-- 
Catalin
