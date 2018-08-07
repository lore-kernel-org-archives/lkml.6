Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769C2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2862121757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2862121757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbeHGQWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:22:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388929AbeHGQWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:22:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A74D40241DE;
        Tue,  7 Aug 2018 14:07:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 153442026D66;
        Tue,  7 Aug 2018 14:07:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w77E7T7F012579;
        Tue, 7 Aug 2018 10:07:29 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w77E7St6012575;
        Tue, 7 Aug 2018 10:07:29 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 7 Aug 2018 10:07:28 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     David Laight <David.Laight@ACULAB.COM>
cc:     "'Ard Biesheuvel'" <ard.biesheuvel@linaro.org>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Andrew Pinski <pinskia@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <51a6c4e102ad4193b3f42498f0ff11a4@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808070939320.6020@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com> <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com> <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com> <51a6c4e102ad4193b3f42498f0ff11a4@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 14:07:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 14:07:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2018, David Laight wrote:

> From: Mikulas Patocka
> > Sent: 05 August 2018 15:36
> > To: David Laight
> ...
> > There's an instruction movntdqa (and vmovntdqa) that can actually do
> > prefetch on write-combining memory type. It's the only instruction that
> > can do it.
> > 
> > It this instruction is used on non-write-combining memory type, it behaves
> > like movdqa.
> > 
> ...
> > I benchmarked it on a processor with ERMS - for writes to the framebuffer,
> > there's no difference between memcpy, 8-byte writes, rep stosb, rep stosq,
> > mmx, sse, avx - all this method achieve 16-17 GB/s
> 
> The combination of write-combining, posted writes and a fast PCIe slave
> are probably why there is little difference.
> 
> > For reading from the framebuffer:
> >  323 MB/s - memcpy (using avx2)
> >   91 MB/s - explicit 8-byte reads
> >  249 MB/s - rep movsq
> >  307 MB/s - rep movsb
> 
> You must be getting the ERMS hardware optimised 'rep movsb'.
> 
> >   90 MB/s - mmx
> >  176 MB/s - sse
> > 4750 MB/s - sse movntdqa
> >  330 MB/s - avx
> 
> avx512 is probably faster still.
> 
> > 5369 MB/s - avx vmovntdqa
> > 
> > So - it may make sense to introduce a function memcpy_from_framebuffer()
> > that uses movntdqa or vmovntdqa on CPUs that support it.
> 
> For kernel space it ought to be just memcpy_fromio().

I meant for userspace. Unaccelerated scrolling is still painfully slow 
even on modern computers because of slow framebuffer read. If glibc 
provided a function memcpy_from_framebuffer() that used movntdqa and the 
fbdev Xorg driver used it, it would help the users who use unaccelerated 
drivers for some reason.

> Can you easily repeat the tests using a non-write-combining map of the
> same PCIe slave?

I mapped the framebuffer as uncached and these are the results:

reading from the framebuffer:
318 MB/s - memcpy
 74 MB/s - explicit 8-byte reads
 73 MB/s - rep movsq
 11 MB/s - rep movsb
 87 MB/s - mmx
173 MB/s - sse
173 MB/s - sse movntdqa
323 MB/s - avx
284 MB/s - avx vmovntdqa

zeroing the framebuffer:
 19 MB/s - memset
154 MB/s - explicit 8-byte writes
152 MB/s - rep stosq
 19 MB/s - rep stosb
152 MB/s - mmx
306 MB/s - sse
621 MB/s - avx

copying data to the framebuffer:
618 MB/s - memcpy (using avx2)
152 MB/s - explicit 8-byte writes
139 MB/s - rep movsq
 17 MB/s - rep movsb
154 MB/s - mmx
305 MB/s - sse
306 MB/s - sse movntdqa
619 MB/s - avx
619 MB/s - avx movntdqa

> I can probably run the same measurements against our rather leisurely
> FPGA based PCIe slave.
> IIRC PCIe reads happen every 128 clocks of the cards 62.5MHz clock,
> increasing the size of the registers makes a significant different.
> I've not tried mapping write-combining and using (v)movntdaq.
> I'm not sure what effect write-combining would have if the whole BAR
> were mapped that way - so I'll either have to map the physical addresses
> twice or add in another BAR.
> 
> 	David

Mikulas
