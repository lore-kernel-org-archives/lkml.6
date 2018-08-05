Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FDC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6DF217B4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6DF217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeHEQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:40:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbeHEQky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:40:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B0754021700;
        Sun,  5 Aug 2018 14:36:05 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A875D7C5F;
        Sun,  5 Aug 2018 14:36:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w75Ea4Jw025496;
        Sun, 5 Aug 2018 10:36:04 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w75Ea10C025475;
        Sun, 5 Aug 2018 10:36:02 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 5 Aug 2018 10:36:01 -0400 (EDT)
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
In-Reply-To: <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com> <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com> <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 05 Aug 2018 14:36:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 05 Aug 2018 14:36:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2018, David Laight wrote:

> From: Mikulas Patocka
> > Sent: 03 August 2018 13:05
> ...
> > > Even on x86 using memcpy() on PCIe memory (maybe mmap()ed into userspace)
> > > isn't a good idea.
> > > In the kernel memcpy_to/fromio() ought to be a better choice but that
> > > is just an alternate name for memcpy().
> > >
> > > The problem on x86 is that memcpy() is likely to be implemented as
> > > 'rep movsb' on modern cpu - relying on the cpu hardware to perform
> > > cache-line sized transfers (etc).
> > > Unfortunately on uncached locations it has to revert to byte copies.
> > > So PCIe transfers (especially reads) are very slow.
> > >
> > > The transfers need to use the largest size register available.
> > >
> > > 	David
> > 
> > On x86, the framebuffer is mapped as write-combining memory type, so "rep
> > movsb" could merge the byte writes to larger chunks. I don't have a cpu
> > with the ERMS feature - could anyone try it if rep movsb works worse or
> > better than explicit writes to the framebuffer?
> 
> I don't think 'write combining' can help reads, and memcpy_to/fromio()

There's an instruction movntdqa (and vmovntdqa) that can actually do 
prefetch on write-combining memory type. It's the only instruction that 
can do it.

It this instruction is used on non-write-combining memory type, it behaves 
like movdqa.

> are likely to be used for normal memory mapped io areas.
> 
> 	David

I benchmarked it on a processor with ERMS - for writes to the framebuffer, 
there's no difference between memcpy, 8-byte writes, rep stosb, rep stosq, 
mmx, sse, avx - all this method achieve 16-17 GB/s

For reading from the framebuffer:
 323 MB/s - memcpy (using avx2)
  91 MB/s - explicit 8-byte reads
 249 MB/s - rep movsq
 307 MB/s - rep movsb
  90 MB/s - mmx
 176 MB/s - sse
4750 MB/s - sse movntdqa
 330 MB/s - avx
5369 MB/s - avx vmovntdqa

So - it may make sense to introduce a function memcpy_from_framebuffer() 
that uses movntdqa or vmovntdqa on CPUs that support it.

Mikulas
