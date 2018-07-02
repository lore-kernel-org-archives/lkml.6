Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD53AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D8525229
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DfxRtaYi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DfxRtaYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D8525229
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeGBHoW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:44:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933055AbeGBHoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:44:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B33660B13; Mon,  2 Jul 2018 07:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530517457;
        bh=kwjdomwJ8eCm4yLXX3FoyXKbJRyqrHN+jIm6LRWq8rI=;
        h=From:To:Cc:Subject:Date:From;
        b=DfxRtaYiSLQgkJd9BJRKBvZXkazTqKwXb94MWS3gvpHl3W+UllojrNzj/dsi7i/eX
         k/K6XIBcdUjB205xbX9WAXB4G4auonHUgVCs2FiEzNTB3JY/xj3hx6NV061dBfyUwh
         uEJfT2sEtT81Ct9hLuXa00S2lz85+vc5B7nZYRc8=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23ADA602A7;
        Mon,  2 Jul 2018 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530517457;
        bh=kwjdomwJ8eCm4yLXX3FoyXKbJRyqrHN+jIm6LRWq8rI=;
        h=From:To:Cc:Subject:Date:From;
        b=DfxRtaYiSLQgkJd9BJRKBvZXkazTqKwXb94MWS3gvpHl3W+UllojrNzj/dsi7i/eX
         k/K6XIBcdUjB205xbX9WAXB4G4auonHUgVCs2FiEzNTB3JY/xj3hx6NV061dBfyUwh
         uEJfT2sEtT81Ct9hLuXa00S2lz85+vc5B7nZYRc8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23ADA602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH] venus: vdec: fix decoded data size
Date:   Mon,  2 Jul 2018 13:14:07 +0530
Message-Id: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exisiting code returns the max of the decoded
size and buffer size. It turns out that buffer
size is always greater due to hardware alignment
requirement. As a result, payload size given to
client is incorrect. This change ensures that
the bytesused is assigned to actual payload size.

Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index d079aeb..ada1d2f 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 
 		vb = &vbuf->vb2_buf;
 		vb->planes[0].bytesused =
-			max_t(unsigned int, opb_sz, bytesused);
+			min_t(unsigned int, opb_sz, bytesused);
 		vb->planes[0].data_offset = data_offset;
 		vb->timestamp = timestamp_us * NSEC_PER_USEC;
 		vbuf->sequence = inst->sequence_cap++;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

