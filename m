Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCLLdb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:33:31 -0400
Received: from mout.web.de ([212.227.15.14]:50381 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeCLLd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:33:29 -0400
Subject: [PATCH 3/5] Bluetooth: btmrvl: One check less in
 btmrvl_sdio_card_to_host() after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <a988a80d-12c0-a414-ab81-ff4ab075855c@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:2cEBLcNpyDciMXQ20/unqmdDd50fnR4WimxV7itDpugBwPdXxNk
 Nasymyo4rPOx7v9a/2s1jFFkCSj72jo3ODlOWHZxbZn5iScvkHiov9W72Bu7Hr+x2eqs4oS
 fLQVvApU+SoWUSvfvBN3KvkazvwZEv/1UHjTUBlMG3UeKF8LA4YgrT0BKi2yFFsw8xuWuFf
 9GnCQxi/rOcZW7mh2H0Aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EMVGNL4wJ+c=:g6DtaZxppjznrq/ow8thu/
 UHYTTHOfR1TkO9HbAZFNrFpbRA/U3av2feRW8pNFidOrE49slxdp+oO79R04/aS/SG5+vy0Az
 osFiYMWky+0p6CaZU2qq4su5unBagrng/e3yJHE/j6tEMrRUfhnGDm20SMD5okHQ4WbPtezU/
 96NcLJDzfJiL94fFnMokpOlVqV1Ag7PNDI+WjNnVgB/0GWHu563jyTiU2IA39zE2iGesNR+G1
 vhH2FXAhmjICXb5TA3m9zhVVCpG2aBXCJhxLfYuOtoQX10vwybZg2Y4n/rH7hyBPF8fm4CvZi
 4P0LpShTLxgrTxDKve5+TDbXQOiCvknJftD5/fQ8T3mWyLenm1kOkxqNWy/XrpssxsG/6bytJ
 H0up8EmVlTNdrjtjdwWN/LlBu81PNSeyYu7KbGEsccbztMGvK2yS3y2KtQ0hiZ0HUI75Eomtu
 YLwyKtS1YFCTS1+OZxH72BfWarmhnSOhLoo4mkoYQuqtYpsQFUO9DVymHr3BmKRPWLCN73ZV3
 qVuvPXeie/GHXC7Dweq+LPF+2t/+CxIX5Ozjj6p53JKmdJGYrijt8xSShWd2edogq7zbzAsjO
 pIJiT5Ae3EFeK22JJIU8TMkPuvPypfJQwf4kjbgyJjMsx4QHUbkVKIxTmFxeDGsuOUVPr019K
 G66FyIje1MLGSmfh/vWgiU+e1attE6NeWCwT6htT0ZicgnkYC6x5VYiPqK+uMNDWUj4BELvJA
 B2Fo9hkmkQmT7MGTeYxRg6DmCiztsJd4NrUEvvC3Qh+vJj/8RwNG9Kwzdve3dGXCRaSCjWhuC
 ycZTzgwBtNSr/LPb3L821B1335QLs2+CHoD1cNKSks45OdsYDU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 11:13:00 +0100

One check could be repeated by the btmrvl_sdio_card_to_host() function
during error handling even if the relevant properties can be determined
for the involved variables before by source code analysis.

* Adjust jump targets so that an extra check can be omitted at the end.

* Reuse a bit of exception handling better.

* Delete an initialisation for the local variable "skb"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 84c222abf0f7..9854addc8e96 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -687,5 +687,5 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 {
 	u16 buf_len = 0;
 	int ret, num_blocks, blksz;
-	struct sk_buff *skb = NULL;
+	struct sk_buff *skb;
 	u32 type;
@@ -695,16 +695,14 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 
 	if (!card || !card->func) {
 		BT_ERR("card or function is NULL!");
-		ret = -EINVAL;
-		goto exit;
+		goto e_inval;
 	}
 
 	/* Read the length of data to be transferred */
 	ret = btmrvl_sdio_read_rx_len(card, &buf_len);
 	if (ret < 0) {
 		BT_ERR("read rx_len failed");
-		ret = -EIO;
-		goto exit;
+		goto e_io;
 	}
 
 	blksz = SDIO_BLOCK_SIZE;
@@ -713,8 +711,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	if (buf_len <= SDIO_HEADER_LEN
 	    || (num_blocks * blksz) > ALLOC_BUF_SIZE) {
 		BT_ERR("invalid packet length: %d", buf_len);
-		ret = -EINVAL;
-		goto exit;
+		goto e_inval;
 	}
 
 	/* Allocate buffer */
@@ -722,7 +719,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	if (!skb) {
 		BT_ERR("No free skb");
 		ret = -ENOMEM;
-		goto exit;
+		goto increment_counter;
 	}
 
 	if ((unsigned long) skb->data & (BTSDIO_DMA_ALIGN - 1)) {
@@ -738,8 +735,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 			  num_blocks * blksz);
 	if (ret < 0) {
 		BT_ERR("readsb failed: %d", ret);
-		ret = -EIO;
-		goto exit;
+		goto free_skb;
 	}
 
 	/* This is SDIO specific header length: byte[2][1][0], type: byte[3]
@@ -753,8 +749,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	if (buf_len > blksz * num_blocks) {
 		BT_ERR("Skip incorrect packet: hdrlen %d buffer %d",
 		       buf_len, blksz * num_blocks);
-		ret = -EIO;
-		goto exit;
+		goto free_skb;
 	}
 
 	type = payload[3];
@@ -797,12 +792,18 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		break;
 	}
 
-exit:
-	if (ret) {
-		hdev->stat.err_rx++;
-		kfree_skb(skb);
-	}
+	return 0;
+
+free_skb:
+	kfree_skb(skb);
+e_io:
+	ret = -EIO;
+	goto increment_counter;
 
+e_inval:
+	ret = -EINVAL;
+increment_counter:
+	hdev->stat.err_rx++;
 	return ret;
 }
 
-- 
2.16.2
