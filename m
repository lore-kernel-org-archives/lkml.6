Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0E121904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497871;
	bh=hrone2WqInClRJmpVN4wZ9HDvXz0sboI3ZEXuhqx0Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wz3RwAO4sI31W2BNlE0e8XPHoVQbDsF7kJ9pPmc/2bG19JiR96RFIe9sWIoNHbGhA
	 xEbj23ipOMcXD13I2/3Mcd+9c/m6tSS1dv5HiTUjJ5lyiqkggY8bzsGp8zvuSsMxB+
	 4/Cb3LxjUOxEVxOQnuYDgkQrVlm1FrfaDim3BpqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfBRNvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732088AbfBRNvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:51:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC14720449;
        Mon, 18 Feb 2019 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497866;
        bh=hrone2WqInClRJmpVN4wZ9HDvXz0sboI3ZEXuhqx0Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PKOom14fJjuZUbxaRaBA06IczLSm0/On2IKeVdbjAT6Qnosn377+cabYE7KPzQus
         oQDzUF59JGOkcI28KE9emfA5axq/Za0lAOgrgxVtZJTV/HT55vDkzrrD6p+lymkCyC
         l/bXO/tf/5mA0uUFkc0IphxReH8/daSVEWKSqGOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hongbo Yao <yaohongbo@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/85] nvme-pci: fix out of bounds access in nvme_cqe_pending
Date:   Mon, 18 Feb 2019 14:43:01 +0100
Message-Id: <20190218133503.679442052@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



