Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADBDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0520850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF0520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGQP7m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:59:42 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36771 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbeGQP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:59:42 -0400
Received: by mail-ua0-f193.google.com with SMTP id y8-v6so937182uan.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X2r7/T/Nj5k4jvZh3uRsJCjgSv2Sm14noM0S+ydqvPg=;
        b=UXFvDVRHbDASqUMxN+BTaTzmEbv6DMGscCh+oMDTWc4BCszPblzyjL2/H91BKB3kF3
         u9KA/033FYJ0rDYePsw9BtBh906BPNnsFFQdsK9AzzqjV9hirRMPIDFLPPLK/7oMUcHf
         4xRCxDaBF9dSNJU/q0I90EVrI2PaI6t3rqgFLfg2rGkHePRibaZQT2a7IbGUK70zsDuR
         HWgq4vfTEkpNVoOA4NRKSSBdlKZAX92dE2apySfmSO1ClCLs8+RyCXQdBpsrdE0NPSCk
         pUDA3yGJJB9LUe6SHrcf+QrXL/D36pOqtdYy3wxJjuuo83e25Ocj+AVUukG6+I5sGt//
         GFUw==
X-Gm-Message-State: AOUpUlGyw/PBfTzCzsGWv1FDwPUO+fLGsYXDhZ8KqLAFhXmo/usGHpUj
        zzaqgIyv8T+qjnTuvLr+6DXRFhMDaz1lg8gv0Oo=
X-Google-Smtp-Source: AAOMgpdEBYYGzhv0r4RJI5XYQ9fF264k7517oo/gU16N6E5sli8UqmbzH4YsSHnALq/9SDv0kG2kjupIf8U1GbKYHT8=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr1439904uap.33.1531841192434;
 Tue, 17 Jul 2018 08:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch> <20180709083650.23549-9-daniel.vetter@ffwll.ch>
In-Reply-To: <20180709083650.23549-9-daniel.vetter@ffwll.ch>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Jul 2018 17:26:21 +0200
Message-ID: <CAMuHMdX3x_anEXtYyL4BnBoOqRew3MDFSAr6CrRaru0BLpcnZQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] nubus: use for_each_if
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jul 9, 2018 at 10:44 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Avoids the inverted check compared to the open-coded version.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: linux-m68k@lists.linux-m68k.org

Thanks for your patch!

> --- a/include/linux/nubus.h
> +++ b/include/linux/nubus.h
> @@ -127,7 +127,7 @@ struct nubus_rsrc *nubus_next_rsrc_or_null(struct nubus_rsrc *from);
>         for (f = nubus_first_rsrc_or_null(); f; f = nubus_next_rsrc_or_null(f))
>
>  #define for_each_board_func_rsrc(b, f) \
> -       for_each_func_rsrc(f) if (f->board != b) {} else
> +       for_each_func_rsrc(f) for_each_if (f->board == b)

drivers/net/ethernet/8390/mac8390.c: In function ‘mac8390_device_probe’:
drivers/net/ethernet/8390/mac8390.c:402: error: implicit declaration
of function ‘for_each_if’
drivers/net/ethernet/8390/mac8390.c:402: error: expected ‘;’ before ‘{’ token

Apparently this depends on patch [01/12], which wasn't CCed to
linux-m68k@lists.linux-m68k.org?

Please don't split CCs if all patches in the a series are not independent.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
