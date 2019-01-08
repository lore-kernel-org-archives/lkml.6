Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5677BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFAB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfAHNgp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:36:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43234 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfAHNgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:36:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so4302136qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FaVmZuPTIiCx0d5JawfXMRfcuSclpexWl6Fgc+Ya/Jc=;
        b=dOoEUldoMYD2vSIp/gvollaYlYGpOpUUPrAZMdn2S5Wn1pQUcYKzssDcLauX8Da+Ea
         reLSL6ZmY1jNOeHNeOfu/6Cxepp5kmoSHt+9M4PJZz16y79eOuWCvKNGC8CrTUUvNK7J
         OTb0JHTGvCperTSfE4ihO3dXcuXXD5okt4Ag6IW9Fdyv7sDPPIb+XPlXx0VreXTCKf7L
         uGpIcLAB2i99bsFz+JCGKhHwmtLtINY7CkP5ruAoOcbwyYtxYNFO6BneysMeHcB3LPJU
         RVPmGCl650DHxLbAXbLn3o94Sc+4qnh20VBdUf7sBiFkK9eH1fVL3Alqxbtf2W2E4nJU
         Jm4w==
X-Gm-Message-State: AJcUukfH6/agoq2yjAX1KVyedHT3zv4b4mAwDPcHZgtW8PBOjOaOafd+
        fhEwER/HI6+WIgrlMh8Sk3GuEs1XYoQKglXz7a0=
X-Google-Smtp-Source: ALg8bN4BIMmKcQreQviw41YLiPDOqC9u6yVCAX7XuY2eOoj0E0Y+jK8MdUBbuOVjZptss05N4keDLvkW1IsgqV3dhtE=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr1640817qvm.149.1546954603760;
 Tue, 08 Jan 2019 05:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20190107092935.14617-1-geert@linux-m68k.org>
In-Reply-To: <20190107092935.14617-1-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Jan 2019 14:36:27 +0100
Message-ID: <CAK8P3a2aFOXdmheM3BMx=rB6AT-3yEXcxfCxt_9o5dWqu_qLYA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Avoid VLA use in mangle_kernel_stack()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> With gcc 7.3.0:
>
>     arch/m68k/kernel/signal.c: In function ‘mangle_kernel_stack’:
>     arch/m68k/kernel/signal.c:654:3: warning: ISO C90 forbids variable length array ‘buf’ [-Wvla]
>        unsigned long buf[fsize / 2]; /* yes, twice as much */
>        ^~~~~~~~
>
> Replace the variable size by the upper limit, which is 168 bytes.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I also have a couple of build warning fixes for m68k that I might
post in the next few days, for stuff that I ran into while testing my
y2038 series.

      Arnd
