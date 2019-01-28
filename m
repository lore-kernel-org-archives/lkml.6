Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16AAC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E1A21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690657;
	bh=Y78R8vEqZQlD+DAn50poZNsqLlkRvYVzVtoNCKKcoxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNyWeQMyTUodmon4csiILzgHGevFDYlnwaYGm6KVM7mpeyod4bnhM+FBU6QXAXC8Y
	 +uM2BhhOmeaXVOSLqZU70888PoWskCUCIAM20uPtPLwSzEg4LupO35d+GbN37i6x4U
	 Bcd/uvnJu/jyY58/m69UnajW1BNHvGUUd0uYJbnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfA1Pu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfA1Pux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:50:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE852177E;
        Mon, 28 Jan 2019 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690652;
        bh=Y78R8vEqZQlD+DAn50poZNsqLlkRvYVzVtoNCKKcoxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5byMabbZgnreagpmtPrESpO5AJOJPdegsDI7+2S9DWkVgiazct0Q97kvKAFaSDo9
         Bs+4q7N+YYsGdxlJsIVfIqLjRczY3FVbzc9CK93f9/R9FtNb3wp+yau7pclKmAvToj
         +k0OyV5LBLuzxe1ItJcWGN2NWqw8KUsNtpgcOX7E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.20 154/304] iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer
Date:   Mon, 28 Jan 2019 10:41:11 -0500
Message-Id: <20190128154341.47195-154-sashal@kernel.org>
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
index 62ef4afc9ee5..11f528e727a1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -679,7 +679,13 @@ static void queue_inc_cons(struct arm_smmu_queue *q)
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

