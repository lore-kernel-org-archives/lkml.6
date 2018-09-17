Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F821ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316D22098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bmJ7I5Dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316D22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeIQUh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:37:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59187 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbeIQUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:37:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180917151011euoutp02fe0e1b8e02c18a08e8774ea2a4f2ba2e~VOImMFtsX1496814968euoutp02x
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:10:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180917151011euoutp02fe0e1b8e02c18a08e8774ea2a4f2ba2e~VOImMFtsX1496814968euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537197011;
        bh=T9jpYh7paRgEMj1xcfos8mLUbeOnMA+vBAv85Pt86X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmJ7I5DjKWB1PHB55ULEXK63ADNw+BboDAQejGKYhkgJW23+oESW9De1ip2x3W6JY
         jBrn9VZ2whnNYkgYb76A4m753V8BCkaez6VuZ9ae4GmIa984lAFBbhtWtpMjXiKlo+
         VOROsMQQzb3IrXboEH0729v+ClPzNiOvMkxZU74o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180917151010eucas1p137a318378eaeabf8518fcb1f8e8a40c3~VOIlRcHs-0556505565eucas1p1v;
        Mon, 17 Sep 2018 15:10:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6A.34.04294.1D3CF9B5; Mon, 17
        Sep 2018 16:10:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02~VOIkhD_S60202502025eucas1p1F;
        Mon, 17 Sep 2018 15:10:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180917151009eusmtrp229eece97d0623a272c92ec0f2378921b~VOIkPLJhD2674126741eusmtrp2v;
        Mon, 17 Sep 2018 15:10:09 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c2-5b9fc3d1354c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 44.46.04128.1D3CF9B5; Mon, 17
        Sep 2018 16:10:09 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180917151008eusmtip26c758608bc47011c811759e45550d48f~VOIj0tvfW2392923929eusmtip2b;
        Mon, 17 Sep 2018 15:10:08 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 3/4] crypto: s5p-sss: Minor code cleanup
Date:   Mon, 17 Sep 2018 17:09:29 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzned2Lh+dHGzy8YGmxccZ6Vovju5cy
        Wsw538Ji0f1KxqJv339Gi/PnN7Bb3L/3k8ni8q45bBYzzu9jsvj/q5nZgctjy8qbTB7bDqh6
        bFrVyebxb+EUFo+D7/YwefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGw5kzmAuaZSqmHLrD
        2MA4V6yLkZNDQsBEYtqTz+xdjFwcQgIrGCU+Nv9khHC+MEps3rqaFcL5zCjx9+weoDIOsJZJ
        t2Mg4ssZJS5vXMgM19F4ZQEjyFw2AVOJ23c/sYE0iAgoSMz7qgMSZhZoYZb4tZoTxBYWsJZY
        2zsbrJxFQFWi89ZzNoiT5CRunutkBrE5BTwk3v+ZxQ4Rn8wucbVRAsTmFSiTONYygxki7iKx
        7tUUqF5hiVfHt0DVy0j83zmfCeQ2CYFmRolbX66xQjgTGCUOru5igaiylth04xUTyKHMApoS
        63fpQzzpKDHzdCWEySdx460gxPl8EpO2TWeGCPNKdLQJQcxQk3i9ZQsbzNYXn78yQpR4SPzf
        EAEJnNmMEs1/prFPYJSfhbBqASPjKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMBkcvrf
        8S87GHf9STrEKMDBqMTDu2DB/Ggh1sSy4srcQ4wSHMxKIrzMfEAh3pTEyqrUovz4otKc1OJD
        jNIcLErivHxaadFCAumJJanZqakFqUUwWSYOTqkGRkUTA2avWUn2AdMY1CayNDBdkm6yUp2+
        fi53zsaF5heXOLj/Nsv4zdf/vXdP0G+lsrYO/msKd42NGTWE3TbfVrx1qizw84OdObLX3ou8
        nCPH0C1t9O9yqFUYk6SWxk0Xn1mZK6xf7Wdbsm6261m2xFtFVydrhq0tqes/4nL+2sEziuus
        6zrWK7EUZyQaajEXFScCALrYY4YiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xe7oXD8+PNljVxG6xccZ6Vovju5cy
        Wsw538Ji0f1KxqJv339Gi/PnN7Bb3L/3k8ni8q45bBYzzu9jsvj/q5nZgctjy8qbTB7bDqh6
        bFrVyebxb+EUFo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
        nqGxeayVkamSvp1NSmpOZllqkb5dgl7Gw5kzmAuaZSqmHLrD2MA4V6yLkYNDQsBEYtLtmC5G
        Lg4hgaWMEi86ljB3MXICxWUk5p3tY4OwhSX+XOtigyj6xCjx6N9xsASbgKnE7buf2EAGiQgo
        SMz7qgNSwyzQxSwx40kHWI2wgLXE2t7ZjCA2i4CqROet52BxXgF3iQPXPrBCLJCTuHmuE2wx
        p4CHxPs/s9hBbCGgmi1TZzBOYORbwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzDAtx37
        uWUHY9e74EOMAhyMSjy8PxbNjxZiTSwrrsw9xCjBwawkwsvMBxTiTUmsrEotyo8vKs1JLT7E
        aAp01ERmKdHkfGD05ZXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRq
        YLS8+KHuh3Hc6v/G0ltjfun/UbW9HGi/Jnmrw8fdIolF3see3d6iN2t30Tv7X+c4dY80tFfa
        cju92RPfND1/u+o5O///TckRC2+un5G8X7HGk/n/Jc8X99ZINAbr54tImEg8XGH2cPbaRg3B
        GE3zbBGFPfdMVi5k+7whPH3K1RP+tYpWr7LClimxFGckGmoxFxUnAgDkmwJBhgIAAA==
