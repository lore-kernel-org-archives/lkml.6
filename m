Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48EmAql1j7yA1NVDTuD8eN1EZXDy0VVqHlyaol7pJa9mPlCKlwat/h656AECDv7xnqkE4It
ARC-Seal: i=1; a=rsa-sha256; t=1523473038; cv=none;
        d=google.com; s=arc-20160816;
        b=QrAVwfbf6MUytpAjD2Swv2nRXesuQr1m6zanrW39Ry71ijf7gZg1wQmRc5IlMbDHZV
         P5uCjwbgBqAg9/cVSO9jBvNU++LDSxUJE8owaOqNhiTnsWBDvDcIfxKgSST370H0kAKs
         8unN2zUaMI2aLSgzk2Z4yqTTbH/xKabylZdkxqeee3gZs8ye35+6zFPv7UDh5EDUZO5n
         1E9KGoxkNhE3gajeqCAAXJ9FjRAGRDHK54HlcLjYQ/wswrXaaryIdMjZ9Rhgn9F3uk3r
         YV0vpWZQs5T0ZJByEQJCBYZr/LZqru1pN4h1A+JXda4SpnCMSv2eySk+BkYtRJJXBn58
         zuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n+3ciDKFxAnh1ZZpKT7DpDdVFJtrDGxHWe4kpnZOHDc=;
        b=giof2NMM146LiFqy/W5nEUcpNQELPyOI/jpU3JKqd0o54k3/0HzxUVd6goswfuGVwJ
         unbs/ZTuAQxwrDQPVz+8YThTICrIxnnYO9H8r23Tkk+fRt6uMho9NCYvXiZV6bEy/pkI
         PMew5m2/Ko8U/kT515tnP2dvkojqpGXJbxTlBsUicimRX5j3/3WCx8hKu20TxSob+hz9
         1N9v7nGdRLNSiJr1eIu4UFuuWZhuSLwq7XWDHWBVV9Lni/5oF54NJ/K72CJ5O12dMbuk
         g0tHVS+cLt1alSatJbMsLHET7wOFJ4EX3ENttvAWK3OdNKhxq4CixT+uBelyKvT95sOM
         pq9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Holger Brunck <holger.brunck@keymile.com>,
	Zhao Qiang <qiang.zhao@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 073/310] net/wan/fsl_ucc_hdlc: fix incorrect memory allocation
Date: Wed, 11 Apr 2018 20:33:32 +0200
Message-Id: <20180411183625.446925578@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477265624350920?=
X-GMAIL-MSGID: =?utf-8?q?1597477265624350920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Holger Brunck <holger.brunck@keymile.com>


[ Upstream commit 5b8aad93c52bdda6a731cab8497998cfa0f2df07 ]

We need space for the struct qe_bd and not for a pointer to this struct.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -137,7 +137,7 @@ static int uhdlc_init(struct ucc_hdlc_pr
 	priv->tx_ring_size = TX_BD_RING_LEN;
 	/* Alloc Rx BD */
 	priv->rx_bd_base = dma_alloc_coherent(priv->dev,
-			RX_BD_RING_LEN * sizeof(struct qe_bd *),
+			RX_BD_RING_LEN * sizeof(struct qe_bd),
 			&priv->dma_rx_bd, GFP_KERNEL);
 
 	if (!priv->rx_bd_base) {
@@ -148,7 +148,7 @@ static int uhdlc_init(struct ucc_hdlc_pr
 
 	/* Alloc Tx BD */
 	priv->tx_bd_base = dma_alloc_coherent(priv->dev,
-			TX_BD_RING_LEN * sizeof(struct qe_bd *),
+			TX_BD_RING_LEN * sizeof(struct qe_bd),
 			&priv->dma_tx_bd, GFP_KERNEL);
 
 	if (!priv->tx_bd_base) {
@@ -295,11 +295,11 @@ free_ucc_pram:
 	qe_muram_free(priv->ucc_pram_offset);
 free_tx_bd:
 	dma_free_coherent(priv->dev,
-			  TX_BD_RING_LEN * sizeof(struct qe_bd *),
+			  TX_BD_RING_LEN * sizeof(struct qe_bd),
 			  priv->tx_bd_base, priv->dma_tx_bd);
 free_rx_bd:
 	dma_free_coherent(priv->dev,
-			  RX_BD_RING_LEN * sizeof(struct qe_bd *),
+			  RX_BD_RING_LEN * sizeof(struct qe_bd),
 			  priv->rx_bd_base, priv->dma_rx_bd);
 free_uccf:
 	ucc_fast_free(priv->uccf);
@@ -688,7 +688,7 @@ static void uhdlc_memclean(struct ucc_hd
 
 	if (priv->rx_bd_base) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * sizeof(struct qe_bd *),
+				  RX_BD_RING_LEN * sizeof(struct qe_bd),
 				  priv->rx_bd_base, priv->dma_rx_bd);
 
 		priv->rx_bd_base = NULL;
@@ -697,7 +697,7 @@ static void uhdlc_memclean(struct ucc_hd
 
 	if (priv->tx_bd_base) {
 		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * sizeof(struct qe_bd *),
+				  TX_BD_RING_LEN * sizeof(struct qe_bd),
 				  priv->tx_bd_base, priv->dma_tx_bd);
 
 		priv->tx_bd_base = NULL;
