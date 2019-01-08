Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EEDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9BF206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfAHNrp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:47:45 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:47072 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfAHNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:47:44 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so2439068vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WBUZT9Z47xJ0v26hgKzNQ/uM79+cRBVZ6rsn7QRff8c=;
        b=cSUcq+nxLoRDd/bC7FnSO1QOAWn+5P/5ogTrPY1obaF25Ndb7FdF7Ej8LY95MK6l+M
         MZN9xfk7pLNdEn1HU8xmv2qxvJlmvEWTH6l0TSCl3LzFv7LDT7iUg0gQHA8LPtkTIP35
         RnZpAzUoWVrUAkcLVKHtBkeywQ6Vvp4DaaTZfdaJ+BpOg0AF7UK17Nwh2t0jnPFzrRqm
         ctlUfOgf68XEEBWHcWZvPnm5Gbvd4ivZwicIXRsvDzuMddjFh8jqWBYV64hiTFTArnsn
         JH+lQzhuBJkoLEjBUVbOgVRShzbioGW6zkgfF++JBHqS7EocE/19vr5FcRoKdi9EDBEc
         X8WQ==
X-Gm-Message-State: AJcUukeqsvcxbksluDlmeZU5cCVGBECrhICZM8NSvp2kMUa0MdB6H5GB
        3jNbmw4kJ2GpsKDQ7zBu2MDwMewv/6ckt0sXloQONPCoD0A=
X-Google-Smtp-Source: ALg8bN5nT6dkGO27ISiuCj8kq5AHkQlMOWDR6dCu300EmfZ3YeZq2ZFXyjxy4N8V2u2DBK9WgWzvTck/pXtgpzGXvMU=
X-Received: by 2002:a67:3885:: with SMTP id n5mr632584vsi.96.1546955263557;
 Tue, 08 Jan 2019 05:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20190107092952.14691-1-geert@linux-m68k.org> <CAK8P3a35ZwkrE-zxRVbwvNEs4RZTuV+-eu3uRD2OaSnVnBG3EQ@mail.gmail.com>
In-Reply-To: <CAK8P3a35ZwkrE-zxRVbwvNEs4RZTuV+-eu3uRD2OaSnVnBG3EQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jan 2019 14:47:31 +0100
Message-ID: <CAMuHMdWG_s3Oc4DH=70CAKRCGn-bLwO+Gq2UsBd1reeqWE7_Cg@mail.gmail.com>
Subject: Re: [PATCH] m68k/atari: Avoid VLA use in atari_switches_setup()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jan 8, 2019 at 2:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 7, 2019 at 10:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > With gcc 7.3.0:
> >
> >     arch/m68k/atari/config.c: In function ‘atari_switches_setup’:
> >     arch/m68k/atari/config.c:151:2: warning: ISO C90 forbids variable length array ‘switches’ [-Wvla]
> >       char switches[strlen(str) + 1];
> >       ^~~~
> >
> > Replace the variable size by the maximum kernel command line size (512
> > bytes), which is an upper limit for all suboptions.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Seems fine as long as COMMAND_LINE_SIZE never grows a lot. Some

If that ever happens, it will be caught by -Wframe-larger-than=1024.

> architectures use 1024 or 2048, but m68k currently has 256 (you write
> 512 here).

Thanks for noticing, will fix!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
