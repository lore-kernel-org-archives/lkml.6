Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A14C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AAF2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078913;
	bh=jByCJgUhclthDZ7gBW6dmMCw5LuqJW0hSmkJBj7/h6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wwfSGS3G2PDdrAHSKYnCQ3PGl4nTGlsi/I9gXAiRFFGtDV5u92062doG6+Cf8jxQY
	 DrZiM9pLFmzpDrSnupkVSnH7LwD6tbW1ES50e7Q2RTRb11IqXgzX2HV598e4tPWq+R
	 yVhbtaX019327LlI4M9F+tpuWNG4sp/GXzIHRLFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfAUNzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbfAUNzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3862084C;
        Mon, 21 Jan 2019 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078907;
        bh=jByCJgUhclthDZ7gBW6dmMCw5LuqJW0hSmkJBj7/h6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjuhHVBmppHOkWkJbDF9BDl6xc+gmO7CKikyof977dNOoaGMmoslBqrw5DHf2xyA4
         ZXb9VjyNKy5iUwvLmMwqbd+/Trejl4XjlffgYLTEPQwlwd359DgaGyY+Tf5z+9pXmt
         Nesr5CpQuvthaSUwkuTSverMitn+ZU6uHj7eLia8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 25/51] crypto: talitos - reorder code in talitos_edesc_alloc()
Date:   Mon, 21 Jan 2019 14:44:21 +0100
Message-Id: <20190121122455.872228298@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit c56c2e173773097a248fd3bace91ac8f6fc5386d upstream.

This patch moves the mapping of IV after the kmalloc(). This
avoids having to unmap in case kmalloc() fails.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |   26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1347,23 +1347,18 @@ static struct talitos_edesc *talitos_ede
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
 	int max_len = is_sec1 ? TALITOS1_MAX_DATA_LEN : TALITOS2_MAX_DATA_LEN;
-	void *err;
 
 	if (cryptlen + authsize > max_len) {
 		dev_err(dev, "length exceeds h/w max limit\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (ivsize)
-		iv_dma = dma_map_single(dev, iv, ivsize, DMA_TO_DEVICE);
-
 	if (!dst || dst == src) {
 		src_len = assoclen + cryptlen + authsize;
 		src_nents = sg_nents_for_len(src, src_len);
 		if (src_nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
+			return ERR_PTR(-EINVAL);
 		}
 		src_nents = (src_nents == 1) ? 0 : src_nents;
 		dst_nents = dst ? src_nents : 0;
@@ -1373,16 +1368,14 @@ static struct talitos_edesc *talitos_ede
 		src_nents = sg_nents_for_len(src, src_len);
 		if (src_nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
+			return ERR_PTR(-EINVAL);
 		}
 		src_nents = (src_nents == 1) ? 0 : src_nents;
 		dst_len = assoclen + cryptlen + (encrypt ? authsize : 0);
 		dst_nents = sg_nents_for_len(dst, dst_len);
 		if (dst_nents < 0) {
 			dev_err(dev, "Invalid number of dst SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
+			return ERR_PTR(-EINVAL);
 		}
 		dst_nents = (dst_nents == 1) ? 0 : dst_nents;
 	}
@@ -1407,11 +1400,10 @@ static struct talitos_edesc *talitos_ede
 	}
 
 	edesc = kmalloc(alloc_len, GFP_DMA | flags);
-	if (!edesc) {
-		dev_err(dev, "could not allocate edescriptor\n");
-		err = ERR_PTR(-ENOMEM);
-		goto error_sg;
-	}
+	if (!edesc)
+		return ERR_PTR(-ENOMEM);
+	if (ivsize)
+		iv_dma = dma_map_single(dev, iv, ivsize, DMA_TO_DEVICE);
 
 	edesc->src_nents = src_nents;
 	edesc->dst_nents = dst_nents;
@@ -1423,10 +1415,6 @@ static struct talitos_edesc *talitos_ede
 						     DMA_BIDIRECTIONAL);
 
 	return edesc;
-error_sg:
-	if (iv_dma)
-		dma_unmap_single(dev, iv_dma, ivsize, DMA_TO_DEVICE);
-	return err;
 }
 
 static struct talitos_edesc *aead_edesc_alloc(struct aead_request *areq, u8 *iv,


