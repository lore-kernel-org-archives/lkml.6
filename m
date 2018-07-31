Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1B3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DA320857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DA320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeGaSnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:43:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59577 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732074AbeGaSnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:43:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4AD8ECB9C7BC5;
        Wed,  1 Aug 2018 01:02:02 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 01:01:58 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <borisp@mellanox.com>, <aviadye@mellanox.com>,
        <davejwatson@fb.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/tls: Use kmemdup to simplify the code
Date:   Wed, 1 Aug 2018 00:50:24 +0800
Message-ID: <1533055824-36976-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemdup is better than kmalloc+memcpy. So replace them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/tls/tls_device.c | 3 +--
 net/tls/tls_sw.c     | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 1e968d2..292742e 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -716,12 +716,11 @@ int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
 	memcpy(ctx->tx.iv + TLS_CIPHER_AES_GCM_128_SALT_SIZE, iv, iv_size);
 
 	ctx->tx.rec_seq_size = rec_seq_size;
-	ctx->tx.rec_seq = kmalloc(rec_seq_size, GFP_KERNEL);
+	ctx->tx.rec_seq = kmemdup(rec_seq, rec_seq_size, GFP_KERNEL);
 	if (!ctx->tx.rec_seq) {
 		rc = -ENOMEM;
 		goto free_iv;
 	}
-	memcpy(ctx->tx.rec_seq, rec_seq, rec_seq_size);
 
 	rc = tls_sw_fallback_init(sk, offload_ctx, crypto_info);
 	if (rc)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 33838f1..ff3a690 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1173,12 +1173,11 @@ int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
 	memcpy(cctx->iv, gcm_128_info->salt, TLS_CIPHER_AES_GCM_128_SALT_SIZE);
 	memcpy(cctx->iv + TLS_CIPHER_AES_GCM_128_SALT_SIZE, iv, iv_size);
 	cctx->rec_seq_size = rec_seq_size;
-	cctx->rec_seq = kmalloc(rec_seq_size, GFP_KERNEL);
+	cctx->rec_seq = kmemdup(rec_seq, rec_seq_size, GFP_KERNEL);
 	if (!cctx->rec_seq) {
 		rc = -ENOMEM;
 		goto free_iv;
 	}
-	memcpy(cctx->rec_seq, rec_seq, rec_seq_size);
 
 	if (sw_ctx_tx) {
 		sg_init_table(sw_ctx_tx->sg_encrypted_data,
-- 
1.7.12.4

