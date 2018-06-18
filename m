Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B53C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1031208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1031208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755043AbeFRG6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:58:25 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34286 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754884AbeFRG6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:58:24 -0400
Received: by mail-vk0-f65.google.com with SMTP id q135-v6so8894654vkh.1;
        Sun, 17 Jun 2018 23:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/smcjl1Ha+ltFrV+ReNIiGBGjjtIHxKfKyP50YiJGMU=;
        b=s+c+xJTyM4QnRFimICwaL+UKkOnAowlGa520onHnwDdAcVWMthJ04Hs2nK3FPgAdTw
         ojvLFdOL3Yah4ZxCnRzNp8JtHkmCF+yeuUNjGf4Hd055Yi+AF4ZVUR5a8JtAlGSBGUdT
         5lqW2D/FYTO8O268FeLfGCjKqQSl2Ew7vdpwxJ8uG+pr6q0axOoD9Aj1sGeCBKMRc1pY
         /te5PPjEfbpLBPZCqoGdSZ1OJO/1TGzyh29ecgCT5HNP00IbYwgAI/ds+mxJaoP/uh5K
         W+wtU9WjAT9F79WZCEKSon7eUOo2mvweRGc3keumyQPYJBCmC0PGagoKrG+Yqe3M8Ksj
         A7Sg==
X-Gm-Message-State: APt69E0Qqx3ANSgNKwHvcJigqnBTvyLWyjdJ7L5mm/ecCXUyjCKeStAr
        gCG4tR+AdntePTd+qA3IhAI6/tIgmC52xs7IlZc=
X-Google-Smtp-Source: ADUXVKLwYYxI3JYfi0+wUCtEBl6cR4dRIIa7TzJHr7dMQf+Fg4quCFEOVnHT3TUfdzmGeHBO0tD+LGZA74b/XcdwIqY=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr6255299vks.106.1529305103243;
 Sun, 17 Jun 2018 23:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180618060426.24497-1-gerg@linux-m68k.org>
In-Reply-To: <20180618060426.24497-1-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Jun 2018 08:58:11 +0200
Message-ID: <CAMuHMdXSaGtremvLCRzKm68s_dUEigL-VCmM-ar=T4PPJrECLw@mail.gmail.com>
Subject: Re: [PATCH] m68k: fix "bad page state" oops on ColdFire boot
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jun 18, 2018 at 8:06 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> Booting a ColdFire m68k core with MMU enabled causes a "bad page state"
> oops since commit 1d40a5ea01d5 ("mm: mark pages in use for page tables"):
>
>  BUG: Bad page state in process sh  pfn:01ce2
>  page:004fefc8 count:0 mapcount:-1024 mapping:00000000 index:0x0
>  flags: 0x0()
>  raw: 00000000 00000000 00000000 fffffbff 00000000 00000100 00000200 00000000
>  raw: 039c4000
>  page dumped because: nonzero mapcount
>  Modules linked in:
>  CPU: 0 PID: 22 Comm: sh Not tainted 4.17.0-07461-g1d40a5ea01d5 #13
>
> Fix by calling pgtable_page_dtor() in our __pte_free_tlb() code path,
> so that the PG_table flag is cleared before we free the pte page.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> CC: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h | 1 +
>  1 file changed, 1 insertion(+)
>
> Matthew: I came across this thread at https://lkml.org/lkml/2018/6/17/163
>          about a similar problem with openrisc. Based on that I came up
>          with this fix for m68k/ColdFire. Fixes the issue for me.
>
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index 8b707c249026..8c441eb57b80 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -44,6 +44,7 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
>                                   unsigned long address)
>  {
> +       pgtable_page_dtor(page);
>         __free_page(page);
>  }

Do you need a call to pgtable_page_dtor() in pte_free(), too?
On x86 (and motorola_pgalloc.h and sun3_pgalloc.h FWIW), both functions
call pgtable_page_dtor().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
