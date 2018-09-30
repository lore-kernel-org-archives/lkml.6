Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA69C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 04:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93A7208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 04:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93A7208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeI3KwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 06:52:16 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:33573 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727574AbeI3KwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 06:52:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A94B9180A8130;
        Sun, 30 Sep 2018 04:20:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: town15_24a4223d21b1f
X-Filterd-Recvd-Size: 3473
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Sep 2018 04:20:51 +0000 (UTC)
Message-ID: <8afdd3b1c51587708db6ae878eb0a7e9f8b5673a.camel@perches.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org
Date:   Sat, 29 Sep 2018 21:20:50 -0700
In-Reply-To: <CAHmME9rqsOid6UOx+VTsFzJLEiaXpTP_z_wvHC6MbeAQUeEtHg@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
         <20180925145622.29959-2-Jason@zx2c4.com>
         <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
         <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
         <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
         <CAKv+Gu__7mZFFq6qC=8yh0OuaV+TCCLFt6nm8yJfaANHUPrJ=A@mail.gmail.com>
         <CAHmME9owF+3aQaZUkK4KkfnJna+DK=GoWV8yf-Wb+gH4w3y9eg@mail.gmail.com>
         <CAKv+Gu9FAVVOiYyGovYZ19-107_6sK9Ya6LnK=AQkTgctMmu5A@mail.gmail.com>
         <CAHmME9rqsOid6UOx+VTsFzJLEiaXpTP_z_wvHC6MbeAQUeEtHg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-28 at 16:01 +0200, Jason A. Donenfeld wrote:
> On Fri, Sep 28, 2018 at 4:00 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > 
> > On 28 September 2018 at 15:59, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > On Fri, Sep 28, 2018 at 3:58 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > > 
> > > > On 28 September 2018 at 15:47, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > On Fri, Sep 28, 2018 at 10:49 AM Ard Biesheuvel
> > > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > > > > +typedef enum {
> > > > > > > > +       HAVE_NO_SIMD = 1 << 0,
> > > > > > > > +       HAVE_FULL_SIMD = 1 << 1,
> > > > > > > > +       HAVE_SIMD_IN_USE = 1 << 31
> > > > > > > > +} simd_context_t;
> > > > > > > > +
> > > > > > 
> > > > > > Oh, and another thing (and I'm surprised checkpatch.pl didn't complain
> > > > > > about it): the use of typedef in new code is strongly discouraged.
> > > > > > This policy predates my involvement, so perhaps Joe can elaborate on
> > > > > > the rationale?
> > > > > 
> > > > > In case it matters, the motivation for making this a typedef is I
> > > > > could imagine this at some point turning into a more complicated
> > > > > struct on certain platforms and that would make refactoring easier. I
> > > > > could just make it `struct simd_context` now with 1 member though...
> > > > 
> > > > Yes that makes sense
> > > 
> > > The rationale for it being a typedef or moving to a struct now?
> > 
> > Yes just switch to a struct.
> 
> Okay. No problem with that, but will wait to hear from Joe first.

Why do you need to hear from me again?

As far as I know, the only info about typedef avoidance are in
Documentation/process/coding-style.rst section 5.



