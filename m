Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCA6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026F92086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlMoGDpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeLPAPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 19:15:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35866 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLPAPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 19:15:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so7989529ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 16:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaJUjhireTSJd5qGmM0k3oHxv5G0DZYtKI5l31H90S8=;
        b=RlMoGDpLPLuaQLGUbXO5gYsA099s4rrT/kxukisvcP74dk46IahU5Ru7EjijesgHQV
         t1LJIbPaArZO8rC18No7QG30REq6p+oSVTI7BpYLAF579+8n/3Y1BEOUdEKiWmilta2i
         6dhEIUUSVB84c/8+eWA7IzZ1ZOEGECpFxmEWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaJUjhireTSJd5qGmM0k3oHxv5G0DZYtKI5l31H90S8=;
        b=KUhaCAQBZvoMXmaEWjieu/IJeaZlVLJ6bVf9vIMixeFHLwiN8bq65LUe62urAmPk1m
         wtEOLC8xYwzzlHdpnMA3Q3HXq49yIOFUTFmWbBJTsVBGFLwTIzgw6Q3Xzg3d29/Kxb7L
         VUC3e4FAYPqeu61T10Yu1hDhdUUkmtjHvu9ANhdVvuYWAZeBzzIDIpQK70ylH+BJBwx4
         tvtnINSc+JtWuYO8vaPA0HKl3jk+wfkqZuORziYW5Z+DOLmZx3D3kSuiLNBn62w7/oWS
         8wq7H+xIzhKi9R5l9foTrVTzGTwmHaQ5i3q/I8++WY/X/teoMmY8bSPjLpb0LVTF1BsQ
         w7Mw==
X-Gm-Message-State: AA+aEWZvpXUM6a9vePk7RKkQrNBrsUBVGLS5qZl3bUId8xBu+trI045q
        rNtrNHmDvZc+Zw1iix2cZTrOSZJRGXh2THkj7m2/zg==
X-Google-Smtp-Source: AFSGD/VIgWUvSIZF81NTOi6KJxvqipGZFyBjiMrFPbOHcQ1n20gaGNpZp3a0ZsXyX4ZJi+ovPB5vbPT6LnrB1+nbefU=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr4629589ljj.9.1544919306999;
 Sat, 15 Dec 2018 16:15:06 -0800 (PST)
MIME-Version: 1.0
References: <3f9179c9a1c8e2486cdd15d28530cd2e381a8830.1544152023.git.christophe.leroy@c-s.fr>
In-Reply-To: <3f9179c9a1c8e2486cdd15d28530cd2e381a8830.1544152023.git.christophe.leroy@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Dec 2018 01:14:55 +0100
Message-ID: <CACRpkdahnp42c1vT6JHLDVWerCqUH9ugSE4i9Xiu+y49xHE76g@mail.gmail.com>
Subject: Re: [PATCH] gpio: max7301: fix driver for use with CONFIG_VMAP_STACK
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 2:07 PM Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> spi_read() and spi_write() require DMA-safe memory. When
> CONFIG_VMAP_STACK is selected, those functions cannot be used
> with buffers on stack.
>
> This patch replaces calls to spi_read() and spi_write() by
> spi_write_then_read() which doesn't require DMA-safe buffers.
>
> Fixes: 0c36ec314735 ("gpio: gpio driver for max7301 SPI GPIO expander")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch applied for fixes.

Yours,
Linus Walleij
