Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262AAC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F2A20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfAONnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:43:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50760 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbfAONnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:43:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A3EFA78;
        Tue, 15 Jan 2019 05:43:46 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEA853F70D;
        Tue, 15 Jan 2019 05:43:44 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     stable@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] crypto: ccree: unmap buffer before copying IV
Date:   Tue, 15 Jan 2019 15:43:15 +0200
Message-Id: <20190115134318.28712-6-gilad@benyossef.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115134318.28712-1-gilad@benyossef.com>
References: <20190115134318.28712-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were copying the last ciphertext block into the IV field
for CBC before removing the DMA mapping of the output buffer
with the result of the buffer sometime being out-of-sync cache
wise and were getting intermittent cases of bad output IV.

Fix it by moving the DMA buffer unmapping before the copy.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Fixes: 00904aa0cd59 ("crypto: ccree - fix iv handling")
Cc: <stable@vger.kernel.org>
---
 drivers/crypto/ccree/cc_cipher.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index cc92b031fad1..98ea53524250 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -652,6 +652,8 @@ static void cc_cipher_complete(struct device *dev, void *cc_req, int err)
 	unsigned int ivsize = crypto_skcipher_ivsize(sk_tfm);
 	unsigned int len;
 
+	cc_unmap_cipher_request(dev, req_ctx, ivsize, src, dst);
+
 	switch (ctx_p->cipher_mode) {
 	case DRV_CIPHER_CBC:
 		/*
@@ -681,7 +683,6 @@ static void cc_cipher_complete(struct device *dev, void *cc_req, int err)
 		break;
 	}
 
-	cc_unmap_cipher_request(dev, req_ctx, ivsize, src, dst);
 	kzfree(req_ctx->iv);
 
 	skcipher_request_complete(req, err);
-- 
2.20.1

