Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE3DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5923720651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfAONnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:43:43 -0500
Received: from foss.arm.com ([217.140.101.70]:50746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbfAONnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:43:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F843A78;
        Tue, 15 Jan 2019 05:43:41 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905783F70D;
        Tue, 15 Jan 2019 05:43:39 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Hadar Gat <hadar.gat@arm.com>, stable@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] crypto: ccree: fix free of unallocated mlli buffer
Date:   Tue, 15 Jan 2019 15:43:13 +0200
Message-Id: <20190115134318.28712-4-gilad@benyossef.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115134318.28712-1-gilad@benyossef.com>
References: <20190115134318.28712-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hadar Gat <hadar.gat@arm.com>

In cc_unmap_aead_request(), call dma_pool_free() for mlli buffer only
if an item is allocated from the pool and not always if there is a
pool allocated.
This fixes a kernel panic when trying to free a non-allocated item.

Cc: stable@vger.kernel.org
Signed-off-by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_buffer_mgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index 237a87a57830..0ee1c52da0a4 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -614,10 +614,10 @@ void cc_unmap_aead_request(struct device *dev, struct aead_request *req)
 				 hw_iv_size, DMA_BIDIRECTIONAL);
 	}
 
-	/*In case a pool was set, a table was
-	 *allocated and should be released
-	 */
-	if (areq_ctx->mlli_params.curr_pool) {
+	/* Release pool */
+	if ((areq_ctx->assoc_buff_type == CC_DMA_BUF_MLLI ||
+	     areq_ctx->data_buff_type == CC_DMA_BUF_MLLI) &&
+	    (areq_ctx->mlli_params.mlli_virt_addr)) {
 		dev_dbg(dev, "free MLLI buffer: dma=%pad virt=%pK\n",
 			&areq_ctx->mlli_params.mlli_dma_addr,
 			areq_ctx->mlli_params.mlli_virt_addr);
-- 
2.20.1

