Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5782FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9F12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9F12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937313AbeFSGxq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:53:46 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38882 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755524AbeFSGxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:53:44 -0400
Received: by mail-vk0-f68.google.com with SMTP id b77-v6so11035820vkb.5;
        Mon, 18 Jun 2018 23:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V7r+pATa6Ig+qglvQVuu7ww7fKlKlT46vyKn2Rqg4YI=;
        b=PNeNDz2uH7vWh+cnB0aABfAtWEbTeciowhLiJGps7e3oVJ+oq9POf2H8PUJuPvQAW0
         aVkjcLJ24z6REGyQdZiLLr0oXxAqR88QqopEiNBxfL36H/DzArQSgucZmVlnUVkx0Zvy
         GkaEfvpXWzcg9CN67MTNCaaDXnHBvnpYB9Mt4q2NbzHl3JrS0V722STGbiRqvXTQxkUA
         4lfX1KZy80O25F7Vi3v+3dxNqZyPjGrP7dQ7WAxNtMs8G66KgJ2WL8uXdnjBkhPkm6O4
         EqZMx/bTjPIyLJU4tZUDZnslNX/uitatBWOvT65nV0Hyv86JJVplLm4bOu4SAee104oh
         H4YA==
X-Gm-Message-State: APt69E0DOQfHVnFotsfzscqJIm94Vb49p6xkL8eCdgid8qI4uaVSrEEE
        0ayBY1K4BYfUNk58b5QdTe+Mgm+ajFkJcQ5gWgO6SsiY
X-Google-Smtp-Source: ADUXVKKtHf4PnvVc2dcxxf9pLOHDv4mruk7w/SptKvgnl+lnuFOISzMsm9xoJnRHSC/zAB6LvBeUjjiOXsv/ZCuoKgg=
X-Received: by 2002:a1f:8307:: with SMTP id f7-v6mr8825902vkd.3.1529391223583;
 Mon, 18 Jun 2018 23:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180619004659.19864-1-gerg@linux-m68k.org>
In-Reply-To: <20180619004659.19864-1-gerg@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jun 2018 08:53:32 +0200
Message-ID: <CAMuHMdWtKzHbzDKkV-AtCd+hgHy0jNx=beQLDHL+vQfHQOxf8Q@mail.gmail.com>
Subject: Re: [PATCHv2] m68k: fix "bad page state" oops on ColdFire boot
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 2:47 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
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
> Note that I had to change the type of pte_free() to be static from
> extern. Otherwise you get a lot of warnings like this:
>
> ./arch/m68k/include/asm/mcf_pgalloc.h:80:2: warning: ‘pgtable_page_dtor’ is static but used in inline function ‘pte_free’ which is not static
>   pgtable_page_dtor(page);
>   ^
>
> And making it static is consistent with our use of this in the other
> m68k pgalloc definitions of pte_free().
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> CC: Matthew Wilcox <mawilcox@microsoft.com>

CC: Matthew Wilcox <willy@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
