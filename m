Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9D9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F1721780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F1721780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbeKOBCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:02:25 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42721 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeKOBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:02:24 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so9652277vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 06:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCGzNDuQH9vSRu+Fiidmh2F4/OGW5BLx2MAn5DAD5Pg=;
        b=uIqIQC7JdenyRsg/V+dgSpz0xnv9pk1NMr9hqBcQWpUiQ5Pia1dd+bSWBQjyEzQGpG
         YU56mlFLlxVhu/R/tQ5U1oUamq0Na++9aMObbAl/93d1B7TZbmadELXtLzjN+ZYCDvg6
         BfyT07L+fPWoY8gA0hb/1zWNz5EMYL5teczbenK0FMmGN7rAAQHP9BSelG1mkafMX7yc
         AOQRvGjvI99mOVWW+HpYMLsIVWF0rpiUoeHyren2227IRsYOTyGgIsFsBbF/wFvu0aOD
         FtvZzUHzMd9xHoq+4CiCx7xxtUKL44VaEnci4E32PlE8N5GDVpXXaAymAz8pGSG2VjAo
         sHtQ==
X-Gm-Message-State: AGRZ1gLTczn3Tl31+KAesVNsrkBl3UlmHPFmPYNRpeooENEm1QtvWOZC
        H6wj7vqmaibP/irtUjrmmu0ZBPFYvHA+X+4Ig5c=
X-Google-Smtp-Source: AJdET5fQ+qIVJHQ/eWlZVgJU/3A3xdDBJ6H8Fv0wcxfP1lfxzAjradN0gbzWQlhXittm26jAgicQAcaVlxdLryvJH58=
X-Received: by 2002:a67:b404:: with SMTP id x4mr1012296vsl.152.1542207529222;
 Wed, 14 Nov 2018 06:58:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org> <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk> <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk> <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
 <20181114141632.GT30658@n2100.armlinux.org.uk>
In-Reply-To: <20181114141632.GT30658@n2100.armlinux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Nov 2018 15:58:36 +0100
Message-ID: <CAMuHMdWwknYYEYpU4ogVAbpWtrF9aG=4vrh505dM2Btp8KjKMg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
To:     Russell King <linux@armlinux.org.uk>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Wed, Nov 14, 2018 at 3:16 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Nov 14, 2018 at 02:17:09PM +1100, Finn Thain wrote:
> > So, even assuming that you're right about the limitations of single-timer
> > platforms in general, removal of arch_gettimeoffset wouldn't require the
> > removal of any platforms, AFAICT.
>
> I haven't proposed removing platforms.
>
> I'm just objecting to the idea of removing arch_gettimeoffset(),
> thereby causing a regression by changing the resolution of
> gettimeofday() without any sign of equivalent functionality.
>
> However, I now see (having searched mailing lists) what you are
> trying to do - you have _not_ copied me or the mailing lists I'm
> on with your cover message, so I'm *totally* lacking in the context
> of your patch series, particularly where you are converting m68k
> to use clocksources without needing the gettimeoffset() stuff.
>
> You have failed to explain that in this thread - probably assuming
> that I've read your cover message.  I haven't until now, because
> you never sent it to me or the linux-arm-kernel mailing list.
>
> I have found this thread _very_ frustrating, and frankly a waste of
> my time discussing the finer points because of this lack of context.
> Please ensure that if you're going to be sending a patch series,
> that the cover message at least finds its way to the intended
> audience of your patches, so that everyone has the context they
> need when looking at (eg) the single patch they may receive.
>
> Alternatively, if someone raises a problem with the patch, and you
> _know_ you haven't done that, then please consider informing them
> where they can get more context, eg, by providing a link to your
> archived cover message.  It would help avoid misunderstandings.

Sorry for the lack of context.
The real trigger was also not explained in the cover message, and was a
the threat to remove platforms not using modern timekeeping APIs, cfr.
 "Removing support for old hardware from the kernel"
(https://lwn.net/Articles/769468/).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
