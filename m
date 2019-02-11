Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FCB21A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901237;
	bh=JHrtO8YYj9rEMaelhl0TXT4fFarwcLZvC0ec4gef+Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzD5DLFHrVP4+UjxS/AEs5JwA/CegUbGfivQPb9j/SvCOhVGL8rk57CARA6Kyzr47
	 wqLLjjaACE4i4smGk6782DIpwjHupDajcBu2ME6i0WFvzF/GJA6ju2amSRnJwl5rT9
	 cbbolx0KM/kJgGkRiBcykpwyRdVUSftx6AtlKUeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfBKQHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbfBKO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:26:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FFBA2075C;
        Mon, 11 Feb 2019 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895205;
        bh=JHrtO8YYj9rEMaelhl0TXT4fFarwcLZvC0ec4gef+Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlM1fYorNbT/xV9+ArdVhkytMeTXkRHCej0C3cLQQQMbVd6+sR40O9Xe4E5nHpoT5
         kXYZRS29CjdX9fZe+uS9izzojGZBFintDWG3OFN6PLash9Xuv/t2mFF57Z5g5y2nUk
         2Otv31L94BhVijdZcPqvrhGvicQOJ1H6/WM2R2Nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Long <eric.long@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 111/352] dmaengine: sprd: Support DMA link-list cyclic callback
Date:   Mon, 11 Feb 2019 15:15:38 +0100
Message-Id: <20190211141852.856303902@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



