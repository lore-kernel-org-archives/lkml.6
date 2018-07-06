Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6E2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0544724066
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eS26KFLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0544724066
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbeGFD4d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:56:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40510 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932513AbeGFD4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:56:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so2218909plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwRz8SkXkoINGnHo89FkceANUfssKlGQRU5dwQMEUkw=;
        b=eS26KFLk+3/jpPZ0kUsFykXl0xFM0RvRNGSpueq2Vx/K4XbPSUVEp3gujLRG1R6+sY
         xzPhoDKjdOWMOjK9ZuIPKcesgADDfO59+qsjB0PLV/kMx35t+CdYcYV94faWv1pLG5H8
         B6UNl/HOhlC8/zwt9vIOjHyPPqV/ddL69bWBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwRz8SkXkoINGnHo89FkceANUfssKlGQRU5dwQMEUkw=;
        b=L3YG/ASEKkrsLqH+YSuWtoHgp+Lp42VANIzuFrqzzlaZKsFrXvmDvXm6zOWkOWTrSd
         lJdQZUKAiQ9Lkml1HVMvE5wex+5mU0DTfR3jRQWfRfb2iv5GZ+hKfTw2QrauZCIW4O1J
         +SutnSFVH/flELNfbW0Oh9Gl9y1J6bYsTW9kYcI6RSQIrN7rrjH/TBlKlFZ/9PFKViqz
         Liq2tImGnAixT9dNuhqEjaYeXcivuGeNK6Vxmzut/sg7xv7CaETIzTHTzADAbtR7Qe7b
         UzQZ60cxF8n+FfDmuQKgAmob3Er6zzxyG3LgNGmVAyTNiAdEWvZTfi01zyH6H5CgKvEq
         euhg==
X-Gm-Message-State: APt69E0ixVXM3KvYajFOdNv9eNaoKdf0vNPWneR6C3HtGPvOy0/UGbPx
        PdzAR2wYs5ZTiDXUBvpcxz/+3w==
X-Google-Smtp-Source: AAOMgpdFBNraHEDUer3pRFJJW4sp7ksP4MBrQZ3jqubmstctw0/0uiVilcXr2mJhUcTKOOsJY3f51Q==
X-Received: by 2002:a17:902:7c16:: with SMTP id x22-v6mr8563419pll.77.1530849390306;
        Thu, 05 Jul 2018 20:56:30 -0700 (PDT)
Received: from localhost.localdomain ([64.64.108.33])
        by smtp.gmail.com with ESMTPSA id y14-v6sm12568403pgo.22.2018.07.05.20.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 20:56:29 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, xuwei5@hisilicon.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v2 4/4] k3dma: delete axi_config
Date:   Fri,  6 Jul 2018 11:55:21 +0800
Message-Id: <20180706035521.13736-5-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706035521.13736-1-guodong.xu@linaro.org>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

Axi_config controls whether DMA resources can be accessed in non-secure
mode, such as linux kernel. The setting is actually done in
bootloader stage.

This patch removes axi_config from k3dma driver.

Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/dma/k3dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 33efb541acb2..4542e703ec85 100644
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
@@ -158,7 +156,6 @@ static void k3_dma_set_desc(struct k3_dma_phy *phy, struct k3_desc_hw *hw)
 	writel_relaxed(hw->count, phy->base + CX_CNT0);
 	writel_relaxed(hw->saddr, phy->base + CX_SRC);
 	writel_relaxed(hw->daddr, phy->base + CX_DST);
-	writel_relaxed(AXI_CFG_DEFAULT, phy->base + AXI_CFG);
 	writel_relaxed(hw->config, phy->base + CX_CFG);
 }
 
-- 
2.17.1

