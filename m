Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9742C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795EB214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfAUJoL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:44:11 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33918 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfAUJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:44:10 -0500
Received: by mail-vs1-f65.google.com with SMTP id y27so12270463vsi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aITi7eGI53kb4sIbuuJd6zMhxxeb+deFOUtQSk8Ckkg=;
        b=NXRGhAz9O5OXnSKbhGqbjAv1Wq2RfvEHuqqEHiU6TNTn2JQ5nD4HkwWGz7ZUDWXXSf
         K67U/pawB4k7L/Bt8eMpMbXC5wuBwKmRM8wZMt3gaHqwZ84QnfSQ1lx03Fcor3C1MX2g
         sgiLkTxXHeoAM8LFbEPkOQRgA8RGjZUQGbuMNk+9F+S4ZxvMq2IDA+E6wqDIj/oftYeP
         hfHOGAtwF3OE32/dLK0jw5BzfTm4M9SiCtaNhpnJ+6UDAPGhtbVBCSpVLYWdgSLN/6Xu
         53UxLRlmKt9lxhYzomWNZorYJ31fg7m6ex86PpCrq2cFtHVkTYqRPRcTfqoHYxqQqHqO
         QB+g==
X-Gm-Message-State: AJcUukduartG/9YH0C12fNHNxKAkG3Rs6A2ugfnzVaHPvi37qly5RBCs
        oDl+ZhxiEK95YOX/2uOFW5u22Zm6ImhMzLm4hExquc0o
X-Google-Smtp-Source: ALg8bN55WSw39k/ILo5igBRbKtOi+AxW5Wpi3V9s1l87ROmXS1C8t0rOYB9Q90TAAXDrvPrOC+HKOK7t7AQYOsDGXsA=
X-Received: by 2002:a67:f43:: with SMTP id 64mr12022291vsp.166.1548063849447;
 Mon, 21 Jan 2019 01:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20190121092422.18544-1-geert@linux-m68k.org>
In-Reply-To: <20190121092422.18544-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:43:57 +0100
Message-ID: <CAMuHMdXJcOQ2NMoHbAvqfP5YbSRA1Xt_MWpnyKe18t-ZAyVY1Q@mail.gmail.com>
Subject: Re: [PATCH v2] dio: Fix buffer overflow in case of unknown board
To:     Kars de Jong <jongk@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:24 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> With gcc 8.2.0:
>
>     drivers/dio/dio.c: In function ‘dio_init’:
>     drivers/dio/dio.c:240:17: warning: ‘strcpy’ writing 69 or more bytes into a region of size 64 overflows the destination [-Wstringop-overflow=]
>                      strcpy(dev->name,dio_getname(dev->id));
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Indeed, if an unknown board is present, the target buffer will overflow.
> Shorten the unknown board name string to fix this, and declare it as an
> array while at it.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
