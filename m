Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CA7C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2550E2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2550E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJHVto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:49:44 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36606 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeJHVto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:49:44 -0400
Received: by mail-vs1-f66.google.com with SMTP id c205so987371vsd.3;
        Mon, 08 Oct 2018 07:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHQP1sg+mKc31WSoW1KAByTxvE4261w2ENPDyjfRtjk=;
        b=DC1xA3GESJvxBu1YNYQ3KsWKk6dtk419N6U887ao8dbzidoQy/kfZiDvpC10omnp5h
         8qTOGzZLc7eyMIUZm57Tg04pAC6vxI7kikMzifS1eCSdkHSm9OtvEv7wQdEXAoUiKpAY
         7p83sRT4nNbMFpbcqRnoF79TseGNVlpMn3b8L6xlDiRzGTaDS79I1RzuvxHW3BAa5mVS
         KVE1Tz/tejvPR+XXI2MHdDasN8Ad3KkAGNQgEfiNhYDFjMqeFzo2rDfwx3eyb0ZVVz8t
         0m1eL4RT70pk3R+8pY/eCTnUO8Xfu1dMDF0LPLk+DMTlbsxlUuvKy3Sh1q4RhqCGLKs0
         JHwA==
X-Gm-Message-State: ABuFfogrzPrrjeNRxL1FTmcBXMYffSr36nFzbTlbtnJE0+c6+hf7NbGi
        pmhxsblj32t3gB8Vw7nvvNSkDCRXSL/nQeqUGw4=
X-Google-Smtp-Source: ACcGV63KSk6XmQgIFAtYd154OX41qHwPwtns/Ef9R6jUsHOUtFRQSyxYMSW/LVcqKi1zt2xk+Bn4484vBx4iOe1QFqQ=
X-Received: by 2002:a67:f3cc:: with SMTP id j12mr7197854vsn.96.1539009461390;
 Mon, 08 Oct 2018 07:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181008110504.25449-1-geert+renesas@glider.be>
 <20181008110504.25449-2-geert+renesas@glider.be> <20181008142544.GB15943@smile.fi.intel.com>
In-Reply-To: <20181008142544.GB15943@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 16:37:29 +0200
Message-ID: <CAMuHMdXFjDXWVxmkpc5AWebeOasDvj5RrhKOd3gkTqAeK5Y5pg@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib/vsprintf: Prepare for more general use of ptr_to_id()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Petr Mladek <pmladek@suse.com>,
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

Hi Andy,

On Mon, Oct 8, 2018 at 4:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Oct 08, 2018 at 01:05:02PM +0200, Geert Uytterhoeven wrote:
> >   - Make the ptr argument const, to avoid adding casts in future
> >     callers,
>
> >   - Add a forward declaration, to avoid moving large blocks of code.
>
> How big it would be? ptr_to_id() itself plus...

... all the randomization helpers.
And ptr_to_id() needs pointer_string(), string(), widen_string(), number(),
and move_right().

118 insertions(+), 120 deletions(-)

Is that acceptable?

> > +static char *ptr_to_id(char *buf, char *end, const void *ptr,
> > +                    struct printf_spec spec);
-
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
