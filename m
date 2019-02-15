Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12993C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE7D206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196540;
	bh=Q//WEul+NCweA1gN4aPnNqITUch2XHQmjN1abGufL60=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HgcIR33uj0WyZ29edySeCnzW/PTnovelFcimoqU/M83pqwA3s2YtloFs/1Pd/ERZr
	 mWug6uL0Iy8/TBInJSvcRwm+DUzvOEDB0UiePe9cdC1/LXxcXTkAbf5u0I6o1GKWJj
	 Bxxp7grzekNMWehlCrOtdBtqEr19HCLOt/H3f/Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbfBOCI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfBOCI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:08:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E443206BA;
        Fri, 15 Feb 2019 02:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196538;
        bh=Q//WEul+NCweA1gN4aPnNqITUch2XHQmjN1abGufL60=;
        h=From:To:Cc:Subject:Date:From;
        b=xGat0EnThfUcllOtN5jYpMNovO5EmfaYI8l5Ekm/tj3cmTWY4JlRdN4LHI8k/tzJ5
         r2xLQT6gkRawSiv7mvpOYnW1wQGcFGpE2+5lotIVop2xoXaTWFP+6ozrwnv661iCzW
         u3Wm0culttYTHcopOytglQDtNc+oF8fXtSDpFRLU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Kristian H. Kristensen" <hoegsberg@gmail.com>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 01/77] drm/msm: Unblock writer if reader closes file
Date:   Thu, 14 Feb 2019 21:07:39 -0500
Message-Id: <20190215020855.176727-1-sashal@kernel.org>
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
index 0c2c8d2c631f..25fc161ab618 100644
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

