Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeCLQSf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:18:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46710 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbeCLQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:18:33 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/5] Bluetooth: btmrvl: Use common error handling code in
 btmrvl_sdio_register_dev()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5c3361c6-ef1d-b919-8817-05c2c98fb2ef@users.sourceforge.net>
Date: Mon, 12 Mar 2018 17:18:31 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EE3DFCC7-3B51-43B6-A28B-3102F55479AA@holtmann.org>
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
 <5c3361c6-ef1d-b919-8817-05c2c98fb2ef@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

> Adjust a jump target so that a bit of exception handling can be better
> reused at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 50 ++++++++++++++++-------------------------
> 1 file changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 0f020254fd39..df2a04bd8428 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -949,31 +949,24 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
> 	ret = sdio_set_block_size(card->func, SDIO_BLOCK_SIZE);
> 	if (ret) {
> 		BT_ERR("cannot set SDIO block size");
> -		ret = -EIO;
> -		goto release_irq;
> +		goto release_with_eio;
> 	}
> 
> 	reg = sdio_readb(func, card->reg->io_port_0, &ret);
> -	if (ret < 0) {
> -		ret = -EIO;
> -		goto release_irq;
> -	}
> +	if (ret < 0)
> +		goto release_with_eio;
> 
> 	card->ioport = reg;
> 
> 	reg = sdio_readb(func, card->reg->io_port_1, &ret);
> -	if (ret < 0) {
> -		ret = -EIO;
> -		goto release_irq;
> -	}
> +	if (ret < 0)
> +		goto release_with_eio;
> 
> 	card->ioport |= (reg << 8);
> 
> 	reg = sdio_readb(func, card->reg->io_port_2, &ret);
> -	if (ret < 0) {
> -		ret = -EIO;
> -		goto release_irq;
> -	}
> +	if (ret < 0)
> +		goto release_with_eio;
> 
> 	card->ioport |= (reg << 16);
> 
> @@ -981,26 +974,20 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
> 
> 	if (card->reg->int_read_to_clear) {
> 		reg = sdio_readb(func, card->reg->host_int_rsr, &ret);
> -		if (ret < 0) {
> -			ret = -EIO;
> -			goto release_irq;
> -		}
> +		if (ret < 0)
> +			goto release_with_eio;
> +
> 		sdio_writeb(func, reg | 0x3f, card->reg->host_int_rsr, &ret);
> -		if (ret < 0) {
> -			ret = -EIO;
> -			goto release_irq;
> -		}
> +		if (ret < 0)
> +			goto release_with_eio;
> 
> 		reg = sdio_readb(func, card->reg->card_misc_cfg, &ret);
> -		if (ret < 0) {
> -			ret = -EIO;
> -			goto release_irq;
> -		}
> +		if (ret < 0)
> +			goto release_with_eio;
> +
> 		sdio_writeb(func, reg | 0x10, card->reg->card_misc_cfg, &ret);
> -		if (ret < 0) {
> -			ret = -EIO;
> -			goto release_irq;
> -		}
> +		if (ret < 0)
> +			goto release_with_eio;
> 	}
> 
> 	sdio_set_drvdata(func, card);
> @@ -1009,7 +996,8 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
> 
> 	return 0;
> 
> -release_irq:
> +release_with_eio:
> +	ret = -EIO;
> 	sdio_release_irq(func);
> 
> disable_func:

please do not send me any patches with renaming goto labels. I dislike long goto labels anyway and it doesn’t make it any better in mind.

In addition, this patch is half baked. If you want to do something, then you replace all err = -EIO and use this.

release_irq:
        sdio_release_irq(func);

disable_func:
        sdio_disable_func(func);

release_host:
        sdio_release_host(func);

	return -EIO;

And replace goto failed with return -EINVAL;

Regards

Marcel
