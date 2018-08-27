Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80734C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43570208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43570208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH0U3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:29:50 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45638 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeH0U3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:29:50 -0400
Received: by mail-ua1-f68.google.com with SMTP id q7-v6so8692525uam.12;
        Mon, 27 Aug 2018 09:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nbTYWDYtf43t4vD8dP0XbEnKPgpX8+DseIpKmET3hU=;
        b=ssEtq/Sz/tvcKxlFPlRM3ktDUd8ZjtUVL94O2TSVvYICHnIpTNo3J+WPJNcGqVwPuu
         RAdTb/CnbRDVqewvfJhjCL8Z7KZDSJBRzDSrn9o0e/MQ88xHI+zyK63eNKM+Ta2qdzBw
         usnICFh36furgzfXgCbQ8ur1pgP/4A8c2kqLv94jpqqEw/V5bZ63P/5eAQkZ+VxhOy+r
         z/Vc7ebMk5qTv29hrbEbfdc8YQPdyzRoJH68+OHeA1+VbGPyUUBtdnht4QVODb5Y10qp
         B9CbtTlwTJjLSxt1YyyiaSFKlbjC1LeqrRW9QHxo6R4ov4dBPBzXj4ZwxP1C9RLuiyn7
         go7w==
X-Gm-Message-State: APzg51DSN9IjD8395QOqPH7T/Tsx1Jcvj7mnV0lRF4xzsxmmyQNG2Yqr
        C2+Yo8EOh3OhOXfoUT4ZpYUQUXMPZGQMNX1pUFA=
X-Google-Smtp-Source: ANB0VdZnvWB6kUrcd1rRIk9o+aj9cwMnWUTYfRkIBKmXqhMrTYxQB/btH0WfreGnwGX5YIMIuHL+QZyqtYJ1RJIJUf4=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr3210559uam.153.1535388149124;
 Mon, 27 Aug 2018 09:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
 <48bcbeb8e5f57c958e6e0bc7a29feae44821901d.1535385970.git.christophe.leroy@c-s.fr>
In-Reply-To: <48bcbeb8e5f57c958e6e0bc7a29feae44821901d.1535385970.git.christophe.leroy@c-s.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Aug 2018 18:42:16 +0200
Message-ID: <CAMuHMdVFUH_6dW0zFP4tuLHjaXWQFr7TXKGuaLz0q57gX9Tpmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drivers/block/z2ram: use ioremap_wt() instead of __ioremap(_PAGE_WRITETHRU)
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 6:10 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> _PAGE_WRITETHRU is a target specific flag. Prefer generic functions.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

From a Zorro bus point of view:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/block/z2ram.c
> +++ b/drivers/block/z2ram.c
> @@ -190,8 +190,7 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
>                         vfree(vmalloc (size));
>                 }
>
> -               vaddr = (unsigned long) __ioremap (paddr, size,
> -                                                  _PAGE_WRITETHRU);
> +               vaddr = (unsigned long)ioremap_wt(paddr, size);
>
>  #else
>                 vaddr = (unsigned long)z_remap_nocache_nonser(paddr, size);

However, since the removal of APUS support, this file can no longer be
compiled on powerpc.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
