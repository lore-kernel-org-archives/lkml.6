Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0736C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E7F21B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196804;
	bh=U3yPzWgWowxtiSrQxiO2CaOREdGqbYLAx0buvaccRec=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G3+GWtKH9QjdHscEW1iuDKkf0Ud87dflvJuFIVDCIiYMYWzdXZglohSJQGpipUE9Q
	 rJicHRt+NrVqDQaAGpGrsgzcXiMcjUEck1rc5y+sygCmd1AEpf7Yx05/xF9Vy9Nlq9
	 O4dSbHnFucuf0KaFrawCtNlYmlZxRF98dl3fDP+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404688AbfBOCNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391373AbfBOCNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18AC21934;
        Fri, 15 Feb 2019 02:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196795;
        bh=U3yPzWgWowxtiSrQxiO2CaOREdGqbYLAx0buvaccRec=;
        h=From:To:Cc:Subject:Date:From;
        b=16yAvfI89akiXxiwPzhIJ1888UU3FTksyTQ0Aya4Fy0ZCZ90aU+w3C3xDtJjLumv/
         9HWi01LTUFcolV6O6hyOITz6b9vWtWJMnILFDCCnwX2qlj2d0Zjs/uKJbBVrGDnuw7
         Muc3KWcJ6I7aJdHQV2bDf8ymySxtubxtJfe9sv+w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Kristian H. Kristensen" <hoegsberg@gmail.com>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 01/40] drm/msm: Unblock writer if reader closes file
Date:   Thu, 14 Feb 2019 21:12:34 -0500
Message-Id: <20190215021313.178476-1-sashal@kernel.org>
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
index ec56794ad039..bdce1c9434c6 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -109,7 +109,9 @@ static void rd_write(struct msm_rd_state *rd, const void *buf, int sz)
 		char *fptr = &fifo->buf[fifo->head];
 		int n;
 
-		wait_event(rd->fifo_event, circ_space(&rd->fifo) > 0);
+		wait_event(rd->fifo_event, circ_space(&rd->fifo) > 0 || !rd->open);
+		if (!rd->open)
+			return;
 
 		/* Note that smp_load_acquire() is not strictly required
 		 * as CIRC_SPACE_TO_END() does not access the tail more
@@ -207,7 +209,10 @@ static int rd_open(struct inode *inode, struct file *file)
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

