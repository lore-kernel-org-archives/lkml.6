Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E23EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DE720882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675391;
	bh=6TMEWmplXObtlXPfssWE6izb849ZoCBkmvEwN2jAZUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=07iZfreMQhZAo1hjL3WJ/c0GwuPHIVeHq9/e36ywM2h9XHAq+IelQY9pUTYkPFPMO
	 QXnE/Zs/TrRq82tuxRtt6pAgCIFzgNLAzzCqbnTUGYTeJsDPOmEhJ6pnkYxzlW/1aH
	 EsyLcThp0isn9LStfKaPCzyusJgVtmHfeGWo9xR0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DE720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeLME3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbeLME3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AABE20873;
        Thu, 13 Dec 2018 04:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675385;
        bh=6TMEWmplXObtlXPfssWE6izb849ZoCBkmvEwN2jAZUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQ1rRzBI8yAftk8dTquSPegADBOpX0d9lF7Vkft2Qqu7YXw7ucrsm5x6ZEoPZOqzH
         iGDi0Ngr0kcaqlXYKIWlygtF0o8MZnDXKYG4v/QgaSifCp8rDCVgIxA4ebjB1HSZAn
         KRwi5265YvkfpmrkwGhYvryDReTOBKcilE6hPM1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 35/73] drm/msm: Fix error return checking
Date:   Wed, 12 Dec 2018 23:28:00 -0500
Message-Id: <20181213042838.75160-35-sashal@kernel.org>
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

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 098336deb946f37a70afc0979af388b615c378bf ]

The error checks on ret for a negative error return always fails because
the return value of iommu_map_sg() is unsigned and can never be negative.

Detected with Coccinelle:
drivers/gpu/drm/msm/msm_iommu.c:69:9-12: WARNING: Unsigned expression
compared with zero: ret < 0

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Rob Clark <robdclark@gmail.com>
CC: David Airlie <airlied@linux.ie>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: linux-arm-msm@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: freedreno@lists.freedesktop.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index b23d33622f37..2a90aa4caec0 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -66,7 +66,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 //	pm_runtime_get_sync(mmu->dev);
 	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
 //	pm_runtime_put_sync(mmu->dev);
-	WARN_ON(ret < 0);
+	WARN_ON(!ret);
 
 	return (ret == len) ? 0 : -EINVAL;
 }
-- 
2.19.1

