Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1400CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F5C2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F5C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbeGTNOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbeGTNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:49 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4CB7541C;
        Fri, 20 Jul 2018 12:26:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Lamparter <chunkeey@googlemail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 11/31] crypto: crypto4xx - fix crypto4xx_build_pdr, crypto4xx_build_sdr leak
Date:   Fri, 20 Jul 2018 14:13:41 +0200
Message-Id: <20180720121340.561389616@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@googlemail.com>

commit 5d59ad6eea82ef8df92b4109615a0dde9d8093e9 upstream.

If one of the later memory allocations in rypto4xx_build_pdr()
fails: dev->pdr (and/or) dev->pdr_uinfo wouldn't be freed.

crypto4xx_build_sdr() has the same issue with dev->sdr.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/amcc/crypto4xx_core.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -207,7 +207,7 @@ static u32 crypto4xx_build_pdr(struct cr
 				  dev->pdr_pa);
 		return -ENOMEM;
 	}
-	memset(dev->pdr, 0,  sizeof(struct ce_pd) * PPC4XX_NUM_PD);
+	memset(dev->pdr, 0, sizeof(struct ce_pd) * PPC4XX_NUM_PD);
 	dev->shadow_sa_pool = dma_alloc_coherent(dev->core_dev->device,
 				   256 * PPC4XX_NUM_PD,
 				   &dev->shadow_sa_pool_pa,
@@ -240,13 +240,15 @@ static u32 crypto4xx_build_pdr(struct cr
 
 static void crypto4xx_destroy_pdr(struct crypto4xx_device *dev)
 {
-	if (dev->pdr != NULL)
+	if (dev->pdr)
 		dma_free_coherent(dev->core_dev->device,
 				  sizeof(struct ce_pd) * PPC4XX_NUM_PD,
 				  dev->pdr, dev->pdr_pa);
+
 	if (dev->shadow_sa_pool)
 		dma_free_coherent(dev->core_dev->device, 256 * PPC4XX_NUM_PD,
 				  dev->shadow_sa_pool, dev->shadow_sa_pool_pa);
+
 	if (dev->shadow_sr_pool)
 		dma_free_coherent(dev->core_dev->device,
 			sizeof(struct sa_state_record) * PPC4XX_NUM_PD,
@@ -416,12 +418,12 @@ static u32 crypto4xx_build_sdr(struct cr
 
 static void crypto4xx_destroy_sdr(struct crypto4xx_device *dev)
 {
-	if (dev->sdr != NULL)
+	if (dev->sdr)
 		dma_free_coherent(dev->core_dev->device,
 				  sizeof(struct ce_sd) * PPC4XX_NUM_SD,
 				  dev->sdr, dev->sdr_pa);
 
-	if (dev->scatter_buffer_va != NULL)
+	if (dev->scatter_buffer_va)
 		dma_free_coherent(dev->core_dev->device,
 				  dev->scatter_buffer_size * PPC4XX_NUM_SD,
 				  dev->scatter_buffer_va,
@@ -1186,7 +1188,7 @@ static int crypto4xx_probe(struct platfo
 
 	rc = crypto4xx_build_gdr(core_dev->dev);
 	if (rc)
-		goto err_build_gdr;
+		goto err_build_pdr;
 
 	rc = crypto4xx_build_sdr(core_dev->dev);
 	if (rc)
@@ -1228,12 +1230,11 @@ err_iomap:
 err_request_irq:
 	irq_dispose_mapping(core_dev->irq);
 	tasklet_kill(&core_dev->tasklet);
-	crypto4xx_destroy_sdr(core_dev->dev);
 err_build_sdr:
+	crypto4xx_destroy_sdr(core_dev->dev);
 	crypto4xx_destroy_gdr(core_dev->dev);
-err_build_gdr:
-	crypto4xx_destroy_pdr(core_dev->dev);
 err_build_pdr:
+	crypto4xx_destroy_pdr(core_dev->dev);
 	kfree(core_dev->dev);
 err_alloc_dev:
 	kfree(core_dev);


