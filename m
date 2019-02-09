Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7424DC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E7C20643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738438;
	bh=IrMHOl6TfBZD6srGScgGuoDRDUm6QL4cBNKIhCye2aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XNdC/EL4Zxu0SXUhfKhXB1eO0BaJJMpraDoIog3zfQs7WaL2xLQxscxvDVjcT0RR7
	 y49g0rqhE1ns9WVat4tqOerpSV/xJvkS1qMtCv3psvC4AC6YNlv5nF5s4HbBXKZonS
	 uI1AWiT3jaaySssiI2gHlox+GtruMrkqN7oSzp7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfBIStK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbfBIStH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408DD21916;
        Sat,  9 Feb 2019 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738147;
        bh=IrMHOl6TfBZD6srGScgGuoDRDUm6QL4cBNKIhCye2aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1eTC3QIc7Re7xoV+CZhUAD/zFwUsePVZt7uCH3c9Yo5yIK47QAbZzxIo04H6KF0g/
         PxumdoubKP9HIxD7zAaeMgWGZ98CQ44bCTNygOJzqpYJszLq82TuTlFXrcKndkoAUm
         eaD6aRFnpLTHm6EIs9WnxGenNF2Sl9I7MnlaV9bc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hongbo Yao <yaohongbo@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 15/28] nvme-pci: fix out of bounds access in nvme_cqe_pending
Date:   Sat,  9 Feb 2019 13:48:23 -0500
Message-Id: <20190209184840.126418-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongbo Yao <yaohongbo@huawei.com>

[ Upstream commit dcca1662727220d18fa351097ddff33f95f516c5 ]

There is an out of bounds array access in nvme_cqe_peding().

When enable irq_thread for nvme interrupt, there is racing between the
nvmeq->cq_head updating and reading.

nvmeq->cq_head is updated in nvme_update_cq_head(), if nvmeq->cq_head
equals nvmeq->q_depth and before its value set to zero, nvme_cqe_pending()
uses its value as an array index, the index will be out of bounds.

Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
[hch: slight coding style update]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 40f76b4f08fc..f46313f441ec 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -908,9 +908,11 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	if (++nvmeq->cq_head == nvmeq->q_depth) {
+	if (nvmeq->cq_head == nvmeq->q_depth - 1) {
 		nvmeq->cq_head = 0;
 		nvmeq->cq_phase = !nvmeq->cq_phase;
+	} else {
+		nvmeq->cq_head++;
 	}
 }
 
-- 
2.19.1

