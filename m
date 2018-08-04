Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC83C46470
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2065217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2065217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeHDNEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:04:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbeHDNEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:04:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9A638197031;
        Sat,  4 Aug 2018 11:04:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E41C2026D66;
        Sat,  4 Aug 2018 11:04:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w74B4EZ0000455;
        Sat, 4 Aug 2018 07:04:14 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w74B4Dsu000400;
        Sat, 4 Aug 2018 07:04:13 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 4 Aug 2018 07:04:13 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Andrew Pinski <pinskia@gmail.com>
cc:     Richard Earnshaw <Richard.Earnshaw@arm.com>,
        ard.biesheuvel@linaro.org,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Florian Weimer <fweimer@redhat.com>,
        thomas.petazzoni@free-electrons.com,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 11:04:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 11:04:15 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2018, Andrew Pinski wrote:

> On Fri, Aug 3, 2018 at 5:58 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> >
> > On Fri, 3 Aug 2018, Richard Earnshaw (lists) wrote:
> >
> > > Whoa, hold on.
> > >
> > > Memcpy should never be used on device memory.  Period.  Memcpy doesn't
> > > know anything about what size of access is needed for accessing a device.
> > >
> > > But why is the buffer in device memory rather than some other form of
> > > uncached memory?
> > >
> > > If you change memcpy to deal with an aspect of the system hardware,
> > > you'll end up hosing performance EVERYWHERE.  DON'T DO IT!
> >
> > memcpy in glibc uses ifunc selection and it already has optimized variants
> > for Falkor and Thunder-X. You can add just another variant for Armada-8040
> > that works around this bug and you won't be harming anyone but users of
> > Armada-8040.
> 
> Except it is not a bug in the ARMADA at all.  It is a bug in thinking
> memcpy will work on non-DRAM memory.

There's plenty of memcpy's in the graphics stack. No one will be rewriting 
all the graphics drivers because of tiny market share that ARM has in 
desktop computers. So if you refuse to fix things and blame everyone else, 
you can as well announce that you don't want to have PCIe graphics on ARM 
at all.

> Can you run the test program on x86 using the similar framebuffer
> setup?  Does doing two writes (one aligned and one unaligned but
> overlapping with previous one) cause the same issue?  I suspect it
> does, then using memcpy for frame buffers is wrong.
>
> Thanks,
> Andrew

Overlapping unaligned writes work on x86 - they have to, because of 
backward compatibility.

8086, 80286 and 80386 didn't have any cache at all.

80486 and Pentium had cache, but when the CPU was reading some data from 
memory, the motherboard could disable cacheability for this data by a 
special pin. Software didn't have to do any explicit cache management - 
programs for 80386 that expected that there's no cache worked flawlessly 
on 80486 and Pentium.

Pentium Pro had memory type range registers that determine cacheability of 
various memory regions (so that it could allocate a cache line on write 
without having to query the motherboard if the particular region of memory 
is cacheable) - but the MTRRs were set by BIOS and the software didn't 
have to care about them at all - an 80386 operating system that had no 
idea of cacheability would still work on Pentium Pro.

MTRRs could also set a write-combining mode on a region of memory - but 
again, this is completely transparent to the software (the write combining 
buffers are flushed when accessing an I/O port or uncacheable memory) - so 
that an accelerated graphics driver written for Pentium that had no idea 
of write-combining would still work on Pentium Pro with write combining 
enabled.

Mikulas
