Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeBALER (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:04:17 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37613 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeBALEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:04:15 -0500
X-Google-Smtp-Source: AH8x224edc1LajgyL74s//Ll6l5v5GXUxEJ7kBgWCp7g4WdTDVGuY1Wi/vCX1g4NkR5tmTF2Hs9Tk0als5I/fR4fE9U=
MIME-Version: 1.0
In-Reply-To: <1517482822-28758-1-git-send-email-himanshujha199640@gmail.com>
References: <1517482822-28758-1-git-send-email-himanshujha199640@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2018 12:04:14 +0100
X-Google-Sender-Auth: _CsAq1KKDD8yVMvs4o11_R8Jfb4
Message-ID: <CAMuHMdVzDpWdc-qav2Y0_p8m6u_jdmjtZ37B4-V7k2vuFTTRVA@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: Handle return of of_match_device function
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, mars.cheng@mediatek.com,
        weiyi.lu@mediatek.com, Ulf Hansson <ulf.hansson@linaro.org>,
        kevin-cw.chen@mediatek.com, sean.wang@mediatek.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Himanshu,

On Thu, Feb 1, 2018 at 12:00 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> In scpsys_probe function, return value of of_match_device function which
> returns null is dereferenced without checking. Therefore, add a check for
> potential null dereference.
>
> Detected by CoverityScan, CID#1424087 "Dereference null return value"
>
> Fixes: commit 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

This is a false positive: as this is a pure-OF driver, scpsys_probe()
is called if
and only if a match was found in of_scpsys_match_tbl[].

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 435ce5e..6e7f196 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -981,6 +981,9 @@ static int scpsys_probe(struct platform_device *pdev)
>         int i, ret;
>
>         match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
> +       if (!match)
> +               return -EINVAL;
> +
>         soc = (const struct scp_soc_data *)match->data;
>
>         scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
