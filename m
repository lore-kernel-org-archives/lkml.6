Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7A7C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9512147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690552;
	bh=MSvf88kmXo26yv2W6D94DPW+7n7vYDwa5+p4K7eKKb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2otvbS8RdNVCzkykUkqBxWSrD2Vte2v42p3y+GghVnQ9NJyPYGtIJLwo/vkaV23a5
	 vkq8+JauJb/+315Yoafp8a82RXLUM7KcBSoCBrIUtaEEbky58MmqK4aoqiyn57l23C
	 XqhMHEUoQ/Z+Alip7xU4+Gg/rAVSXjyu8v8yWxZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfA1PtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbfA1PtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82C52147A;
        Mon, 28 Jan 2019 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690547;
        bh=MSvf88kmXo26yv2W6D94DPW+7n7vYDwa5+p4K7eKKb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ft+b8B6J+76YwirVnP+DRwdeOKaV5sXX3gIJBvYd8BYFj4enMg8yzNBHHbDKIzSUt
         1UpBFk655i6YAZO3TotV6TVy93JTKcC9yCkT5LztXsWQknnnTt4LWssgZvCAmmKH2Q
         lc9gtM2RkSELDNktslat6SQ0sTywlnYko7LfyzQE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Long <eric.long@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 120/304] dmaengine: sprd: Support DMA link-list cyclic callback
Date:   Mon, 28 Jan 2019 10:40:37 -0500
Message-Id: <20190128154341.47195-120-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

[ Upstream commit 97dbd6ea02beb3a7027c158e0a110b5095268d59 ]

The Spreadtrum DMA link-list mode is always one cyclic transfer,
so we should clear the SPRD_DMA_LLIST_END flag for the link-list
configuration. Moreover add cyclic callback support for the cyclic
transfer.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sprd-dma.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 38d4e4f07c66..f7da9ab31b7c 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -450,7 +450,7 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
 	struct sprd_dma_desc *sdesc;
 	enum sprd_dma_req_mode req_type;
 	enum sprd_dma_int_type int_type;
-	bool trans_done = false;
+	bool trans_done = false, cyclic = false;
 	u32 i;
 
 	while (irq_status) {
@@ -465,13 +465,19 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
 
 		sdesc = schan->cur_desc;
 
-		/* Check if the dma request descriptor is done. */
-		trans_done = sprd_dma_check_trans_done(sdesc, int_type,
-						       req_type);
-		if (trans_done == true) {
-			vchan_cookie_complete(&sdesc->vd);
-			schan->cur_desc = NULL;
-			sprd_dma_start(schan);
+		/* cyclic mode schedule callback */
+		cyclic = schan->linklist.phy_addr ? true : false;
+		if (cyclic == true) {
+			vchan_cyclic_callback(&sdesc->vd);
+		} else {
+			/* Check if the dma request descriptor is done. */
+			trans_done = sprd_dma_check_trans_done(sdesc, int_type,
+							       req_type);
+			if (trans_done == true) {
+				vchan_cookie_complete(&sdesc->vd);
+				schan->cur_desc = NULL;
+				sprd_dma_start(schan);
+			}
 		}
 		spin_unlock(&schan->vc.lock);
 	}
@@ -674,9 +680,6 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 
 	/* link-list configuration */
 	if (schan->linklist.phy_addr) {
-		if (sg_index == sglen - 1)
-			hw->frg_len |= SPRD_DMA_LLIST_END;
-
 		hw->cfg |= SPRD_DMA_LINKLIST_EN;
 
 		/* link-list index */
-- 
2.19.1

