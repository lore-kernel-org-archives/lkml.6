Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B9CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2351F2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896307;
	bh=FGZl8Gdg1xRclhY3G8IQYOu/wCJ1IQmsdj7S9Lug3xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ydBWJrH0mYn9/1ccMYM4tfFkWgnUpOV61Yg5oDEf924ogFiK5UG2TWM2iXDiiH52+
	 e5A9LdcDdekyezkH1xLX11b+uHMJAcvWGXxoZ9IdQJNmBPHCL1mmUMyWE2NAaDV+Cy
	 VNSiOMJSpXudflQru5UiTWgBEdFcaO2qc0mIB0D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbfBKOpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732535AbfBKOpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E628120700;
        Mon, 11 Feb 2019 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896303;
        bh=FGZl8Gdg1xRclhY3G8IQYOu/wCJ1IQmsdj7S9Lug3xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z5shfQzKEWlW6PGiGvTG9e1SXYE94zYY4ey9ELnryBrHsr1uBcF4MMn2QOSxih7Cm
         rDVb3FXUujUXxYesYjfAVbD+Ls+rw7reVws60Is6UBvxqJqFJPbxGo6Xob1RSJZx1T
         6dQCzd41s4GHsSotOO9H6naIEKxYbd5kLCqSDK8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 122/313] iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer
Date:   Mon, 11 Feb 2019 15:16:42 +0100
Message-Id: <20190211141901.950644337@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
index 4afb9cb99ea3..9ae3678844eb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -688,7 +688,13 @@ static void queue_inc_cons(struct arm_smmu_queue *q)
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



