Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A17EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4416121927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198229;
	bh=2flhbers7AKAxiXeNOxNrn0Yimkyb3qPfSEZA4IiV+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tcOReg5TniY+A/Yyn84l9jgRV4W79vu567b5QPWnNR7NkuRd8EKyPhEv3kRaFzTfc
	 a7RVKJZIToC2bRBumhmSfkExEQP1WX++KanBASbuYH66My7PCumlA1rtjhdEIzqwGK
	 nrpM33NZHzr+lSfUfvpvG98C6G3WP92kqpLBgsfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbfBOChH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:37:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390627AbfBOCKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D28222D7;
        Fri, 15 Feb 2019 02:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196636;
        bh=2flhbers7AKAxiXeNOxNrn0Yimkyb3qPfSEZA4IiV+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzmuUuJNLiURWFbNH/P4gVu9xERjdP46yL4cJqNc/+oDeChb2Wpqm6beWc8Qepu1r
         +QEaaxj+CWbgoTvzwXw4VIrnr21HNdq2JEe8r51UQI5HeIuKd42dcYD8twQ5TTF7Hq
         KH6gwK1xAvHymZ18bwlt9ZRTOn+CyLvXtg6h+ZjI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 61/77] nvme-multipath: drop optimization for static ANA group IDs
Date:   Thu, 14 Feb 2019 21:08:39 -0500
Message-Id: <20190215020855.176727-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
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
index 9901afd804ce..266bac07ed11 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -561,8 +561,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
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

