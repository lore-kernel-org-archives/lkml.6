Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DF9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8CC20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8CC20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeKSSbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:31:11 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34749 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeKSSbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:31:11 -0500
Received: by mail-ua1-f66.google.com with SMTP id z23so10155305uam.1;
        Mon, 19 Nov 2018 00:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTFpqlygnerUkcZsNrxxAvnXTP4akxiC87ZbUMZlnF0=;
        b=Xf8tKJI0+hizQ/AP91hGa8c8Y/zqXOZZd/w59zeL9/B6ZXICUhseHqisbIhVYpGwVF
         bpLi67uJ7guK57///yh6TPth2spgBAmYiO6PF82JZ1xISalRyZU/YnE7qAU9FiAMot9U
         4zDIvtadTqMXUxR6m7nKetd3gPA6J3QvlWURGGVnfr0DbVNkyaqJ43qdzScAn5k7LcLi
         PLfZ0U5o/yC8e/rPLD8bdhKK1BdIIwMBZOpsbzMo5YX1ZI5cXwdIXYD1bGmWPtzX9HHL
         MKeYqUpxwKt2AmIt2NvQtYnUsG+1uSdclxzcBL3+6d1unYUh8D0glIqp80tlXmp8qkY5
         k2UA==
X-Gm-Message-State: AGRZ1gJLq+QEPqC4og172wQp1PwIRrWrgqiZIaFen+0oU+x+SyPrHPmH
        5kNacge2PpB0XB7SpHnF24m89rUWpHDRkbN5eDw=
X-Google-Smtp-Source: AJdET5cACg44XwH/Nci0Pb4EdczJDrRpVtrjSbOFeY1+fHQn4eWhzVhwkUKjv8Hv3oUQ9OwwN66+crK8Y7Rto4jgwd0=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr8577414uad.78.1542614898451;
 Mon, 19 Nov 2018 00:08:18 -0800 (PST)
MIME-Version: 1.0
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org> <0b9aaa2f-9eda-82f1-8d52-b537a8c0c190@landley.net>
In-Reply-To: <0b9aaa2f-9eda-82f1-8d52-b537a8c0c190@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Nov 2018 09:08:06 +0100
Message-ID: <CAMuHMdUKPo6Lu0CtWERYkQTKSATqq0QVit-Awcn1O2EsS22iKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
To:     Rob Landley <rob@landley.net>
Cc:     firoz.khan@linaro.org, Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 6:26 AM Rob Landley <rob@landley.net> wrote:
> On 11/13/18 10:32 PM, Firoz Khan wrote:
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>
> I applied the patch in https://github.com/landley/mkroot and the result booted
> under qemu-system-sh4, seems to work fine. Network's fine, it can read a block
> device, etc.
>
> Acked-and-or-tested-by: Rob Landley <rob@landley.net>
>
> I assume that this is just git du jour and not your patch:
>
> WARNING: CPU: 0 PID: 1 at mm/slub.c:2448 ___slab_alloc.constprop.34+0x196/0x288

https://patchwork.kernel.org/patch/10549883/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
