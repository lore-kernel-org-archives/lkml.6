Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6D4C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C3820879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675488;
	bh=6TMEWmplXObtlXPfssWE6izb849ZoCBkmvEwN2jAZUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tDG9+CJm2SEjAy5JP6S0C43wwvBYJIYdc+NuF5B1e7UMJETIHOciRigBcMZhm2z93
	 Nck2mXvhGJ4XWEGpCcvJx3V7KXQRCWxAvRnQtHwM0cf4jMs234PUJSVpIEqTRN5xYv
	 t50yHuF4kmBqFLQpLQb6vfFavyYAypnK4ZeUOGr4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C3820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeLMEb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbeLMEbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D8D20873;
        Thu, 13 Dec 2018 04:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675480;
        bh=6TMEWmplXObtlXPfssWE6izb849ZoCBkmvEwN2jAZUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3dK8RGybJVzN6perwk5LIHUgaKjhvskY1vKin3E7kr29S+ljCjheJPKjBj1KCU1r
         V0d/hkLABW59blSiIEwDp5R5ulGXz5mF/z29hvSbcJeV2HWYWxi8wrPGqeVoiYjyLl
         jtRvO3Fwvj975jZzb2HOFoy5NcV+g5sIy/rymY7g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 17/41] drm/msm: Fix error return checking
Date:   Wed, 12 Dec 2018 23:30:30 -0500
Message-Id: <20181213043054.75891-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
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

