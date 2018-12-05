Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BE3C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F75620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDu29oM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F75620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeLEJl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeLEJly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:54 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F012A2084C;
        Wed,  5 Dec 2018 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002913;
        bh=9mdOwFQ2YgAflfi4ARvhFVUpCmhM5VKHh0ktH4/P0Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDu29oM8KJwEEKz4WFTITTtSd0ps//K/PBkkOA7AGqBbSznQrDxtLTnFBv08bNSso
         4ag4n2FZeH4MIHRSFT06AFTaDRAremqcKLuTNJ1YWDhTGoHSI8r77wgxgInpATaGJX
         6m2D6JbK0y7jxaMil63mqpBxd4iCXiiuQw0frcYY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 110/123] nvme: flush namespace scanning work just before removing namespaces
Date:   Wed,  5 Dec 2018 04:35:42 -0500
Message-Id: <20181205093555.5386-110-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit f6c8e432cb0479255322c5d0335b9f1699a0270c ]

nvme_stop_ctrl can be called also for reset flow and there is no need to
flush the scan_work as namespaces are not being removed. This can cause
deadlock in rdma, fc and loop drivers since nvme_stop_ctrl barriers
before controller teardown (and specifically I/O cancellation of the
scan_work itself) takes place, but the scan_work will be blocked anyways
so there is no need to flush it.

Instead, move scan_work flush to nvme_remove_namespaces() where it really
needs to flush.

Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed by: James Smart <jsmart2021@gmail.com>
Tested-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0ba301f7e8b4..b7b2659e02fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3308,6 +3308,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(ns_list);
 
+	/* prevent racing with ns scanning */
+	flush_work(&ctrl->scan_work);
+
 	/*
 	 * The dead states indicates the controller was not gracefully
 	 * disconnected. In that case, we won't be able to flush any data while
@@ -3463,7 +3466,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
-	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
-- 
2.17.1

