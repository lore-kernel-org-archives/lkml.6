Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeC2OUu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:20:50 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:26756 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeC2OUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:20:49 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517900400";
   d="scan'208";a="12507687"
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC: "wenyouya@gmail.com" <wenyouya@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180329131054.22506-1-peda@axentia.se>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
Date: Thu, 29 Mar 2018 16:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329131054.22506-1-peda@axentia.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2018 at 15:10, Peter Rosin wrote:
> On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> flash accesses have a tendency to cause display disturbances. Add a
> module param to disable DMA from the NAND controller, since that fixes
> the display problem for me.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>   drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index b2f00b398490..2ff7a77c7b8e 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -129,6 +129,11 @@
>   #define DEFAULT_TIMEOUT_MS			1000
>   #define MIN_DMA_LEN				128
>   
> +static bool atmel_nand_avoid_dma __read_mostly;
> +
> +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
> +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);

We had the DT parameter "atmel,nand-has-dma" for this purpose and it was 
associated with a module parameter as well (use_dma,).

Is it only managed by old DT binding?

Best regards,
   Nicoals

>   enum atmel_nand_rb_type {
>   	ATMEL_NAND_NO_RB,
>   	ATMEL_NAND_NATIVE_RB,
> @@ -1977,7 +1982,7 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>   		return ret;
>   	}
>   
> -	if (nc->caps->has_dma) {
> +	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
>   		dma_cap_mask_t mask;
>   
>   		dma_cap_zero(mask);
> 


-- 
Nicolas Ferre
