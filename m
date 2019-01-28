Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD32C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A672084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694065;
	bh=oPGNJQfkbesL5fXZUHy+10SL0znJPCG3AzVSpnwC4mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sqei3zAJ0awjLF/Pc60AyiDCn9z8MgRKYJFuPQuJcP5icvjLmNQkycsbgOksTK7Rk
	 l4IzWxW2wytDbo+S2Rxb+TxKqMdBwCT82qS6MpJG+nIO+XEN4cHtPlpe7MpSowX1tY
	 WazoqCmGYITYEioJY5dOKNHkUpBbj+qeczpq0nuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbfA1Qrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:47:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389134AbfA1QWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD7012147A;
        Mon, 28 Jan 2019 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692522;
        bh=oPGNJQfkbesL5fXZUHy+10SL0znJPCG3AzVSpnwC4mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsR3rhnZyh/3cIqIVJUJUaga/s5iOv9RuG2NQ1jGB5rPR/UMFzNWpMrydlZzOcT9q
         Os9vAQKFCAt/MMTdy2Q3yv8PUisJ1LxJg9XN9OcRqeMCdYAPsUqe0OtQzuIzogu35/
         eBjqdvJRiYdpCLKdnP+T50eFnh8rZkHOP7gs54WU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 049/107] iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer
Date:   Mon, 28 Jan 2019 11:18:49 -0500
Message-Id: <20190128161947.57405-49-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit a868e8530441286342f90c1fd9c5f24de3aa2880 ]

After removing an entry from a queue (e.g. reading an event in
arm_smmu_evtq_thread()) it is necessary to advance the MMIO consumer
pointer to free the queue slot back to the SMMU. A memory barrier is
required here so that all reads targetting the queue entry have
completed before the consumer pointer is updated.

The implementation of queue_inc_cons() relies on a writel() to complete
the previous reads, but this is incorrect because writel() is only
guaranteed to complete prior writes. This patch replaces the call to
writel() with an mb(); writel_relaxed() sequence, which gives us the
read->write ordering which we require.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ff4be1174ff0..7bd98585d78d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -697,7 +697,13 @@ static void queue_inc_cons(struct arm_smmu_queue *q)
 	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
 
 	q->cons = Q_OVF(q, q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
-	writel(q->cons, q->cons_reg);
+
+	/*
+	 * Ensure that all CPU accesses (reads and writes) to the queue
+	 * are complete before we update the cons pointer.
+	 */
+	mb();
+	writel_relaxed(q->cons, q->cons_reg);
 }
 
 static int queue_sync_prod(struct arm_smmu_queue *q)
-- 
2.19.1

