Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3D620449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298610;
	bh=pTcMKgYXSqRdfDNm05MA+LmStAIdl75SfcDLj8E5l7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0gQ3FfGQnO63xO1KP6nAyQOnm1+tR874zcPPxiR7z76JN+y28lFpXIQg3CiVWR047
	 24B2CK+2RJxZq1roI9aoRZZ/ljs26wWsLeHQElL2USItvA+o8Iad4c3otxNKsBjB/T
	 nxtBhHstqcdH6FLYm+0/Eokq2nTXk3xWLcs9QqoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbeLTJgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:36:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732318AbeLTJ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:27:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9470F217D4;
        Thu, 20 Dec 2018 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298046;
        bh=pTcMKgYXSqRdfDNm05MA+LmStAIdl75SfcDLj8E5l7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHl1qc6Atn1GqdHg4WBcKNpQydSg21MUi4vtxP19CbuEjpMx8htOPpOiNtIBW94s0
         hGXvylsBXSDHqq3ClfZygJSjwCG1RgnfgDY/738NL3mTTYGGYt4znK+IdIq7sOsYoq
         NaVybeaCmCNI3XhWUhJxkaT2guW6g+ObktNGNPrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 51/72] drm/msm: Fix error return checking
Date:   Thu, 20 Dec 2018 10:18:50 +0100
Message-Id: <20181220085924.350437005@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



