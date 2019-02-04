Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5254C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E56E20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CFm/RvdA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CFm/RvdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfBDQQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:16:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfBDQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:15:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5AB1B6090C; Mon,  4 Feb 2019 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296952;
        bh=J8xH1b025Ak0cgQWcawEbmu4VONZ1oqKmFEO2taBjds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFm/RvdAZrwOp1Asbf30WCnyohUqn3JBtBih4tJx8D+3CNPcfdysrJRRBe9vz36+R
         COgQQUSFmQHXQ7ACsR/JpV8VPS5Zdyf3B9xIvTf1NCnNbaeGLEtskCrYiHCbF/8Kum
         aoa2R690zvGjeSC9DMP3GrxJvSvymgm34S2d9TNk=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE5796030E;
        Mon,  4 Feb 2019 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296952;
        bh=J8xH1b025Ak0cgQWcawEbmu4VONZ1oqKmFEO2taBjds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFm/RvdAZrwOp1Asbf30WCnyohUqn3JBtBih4tJx8D+3CNPcfdysrJRRBe9vz36+R
         COgQQUSFmQHXQ7ACsR/JpV8VPS5Zdyf3B9xIvTf1NCnNbaeGLEtskCrYiHCbF/8Kum
         aoa2R690zvGjeSC9DMP3GrxJvSvymgm34S2d9TNk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE5796030E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 1/6] drm/msm/a6xx: Remove unwanted regulator code
Date:   Mon,  4 Feb 2019 09:15:39 -0700
Message-Id: <1549296944-17285-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GMU code currently has some misguided code to try to work around
a hardware quirk that requires the power domains on the GPU be
collapsed in a certain order. Upcoming patches will do this the
right way so get rid of the unused and unwanted regulator
code.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 4 ----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ce1b3cc..f1baf64f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -671,9 +671,6 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
 	gmu_poll_timeout(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS, val,
 		(val & 1), 100, 1000);
 
-	/* Force off the GX GSDC */
-	regulator_force_disable(gmu->gx);
-
 	/* Disable the resources */
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
 	pm_runtime_put_sync(gmu->dev);
@@ -1203,7 +1200,6 @@ int a6xx_gmu_probe(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	gmu->idle_level = GMU_IDLE_STATE_ACTIVE;
 
 	pm_runtime_enable(gmu->dev);
-	gmu->gx = devm_regulator_get(gmu->dev, "vdd");
 
 	/* Get the list of clocks */
 	ret = a6xx_gmu_clocks_probe(gmu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index c721d91..8081083 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -52,8 +52,6 @@ struct a6xx_gmu {
 	int hfi_irq;
 	int gmu_irq;
 
-	struct regulator *gx;
-
 	struct iommu_domain *domain;
 	u64 uncached_iova_base;
 
-- 
2.7.4

