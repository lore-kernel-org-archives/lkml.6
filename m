Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2806A21798
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2806A21798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeHHVBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:01:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbeHHVBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BCD540216E7;
        Wed,  8 Aug 2018 18:40:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A52110CD629;
        Wed,  8 Aug 2018 18:40:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w78IeHVU027839;
        Wed, 8 Aug 2018 14:40:17 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w78IeGNn027835;
        Wed, 8 Aug 2018 14:40:16 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 8 Aug 2018 14:40:16 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Catalin Marinas <catalin.marinas@arm.com>
cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
In-Reply-To: <20180808142852.GD24736@iMac.local>
Message-ID: <alpine.LRH.2.02.1808081437260.18198@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com> <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com> <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com> <20180808113927.GA24736@iMac.local>
 <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com> <20180808142852.GD24736@iMac.local>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 18:40:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 18:40:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Aug 2018, Catalin Marinas wrote:

> On Wed, Aug 08, 2018 at 10:12:27AM -0400, Mikulas Patocka wrote:
> > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> > > On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> > > > 	while (1) {
> > > > 		start = (unsigned)random() % (LEN + 1);
> > > > 		end = (unsigned)random() % (LEN + 1);
> > > > 		if (start > end)
> > > > 			continue;
> > > > 		for (i = start; i < end; i++)
> > > > 			data[i] = val++;
> > > > 		memcpy(map + start, data + start, end - start);
> > > > 		if (memcmp(map, data, LEN)) {
> > > 
> > > It may be worth trying to do a memcmp(map+start, data+start, end-start)
> > > here to see whether the hazard logic fails when the writes are unaligned
> > > but the reads are not.
> > > 
> > > This problem may as well appear if you do byte writes and read longs
> > > back (and I consider this a hardware problem on this specific board).
> > 
> > I triad to insert usleep(10000) between the memcpy and memcmp, but the 
> > same corruption occurs. So, it can't be read-after-write hazard. It is 
> > caused by the improper handling of hazard between the overlapping writes 
> > inside memcpy.
> 
> It could get it wrong between subsequent writes to the same 64-bit range
> (e.g. the address & ~63 is the same but the data strobes for which bytes
> to write are different). If it somehow thinks that it's a
> write-after-write hazard even though the strobes are different, it could
> cancel one of the writes.

I believe that the SoC has logic for write-after-write detection, but the 
logic is broken and corrupts data.

If I insert "dmb sy" between the overlapping writes, there's no corruption 
(the PCIe controller won't see any overlapping writes in that case).

> It may be worth trying with a byte-only memcpy() function while keeping
> the default memcmp().

I tried that and byte-only memcpy works without any corruption.

> -- 
> Catalin

Mikulas