Message-Id: <20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02~VOIkhD_S60202502025eucas1p1F@eucas1p1.samsung.com>
X-CMS-MailID: 20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02
References: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifications in s5p-sss.c:
- remove unnecessary 'goto' statements (making code shorter),
- change uint_8 and uint_32 to u8 and u32 types (for consistency in the
driver and making code shorter),

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/crypto/s5p-sss.c | 54 +++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index b7216935236f..ba8f2e2ea88f 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -249,8 +249,8 @@ struct s5p_aes_reqctx {
 struct s5p_aes_ctx {
 	struct s5p_aes_dev		*dev;
 
-	uint8_t				aes_key[AES_MAX_KEY_SIZE];
-	uint8_t				nonce[CTR_RFC3686_NONCE_SIZE];
+	u8				aes_key[AES_MAX_KEY_SIZE];
+	u8				nonce[CTR_RFC3686_NONCE_SIZE];
 	int				keylen;
 };
 
@@ -518,46 +518,28 @@ static int s5p_make_sg_cpy(struct s5p_aes_dev *dev, struct scatterlist *src,
 
 static int s5p_set_outdata(struct s5p_aes_dev *dev, struct scatterlist *sg)
 {
-	int err;
-
-	if (!sg->length) {
-		err = -EINVAL;
-		goto exit;
-	}
+	if (!sg->length)
+		return -EINVAL;
 
-	err = dma_map_sg(dev->dev, sg, 1, DMA_FROM_DEVICE);
-	if (!err) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	if (!dma_map_sg(dev->dev, sg, 1, DMA_FROM_DEVICE))
+		return -ENOMEM;
 
 	dev->sg_dst = sg;
-	err = 0;
 
-exit:
-	return err;
+	return 0;
 }
 
 static int s5p_set_indata(struct s5p_aes_dev *dev, struct scatterlist *sg)
 {
-	int err;
-
-	if (!sg->length) {
-		err = -EINVAL;
-		goto exit;
-	}
+	if (!sg->length)
+		return -EINVAL;
 
-	err = dma_map_sg(dev->dev, sg, 1, DMA_TO_DEVICE);
-	if (!err) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	if (!dma_map_sg(dev->dev, sg, 1, DMA_TO_DEVICE))
+		return -ENOMEM;
 
 	dev->sg_src = sg;
-	err = 0;
 
-exit:
-	return err;
+	return 0;
 }
 
 /*
@@ -662,8 +644,7 @@ static irqreturn_t s5p_aes_interrupt(int irq, void *dev_id)
 	bool tx_end = false;
 	bool hx_end = false;
 	unsigned long flags;
-	uint32_t status;
-	u32 st_bits;
+	u32 status, st_bits;
 	int err;
 
 	spin_lock_irqsave(&dev->lock, flags);
@@ -1832,7 +1813,7 @@ static struct ahash_alg algs_sha1_md5_sha256[] = {
 };
 
 static void s5p_set_aes(struct s5p_aes_dev *dev,
-			const uint8_t *key, const uint8_t *iv,
+			const u8 *key, const u8 *iv,
 			unsigned int keylen)
 {
 	void __iomem *keystart;
@@ -1918,7 +1899,7 @@ static int s5p_set_outdata_start(struct s5p_aes_dev *dev,
 static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 {
 	struct ablkcipher_request *req = dev->req;
-	uint32_t aes_control;
+	u32 aes_control;
 	unsigned long flags;
 	int err;
 	u8 *iv;
@@ -2026,7 +2007,7 @@ static int s5p_aes_handle_req(struct s5p_aes_dev *dev,
 	err = ablkcipher_enqueue_request(&dev->queue, req);
 	if (dev->busy) {
 		spin_unlock_irqrestore(&dev->lock, flags);
-		goto exit;
+		return err;
 	}
 	dev->busy = true;
 
@@ -2034,7 +2015,6 @@ static int s5p_aes_handle_req(struct s5p_aes_dev *dev,
 
 	tasklet_schedule(&dev->tasklet);
 
-exit:
 	return err;
 }
 
@@ -2056,7 +2036,7 @@ static int s5p_aes_crypt(struct ablkcipher_request *req, unsigned long mode)
 }
 
 static int s5p_aes_setkey(struct crypto_ablkcipher *cipher,
-			  const uint8_t *key, unsigned int keylen)
+			  const u8 *key, unsigned int keylen)
 {
 	struct crypto_tfm *tfm = crypto_ablkcipher_tfm(cipher);
 	struct s5p_aes_ctx *ctx = crypto_tfm_ctx(tfm);
-- 
2.7.4

