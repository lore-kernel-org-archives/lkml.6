Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbeDVR2E (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:28:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46693 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbeDVR2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:28:00 -0400
Date: Sun, 22 Apr 2018 19:27:48 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mtd@lists.infradead.org, Xiaolei Li <xiaolei.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: mtk: use of_device_get_match_data()
Message-ID: <20180422192748.42fc6b6f@bbrezillon>
In-Reply-To: <c3af6d5035e43b53b5cc7ee68f9f1a853ce2a8f9.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
        <c3af6d5035e43b53b5cc7ee68f9f1a853ce2a8f9.1523347340.git.ryder.lee@mediatek.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018 10:33:54 +0800
Ryder Lee <ryder.lee@mediatek.com> wrote:

> The usage of of_device_get_match_data() reduce the code size a bit.
> 
> Also, the only way to call .probe() is to match an entry in
> .of_match_table[], so of_device_id cannot be NULL.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/mtd/nand/raw/mtk_ecc.c  |  7 +------
>  drivers/mtd/nand/raw/mtk_nand.c | 10 +---------

Applied to nand/next after fixing the subject prefix.

Thanks,

Boris

>  2 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mtk_ecc.c b/drivers/mtd/nand/mtk_ecc.c
> index 40d86a8..6432bd7 100644
> --- a/drivers/mtd/nand/raw/mtk_ecc.c
> +++ b/drivers/mtd/nand/raw/mtk_ecc.c
> @@ -500,7 +500,6 @@ static int mtk_ecc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_ecc *ecc;
>  	struct resource *res;
> -	const struct of_device_id *of_ecc_id = NULL;
>  	u32 max_eccdata_size;
>  	int irq, ret;
>  
> @@ -508,11 +507,7 @@ static int mtk_ecc_probe(struct platform_device *pdev)
>  	if (!ecc)
>  		return -ENOMEM;
>  
> -	of_ecc_id = of_match_device(mtk_ecc_dt_match, &pdev->dev);
> -	if (!of_ecc_id)
> -		return -ENODEV;
> -
> -	ecc->caps = of_ecc_id->data;
> +	ecc->caps = of_device_get_match_data(dev);
>  
>  	max_eccdata_size = ecc->caps->num_ecc_strength - 1;
>  	max_eccdata_size = ecc->caps->ecc_strength[max_eccdata_size];
> diff --git a/drivers/mtd/nand/mtk_nand.c b/drivers/mtd/nand/mtk_nand.c
> index 6977da3..75c845a 100644
> --- a/drivers/mtd/nand/raw/mtk_nand.c
> +++ b/drivers/mtd/nand/raw/mtk_nand.c
> @@ -1434,7 +1434,6 @@ static int mtk_nfc_probe(struct platform_device *pdev)
>  	struct device_node *np = dev->of_node;
>  	struct mtk_nfc *nfc;
>  	struct resource *res;
> -	const struct of_device_id *of_nfc_id = NULL;
>  	int ret, irq;
>  
>  	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> @@ -1452,6 +1451,7 @@ static int mtk_nfc_probe(struct platform_device *pdev)
>  	else if (!nfc->ecc)
>  		return -ENODEV;
>  
> +	nfc->caps = of_device_get_match_data(dev);
>  	nfc->dev = dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1498,14 +1498,6 @@ static int mtk_nfc_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> -	of_nfc_id = of_match_device(mtk_nfc_id_table, &pdev->dev);
> -	if (!of_nfc_id) {
> -		ret = -ENODEV;
> -		goto clk_disable;
> -	}
> -
> -	nfc->caps = of_nfc_id->data;
> -
>  	platform_set_drvdata(pdev, nfc);
>  
>  	ret = mtk_nfc_nand_chips_init(dev, nfc);
