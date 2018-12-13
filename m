Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228B320870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676727;
	bh=ND30UdmIcJ/iv+jpp5dhyNom6sdF+ClFOmy5Mb5QoZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HGvhrdWYa9mJwawqISiqB5Z4QS/5YTcPel5aKTOr+0nwngfM0Mc9QT9IG0hf23tlo
	 L9MEostGMQqtHyJe0hmf8RsMQ50OiZRIJprCRv7pa19/8tYmNoqTLHpy3tNNWjgjPc
	 IBgwc54YmrDYeRqZGaQob7q/+b9qpiX1E2FF/Wt0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228B320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeLMEwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbeLME27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:28:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 651D320849;
        Thu, 13 Dec 2018 04:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675339;
        bh=ND30UdmIcJ/iv+jpp5dhyNom6sdF+ClFOmy5Mb5QoZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbAwGP2OxO5aKeqWMxvEu+SZwffsEarOox/tMSerylOKTyBUj6H7F10OtaDBlXlJ0
         jDhIOL3NRqpDnjXo4tLvDSU//E29lWAOD1kknr75rylTGZnDUiW7QjW/4g4qtRpWSt
         BoEyLI95UA31yuLO9sU0kD6pmV0ML4ChRhLosIis=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 14/73] drm/msm: fix handling of cmdstream offset
Date:   Wed, 12 Dec 2018 23:27:39 -0500
Message-Id: <20181213042838.75160-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@gmail.com>

[ Upstream commit 47e7f506ee6590ceb2efa1f08aca7f9f2ee5c1d3 ]

Userspace hasn't used submit cmds with submit_offset != 0 for a while,
but this starts cropping up again with cmdstream sub-buffer-allocation
in libdrm_freedreno.

Doesn't do much good to increment the buf ptr before assigning it.

Fixes: 78b8e5b847b4 drm/msm: dump a rd GPUADDR header for all buffers in the command
Reviewed-by: Kristian H. Kristensen <hoegsberg@google.com>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_rd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index 3aa8a8576abe..f7a0edea4705 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -316,10 +316,11 @@ static void snapshot_buf(struct msm_rd_state *rd,
 		uint64_t iova, uint32_t size)
 {
 	struct msm_gem_object *obj = submit->bos[idx].obj;
+	unsigned offset = 0;
 	const char *buf;
 
 	if (iova) {
-		buf += iova - submit->bos[idx].iova;
+		offset = iova - submit->bos[idx].iova;
 	} else {
 		iova = submit->bos[idx].iova;
 		size = obj->base.size;
@@ -340,6 +341,8 @@ static void snapshot_buf(struct msm_rd_state *rd,
 	if (IS_ERR(buf))
 		return;
 
+	buf += offset;
+
 	rd_write_section(rd, RD_BUFFER_CONTENTS, buf, size);
 
 	msm_gem_put_vaddr(&obj->base);
-- 
2.19.1

