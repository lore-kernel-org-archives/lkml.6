Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935857AbeEXIAz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:00:55 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:8482 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935785AbeEXIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:00:23 -0400
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="11861485"
Date: Thu, 24 May 2018 09:59:29 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        <kernel-janitors@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] pinctrl: at91-pio4: add missing of_node_put
Message-ID: <20180524075929.GA3750@rfolt0960.corp.atmel.com>
Mail-Followup-To: Julia Lawall <Julia.Lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
 <1527102436-13447-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1527102436-13447-2-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 09:07:12PM +0200, Julia Lawall wrote:
> The device node iterators perform an of_node_get on each iteration, so a
> jump out of the loop requires an of_node_put.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> iterator name for_each_child_of_node;
> @@
> 
>  for_each_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> +  of_node_put(child);
> ?  break;
>    ...
> }
> ... when != child
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks
> 
> ---
>  drivers/pinctrl/pinctrl-at91-pio4.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 4b57a13..bafb3d4 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -576,8 +576,10 @@ static int atmel_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  		for_each_child_of_node(np_config, np) {
>  			ret = atmel_pctl_dt_subnode_to_map(pctldev, np, map,
>  						    &reserved_maps, num_maps);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				of_node_put(np);
>  				break;
> +			}
>  		}
>  	}
>  
> 
