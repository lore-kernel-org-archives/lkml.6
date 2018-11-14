Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9377FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A4D2252A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k84VjjAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A4D2252A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbeKOI3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388414AbeKOI3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:41 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E84B22527;
        Wed, 14 Nov 2018 22:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234276;
        bh=54X0huYgws1qZJGHf+qhnjRL5wthg+ddG7wM/J9Ati8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k84VjjASyVPE5XpV1VpWgNe+TMjIUEsnc/sEhlDIP9iWf4DcGIuS+mPdvgrbU8zc1
         Z6bf0gFFWVE9brU0vugQZsLhB2uRdBwTpqhrgrkw5mWvW025luLYIQ8Ggzk9/WFY4X
         7NyTOcwSSsYC8IiN67XLnH244HS9X8SiqparnthU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.18 38/59] nvme: make sure ns head inherits underlying device limits
Date:   Wed, 14 Nov 2018 17:23:10 -0500
Message-Id: <20181114222335.99339-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 8f676b8508c250bbe255096522fdefb73f1ea0b9 ]

Whenever we update ns_head info, we need to make sure it is still
compatible with all underlying backing devices because although nvme
multipath doesn't have any explicit use of these limits, other devices
can still be stacked on top of it which may rely on the underlying limits.
Start with unlimited stacking limits, and every info update iterate over
siblings and adjust queue limits.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c      | 4 +++-
 drivers/nvme/host/multipath.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bf65501e6ed6..33ec25db4f15 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1501,8 +1501,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->ndev)
 		nvme_nvm_update_nvm_info(ns);
 #ifdef CONFIG_NVME_MULTIPATH
-	if (ns->head->disk)
+	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
+		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+	}
 #endif
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1ffd3e8b13a1..20f5010ca7a2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -197,6 +197,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	/* set to a default value for 512 until disk is validated */
 	blk_queue_logical_block_size(q, 512);
+	blk_set_stacking_limits(&q->limits);
 
 	/* we need to propagate up the VMC settings */
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
-- 
2.17.1

