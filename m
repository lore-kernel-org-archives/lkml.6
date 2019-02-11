Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DA8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CD8222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897610;
	bh=CI9GKCcxjrPAuZ6+ooK2LiOsvQnhyM+CYMIvLVghP9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q2dGJflgkTsQyL24f5evRulbT0McGh1N7AgA7XSE61f5RAoyCki8OLESaQ40UEps9
	 gyNHq0AyCyQode0lyS0lvPJmUq8YuY74U1fM+kPzRJbadTCnZrCvPksY2NJnsTXnI7
	 w5SK6a1XpXDvy/yDYv+W3b5h/hC+lpOPETOnlQjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391264AbfBKPGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390135AbfBKPGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:06:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FCC222A7;
        Mon, 11 Feb 2019 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897607;
        bh=CI9GKCcxjrPAuZ6+ooK2LiOsvQnhyM+CYMIvLVghP9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBlB4OI7VK2+IMWP7blPnO05G1jYQMLJM3tlKjcte1VhXeCKki/eD3IvfzaQLowNk
         hxlNmYfujL11vWuq0hdwBG5+eZUPqAt5I3fe4/qtzPGKUgOgRY8P8r8gyGmNzVAp+F
         NMFPVXeQbxmDliNAGNYjSuFw3Fz60WpES3+XtBJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 046/137] iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer
Date:   Mon, 11 Feb 2019 15:18:47 +0100
Message-Id: <20190211141816.238572830@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



