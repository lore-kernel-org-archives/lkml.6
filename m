Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AA7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C0920643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197242;
	bh=LdcnhN3ppJ952Lcr4o+LXP9lBUdJiMNefPLQv+qOfX0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nzWYgegSJ1fpWd8FkFxqHjWWNZ1X8XXGGCCdIdb0VrpBX4PVWOSkCFbDrS5eyX6co
	 k0oZfLvG3iObOB5jn1vjXwj5e9zsKJ1r1rdAsRfyz2mD4roga7GGsAIpJ9x+NsaeO9
	 LwKrCC3oH+4hYBW6n0uLPsDWgufeq+10ebi7jYPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfBOCUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:20:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405570AbfBOCPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:15:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDDE120643;
        Fri, 15 Feb 2019 02:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196914;
        bh=LdcnhN3ppJ952Lcr4o+LXP9lBUdJiMNefPLQv+qOfX0=;
        h=From:To:Cc:Subject:Date:From;
        b=t6VkFU+47MMFq/UsrKM/41r7i+wSDGfah12r7Jn79t8i0xcCIWzvwnerchE5UZRig
         KpHNzPi0rtUiRldKCgShHyUpOGUJh6SQR98XBhiZQ593ztZFDzOcXWMp1S0/28y89m
         9GFdDXaldOyjG87pk3YniDPQDHq3zsBnRkn2MGGY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Kristian H. Kristensen" <hoegsberg@gmail.com>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 01/20] drm/msm: Unblock writer if reader closes file
Date:   Thu, 14 Feb 2019 21:14:52 -0500
Message-Id: <20190215021511.179333-1-sashal@kernel.org>
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
index 9a78c48817c6..909a52b21ebe 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -103,7 +103,9 @@ static void rd_write(struct msm_rd_state *rd, const void *buf, int sz)
 		char *fptr = &fifo->buf[fifo->head];
 		int n;
 
-		wait_event(rd->fifo_event, circ_space(&rd->fifo) > 0);
+		wait_event(rd->fifo_event, circ_space(&rd->fifo) > 0 || !rd->open);
+		if (!rd->open)
+			return;
 
 		n = min(sz, circ_space_to_end(&rd->fifo));
 		memcpy(fptr, ptr, n);
@@ -192,7 +194,10 @@ static int rd_open(struct inode *inode, struct file *file)
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

