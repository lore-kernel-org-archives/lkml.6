Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A74AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6AC2197D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392273AbeLVQt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:49:27 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34853 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbeLVQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:49:26 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so5190493vsc.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1v3viShWJ3M/wR9piiPTCeDwjVeaDateQur33blriE=;
        b=ewRxVCaEJ7zd/22pX+nE8LYoyw0Do3APujgDscUywlPDHbnf573Nm+ehYE/2sPOhL3
         46H9TMriDHNjXieSgkIoEaJbWbUgOLm9nqoy72nD3RQBkZTvbMRobXBu2BFHyUwDFNwH
         uZ2sG6w3LCcU1kWj6a9MVvQaV8vJ54b2qLQRlYBEvnDbAIp/setgm0aZkblQ3+WxuWWn
         RxuM1pSrtU/lr5YYqqRSoFAkPcW+tK2INOrtOFXRdIFQQ4YkpxcD4cYjFhjtGGGS27Xw
         CHurAAAY3YU9k1PHxxoVCOB+qG6YhaY8VOQaQFwF6czyeLvXJ2o3DaaIfzBngEv+W1JM
         km1Q==
X-Gm-Message-State: AA+aEWb8wtpzaSxXT0i3c7DG25HemgQa7h5w3FsynZIPzBAHZNYBdf0J
        CLzNnDPlhonGjxWV4o205bGCkcln0W8mi5iV25jSvQbvEmo=
X-Google-Smtp-Source: AFSGD/VjKjBYki/ox7OZ/zU+18NE+GUWLnm20dC1LavEOM4HxvgcXqEhsbh0KA5jCTXJp1Py0NLb8S9HIK1ixArUKsw=
X-Received: by 2002:a67:f43:: with SMTP id 64mr2535553vsp.166.1545476665704;
 Sat, 22 Dec 2018 03:04:25 -0800 (PST)
MIME-Version: 1.0
References: <dc3abf702c1f54d536c94305c44de7182f5212b6.1545445081.git.fthain@telegraphics.com.au>
In-Reply-To: <dc3abf702c1f54d536c94305c44de7182f5212b6.1545445081.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 22 Dec 2018 12:04:14 +0100
Message-ID: <CAMuHMdVtbnq6-6TqhnY6EKPWuupP+tCNwFj0_tJJek9qAqEoPQ@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Use '030 reset method on SE/30
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sat, Dec 22, 2018 at 4:07 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The comment says that calling the ROM routine doesn't work. But testing
> shows that the 68030 fall-back reset method does work, so just use that.
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -410,9 +410,8 @@ void mac_poweroff(void)
>
>  void mac_reset(void)
>  {
> -       if (macintosh_config->adb_type == MAC_ADB_II) {
> -               unsigned long flags;
> -
> +       if (macintosh_config->adb_type == MAC_ADB_II &&
> +           macintosh_config->ident != MAC_MODEL_SE30) {
>                 /* need ROMBASE in booter */
>                 /* indeed, plus need to MAP THE ROM !! */
>
> @@ -422,17 +421,8 @@ void mac_reset(void)
>                 /* works on some */
>                 rom_reset = (void *) (mac_bi_data.rombase + 0xa);
>
> -               if (macintosh_config->ident == MAC_MODEL_SE30) {
> -                       /*
> -                        * MSch: Machines known to crash on ROM reset ...
> -                        */
> -               } else {
> -                       local_irq_save(flags);
> -
> -                       rom_reset();
> -
> -                       local_irq_restore(flags);

I guess you removed the call to local_irq_restore() because you never
get there anyway?

> -               }
> +               local_irq_disable();
> +               rom_reset();
>  #ifdef CONFIG_ADB_CUDA
>         } else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
>                    macintosh_config->adb_type == MAC_ADB_CUDA) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
