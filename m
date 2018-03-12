Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeCLQGT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:06:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48099 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:06:18 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 5/5] Bluetooth: btmrvl: Use common error handling code in
 btmrvl_sdio_download_fw_w_helper()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a3f4f205-dbda-c1dc-6ca6-506d44e20615@users.sourceforge.net>
Date: Mon, 12 Mar 2018 17:06:15 +0100
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <360E0F12-1BC1-441D-872B-8E3946EB2425@holtmann.org>
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
 <a3f4f205-dbda-c1dc-6ca6-506d44e20615@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 12 Mar 2018 11:30:28 +0100
> 
> Add a jump target so that the setting of a specific error code is stored
> only once at the end of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 05c78fcc13ff..24ed62fe2aeb 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -601,8 +601,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
> 					" base0 = 0x%04X(%d)."
> 					" Terminating download",
> 					base0, base0);
> -				ret = -EIO;
> -				goto done;
> +				goto e_io;
> 			}
> 			base1 = sdio_readb(card->func,
> 					card->reg->sq_read_base_addr_a1, &ret);
> @@ -611,8 +610,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
> 					" base1 = 0x%04X(%d)."
> 					" Terminating download",
> 					base1, base1);
> -				ret = -EIO;
> -				goto done;
> +				goto e_io;
> 			}
> 
> 			len = (((u16) base1) << 8) | base0;
> @@ -638,8 +636,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
> 			if (count > MAX_WRITE_IOMEM_RETRY) {
> 				BT_ERR("FW download failure @%d, "
> 					"over max retry count", offset);
> -				ret = -EIO;
> -				goto done;
> +				goto e_io;
> 			}
> 			BT_ERR("FW CRC error indicated by the helper: "
> 				"len = 0x%04X, txlen = %d", len, txlen);
> @@ -681,6 +678,10 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
> 	kfree(tmpfwbuf);
> 	release_firmware(fw_firmware);
> 	return ret;
> +
> +e_io:
> +	ret = -EIO;
> +	goto done;
> }

I am not applying this one. I see zero benefit in this change. It is not even saving a single line since it actually is more code.

Regards

Marcel
