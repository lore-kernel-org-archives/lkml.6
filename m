Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DCBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D2420652
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D2420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeI1VFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:05:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54607 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1VFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:05:19 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5tww-0000Zg-VS; Fri, 28 Sep 2018 16:40:59 +0200
Date:   Fri, 28 Sep 2018 16:40:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net>
Message-ID: <alpine.DEB.2.21.1809281637000.2004@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1>
 <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de> <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1735524495-1538145658=:2004"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1735524495-1538145658=:2004
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 28 Sep 2018, Andy Lutomirski wrote:
> > On Sep 28, 2018, at 1:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> >> On Fri, 28 Sep 2018, Martin Schwidefsky wrote:
> >> On Fri, 28 Sep 2018 09:12:10 +0200
> >> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>> I don't know if that has happened, and whether it would work on s390 now.
> >> 
> >> commit 03b8c7b623c80af264c4c8d6111e5c6289933666
> >> Author: Heiko Carstens <heiko.carstens@de.ibm.com>
> >> Date:   Sun Mar 2 13:09:47 2014 +0100
> >> 
> >>    futex: Allow architectures to skip futex_atomic_cmpxchg_inatomic() test
> >> 
> >>    If an architecture has futex_atomic_cmpxchg_inatomic() implemented and there
> >>    is no runtime check necessary, allow to skip the test within futex_init().
> >> 
> >>    This allows to get rid of some code which would always give the same result,
> >>    and also allows the compiler to optimize a couple of if statements away.
> >> 
> >>    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> >>    Cc: Finn Thain <fthain@telegraphics.com.au>
> >>    Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >>    Link: http://lkml.kernel.org/r/20140302120947.GA3641@osiris
> >>    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >> 
> >> 
> >> Heiko created the CONFIG_HAVE_FUTEX_CMPXCHG to get around this issue.
> >> We just skip the runtime check as well as arc, m68k and sh. Not sure
> >> about xtensa, the set it config option only for !MMU.
> > 
> > Duh. grep would have told me. -ENOTENOUGHCOFFEE
> > 
> > 
> There’s another way to skin this cat: keep KERNEL_DS but pass a valid
> pointer. I don’t suppose you remember why you didn’t do that?

IIRC, there was an issue with extra checks in some architectures when you
handed in a kernel address spitting warnings or such. That's probably gone
by now, but I can't tell for sure. At least the requirement to do runtime
detection for x86 is gone. Don't know if any other architecture still has
it.

Thanks,

	tglx


--8323329-1735524495-1538145658=:2004--
