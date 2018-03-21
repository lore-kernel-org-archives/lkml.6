Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeCUIte (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:49:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40492 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCUItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:49:31 -0400
X-Google-Smtp-Source: AG47ELtm9jyV0u2d0S0iNkKSSU2cInD6mSaFhSui5SXy0NTC66uM2K7Q4WZPozqzN9hy8Av8mnTlD4fNcu+XvDE1Qgs=
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB3063FA8C1B267634A8B1A5180C10@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <20180226120418.3589-1-colin.king@canonical.com> <AM3PR04MB3063FA8C1B267634A8B1A5180C10@AM3PR04MB306.eurprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Mar 2018 09:49:29 +0100
Message-ID: <CACRpkdZYn8Ke2cXWt63LukTMa-zohToaK-UcrR3mvbCgL_M_yw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: imx: fix unsigned check if nfuncs with less than
 or equal zero
To: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Colin King <colin.king@canonical.com>,
        Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 2:14 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:

>> -     u32 nfuncs = 0;
>> -     u32 i = 0;
>> +     int nfuncs = 0;
>> +     int i = 0;
>>       bool flat_funcs;
>>
>
> I saw 'i', later used, is converted to u32 unconditionally. (GCC did not complain)
> e.g.
> radix_tree_insert
> imx_pinctrl_parse_functions
>
> And of_get_child_count seems can't  return a minor value.
>
> So does something like below look better?
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index c976ffe..4259209 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -612,7 +612,7 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
>                 nfuncs = 1;
>         } else {
>                 nfuncs = of_get_child_count(np);
> -               if (nfuncs <= 0) {
> +               if (nfuncs == 0) {

This makes more sense to me.

You can have zero functions but not negative number of functions.

Aisheng, can you send a patch like this? (Or is it already somewhere in
my inbox?)

Yours,
Linus Walleij
