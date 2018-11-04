Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B45CECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFC72085B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zbGr1g0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFC72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeKDXHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbeKDXHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A59E2086C;
        Sun,  4 Nov 2018 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339541;
        bh=/YeBbyCTfskRgidnU1fFUSUGXSsNtDUXMphIokD2Z/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zbGr1g0Bot1yhHZPAAr33JY9NU/MJ5OBUuRpGMlIH1iekHJKBiAv/ZtrDVPIW0Syr
         AJaK6BRBL19R72ofZY+suSu1mAXqkHiGEglqn00KvvIfGxq38caIWOrSsI3osFY6LC
         ZNj3CDO08mcpCi1JmyLEp8/5d2PImqFvXd3nej8Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 36/57] media: coda: don't overwrite h.264 profile_idc on decoder instance
Date:   Sun,  4 Nov 2018 08:51:23 -0500
Message-Id: <20181104135144.88324-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 1f32061e843205f6fe8404d5100d5adcec334e75 ]

On a decoder instance, after the profile has been parsed from the stream
__v4l2_ctrl_s_ctrl() is called to notify userspace about changes in the
read-only profile control. This ends up calling back into the CODA driver
where a missing check on the s_ctrl caused the profile information that has
just been parsed from the stream to be overwritten with the default
baseline profile.

Later on the driver fails to enable frame reordering, based on the wrong
profile information.

Fixes: 347de126d1da (media: coda: add read-only h.264 decoder
                     profile/level controls)

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/coda/coda-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 726b3b93a486..bf7b8417c27f 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1804,7 +1804,8 @@ static int coda_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
 		/* TODO: switch between baseline and constrained baseline */
-		ctx->params.h264_profile_idc = 66;
+		if (ctx->inst_type == CODA_INST_ENCODER)
+			ctx->params.h264_profile_idc = 66;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
 		/* nothing to do, this is set by the encoder */
-- 
2.17.1

