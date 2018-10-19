Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42179C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C0221476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MsqXR+nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C0221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeJSIyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:54:36 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60788 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:54:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 31290CFA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 00:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TWiyg2I1mspt for <linux-kernel@vger.kernel.org>;
        Thu, 18 Oct 2018 19:50:56 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id F40EFCF5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 19:50:55 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id d10so2131954itk.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 17:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zzWkJBIjG10CwYiaDC6oWbOPZZktIa4pZ5ZuvqWSC/k=;
        b=MsqXR+nrwLeDnMIvJzGlIc5htPSdeQs/YE2yTGOZbbrVVM7Cv44p9tgUfwQVKN/PMi
         6tpOGEHc/Ji5poqXux/KMU5zmjI1Bt8utTLTRf+TghhmYlOn/EPVT6KsFDPBiR0ZhoWv
         qn5IqSqOIJX99NADzT+6Tr0EfsYoTZYyFdbLv6oW6jcpjD5d3NEVCren1mUT80vfZSlO
         wqidaDCW0joeJnEUli9EMoqzfwzJkRcR9uwssJHz+zewFiyRBz8cumzsXVqaWqseH/c1
         Z3rRXMtg75FELa3R+JRHC/rE3PuwpDq1YUJJi56y2/yt1ET/PSXH2jNbW7p9U8WJA+rX
         YttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zzWkJBIjG10CwYiaDC6oWbOPZZktIa4pZ5ZuvqWSC/k=;
        b=UVZnDDrG9TttVytKFRiwJ1Vxqs4VEqr3G+4d/cMokIN/T2Gn0b/bBKlBgwVeK+5qO+
         7K7c3DHGTo+OcmJEramnnOqhrGj+MyT6+Lm5EWw+FNd37t3XMYD8CHMDwmF8RfgRdp0D
         nNPRYX5X0aNXYE5qU6beCrFQuKpV7sQPdieQhKdWj680n0JHpYgVI9JD8/WG+nesKdW7
         mjxAToh9ScHK96JfDgehSfldDyBZSeWpctO8/dCtjvRGlPjW26A2ATB3QIQjYqjr8vmK
         CUDqq3BXrS7q0Vjz+6TuZW0NfEhXm593F5sA3CWCKoBbNUvyHyf7OV3o0MuILjQKSdcv
         AuYg==
X-Gm-Message-State: ABuFfohlo+dJDNgEn/Sxx1onvGXqeqHu4tciTh33AQsbwOyQ5ZuCxCPv
        C/5+lVD9yYyS5UTVvXOKRgBBFdyT6ddzr6ZdKkgr0EJ2W+DB0RD8z9dM2VSUSLBDpHTLdTKpQv5
        mSjliyzbpQWspN8w79fXxwuemPoom
X-Received: by 2002:a02:1089:: with SMTP id 131-v6mr26002154jay.116.1539910255639;
        Thu, 18 Oct 2018 17:50:55 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61mQLe2HHp50rJ2sSvMTeRSkG+idj4KGa+dTmDBjN9OpHEUrfzKU2ddkvT0xLp8DJUxgqujjA==
X-Received: by 2002:a02:1089:: with SMTP id 131-v6mr26002138jay.116.1539910255404;
        Thu, 18 Oct 2018 17:50:55 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id s14-v6sm445048ioj.71.2018.10.18.17.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 17:50:54 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Srikanth Jampala <Jampala.Srikanth@cavium.com>,
        Gadam Sreerama <sgadam@cavium.com>,
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] crypto: cavium/nitrox - fix a DMA pool free failure
Date:   Thu, 18 Oct 2018 19:50:43 -0500
Message-Id: <1539910247-9250-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In crypto_alloc_context(), a DMA pool is allocated through dma_pool_alloc()
to hold the crypto context. The meta data of the DMA pool, including the
pool used for the allocation 'ndev->ctx_pool' and the base address of the
DMA pool used by the device 'dma', are then stored to the beginning of the
pool. These meta data are eventually used in crypto_free_context() to free
the DMA pool through dma_pool_free(). However, given that the DMA pool can
also be accessed by the device, a malicious device can modify these meta
data, especially when the device is controlled to deploy an attack. This
can cause an unexpected DMA pool free failure.

To avoid the above issue, this patch introduces a new structure
crypto_ctx_hdr and a new field chdr in the structure nitrox_crypto_ctx hold
the meta data information of the DMA pool after the allocation. Note that
the original structure ctx_hdr is not changed to ensure the compatibility.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/crypto/cavium/nitrox/nitrox_algs.c | 12 +++++++-----
 drivers/crypto/cavium/nitrox/nitrox_lib.c  | 22 +++++++++++++++++-----
 drivers/crypto/cavium/nitrox/nitrox_req.h  |  7 +++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_algs.c b/drivers/crypto/cavium/nitrox/nitrox_algs.c
