Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F6AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027382087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027382087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJIVci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:32:38 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37762 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIVci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:32:38 -0400
Received: by mail-vk1-f196.google.com with SMTP id y128-v6so411539vky.4;
        Tue, 09 Oct 2018 07:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jNT7Ew4uBEDhnvJVNp0jMq6UrZlPALqiTLZpiTCrew=;
        b=QBMxCFA0PvPq0iLEShKlpVzfXI09/0/5Q5U1RiyrLbEWMwunaDchovipjY4NPKMBV2
         VGQA0vAWiGfS3LX8uCCMV069E92SjwalsCFBgZfh64L5HdFoXB7mWI3pXS2k81X9oMm9
         lPgWLFEmfzKcBPZOb8DIiqphdbiBpiehnvxZN0YNUQB2qqYHsM5OK95VXZZRiGIl56UJ
         z9VP+wQ81C+aK/e4OMPo8SvpIweRb+ee57IyEDs1YQUp/3mUJWHX+TkSFFcfXSclJ0Il
         0H1O2ItjJLNHePqDsCdqCzzorfNGUQnJtGUEBo0sZYeS9IGI4LM0QEGfbiO5IoKFkdRj
         pPmg==
X-Gm-Message-State: ABuFfogeczi74KXzOdvXAQrgkhpV5KmlO0ZEuGASBzPAkav9E/q9zY8m
        7gv4lMWSrY3Y5qrcQvIhW27L8Vt7YRLHegPsHMc=
X-Google-Smtp-Source: ACcGV61mVamNthuylEhCGw238uSxaQrljizUN2swf55DB79xABdExiq+IvTLg3KqpAMxQCMvnZSzK2MKW02ABG6v0bU=
X-Received: by 2002:a1f:cd3:: with SMTP id 202-v6mr11052570vkm.74.1539094527656;
 Tue, 09 Oct 2018 07:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181008110504.25449-1-geert+renesas@glider.be>
 <20181008110504.25449-2-geert+renesas@glider.be> <20181008142544.GB15943@smile.fi.intel.com>
 <CAMuHMdXFjDXWVxmkpc5AWebeOasDvj5RrhKOd3gkTqAeK5Y5pg@mail.gmail.com> <20181009135652.kdy2izt2pbehndmx@pathway.suse.cz>
In-Reply-To: <20181009135652.kdy2izt2pbehndmx@pathway.suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Oct 2018 16:15:15 +0200
Message-ID: <CAMuHMdUs76b=rPTAzS8NYY-cjhKD2tzC5p2099Lw5duYBtrctg@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib/vsprintf: Prepare for more general use of ptr_to_id()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Tue, Oct 9, 2018 at 3:56 PM Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2018-10-08 16:37:29, Geert Uytterhoeven wrote:
> > On Mon, Oct 8, 2018 at 4:25 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Oct 08, 2018 at 01:05:02PM +0200, Geert Uytterhoeven wrote:
> > > >   - Make the ptr argument const, to avoid adding casts in future
> > > >     callers,
> > >
> > > >   - Add a forward declaration, to avoid moving large blocks of code.
> > >
> > > How big it would be? ptr_to_id() itself plus...
> >
> > ... all the randomization helpers.
> > And ptr_to_id() needs pointer_string(), string(), widen_string(), number(),
> > and move_right().
> >
> > 118 insertions(+), 120 deletions(-)
> >
> > Is that acceptable?
>
> Yes, it is acceptable. And my feeling is that it is the preferred
> solution is kernel because it helps to keep the code cleaner
> in the long term.
>
> I am for moving the code if there is no cyclic dependency.

OK, will do so for v2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
