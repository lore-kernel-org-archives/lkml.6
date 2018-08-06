Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E20C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0795D219CE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0795D219CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeHFKJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:09:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbeHFKJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:09:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CA2740216EA;
        Mon,  6 Aug 2018 08:02:05 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6DC22156897;
        Mon,  6 Aug 2018 08:02:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w76824lK011665;
        Mon, 6 Aug 2018 04:02:04 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w76823Uo011656;
        Mon, 6 Aug 2018 04:02:03 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 6 Aug 2018 04:02:03 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Florian Weimer <fweimer@redhat.com>
cc:     Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        ard.biesheuvel@linaro.org,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        thomas.petazzoni@free-electrons.com,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
Message-ID: <alpine.LRH.2.02.1808060325110.3756@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com> <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com> <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com> <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com> <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com> <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com> <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 06 Aug 2018 08:02:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 06 Aug 2018 08:02:05 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Aug 2018, Florian Weimer wrote:

> On 08/04/2018 01:04 PM, Mikulas Patocka wrote:
> > There's plenty of memcpy's in the graphics stack. No one will be rewriting
> > all the graphics drivers because of tiny market share that ARM has in
> > desktop computers. So if you refuse to fix things and blame everyone else,
> > you can as well announce that you don't want to have PCIe graphics on ARM
> > at all.
> 
> The POWER toolchain maintainers said pretty much the same thing not too 
> long ago. I wonder how many architectures need to fail until the 
> graphics stack is finally fixed.
> 
> Thanks,
> Florian

If you say that your architecture doesn't support unaligned accesses at 
all, there's no problem - the compiler won't generate them and the libc 
won't contain them.

But if you say that your architecture supports unaligned accesses except 
for the framebuffer, then you have a problem - the compiler can't know 
which pointers point to the framebuffer and libc can't know either - you 
caused this problem by your architectural decision.

You can use 'volatile' to suppress memory optimizations, but it's 
impossible to go through the whole Linux graphics stack and add volatile 
to every pointer that may point to videoram. Even if you succeesed, new 
videoram accesses without volatile will appear after a year of 
development.

See for example the macros READ_ONCE and WRITE_ONCE in Linux kernel - they 
should be used when there's concurrent access to the particular variable, 
but mainstream architectures don't require them, so many kernel developers 
are omitting them in their code.

If you are building a supercomputer with a particular GPU, you can force 
the GPU vendor to provide POWER-compliant drivers. If you are building a 
workstation where the user can plug any GPU, forcing developers will go 
nowhere. You have to emulate the unaligned accesses and make sure that the 
next versions of your architecture support them in hardware.

Mikulas
