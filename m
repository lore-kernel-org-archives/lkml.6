Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC89C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BAE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0SVdr1My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BAE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbeKTC4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbeKTC4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FADB20831;
        Mon, 19 Nov 2018 16:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645166;
        bh=qLL7/2AZfEul3vbHvFBFM/9D4fPVUtl9AgZbDDDmqPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0SVdr1MyvSGh8x5P00ONbjDcpYyF+2ZybRVmUpFiHUoQ1YIEUjf05nlRyBVbSsP2D
         JZBBvvJUhegeUopEr6GWb1zKXPd08uQflj0GVNjTPipNB0D3lZ2irQqiDgswyNccIU
         B7K6NQjG2dOy0i2VRySJObv3CASq0rixHPfoT1CA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/205] media: coda: dont overwrite h.264 profile_idc on decoder instance
Date:   Mon, 19 Nov 2018 17:25:31 +0100
Message-Id: <20181119162621.727529798@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/coda/coda-common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1804,7 +1804,8 @@ static int coda_s_ctrl(struct v4l2_ctrl
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
 		/* TODO: switch between baseline and constrained baseline */
-		ctx->params.h264_profile_idc = 66;
+		if (ctx->inst_type == CODA_INST_ENCODER)
+			ctx->params.h264_profile_idc = 66;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
 		/* nothing to do, this is set by the encoder */


