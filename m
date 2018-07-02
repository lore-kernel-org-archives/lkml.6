Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B825C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10444253BA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10444253BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeGBM7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:59:13 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46600 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeGBM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:59:11 -0400
Received: by mail-ua0-f195.google.com with SMTP id r18-v6so9973035ual.13;
        Mon, 02 Jul 2018 05:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcSfcO5uVMR4CK4iBm716k8Rw1TfsDT23f4ealeYtS4=;
        b=TiPnFgUJ8wjWwzfIEnkwIHpzvI1pwjXO9e910Y/vm+Q4TaOgTg8qiYDFmy+5/nPFJX
         bApOc8RB2bY5BefzM7tVQzSd2Ii9FcNvGw2vnNt/4Z6eKYmNiy7ptjKkcmo3KzJyEA6M
         YCPQ8oHWo+iF1VuO8uGaImKL9IdX8XW0eLtJm5DDBBGPeyZ9gXrfEpglTjq8Zzr3KBof
         E9TC/0L2Dm2jh5RPZ9+zhS7wAqk8oRcMj+63eZy3NlT96Z777Qk6/370tfdZ8BEnemru
         Ruej80E4dm8QZQ/07qhmfQqgargpXvaOL17l8BP9vUE+MTnE7RfHzzUMXdqZFmX6MtCm
         +1eQ==
X-Gm-Message-State: APt69E37McdLphMVQIs1vOYkBouPUUioETx2TB8r2tp93yIsfJM3xf/7
        CV8OYM67aem3LlmmcVg786fvRFArGh8Jac7lxLM=
X-Google-Smtp-Source: AAOMgpe6sDSUAZCjP8DiEXOqrB7xDpcdVjGu0oyFopx7hWsgIsa4/vwiZPY1srxcUjQImBLjm+L4SH0XwieV7Wq0JRk=
X-Received: by 2002:ab0:1b6c:: with SMTP id n44-v6mr10151128uai.4.1530536350669;
 Mon, 02 Jul 2018 05:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <1530428560-4440-1-git-send-email-gilad@benyossef.com> <1530428560-4440-7-git-send-email-gilad@benyossef.com>
In-Reply-To: <1530428560-4440-7-git-send-email-gilad@benyossef.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jul 2018 14:58:59 +0200
Message-ID: <CAMuHMdW7Sock8Z=L7w58u9-q-gWvkz=VfK-QZDUXPgEw4+NBzA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] crypto: ccree: rate limit debug print
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, hadar.gat@arm.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilad,

On Sun, Jul 1, 2018 at 9:05 AM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> A debug print about register status post interrupt can happen
> quite often. Rate limit it to avoid cluttering the log.
>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks for your patch!

> --- a/drivers/crypto/ccree/cc_driver.c
> +++ b/drivers/crypto/ccree/cc_driver.c
> @@ -131,8 +131,8 @@ static irqreturn_t cc_isr(int irq, void *dev_id)
>         }
>
>         if (irr) {
> -               dev_dbg(dev, "IRR includes unknown cause bits (0x%08X)\n",
> -                       irr);
> +               dev_dbg_ratelimited(dev, "IRR includes unknown cause bits (0x%08X)\n",
> +                                   irr);
>                 /* Just warning */
>         }

    cc_isr: 932 callbacks suppressed

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Note that it still printed 1410 lines like:

    ccree e6601000.crypto: Got IRR=0x008000D8 (actual value may differ)

but perhaps you do intend to see these during debugging?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
