Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeA3NL4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:11:56 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:41569 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeA3NLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:11:53 -0500
Date: Tue, 30 Jan 2018 14:11:41 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: ldv-project@linuxtesting.org, Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] mtd: nand: vf610: fix error handling in
 vf610_nfc_probe()
Message-ID: <20180130141141.7f4fd15a@bbrezillon>
In-Reply-To: <1517005961-7938-1-git-send-email-khoroshilov@ispras.ru>
References: <20180106102541.75ff546d@bbrezillon>
        <1517005961-7938-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2018 01:32:41 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> vf610_nfc_probe() misses error handling of mtd_device_register()
> and contains unneeded of_node_put() on error path.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
> v2: Add nand_cleanup() to undone nand_scan_tail() as Boris Brezillon noted.
> v3: Rename error labels, remove of_node_put() per Boris Brezillon request.

Should be separated in 3 patches IMO:
1/ remove the unnecessary of_node_put()
2/ rename error label into err_disable_clk
3/ check mtd_device_register() return code

> 
>  drivers/mtd/nand/vf610_nfc.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> index 8037d4b48a05..7cdc6eed305d 100644
> --- a/drivers/mtd/nand/vf610_nfc.c
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -682,7 +682,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  				dev_err(nfc->dev,
>  					"Only one NAND chip supported!\n");
>  				err = -EINVAL;
> -				goto error;
> +				goto err_disable_clk;
>  			}
>  
>  			nand_set_flash_node(chip, child);
> @@ -692,7 +692,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  	if (!nand_get_flash_node(chip)) {
>  		dev_err(nfc->dev, "NAND chip sub-node missing!\n");
>  		err = -ENODEV;
> -		goto err_clk;
> +		goto err_disable_clk;
>  	}
>  
>  	chip->dev_ready = vf610_nfc_dev_ready;
> @@ -712,7 +712,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
>  	if (err) {
>  		dev_err(nfc->dev, "Error requesting IRQ!\n");
> -		goto error;
> +		goto err_disable_clk;
>  	}
>  
>  	vf610_nfc_preinit_controller(nfc);
> @@ -720,7 +720,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  	/* first scan to find the device and get the page size */
>  	err = nand_scan_ident(mtd, 1, NULL);
>  	if (err)
> -		goto error;
> +		goto err_disable_clk;
>  
>  	vf610_nfc_init_controller(nfc);
>  
> @@ -732,20 +732,20 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
>  		dev_err(nfc->dev, "Unsupported flash page size\n");
>  		err = -ENXIO;
> -		goto error;
> +		goto err_disable_clk;
>  	}
>  
>  	if (chip->ecc.mode == NAND_ECC_HW) {
>  		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
>  			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
>  			err = -ENXIO;
> -			goto error;
> +			goto err_disable_clk;
>  		}
>  
>  		if (chip->ecc.size != mtd->writesize) {
>  			dev_err(nfc->dev, "Step size needs to be page size\n");
>  			err = -ENXIO;
> -			goto error;
> +			goto err_disable_clk;
>  		}
>  
>  		/* Only 64 byte ECC layouts known */
> @@ -765,7 +765,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  		} else {
>  			dev_err(nfc->dev, "Unsupported ECC strength\n");
>  			err = -ENXIO;
> -			goto error;
> +			goto err_disable_clk;
>  		}
>  
>  		chip->ecc.read_page = vf610_nfc_read_page;
> @@ -777,16 +777,19 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  	/* second phase scan */
>  	err = nand_scan_tail(mtd);
>  	if (err)
> -		goto error;
> +		goto err_disable_clk;
>  
>  	platform_set_drvdata(pdev, mtd);
>  
>  	/* Register device in MTD */
> -	return mtd_device_register(mtd, NULL, 0);
> +	err = mtd_device_register(mtd, NULL, 0);
> +	if (err)
> +		goto err_cleanup_nand;
> +	return 0;
>  
> -error:
> -	of_node_put(nand_get_flash_node(chip));
> -err_clk:
> +err_cleanup_nand:
> +	nand_cleanup(chip);
> +err_disable_clk:
>  	clk_disable_unprepare(nfc->clk);
>  	return err;
>  }
