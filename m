Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2425C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715F620643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738593;
	bh=l5b9oeVKvvO/ON5fswllXO8ogbeNs033M5PTGo7XOT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=080Jz7GVsG22Mcoe3GKBFMbbgJc6zOwebXEqcTPkwUtByIH6PhBjlWS3KhugSyDoi
	 fWRrih3T2kFTn4fraJ5ZOOGpYu/9dDyJBLZ2EgJi2ZIIMJCLPNHKv/VBBFrdg8MJM7
	 7iezZQq98UhXAN7FcDgt0dnH+v/MR403UB24Q7C4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfBIS4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfBISsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9205D2192B;
        Sat,  9 Feb 2019 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738080;
        bh=l5b9oeVKvvO/ON5fswllXO8ogbeNs033M5PTGo7XOT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8ojkPS2l9CWnkiLPjNZkvYw6uwb6iX2/2C3DBHRd6Hm5jrswT1k/VGBIqc6VAH2O
         nwdRv3yeikLAuEhW9zvnremgz5I9D5CmK/L1NGBnLlHaHZQ33YYUHAuS6M4wYEv5Qe
         o9kFwDeiVRFGswas73/o1V4fZ8tQBkJ8xXwiJinc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 23/42] nvme-multipath: zero out ANA log buffer
Date:   Sat,  9 Feb 2019 13:47:15 -0500
Message-Id: <20190209184734.125935-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit c7055fd15ff46d92eb0dd1c16a4fe010d58224c8 ]

When nvme_init_identify() fails the ANA log buffer is deallocated
but _not_ set to NULL. This can cause double free oops when this
controller is deleted without ever being reconnected.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9901afd804ce..2b1d1f066efa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -586,6 +586,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return 0;
 out_free_ana_log_buf:
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 out:
 	return error;
 }
@@ -593,5 +594,6 @@ out:
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 }
 
-- 
2.19.1

