Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DCC20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DCC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbeIFTHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:07:22 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34567 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbeIFTHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:07:22 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so12523197qth.1;
        Thu, 06 Sep 2018 07:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dTnNXbG7AJ3uOEcFPlRh3sJWKocXIpEXNe+XKnoXLs=;
        b=dUDoB1TKr/o3a4AG//35ZYAfIbDtAgGAxsaHfB8qLUxUrAzXMYP7WOuOpv6RTUiqjP
         O36r7oZtrb/vWXNGatBoERo78QFbpzQhdZVOkS5CjqMTlQ237tQHHWcvbKtnz9g3x/Pz
         2QW5ok2/ECGIPxYXwJRUVr7/QAtxKmBthqgKfoKa/subTgtFUZLG/UZ/FZfLw3g6chIf
         5gbSYj10GANSTIQS/HEJdU0i5dapiCPbZSvAfrnxBN9ie6Tzl0JfsJmNzUb9oarUMZBw
         FuceygILQ24oZ1ZbFoGjHpE/fouUaKMS68gTsFoQQZYFtw39BskOheEtVbx9qbh29zBy
         E/tw==
X-Gm-Message-State: APzg51DC9Y3Nkq6NsaVsrhgd+gHw5pWwcNx/5d3AAsATCCUGIexug3dD
        jLkFJOBR4CNyuIWLtx0EIvXcoeh1EvrZ4DIR4f4=
X-Google-Smtp-Source: ANB0VdY8j/AuofxpDy2wzUMKVc4/XVNUAgnelbrw/nkbzsLRiJdYFKJvYzhU6vg3SDoLQzBfY1njwl8c6lLmb7fjQcA=
X-Received: by 2002:aed:2b47:: with SMTP id p65-v6mr2331145qtd.132.1536244292864;
 Thu, 06 Sep 2018 07:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 16:31:16 +0200
Message-ID: <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
Subject: Re: [PATCH V3 06/26] csky: Cache and TLB routines
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:

> diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> new file mode 100644
> index 0000000..fcb2142
> --- /dev/null
> +++ b/arch/csky/include/asm/io.h
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef __ASM_CSKY_IO_H
> +#define __ASM_CSKY_IO_H
> +
> +#include <abi/pgtable-bits.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +
> +extern void __iomem *ioremap(phys_addr_t offset, size_t size);
> +
> +extern void iounmap(void *addr);
> +
> +extern int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
> +               size_t size, unsigned long flags);
> +
> +#define ioremap_nocache(phy, sz)       ioremap(phy, sz)
> +#define ioremap_wc ioremap_nocache
> +#define ioremap_wt ioremap_nocache
> +
> +#include <asm-generic/io.h>

It is very unusual for an architecture to not need special handling in asm/io.h,
to do the proper barriers etc.

Can you describe how C-Sky hardware implements MMIO?

In particular:

- Is a read from uncached memory always serialized with DMA, and with
  other CPUs doing MMIO access to a different address?

- How does endianess work? Are there any buses that flip bytes around
  when running big-endian, or do you always do that in software?

        Arnd
