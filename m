Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1808C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919A22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691557;
	bh=nqgrXLaJEHrhcbL9D8uQmAp7BxY5tKdpYBY8bZh4r2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=znbxD1BfrcimiL/GYojfivAOnZJXoQQASan4MNDoKYgOGEnq7QkkhzmJjvooagsL0
	 NLa3eGOwXKog8Ow8cchNDE24GNgshp0MUN3wpI1oExJGiwP9HxBEBv3cxoeZ+fbqgO
	 wrtTuTGqJn3xuf021VBWZK/bp/BPq/iGFsVdV/cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfA1QFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731102AbfA1QFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC2C20989;
        Mon, 28 Jan 2019 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691552;
        bh=nqgrXLaJEHrhcbL9D8uQmAp7BxY5tKdpYBY8bZh4r2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuWvQafKIVFAXlWCvpLvJ/8AsXwBAZ99sTYZ1e0Dsd5xVnoJ2igZw85XVnCvAKHdl
         uxAemXnDj1WqOVozaIbbe7g57QEjEznefxmWHpH56de0yoGhBZmO9VvgfDBmXgAgSY
         T2D8w1OkANVgBroEL64J43ScoD3NKtVOEZ6g2Roc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 138/258] drm/msm: dpu: Only check flush register against pending flushes
Date:   Mon, 28 Jan 2019 10:57:24 -0500
Message-Id: <20190128155924.51521-138-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit 5f79e03b1f7c1b2cf0019ce6365fe5d52629813d ]

There exists a case where a flush of a plane/dma may have been triggered
& started from an async commit. If that plane/dma is subsequently disabled
by the next commit, the flush register will continue to hold the flush
bit for the disabled plane. Since the bit remains active,
pending_kickoff_cnt will never decrement and we'll miss frame_done
events.

This patch limits the check of flush_register to include only those bits
which have been updated with the latest commit.

Changes in v2:
- None

Reviewed-by: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 14fc7c2a6bb7..c9962a36b86b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -331,7 +331,7 @@ static void dpu_encoder_phys_vid_vblank_irq(void *arg, int irq_idx)
 	if (hw_ctl && hw_ctl->ops.get_flush_register)
 		flush_register = hw_ctl->ops.get_flush_register(hw_ctl);
 
-	if (flush_register == 0)
+	if (!(flush_register & hw_ctl->ops.get_pending_flush(hw_ctl)))
 		new_cnt = atomic_add_unless(&phys_enc->pending_kickoff_cnt,
 				-1, 0);
 	spin_unlock_irqrestore(phys_enc->enc_spinlock, lock_flags);
-- 
2.19.1

