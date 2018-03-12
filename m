Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeCLLbt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:31:49 -0400
Received: from mout.web.de ([212.227.15.3]:39579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeCLLbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:31:47 -0400
Subject: [PATCH 1/5] Bluetooth: btmrvl: Use common error handling code in
 btmrvl_sdio_register_dev()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <5c3361c6-ef1d-b919-8817-05c2c98fb2ef@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ETzZMnIwpKXtzFt+QTvb+TrQqQiIOpxirtEFP+TOiyJ7FeCP6wi
 wGm8ffPIVOcBxgP882CRnVxAYX/euUFTWA9064r6YVA3L4Z8OUPuc87Ty/NYiHFKKaQFfai
 zGFAIOnQeWVOBw7YfTIbp7VUjS9PQlsYmnyHsAZvsc026yeOx0/+2eFpCqFoCRZgPBRWOA2
 fibHp6Mq8v29kLkJmJV5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3dvIwYlIbMg=:RlGVbrhHQhoCVr14BItlrF
 xIpHU0Hex5PtrOzbjfe378jJrTTisSCO4OfKeDxleO5kJqElhKDEWvRhjogkkIFcCyirxy2mp
 jVRcpQqVOZkQfL0566N3NnCXAn8CbeFomq2G8IuVntsigf8DdB2uwmt+mJstzvmx7/Dj2/br+
 ivINUzzfxC6uY5zdr4ZSIbw5Qg2k6nKdBs2LCZxDed/ebtIe6btrdsCk1QSczHfBmCvXv/kuQ
 kD29hO8Vhg93uVwUai3eeFD50Yguo8ZNm/XCyLcz83aNdoPfNZghjS52rR4ZqMUYXIyCOyMK7
 t5zgA/+/XJvrfeR+BddWq9G+ogt0XpqBH7+fNFGwe6EJYT+zZYvkltvrgxFuYGlKU3pT26adL
 uR2GkGZpiQ2OsUcaVhFBrUKxvfetwi73+PJHYJUu6JQeU/rI46mQibBhX75st0OIqDx5tKEQg
 JcZWGzrZP71+Cr7+rLyVekgK5iMSQM46foxWK350z/d9YzIV+7guCpQRK+rqWTerrWd4DPE+0
 Ukx3PrZlV5sQ6M7dhVvw8bPP7LtJEO+afvafLOkfng2KvYjTcnlJfpuZOQg17wBkmVjrD594V
 r5UuhhLLGRDAx2WTeniYFeV9IUOlo5jhkamxURK+9tyxR9mUYOQfmDF2equckicRC/Qj5S1e6
 8JmT7rC9AMpQb3QrAVfZpYIaNZGuZkeCR5SKi770uiHC4h/ekuj8L3j4sQF1XEflBwhOmAa5J
 YiKx791nwSLiLO03DeiVh7X/nzgIRJT2IsS0uQwnr/SvJD/hK4np4aS+4N7FQ6t0VOF5BsKig
 Oq2wcx48BY6m5Crg6WeH+IfXdxoIsQKZRZVKhvLxdqRqUgdTBU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 10:15:17 +0100

Adjust a jump target so that a bit of exception handling can be better
reused at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 50 ++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 0f020254fd39..df2a04bd8428 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -949,31 +949,24 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 	ret = sdio_set_block_size(card->func, SDIO_BLOCK_SIZE);
 	if (ret) {
 		BT_ERR("cannot set SDIO block size");
-		ret = -EIO;
-		goto release_irq;
+		goto release_with_eio;
 	}
 
 	reg = sdio_readb(func, card->reg->io_port_0, &ret);
-	if (ret < 0) {
-		ret = -EIO;
-		goto release_irq;
-	}
+	if (ret < 0)
+		goto release_with_eio;
 
 	card->ioport = reg;
 
 	reg = sdio_readb(func, card->reg->io_port_1, &ret);
-	if (ret < 0) {
-		ret = -EIO;
-		goto release_irq;
-	}
+	if (ret < 0)
+		goto release_with_eio;
 
 	card->ioport |= (reg << 8);
 
 	reg = sdio_readb(func, card->reg->io_port_2, &ret);
-	if (ret < 0) {
-		ret = -EIO;
-		goto release_irq;
-	}
+	if (ret < 0)
+		goto release_with_eio;
 
 	card->ioport |= (reg << 16);
 
@@ -981,26 +974,20 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	if (card->reg->int_read_to_clear) {
 		reg = sdio_readb(func, card->reg->host_int_rsr, &ret);
-		if (ret < 0) {
-			ret = -EIO;
-			goto release_irq;
-		}
+		if (ret < 0)
+			goto release_with_eio;
+
 		sdio_writeb(func, reg | 0x3f, card->reg->host_int_rsr, &ret);
-		if (ret < 0) {
-			ret = -EIO;
-			goto release_irq;
-		}
+		if (ret < 0)
+			goto release_with_eio;
 
 		reg = sdio_readb(func, card->reg->card_misc_cfg, &ret);
-		if (ret < 0) {
-			ret = -EIO;
-			goto release_irq;
-		}
+		if (ret < 0)
+			goto release_with_eio;
+
 		sdio_writeb(func, reg | 0x10, card->reg->card_misc_cfg, &ret);
-		if (ret < 0) {
-			ret = -EIO;
-			goto release_irq;
-		}
+		if (ret < 0)
+			goto release_with_eio;
 	}
 
 	sdio_set_drvdata(func, card);
@@ -1009,7 +996,8 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	return 0;
 
-release_irq:
+release_with_eio:
+	ret = -EIO;
 	sdio_release_irq(func);
 
 disable_func:
-- 
2.16.2
