Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F253C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C3020821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738154;
	bh=WNmwQzlrVzbsoE9MjBNEWMfZNPbG3paqjmHW6U9+RFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TZ869gWGYtq9qmDsNYzgKxRKQNZjEzQnV0vY5PnoJAwPLKiuK+0sN9I0PHZKaUTQp
	 RAJWL3mMK5WVBiDYn9r/Nhmwi1uIUHwxCNSz0A5cjZq6vKbCxgcSSXC/tgHA/Kb1bC
	 qthxDP4uMddQ9WY6y6Bq+kyeV2Fk9oTtZ691QZ5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBIStM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbfBIStI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5918E21919;
        Sat,  9 Feb 2019 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738148;
        bh=WNmwQzlrVzbsoE9MjBNEWMfZNPbG3paqjmHW6U9+RFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCH7Bafx/rplKAo78PqC7hwbNWEnSIN0lFeqAGNXqysBd+6UzassMXTM5kD0xNd0d
         /5Hns6a6CtiAMGs9puaElgNWVVHgGEyRTLW8h0XvXmSDe6bIiguTJcw7IpzqOmCkqG
         udIpp/+DGtCqFkMs6Eypyt1i4YnzeRe11AHM8nX0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 16/28] nvme-multipath: zero out ANA log buffer
Date:   Sat,  9 Feb 2019 13:48:24 -0500
Message-Id: <20190209184840.126418-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
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
index c27af277e14e..815509dbed84 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -556,6 +556,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return 0;
 out_free_ana_log_buf:
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 out:
 	return error;
 }
@@ -563,5 +564,6 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
 	kfree(ctrl->ana_log_buf);
+	ctrl->ana_log_buf = NULL;
 }
 
-- 
2.19.1

