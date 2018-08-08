Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD421C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF1221765
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF1221765
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHHQll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:41:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbeHHQll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80F44402315B;
        Wed,  8 Aug 2018 14:21:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3267420180F4;
        Wed,  8 Aug 2018 14:21:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w78ELlJ5011795;
        Wed, 8 Aug 2018 10:21:47 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w78ELkNR011791;
        Wed, 8 Aug 2018 10:21:46 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 8 Aug 2018 10:21:46 -0400 (EDT)
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
In-Reply-To: <5f5ab5ba0bc84b31be52bd7708c6a356@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808081017210.9997@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com> <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com> <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com> <51a6c4e102ad4193b3f42498f0ff11a4@AcuMS.aculab.com> <alpine.LRH.2.02.1808070939320.6020@file01.intranet.prod.int.rdu2.redhat.com>
 <5f5ab5ba0bc84b31be52bd7708c6a356@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 08 Aug 2018 14:21:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 08 Aug 2018 14:21:47 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2018, David Laight wrote:

> From: Mikulas Patocka
> > Sent: 07 August 2018 15:07
> ...
> > Unaccelerated scrolling is still painfully slow
> > even on modern computers because of slow framebuffer read.
> 
> I solved that many years ago on a strongarm system by mapping
> the screen memory at two separate virtual addresses.
> One uncached used for writes, the second cached using the
> 'minicache' for reads.
> (and immediately fell foul of a memcpy() function that compared
> the two virtual addresses and decided to copy backwards)
> 
> I suspect some modern cpus don't like you doing that and the
> graphics 'drivers' won't use different mappings.

Intel says that you can't mix PAT memory attributes - but the non-temporal 
store instructions use write-combining semantics on a memory that is 
normally cacheable - and it is allowed to mix non-temporal stores with 
other cacheable memory accesses - so I believe that the CPU will snoop the 
cache for wc accesses and handle the conflict.

> Even in glibc you want a more general copy_to/from_io_memory()
> rather than just 'copy_from_framebuffer()'.
> Best to define both - even if they end up identical.
> Other drivers allow PCIe space be mmap()ed into user space.
> 
> While your tests show vmovntdqa being slightly slower than an
> avx read for uncached mappings it is still much better than
> all the other options.

Tihs was a measuring glitch - movntdqa is as fast as movdqa on non-cached
mappings.

Mikulas

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
