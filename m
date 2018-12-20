Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34034C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D4720989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298154;
	bh=aGnu5NXUl88nPaoswnU4x72DzCwCHDCLcozFK25fFtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wPTjiKVRkZhS/VApXR5JRwR9VDSuWMb0a9gLXDEacRegdXw0IjZbGY71MfvajHSax
	 E/wykJUhPHIzlhJ58ARg+yAkwY64dMwJCsU0StmMGt6yDurLHagkJ9fO7xP/KxMQT0
	 8mOgoINGn4BgkVx5d/lpKw/shyFXanieXAd0Ix5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbeLTJ3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732631AbeLTJ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA5020989;
        Thu, 20 Dec 2018 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298144;
        bh=aGnu5NXUl88nPaoswnU4x72DzCwCHDCLcozFK25fFtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMvtCwawIJGpMr3K84GzHZMAGmIr68fCoECIcQ6X40OgQE/pJTvt3HxtRcAvdEfFk
         eKdH5aSyW5Tia3r/r9BOZ5GXjOQkqZhCMbmVIdD71lizTIVBGJxrumgsQbFy8JQiZY
         E0QOHko8koz964oNz5MzFeeSqwqJ5H7tjBQFfAHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 16/67] drm/msm: fix handling of cmdstream offset
Date:   Thu, 20 Dec 2018 10:18:28 +0100
Message-Id: <20181220085904.199954728@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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



