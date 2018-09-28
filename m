Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04189C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B542173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B542173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeI1OyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:54:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53651 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeI1OyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:54:15 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5oBP-0003CG-2f; Fri, 28 Sep 2018 10:31:31 +0200
Date:   Fri, 28 Sep 2018 10:31:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809281029350.2004@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018, Geert Uytterhoeven wrote:
> 
> On Fri, Sep 28, 2018 at 8:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 27 Sep 2018, Andy Lutomirski wrote:
> > > I have a couple questions here:
> > >
> > >  - Is this actually okay on all architectures?  That is, are there
> > >    cases where we'll screw up if we fail a USER_DS access this early?
> > >    s390 stands out as the obvious special case (where USER_DS is not
> > >    than just a subset of KERNEL_DS), but s390 opts out.
> > >
> > >  - Why doesn't x86 set HAVE_FUTEX_CMPXCHG?  Or do we still support
> > >    some 32-bit configurations that don't have cmpxchg and don't know
> > >    about it at compile time?
> >
> > I'm not entirely sure. Have to dig into the details. I assume S390 just can
> > set it though.
> 
> Not sure. My "[PATCH] futex: Switch to USER_DS for futex test"
> (https://www.spinics.net/lists/stable/msg28846.html), which is
> basically the same
> as this patch, broke s390, so it was never merged.
> 
> See "[BUG -next] "futex: switch to USER_DS for futex test" breaks s390"
> (https://www.spinics.net/lists/linux-next/msg27902.html)
> 
> Heiko said:
> | Martin and I discussed this today and we will change the s390 code so that
> | it will also survive very early USER_DS accesses (without valid current->mm)
> | since we also discovered a couple of other oddities in our code.
> 
> I don't know if that has happened, and whether it would work on s390 now.

Duh yes, forgot about that one. But as S390 always has cmpxchg it simply
can set HAVE_FUTEX_CMPXCHG which avoids the check completely.

Surely they want to fix the other oddities or have done so already :)

Thanks,

	tglx
