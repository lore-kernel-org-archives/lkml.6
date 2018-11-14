Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41ABC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610A8214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610A8214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbeKNTAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:00:33 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40709 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:00:32 -0500
Received: by mail-ua1-f68.google.com with SMTP id n7so5410535uao.7;
        Wed, 14 Nov 2018 00:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPCS2t4sl0sI8nO5FQ/yfZ+3HpCcKGF5207JlRqXGIs=;
        b=YOji/eKShznxr/OF5wpbhgg7RZwHVQT2JYC55JFFzwO9pTCW2QbiX4Zi/XlbIoVCSt
         nxa9qnTBs51Ko4nzV7gqQ9BosWmGb9OoyU3L40ljoiMgCPG+DYINXuMT6trwnpB9YMMk
         eEDd3TTtHDXNwNV6VPIOjyflOSOF9ua970L5vOicGvO29bd6fmmoLCQG4fWkAEeqiswR
         riOMgUn26aXDPxLk6ExTWi5ZeI0Gj4W3MTEZa9wdOQ1gUCOIbN2/wC5pNCq+a4CwrAgh
         AL6rwpgkpXWnkTKlH0lPZRg2ybtuzxnq7lYhDZfsyXWgH/LbY9PAzabAJXL51YZ8R4+Z
         oubA==
X-Gm-Message-State: AGRZ1gIlSkSZF0m/bkaBOixZDrZ98h//ZhZ+Viu0guTFwOXXZMFQ9/hP
        TzVe2HRDfEVExu3WxLRGxLZL+L4GFjkK7s8RgNU=
X-Google-Smtp-Source: AJdET5dLxEycft5C4NPtfRTXwgBwt8D/OK+Wx4vJA+fK1/3RXwShSqWxt8WgjlZSY6CYSgM4c5sMaDDU6/05OO3PNME=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr445776uae.75.1542185892501;
 Wed, 14 Nov 2018 00:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20181113124744.7769-1-geert+renesas@glider.be> <1090034354.41357.1542177021922@webmail.strato.com>
In-Reply-To: <1090034354.41357.1542177021922@webmail.strato.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Nov 2018 09:58:00 +0100
Message-ID: <CAMuHMdV=1GL43ogU3PO6u8x6f2gX-vdgBVON2+t+1QUJtj=Tkg@mail.gmail.com>
Subject: Re: [PATCH] reset: Add reset_control_get_count()
To:     uli@fpond.eu
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 7:30 AM Ulrich Hecht <uli@fpond.eu> wrote:
> On November 13, 2018 at 1:47 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > Currently the reset core has internal support for counting the number of
> > resets for a device described in DT.  Generalize this to devices using
> > lookup resets, and export it for public use.
> >
> > This will be used by generic drivers that need to be sure a device is
> > controlled by a single, dedicated reset line (e.g. vfio-platform).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > See https://lore.kernel.org/lkml/1539003437.11512.20.camel@pengutronix.de/
> > for the rationale to ensure a single, dedicated reset line.
> >
> >  drivers/reset/core.c  | 41 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/reset.h |  7 +++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 654e20ff2d5da9d4..c32b755ec373c338 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c

> > +/**
> > + * of_reset_control_get_count - Count number of resets available with a device
>
> Should be "reset_control_get_count", without of_ prefix.

Oops, thanks for catching!

Philipp: Do you want a v2 or incremental, or can you fix it up yourself?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
