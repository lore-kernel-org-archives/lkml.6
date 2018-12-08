Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4587BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B672082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B672082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLHKvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 05:51:52 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46004 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 05:51:52 -0500
Received: by mail-vs1-f68.google.com with SMTP id v10so3953230vsv.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 02:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uR92faYjOGDnSzfrq403TGJDpi1UyEgNqr1tWXpR7fg=;
        b=FNxhEnHQ140TyMSo5OEQcG2j6rXAytQ9uSZEHJC7xaVLLBs6APyAJ3QHjC3R5GWfDf
         YjqKcfxbeo03YRzQiA0eOHjGO2hrGojNlMrVMv3eTksramUbYt9K1NpzTlDVOZuTL7/s
         BfnoLPnxI81rprVMbvGEKU+zqCjSmAejUKa09Hu2m+YZMX2HdE8GHklEOnZ0bnD2eT0R
         xAJUvV4HEH4Q9hwE2sWl0Yc/XYsKmW80tOMowPe9ttiVNEiTua4rLP8K1QtkrX3GRm50
         4yiJmJIR3u3pLB8+qwkM29ADHkBIUTGasrJvKuXhqrTS/nANsUeZ2LhUghknOIv6dJS8
         bO7g==
X-Gm-Message-State: AA+aEWZgumyVM1Ra/DAfOeuSjUR/KrT7X1wj9GCQ8bC1yXiB7/Sski+s
        QG16QbGLsy/EvJv2ki6TE+DxsIwi4eE5wO4+EXk=
X-Google-Smtp-Source: AFSGD/W1EweHR1ZbB7MV8/kjf73+pF6iwUIiRDiaU44Uf8A0SsV/yPV/lxcZvn3kz54kywL0wtJmhD24GvDSygPRI/g=
X-Received: by 2002:a67:c202:: with SMTP id i2mr2152477vsj.11.1544266311089;
 Sat, 08 Dec 2018 02:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20181207165011.31497-1-geert@linux-m68k.org> <20181207210224.GA19067@rapoport-lnx>
In-Reply-To: <20181207210224.GA19067@rapoport-lnx>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 8 Dec 2018 11:51:38 +0100
Message-ID: <CAMuHMdVHDn5=3SBvmHSHsY5rCZKgRXRbk258RAKJp8V8__Hi8w@mail.gmail.com>
Subject: Re: [PATCH v3] m68k: Fix memblock-related crashes
To:     rppt@linux.ibm.com
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Sam Creasey <sammy@sammy.net>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, Dec 7, 2018 at 10:02 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> On Fri, Dec 07, 2018 at 05:50:11PM +0100, Geert Uytterhoeven wrote:
> > Sun-3 must be broken before this fix, as it fills in m68k_memory[0] in
> > config_sun3(), i.e. after m68k_parse_bootinfo().
> > Sun-3 is not fixed by this fix, as it uses its own paging_init(), not
> > the one in motorola.c.
> > Fixing Sun-3 requires adding memblock_add()/memblock_reserve() calls to
> > the Sun-3 memory management code.
>
> I think that adding memblock_add() to config_sun3 would be sufficient,
> something like the diff below. This will make memblock aware of the
> available physical memory and it seems there no allocations in sun3 before
> paging_init().
>
> diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
> index 542c440..9a5b9dd 100644
> --- a/arch/m68k/sun3/config.c
> +++ b/arch/m68k/sun3/config.c
> @@ -150,6 +150,7 @@ void __init config_sun3(void)
>
>         m68k_num_memory=1;
>          m68k_memory[0].size=*(romvec->pv_sun3mem);
> +       memblock_add(memory_start, memory_end - memory_start);
>
>         sun3_bootmem_alloc(memory_start, memory_end);
>  }

Thanks!

It doesn't need a memblock_reserve() for the kernel, as memory_start is
already adjusted for that, right?

Anyone who can test this is on Sun-3? Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
