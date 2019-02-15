Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7169C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E088206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196688;
	bh=oEqDsEBYFU7gPlxJyLqO/IgFG6lXMm8lv23vUo97DsI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NfJXRfgiyiqBKEHX6y96ltk+BS2M5xu2cO3ll0tKbDDKGDB9wJIbheAuwewpEjiLC
	 /QdMYwYZr34IXh7ec7/CBEFgfxNTg9Ac/TGuJE/DStFpMuN2DYuBIXxsrGrFvz/zWD
	 5lPL1mVEd2zIiqdTXH/qG9i+PxGxpFDO5tyGykK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390734AbfBOCL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:11:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732273AbfBOCLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A3E206BA;
        Fri, 15 Feb 2019 02:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196683;
        bh=oEqDsEBYFU7gPlxJyLqO/IgFG6lXMm8lv23vUo97DsI=;
        h=From:To:Cc:Subject:Date:From;
        b=ZkWjWJfVnzST9KTDjckFiiqVYEBBxfp2EIRSIWAQdgFe0DyE/lcuWmQa1vLX7u6Nz
         rP8l+K7AyEFbwnTANz+Hi9U+ayxW49gyss78apo0B4bSBMoqp3rGxfNdXnIKj5VzlX
         okWdfiB0FwE5JxE4G7NJvXz0Hzy6Ya7UbPY5uPGI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Kristian H. Kristensen" <hoegsberg@gmail.com>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 01/65] drm/msm: Unblock writer if reader closes file
Date:   Thu, 14 Feb 2019 21:10:17 -0500
Message-Id: <20190215021121.177674-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kristian H. Kristensen" <hoegsberg@gmail.com>

[ Upstream commit 99c66bc051e7407fe0bf0607b142ec0be1a1d1dd ]

Prevents deadlock when fifo is full and reader closes file.

Signed-off-by: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_rd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index f7a0edea4705..d4cc5ceb22d0 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -115,7 +115,9 @@ static void rd_write(struct msm_rd_state *rd, const void *buf, int sz)
 		char *fptr = &fifo->buf[fifo->head];
 		int n;
 
-		wait_event(rd->fifo_event, circ_space(&rd->fifo) > 0);
+		wait_event(rd->fifo_event, circ_space(&rd->fifo) > 0 || !rd->open);
+		if (!rd->open)
+			return;
 
 		/* Note that smp_load_acquire() is not strictly required
 		 * as CIRC_SPACE_TO_END() does not access the tail more
@@ -213,7 +215,10 @@ static int rd_open(struct inode *inode, struct file *file)
 static int rd_release(struct inode *inode, struct file *file)
 {
 	struct msm_rd_state *rd = inode->i_private;
+
 	rd->open = false;
+	wake_up_all(&rd->fifo_event);
+
 	return 0;
 }
 
-- 
2.19.1

