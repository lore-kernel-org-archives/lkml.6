Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935341AbeEIPDX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:03:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60859 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935125AbeEIPDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:03:22 -0400
Date: Wed, 9 May 2018 17:03:10 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Joachim Eastwood <manabian@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
Subject: Re: [PATCH v2] mtd: nxp-spifi: release flash_np in
 nxp_spifi_probe()
Message-ID: <20180509170310.65d19c49@bbrezillon>
In-Reply-To: <1525877806-21148-1-git-send-email-khoroshilov@ispras.ru>
References: <20180509163920.67a5f203@bbrezillon>
        <1525877806-21148-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 May 2018 17:56:46 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> nxp_spifi_probe() increments refcnt of SPI flash device node by
> of_get_next_available_child() and leaves it undecremented on both
> successful and error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/mtd/spi-nor/nxp-spifi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/nxp-spifi.c
> index 15374216d4d9..7b047951d0a2 100644
> --- a/drivers/mtd/spi-nor/nxp-spifi.c
> +++ b/drivers/mtd/spi-nor/nxp-spifi.c
> @@ -438,11 +438,15 @@ static int nxp_spifi_probe(struct platform_device *pdev)
>  	ret = nxp_spifi_setup_flash(spifi, flash_np);

Just put the of_node_put() here and that's the only change you'll need.

>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to setup flash chip\n");
> -		goto dis_clks;
> +		goto put_np;
>  	}
>  
> +	of_node_put(flash_np);
> +
>  	return 0;
>  
> +put_np:
> +	of_node_put(flash_np);
>  dis_clks:
>  	clk_disable_unprepare(spifi->clk_spifi);
>  dis_clk_reg:
