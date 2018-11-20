Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77ACC04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAA320851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAA320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeKTSpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:45:31 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35724 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeKTSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:45:31 -0500
Received: by mail-ua1-f65.google.com with SMTP id d2so350740ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcK6eBcd+OHabn/M+TbT7b9qeMTPFsAKfVdSDCMY5RE=;
        b=imBMsBKuTRObDgGzhr8RUwvVJxY0h740nJgKZg15rnUpC0caJKkuH+nzb22Luj6Jkn
         wJgoxiF9QLOrZf9sR7bFESpeO7MHHW6qnai9rzTlwWnbfztCNq9aS/bSte3bh1jHlc+X
         jHjWSNk6o8R1CBGAf9YFSanM7AjD7GhBdBu6acl5r1vQ5woUgu3i8gaCyK6OehMc+/bP
         113JCly4XIKr5bDLyZyv0MlOwginVi5jEC61igi3uG0KZdAtXdKyAMchQTBma+G1Zy6s
         m6Mi8z+f+hGeLZt96wwF8NkmnL5i7L8gtg65eMICVZNIvWPmIlQgmKpTBKy4AX493BTe
         Ie1w==
X-Gm-Message-State: AA+aEWbvDySCA0O5zinTvn08QY/CRJM6qdHzIzwniplE9buUCYeAu3ks
        rYTN8q7A4cA3IU0+wCA0e8ugk2gahbJI1YPulFjKuQ==
X-Google-Smtp-Source: AFSGD/W+xNl6RnmQbdlRTyWrb2PaED19jqSZkn7nebLmlPXVU69+vU0RB5lQ5AO38z5falY6dDNoOEuNYQMcbIMMPHc=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr484260uap.0.1542701858839;
 Tue, 20 Nov 2018 00:17:38 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181115050737eucas1p104ccec527d0713f9414bc75e0959feb6@eucas1p1.samsung.com>
 <1542258449-19930-1-git-send-email-huijin.park@samsung.com>
In-Reply-To: <1542258449-19930-1-git-send-email-huijin.park@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Nov 2018 09:17:26 +0100
Message-ID: <CAMuHMdWwj6t6Pw==HG+jHC8y6rooWROuQjxJZNUwcXjimai8Pg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: cast to u64 to avoid uint overflows
To:     huijin.park@samsung.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bbanghj.park@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huijin,

On Thu, Nov 15, 2018 at 6:08 AM Huijin Park <huijin.park@samsung.com> wrote:
> From: "huijin.park" <huijin.park@samsung.com>
>
> The "params->size" is defined as "u64".
> And "info->sector_size" and "info->n_sectors" are defined as
> unsigned int and u16.
> Thus, u64 data might have strange data(loss data) if the result
> overflows an unsigned int.
> This patch casts "info->sector_size" and "info->n_sectors" to an u64.
>
> Signed-off-by: huijin.park <huijin.park@samsung.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d9c368c..527f281 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
>         memset(params, 0, sizeof(*params));
>
>         /* Set SPI NOR sizes. */
> -       params->size = info->sector_size * info->n_sectors;
> +       params->size = (u64)info->sector_size * (u64)info->n_sectors;

Adding the cast to only the first operand should be sufficient, and may lead
to faster code, as only a 64x16 multiplication needs to be done, instead of
a 64x64.

>         params->page_size = info->page_size;
>
>         /* (Fast) Read settings. */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
