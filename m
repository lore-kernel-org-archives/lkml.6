Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8065CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470C020840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197828;
	bh=GzkL0USozPtgPZE7i2JmzwzS2YjEpXKRWdhjCqO+tVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LlWsSQr+EUyZXNLQLExzNlwUf9v2A+PRBIW+iHi43XwNtvGqz1dcgCPA1F9acKulM
	 TWJQIsnwJVL9p9WJrSWakX5SkUD+Z+lS17/coXvqUeAGVFL/x0wreJpR6Bo1lyS56b
	 wg4jkPNzTf2xMmefsH8QlPxDYJbPnN7pTK5obP74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfBOCa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404454AbfBOCMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D59D21B68;
        Fri, 15 Feb 2019 02:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196765;
        bh=GzkL0USozPtgPZE7i2JmzwzS2YjEpXKRWdhjCqO+tVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vl18s16OdZT087d0pAw4DE+1qJrCLNTo94lMOD7zis3enY3IGBLOSMQcaEWKJoeLt
         OHFEdnOhe3K1hThLwfC9/mpsoNV3trS2KYN8hpkoCjnrWSUHUsFbVLbEtgr/ZyMSJI
         u9mXIaovZ6rMV/H6IyoIWzylmTtN7lrHxkYHIt94=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 53/65] nvme-multipath: drop optimization for static ANA group IDs
Date:   Thu, 14 Feb 2019 21:11:09 -0500
Message-Id: <20190215021121.177674-53-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 78a61cd42a64f3587862b372a79e1d6aaf131fd7 ]

Bit 6 in the ANACAP field is used to indicate that the ANA group ID
doesn't change while the namespace is attached to the controller.
There is an optimisation in the code to only allocate space
for the ANA group header, as the namespace list won't change and
hence would not need to be refreshed.
However, this optimisation was never carried over to the actual
workflow, which always assumes that the buffer is large enough
to hold the ANA header _and_ the namespace list.
So drop this optimisation and always allocate enough space.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c27af277e14e..65180cc1ba33 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -531,8 +531,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	ctrl->ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
 		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
-	if (!(ctrl->anacap & (1 << 6)))
-		ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
+	ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
 
 	if (ctrl->ana_log_size > ctrl->max_hw_sectors << SECTOR_SHIFT) {
 		dev_err(ctrl->device,
-- 
2.19.1

