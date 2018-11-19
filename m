Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4724FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77162089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CMchDugw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X1aGxiZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77162089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeKSQsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 11:48:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34752 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeKSQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 11:48:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F9EA60A33; Mon, 19 Nov 2018 06:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542608753;
        bh=JcnG5bE+977iRzpiMqix6Qtvcnm35/lPv8HX3yjDmYE=;
        h=From:To:Cc:Subject:Date:From;
        b=CMchDugwVDY+kplK94pAAVNPY6W0K7LrEP0DnOqeKh15VyDXWl8+La6Pu5JOv+p2S
         n3oQ995+8Z8cZx7kczQOLyGTG+tkUqrb8+rgRo+rIUCZ9JDmdoR/+wyyCKm7WtA43j
         yqA6SQsueQ2Ftf+HuAxWUt2+5rJVGDXgORMhc6Ws=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07A7D60227;
        Mon, 19 Nov 2018 06:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542608752;
        bh=JcnG5bE+977iRzpiMqix6Qtvcnm35/lPv8HX3yjDmYE=;
        h=From:To:Cc:Subject:Date:From;
        b=X1aGxiZhifXEx9qb7HyBBQWJV2UfSf9J0kU2ATK19bWzLC1f2AFiowEh4OgbGB1Mz
         57oWn4CuMUztfqXUMbqv1WHbofS7nx1p3pxzrYmxtRm4gmGQ2mub6CBftHt5ZzTsDY
         jXkn1HDIBXbDKL5K8NiZiuVcbPeY/QxgvJalv+Sg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07A7D60227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: =?UTF-8?q?=5BPatch=20v3=C2=A0=5D=20drm/msm/dpu=3A=20Correct=20dpu=20destroy=20and=20disable=20order?=
Date:   Mon, 19 Nov 2018 11:55:38 +0530
Message-Id: <1542608738-3315-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of msm drm bind failure, pm runtime put sync
is called from dsi driver which issues an asynchronous
put on mdss device. Subsequently when dpu_mdss_destroy
is triggered the change will make sure to put the mdss
device in suspend and clearing pending work if not
scheduled.

Changes in v2:
   - Removed double spacings [Jeykumar]

Changes in v3:
   - Fix clock on issue during bootup [Rajendra]

Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index fd9c893..df8127b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -156,18 +156,16 @@ static void dpu_mdss_destroy(struct drm_device *dev)
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
 
+	pm_runtime_suspend(dev->dev);
+	pm_runtime_disable(dev->dev);
 	_dpu_mdss_irq_domain_fini(dpu_mdss);
-
 	free_irq(platform_get_irq(pdev, 0), dpu_mdss);
-
 	msm_dss_put_clk(mp->clk_config, mp->num_clk);
 	devm_kfree(&pdev->dev, mp->clk_config);
 
 	if (dpu_mdss->mmio)
 		devm_iounmap(&pdev->dev, dpu_mdss->mmio);
 	dpu_mdss->mmio = NULL;
-
-	pm_runtime_disable(dev->dev);
 	priv->mdss = NULL;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

