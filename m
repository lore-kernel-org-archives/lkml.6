Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206ACECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0BA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0BA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbeGWJI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:08:27 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46455 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbeGWJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:08:26 -0400
Received: by mail-ua0-f194.google.com with SMTP id r18-v6so11165137ual.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eVTHwSwf2iB/jdxcRfnMo5JL1a1xNj/slednBEX+j4=;
        b=fsErztucbtd7ONyBy/cT4sp2VZfblz+dD829fabLDPmEX2HXJ5qMGE4zigI7ByyAaD
         am/3GTK7PVYPzgDdbECz7kKdopmDbHDiT838GuaU0EYTdZcv75/+cB9uh1qmOdA+nYGJ
         7PAaGVJ6qDXdDxRx4OXJh1XQNaM26MxjWfHQX6+nrajAUkft5asXrRSHnav7H1JfNi3o
         YjwX7JJCguhtDCdQjd9qj4HQbDZGyVjwx51dnQaUujuOh77PLd9f2gWsw2m/bn/aL35g
         6JcCUWU/1jr5kmMdFyHG1op0DkV+if6mas7oyEbygeNSagz1B53XH0BhQ6adO4CS/2Se
         yDig==
X-Gm-Message-State: AOUpUlHEQJLWzKsSoitn7ta1amDJ10AWZih6KO8o4FdyQ3c9FEyTlYGA
        0fkRM3twV9mNIcQrmGnl9VkGyh7LYOHXjx9Glv74aA==
X-Google-Smtp-Source: AAOMgpcyRIEeC3u3PsHNXUWiyKXFou0drrYo4Gn8oGQobqYY5thqItBKQ3oP5gX84+hFI1f893iZBObUcyLt9zNXWrE=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr8011066uad.12.1532333307477;
 Mon, 23 Jul 2018 01:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
 <alpine.LNX.2.21.1807182201560.41@nippy.intranet> <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
 <alpine.LNX.2.21.1807182333150.41@nippy.intranet> <alpine.LNX.2.21.1807222145330.56@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1807222145330.56@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jul 2018 10:08:15 +0200
Message-ID: <CAMuHMdX-q1jGqpi84=AVuP=14t5S8qs-+NxJmLZ814nZL12M+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sun, Jul 22, 2018 at 1:56 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 18 Jul 2018, I wrote:
> > On Wed, 18 Jul 2018, Arnd Bergmann wrote:
> > > I'd suggest we do it like below to make it consistent with the rest
> > > again, using the 1904..2040 range of dates and no warning for invalid
> > > dates.
> > >
> > > If you agree, I'll send that as a proper patch.
> >
> > Geert may instead wish to fixup or revert the patch he has committed
> > already...
>
> Geert, how do you want to handle this?
>
> Do you want a fixup patch or a v3 patch with the WARN_ON and the other two
> issues addressed?

Please send a fixup patch, for the m68k/master branch, which is non-rebasing.
I'll fold it into the original commit on the m68k/for-next branch.

> I'm willing to send either one if Arnd is okay with that. I'd really like
> to resolve this before the merge window opens, since my PMU patch series
> is affected.

+1. If it's not resolved (a few days) before the merge window opens, I may have
to revert the patch instead.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
