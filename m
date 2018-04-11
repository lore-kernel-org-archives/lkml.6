Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeDKPER (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:04:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33066 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeDKPEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:04:15 -0400
X-Google-Smtp-Source: AIpwx48GrXicLtxjKYilq5B9YugB1LSk74slBNUfaUftSKMY54S2KEtVUUyZfHniYGIZbps5MKUg+oQPNhh7R6rK/WY=
MIME-Version: 1.0
In-Reply-To: <1523414803-2626-1-git-send-email-baijiaju1990@gmail.com>
References: <1523414803-2626-1-git-send-email-baijiaju1990@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Apr 2018 17:04:14 +0200
Message-ID: <CAPDyKFq4hL6TRaovv9O1NLXBmd7QJQcuVGmc5kSO3Na-2gcT1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: wbsd: Replace mdelay with usleep_range in wbsd_init
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Pierre Ossman <pierre@ossman.eu>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2018 at 04:46, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> wbsd_init() is never called in atomic context.
>
> The call chains ending up at wbsd_init() are:
> [1] wbsd_init() <- wbsd_probe()
> [2] wbsd_init() <- wbsd_pnp_probe()
>
> wbsd_probe() is set as ".probe" in struct platform_driver.
> wbsd_pnp_probe() is set as ".probe" in struct pnp_driver.
> These functions are not called in atomic context.
>
> Despite never getting called from atomic context, wbsd_init()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
>
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

The patch is good, however I think you should squash all three in this
series into one. For obvious reasons.

Kind regards
Uffe

> ---
>  drivers/mmc/host/wbsd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 546aaf8..6224d12 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1709,7 +1709,7 @@ static int wbsd_init(struct device *dev, int base, int irq, int dma,
>         /*
>          * Allow device to initialise itself properly.
>          */
> -       mdelay(5);
> +       usleep_range(5000, 6000);
>
>         /*
>          * Reset the chip into a known state.
> --
> 1.9.1
>
