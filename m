Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869BEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5917C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWO7NR8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfAJRev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:34:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35776 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbfAJReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:34:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so5120507pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+fP/xi0ogaPcZ5aUHlMSoUJnZJ6VWVBpkuoagJMFKE=;
        b=VWO7NR8wXtFW4Qlf63tIXxHJOiol4rHIv6edeuFVZUZGFLoaQ/L5sMXEC6Gnj0ecqg
         ntEl4sSyjfnQ6ux4tIHo4pTkDDOIB7JgToE7egW6Jvdnh8YnlDOzaw7XERuLV+tUBlUl
         uK6+LA6fjyzNrvXKDqGMTLvkzZztdPd9Jy5/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+fP/xi0ogaPcZ5aUHlMSoUJnZJ6VWVBpkuoagJMFKE=;
        b=jhxLg0snbB0/uB7H89g1mj+KTErFxMe2kqiHemUIIjBJSTmHuWTKgRa9sIaRxLAk2j
         mRiA6Rr8iyn1azKwHh5zNloQKVDBV42QmiN1ygLR6Hdg0L5ogKZjL2uyFS7C9vaYFKo1
         P8HQWcLQwohYQVJfc36Xpm6ZzrY7q1U7RPXpVyHPgHqNCrjWtcz5cRfa7xs26U4Y0HXA
         jE4V4wDqutOggGANAx+vweSKeMvzYNUkPqS+is33APYgeNQeUspdaq9Y08g1Ik3CtoeJ
         WVSqvIB/qtvKgIzIyvu95e60TUO2LG+K1M3fsfhL/1at8MEOWYfX8GPFIlPZtNGu+ape
         +g3w==
X-Gm-Message-State: AJcUukc8l6lGAUGfgGPocYAu8MwNieujEfvI2W2YePmLoV02igWAQxDl
        IQXd6rjzAPi6f79R8bMfwy2DUgN2vXsftw==
X-Google-Smtp-Source: ALg8bN55NhBvyLBl8QSVRq6gfls6ISMWyizSgdLOnG4pIi6rCxlD/gk0Mu3cye+141YUVCqSqC9gTg==
X-Received: by 2002:a63:ac46:: with SMTP id z6mr10182577pgn.162.1547141661687;
        Thu, 10 Jan 2019 09:34:21 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id k15sm125977409pfb.147.2019.01.10.09.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 09:34:20 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, Li Yu <liyu65@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4/8 v3] dma: k3dma: Delete axi_config
Date:   Thu, 10 Jan 2019 09:34:08 -0800
Message-Id: <1547141652-8660-5-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

Axi_config controls whether DMA resources can be accessed in non-secure
mode, such as linux kernel. The register should be set by the bootloader
stage and depends on the device.

Thus, this patch removes axi_config from k3dma driver.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
[jstultz: Minor tweaks to commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma/k3dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index df61406..b2060bf 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -52,8 +52,6 @@
 #define CX_SRC			0x814
 #define CX_DST			0x818
 #define CX_CFG			0x81c
-#define AXI_CFG			0x820
-#define AXI_CFG_DEFAULT		0x201201
 
 #define CX_LLI_CHAIN_EN		0x2
 #define CX_CFG_EN		0x1
@@ -168,7 +166,6 @@ static void k3_dma_set_desc(struct k3_dma_phy *phy, struct k3_desc_hw *hw)
 	writel_relaxed(hw->count, phy->base + CX_CNT0);
 	writel_relaxed(hw->saddr, phy->base + CX_SRC);
 	writel_relaxed(hw->daddr, phy->base + CX_DST);
-	writel_relaxed(AXI_CFG_DEFAULT, phy->base + AXI_CFG);
 	writel_relaxed(hw->config, phy->base + CX_CFG);
 }
 
-- 
2.7.4

