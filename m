Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C3C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8ED2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501251;
	bh=OfJ+lcQcqPZ6jmLvp9uYhnCoYwIruvVu6EdRU9P50pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zLSG1ayUl0lfzcJPKSiJAw4GD+sPHw7H4eI6UsKYS3BnSpoyo50Bw3T7dctSUFoZB
	 iow6R58zsAfGBduGEYTTxWKwB8VCs7LziKG3UEWu+/nQzYhia/gxRo6SVjRnHL/ep7
	 G1/bM4a6b2sHvt2LL42roT/OQCmDxDw8mfbrI1L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfBROr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731420AbfBRNpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46942218FC;
        Mon, 18 Feb 2019 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497545;
        bh=OfJ+lcQcqPZ6jmLvp9uYhnCoYwIruvVu6EdRU9P50pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhWMlc4Ugcol3owg/fg0nDsXUswabqgpDAZzulTFolTpBdJagAzAmGlTKUwbscwOC
         EgmUKA/FmVYtvgIHdRBdUR/Uyjc8K62OrPEx3kT04svke0tghwSqqn5FgPMOuTUUYt
         tgN2kEQzk7fC0sqpwx0tKLuh1go+YHPFWeV3PCQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hongbo Yao <yaohongbo@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 25/92] nvme-pci: fix out of bounds access in nvme_cqe_pending
Date:   Mon, 18 Feb 2019 14:42:28 +0100
Message-Id: <20190218133457.073670440@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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
index 0f45868e8af9..47597046c14f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -913,9 +913,11 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
 
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