index 2ae6124..5d54ebc 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_algs.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_algs.c
@@ -73,7 +73,7 @@ static int flexi_aes_keylen(int keylen)
 static int nitrox_skcipher_init(struct crypto_skcipher *tfm)
 {
 	struct nitrox_crypto_ctx *nctx = crypto_skcipher_ctx(tfm);
-	void *fctx;
+	struct crypto_ctx_hdr *chdr;
 
 	/* get the first device */
 	nctx->ndev = nitrox_get_first_device();
@@ -81,12 +81,14 @@ static int nitrox_skcipher_init(struct crypto_skcipher *tfm)
 		return -ENODEV;
 
 	/* allocate nitrox crypto context */
-	fctx = crypto_alloc_context(nctx->ndev);
-	if (!fctx) {
+	chdr = crypto_alloc_context(nctx->ndev);
+	if (!chdr) {
 		nitrox_put_device(nctx->ndev);
 		return -ENOMEM;
 	}
-	nctx->u.ctx_handle = (uintptr_t)fctx;
+	nctx->chdr = chdr;
+	nctx->u.ctx_handle = (uintptr_t)((u8 *)chdr->vaddr +
+					 sizeof(struct ctx_hdr));
 	crypto_skcipher_set_reqsize(tfm, crypto_skcipher_reqsize(tfm) +
 				    sizeof(struct nitrox_kcrypt_request));
 	return 0;
@@ -102,7 +104,7 @@ static void nitrox_skcipher_exit(struct crypto_skcipher *tfm)
 
 		memset(&fctx->crypto, 0, sizeof(struct crypto_keys));
 		memset(&fctx->auth, 0, sizeof(struct auth_keys));
-		crypto_free_context((void *)fctx);
+		crypto_free_context((void *)nctx->chdr);
 	}
 	nitrox_put_device(nctx->ndev);
 
diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/cavium/nitrox/nitrox_lib.c
index 4d31df0..28baf1a 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
@@ -146,12 +146,19 @@ static void destroy_crypto_dma_pool(struct nitrox_device *ndev)
 void *crypto_alloc_context(struct nitrox_device *ndev)
 {
 	struct ctx_hdr *ctx;
+	struct crypto_ctx_hdr *chdr;
 	void *vaddr;
 	dma_addr_t dma;
 
+	chdr = kmalloc(sizeof(*chdr), GFP_KERNEL);
+	if (!chdr)
+		return NULL;
+
 	vaddr = dma_pool_alloc(ndev->ctx_pool, (GFP_KERNEL | __GFP_ZERO), &dma);
-	if (!vaddr)
+	if (!vaddr) {
+		kfree(chdr);
 		return NULL;
+	}
 
 	/* fill meta data */
 	ctx = vaddr;
@@ -159,7 +166,11 @@ void *crypto_alloc_context(struct nitrox_device *ndev)
 	ctx->dma = dma;
 	ctx->ctx_dma = dma + sizeof(struct ctx_hdr);
 
-	return ((u8 *)vaddr + sizeof(struct ctx_hdr));
+	chdr->pool = ndev->ctx_pool;
+	chdr->dma = dma;
+	chdr->vaddr = vaddr;
+
+	return chdr;
 }
 
 /**
@@ -168,13 +179,14 @@ void *crypto_alloc_context(struct nitrox_device *ndev)
  */
 void crypto_free_context(void *ctx)
 {
-	struct ctx_hdr *ctxp;
+	struct crypto_ctx_hdr *ctxp;
 
 	if (!ctx)
 		return;
 
-	ctxp = (struct ctx_hdr *)((u8 *)ctx - sizeof(struct ctx_hdr));
-	dma_pool_free(ctxp->pool, ctxp, ctxp->dma);
+	ctxp = ctx;
+	dma_pool_free(ctxp->pool, ctxp->vaddr, ctxp->dma);
+	kfree(ctxp);
 }
 
 /**
diff --git a/drivers/crypto/cavium/nitrox/nitrox_req.h b/drivers/crypto/cavium/nitrox/nitrox_req.h
index d091b6f..19f0a20 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_req.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_req.h
@@ -181,12 +181,19 @@ struct flexi_crypto_context {
 	struct auth_keys auth;
 };
 
+struct crypto_ctx_hdr {
+	struct dma_pool *pool;
+	dma_addr_t dma;
+	void *vaddr;
+};
+
 struct nitrox_crypto_ctx {
 	struct nitrox_device *ndev;
 	union {
 		u64 ctx_handle;
 		struct flexi_crypto_context *fctx;
 	} u;
+	struct crypto_ctx_hdr *chdr;
 };
 
 struct nitrox_kcrypt_request {
-- 
2.7.4

