Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCUIB0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:01:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36200 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbeCUIBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:01:25 -0400
Date: Wed, 21 Mar 2018 09:01:23 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: dwmw2@infradead.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: devices: check mtd_device_register() return code
Message-ID: <20180321090123.07d55e32@xps13>
In-Reply-To: <20180321053709.GA5611@seema-Inspiron-15-3567>
References: <20180321053709.GA5611@seema-Inspiron-15-3567>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arushi,

On Wed, 21 Mar 2018 11:07:09 +0530, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:

> stfsm_probe() misses error handling of mtd_device_register().
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index 7bc29d7..e1aa4f8 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -2125,7 +2125,13 @@ static int stfsm_probe(struct platform_device *pdev)
>  		(long long)fsm->mtd.size, (long long)(fsm->mtd.size >> 20),
>  		fsm->mtd.erasesize, (fsm->mtd.erasesize >> 10));
>  
> -	return mtd_device_register(&fsm->mtd, NULL, 0);
> +	ret = mtd_device_register(&fsm->mtd, NULL, 0);
> +	if (ret) {
> +		pr_err("Failed to register device\n");
> +		return ret;
> +	}
> +
> +	return 0;

I don't think this bring anything. However, if you want to fix
something you should jump below on error to disable the clock instead
of returning 'ret' directly.

>  
>  err_clk_unprepare:
>  	clk_disable_unprepare(fsm->clk);

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
