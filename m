Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DCCC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34148242E9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34148242E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeFVNml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:42:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41695 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeFVNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:42:40 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWMKi-0005yy-OV; Fri, 22 Jun 2018 15:42:36 +0200
Date:   Fri, 22 Jun 2018 15:42:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] time: Make sure jiffies_to_msecs() preserves non-zero
 time periods
In-Reply-To: <CAMuHMdW9FUMQ568GTJG_p9J8jFbVLOR6hPhsxsaMTttQjp=Wzw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806221539380.2402@nanos.tec.linutronix.de>
References: <20180622075421.16001-1-geert@linux-m68k.org> <alpine.DEB.2.21.1806221446230.2402@nanos.tec.linutronix.de> <CAMuHMdW9FUMQ568GTJG_p9J8jFbVLOR6hPhsxsaMTttQjp=Wzw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-787096374-1529674956=:2402"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-787096374-1529674956=:2402
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 22 Jun 2018, Geert Uytterhoeven wrote:
> On Fri, Jun 22, 2018 at 2:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 22 Jun 2018, Geert Uytterhoeven wrote:
> > > For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> > > of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> > > time period.
> > >
> > > However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
> > > 1200, as used on alpha and DECstation), jiffies_to_msecs() may return
> > > zero for small non-zero time periods.  This may break code that relies
> > > on receiving back a non-zero value.
> > >
> > > jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
> > > not support values of HZ larger than 12287, thus rejecting any
> > > problematic huge values of HZ.
> >
> > Sorry, I'm not understanding that sentence at all.
> 
> Sorry for being unclear.
> 
> 1 jiffy can only be less than 1µs if HZ > 1000000.
> But include/linux/jiffies.h checks if HZ >= 12288, and does #error otherwise.
> In addition, there's a "BUILD_BUG_ON(HZ > USEC_PER_SEC)" in time.c

Hmm, ok. Care to reword?

> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > This lacks a stable tag, right?
> 
> Up to the maintainer to add, isn't it?

Yes and no. At least a hint that this has been broken by commit X or has
been broken forever would be appreciated.

Thanks,

	tglx
--8323329-787096374-1529674956=:2402--
