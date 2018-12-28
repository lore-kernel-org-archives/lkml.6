Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3A5C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B746B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeL1Gls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 01:41:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728615AbeL1Gls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 01:41:48 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E8F3341C4A1A9;
        Fri, 28 Dec 2018 14:41:44 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 28 Dec 2018
 14:41:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harsh@chelsio.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: chelsio - check set_msg_len overflow in generate_b0
Date:   Fri, 28 Dec 2018 14:41:00 +0800
Message-ID: <20181228064100.16876-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_msg_len may fails with -EOVERFLOW, It should be propagate
to upstream.

Fixes: 2debd3325e55 ("crypto: chcr - Add AEAD algos.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index bcef765..bdbdce9 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2762,7 +2762,7 @@ static int set_msg_len(u8 *block, unsigned int msglen, int csize)
 	return 0;
 }
 
-static void generate_b0(struct aead_request *req, u8 *ivptr,
+static int generate_b0(struct aead_request *req, u8 *ivptr,
 			unsigned short op_type)
 {
 	unsigned int l, lp, m;
@@ -2787,6 +2787,8 @@ static void generate_b0(struct aead_request *req, u8 *ivptr,
 	rc = set_msg_len(b0 + 16 - l,
 			 (op_type == CHCR_DECRYPT_OP) ?
 			 req->cryptlen - m : req->cryptlen, l);
+
+	return rc;
 }
 
 static inline int crypto_ccm_check_iv(const u8 *iv)
@@ -2821,7 +2823,7 @@ static int ccm_format_packet(struct aead_request *req,
 		*((unsigned short *)(reqctx->scratch_pad + 16)) =
 				htons(assoclen);
 
-	generate_b0(req, ivptr, op_type);
+	rc = generate_b0(req, ivptr, op_type);
 	/* zero the ctr value */
 	memset(ivptr + 15 - ivptr[0], 0, ivptr[0] + 1);
 	return rc;
-- 
2.7.0


