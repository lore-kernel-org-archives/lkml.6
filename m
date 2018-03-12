Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbeCLQMy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:12:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47650 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbeCLQMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:12:53 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 3/5] Bluetooth: btmrvl: One check less in
 btmrvl_sdio_card_to_host() after error detection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a988a80d-12c0-a414-ab81-ff4ab075855c@users.sourceforge.net>
Date: Mon, 12 Mar 2018 17:12:51 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <609D1B28-2B75-4AB5-B707-FDB5D0500F1A@holtmann.org>
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
 <a988a80d-12c0-a414-ab81-ff4ab075855c@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

> One check could be repeated by the btmrvl_sdio_card_to_host() function
> during error handling even if the relevant properties can be determined
> for the involved variables before by source code analysis.
> 
> * Adjust jump targets so that an extra check can be omitted at the end.
> 
> * Reuse a bit of exception handling better.
> 
> * Delete an initialisation for the local variable "skb"
>  which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 35 ++++++++++++++++++-----------------
> 1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 84c222abf0f7..9854addc8e96 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -687,5 +687,5 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
> {
> 	u16 buf_len = 0;
> 	int ret, num_blocks, blksz;
> -	struct sk_buff *skb = NULL;
> +	struct sk_buff *skb;
> 	u32 type;
> @@ -695,16 +695,14 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
> 
> 	if (!card || !card->func) {
> 		BT_ERR("card or function is NULL!");
> -		ret = -EINVAL;
> -		goto exit;
> +		goto e_inval;
> 	}
> 
> 	/* Read the length of data to be transferred */
> 	ret = btmrvl_sdio_read_rx_len(card, &buf_len);
> 	if (ret < 0) {
> 		BT_ERR("read rx_len failed");
> -		ret = -EIO;
> -		goto exit;
> +		goto e_io;
> 	}
> 
> 	blksz = SDIO_BLOCK_SIZE;
> @@ -713,8 +711,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
> 	if (buf_len <= SDIO_HEADER_LEN
> 	    || (num_blocks * blksz) > ALLOC_BUF_SIZE) {
> 		BT_ERR("invalid packet length: %d", buf_len);
> -		ret = -EINVAL;
> -		goto exit;
> +		goto e_inval;
> 	}
> 
> 	/* Allocate buffer */
> @@ -722,7 +719,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
> 	if (!skb) {
> 		BT_ERR("No free skb");
> 		ret = -ENOMEM;
> -		goto exit;
> +		goto increment_counter;
> 	}
> 
> 	if ((unsigned long) skb->data & (BTSDIO_DMA_ALIGN - 1)) {
> @@ -738,8 +735,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
> 			  num_blocks * blksz);
> 	if (ret < 0) {
> 		BT_ERR("readsb failed: %d", ret);
> -		ret = -EIO;
> -		goto exit;
> +		goto free_skb;
> 	}
> 
> 	/* This is SDIO specific header length: byte[2][1][0], type: byte[3]
> @@ -753,8 +749,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
> 	if (buf_len > blksz * num_blocks) {
> 		BT_ERR("Skip incorrect packet: hdrlen %d buffer %d",
> 		       buf_len, blksz * num_blocks);
> -		ret = -EIO;
> -		goto exit;
> +		goto free_skb;
> 	}
> 
> 	type = payload[3];
> @@ -797,12 +792,18 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
> 		break;
> 	}
> 
> -exit:
> -	if (ret) {
> -		hdev->stat.err_rx++;
> -		kfree_skb(skb);
> -	}
> +	return 0;
> +
> +free_skb:
> +	kfree_skb(skb);
> +e_io:
> +	ret = -EIO;
> +	goto increment_counter;
> 
> +e_inval:
> +	ret = -EINVAL;
> +increment_counter:
> +	hdev->stat.err_rx++;
> 	return ret;

Nope!

This is not easier to read for me. This goto exit jumping and I hate that. Actually to be honest this kind of goto jumping makes my brain hurt and I want to avoid it.

Regards

Marcel
