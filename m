Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215F72081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215F72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeLDQRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:17:14 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36733 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeLDQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:17:11 -0500
Received: by mail-vk1-f195.google.com with SMTP id t132so3918220vkc.3;
        Tue, 04 Dec 2018 08:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmLCf6BL4i554eG9ZXhoe0C9CpZOtNdcIRhAY38KKaM=;
        b=KQBDRlyY5HoaNDvXURncwf3HBT4FRUGDJqddHvMYfHjUhO6k0QLIO8j24Z3och4wUf
         BSlSyT2r6V699KeiX84CdHCvLzK6G8lisktI7ue+zP5pfBpUNsgJZeMTs4ultMpsdBsL
         xuBq0Et5g2dcxa9SfG4iw2GEkDtjpYABE7j0l3Zo5DYOqtSoe2BSVygvPXTq37DQbOM+
         UhFfiD5A5QRotbsrrMiv8GdIjU7y4tSg2hwCj4+PxvgZN62O52Kq0Xs2vl3Egotr+y2W
         QZs5lk6hccThbxAV1Jhi8ImkCh5IX1R596XDOSNvcaATQv2Hrl1dRo4MS7Dz0/56uMS4
         6kzQ==
X-Gm-Message-State: AA+aEWZsqvbWZ41iVWUeYHEacChEHAKjdi5KTT+ST2qf1ONIf0qxdlfj
        HoLUvjMozpEW1YS0M/PUcEgvOnJlkSpJUr2ndwU=
X-Google-Smtp-Source: AFSGD/WSH3YyXuUZC935csxEIhTYqhWzzX0iw9YdA7nQliPBie3kG1/m1GloinLlWhkOLyOAyO391yh/nlN6oMegX2s=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr9229834vkh.65.1543940230538;
 Tue, 04 Dec 2018 08:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
 <20181129105956.25933-3-andriy.shevchenko@linux.intel.com>
 <20181204133028.xkdnc5bqtqlnb3zu@pathway.suse.cz> <20181204161242.GD10650@smile.fi.intel.com>
In-Reply-To: <20181204161242.GD10650@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Dec 2018 17:16:58 +0100
Message-ID: <CAMuHMdUXQX=Y6K5XZok38W75KSBM+5PNRMKMhavNG_JtbxoNAw@mail.gmail.com>
Subject: Re: [PATCH v5 02/21] lib/vsprintf: Print time and date in human
 readable format via %pt
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Dec 4, 2018 at 5:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Dec 04, 2018 at 02:30:28PM +0100, Petr Mladek wrote:
> > On Thu 2018-11-29 12:59:40, Andy Shevchenko wrote:
> > > There are users which print time and date represented by content of
> > > struct rtc_time in human readable format.
> > >
> > > Instead of open coding that each time introduce %ptR[dt][r] specifier.
>
> > > +static void __init
> > > +struct_rtc_time(void)
> > > +{
> > > +}
> >
> > Just by chance, do you have any plans to add the test code? ;-)
> >
> > I understand that you did now want to spend time on it before
> > the real change was accepted.
>
> You see, there were several iterations with no consensus on everything:
> specifier format changed 3 times, for example.
>
> But it might be good idea to eventually add couple simple tests at some point.
>
> Is it a show stopper?

Can the user trigger formatting, and exploit a bug in the formatting code?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
