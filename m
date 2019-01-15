Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44594C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1762720651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfAONoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:44:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50736 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbfAONni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:43:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E5EBA78;
        Tue, 15 Jan 2019 05:43:38 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E3033F70D;
        Tue, 15 Jan 2019 05:43:36 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Hadar Gat <hadar.gat@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] crypto: ccree: add error message
Date:   Tue, 15 Jan 2019 15:43:12 +0200
Message-Id: <20190115134318.28712-3-gilad@benyossef.com>
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

Add error message in case of too many mlli entries.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_buffer_mgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index 32d2df36ced2..237a87a57830 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -156,8 +156,11 @@ static int cc_render_buff_to_mlli(struct device *dev, dma_addr_t buff_dma,
 
 	/* Verify there is no memory overflow*/
 	new_nents = (*curr_nents + buff_size / CC_MAX_MLLI_ENTRY_SIZE + 1);
-	if (new_nents > MAX_NUM_OF_TOTAL_MLLI_ENTRIES)
+	if (new_nents > MAX_NUM_OF_TOTAL_MLLI_ENTRIES) {
+		dev_err(dev, "Too many mlli entries. current %d max %d\n",
+			new_nents, MAX_NUM_OF_TOTAL_MLLI_ENTRIES);
 		return -ENOMEM;
+	}
 
 	/*handle buffer longer than 64 kbytes */
 	while (buff_size > CC_MAX_MLLI_ENTRY_SIZE) {
-- 
2.20.1

