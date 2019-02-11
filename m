Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD79222B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899867;
	bh=Vh9tFSUjCo8gqVJ/Nqh93XKEoy2XcMuOsdLFBOqAp74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i3gMUdyQw7UeR2WX30mVr64ZHrnblscjZEsdRpY+nHv8vNHJ9nfCrJRnaq+lKIE+G
	 C8Jo7XciSLefyn/rF7elc5y8PbCi6LEu+JMuaOTQc0bheCSmXLiQYiQSF+ec8csVz6
	 nco79NRhQHHfmTMwNJF/NCoI8pTeKjbvZVFfiZ9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbfBKOoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732192AbfBKOod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66C152081B;
        Mon, 11 Feb 2019 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896272;
        bh=Vh9tFSUjCo8gqVJ/Nqh93XKEoy2XcMuOsdLFBOqAp74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpyNNSNpPx1A03SJwd2NhHrq7WDz1eo6vCweZk+lohp5Tb21yBttkMwHDuzdqxJzZ
         3K/u3czruHEQEs81ZVhPbap+oRzf12TtqjPUR8FinlLr338Z4QgB++RYgNiksFLoH0
         gIzCNz6tqRjqGJ/vWjdIXwpslscI7E76ZEJwZPuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeykumar Sankaran <jsanka@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 130/313] drm/msm: dpu: Only check flush register against pending flushes
Date:   Mon, 11 Feb 2019 15:16:50 +0100
Message-Id: <20190211141902.419018026@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



