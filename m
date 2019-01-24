Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F2BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB768218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxmoAdm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfAXUZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:25:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35636 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfAXUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so3569776pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=047J1k0/mUcjNgmvRUyCPtpz6N3HyINo5R4EX4aYjSs=;
        b=FxmoAdm15J9jmB9nUS/eH4yx3ojUDV8+yI0dYQNVqxuIDrQ0Yymglbt8B61ufqfo6c
         LtA+KYn9997gWwA6mQm2aydPKf+J41p9PIGjKs5ZTn4y1MaGCGjTQ4cl6LF3K/Z8m1/o
         9lGp0YpQsia/DMIPOmizrFEq6fBug74EO5Svg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=047J1k0/mUcjNgmvRUyCPtpz6N3HyINo5R4EX4aYjSs=;
        b=uL1IRbEVjLg6L8f+f+bjIwuEaIPlqOfNA4D7QnVYPwwwU9IhwQuYwPLVwzTEIKkYVp
         CVG46G/IiEXn4tQeqDzT/CX1nKKdEw1c/5tv0cgGI51uz9ACbCcEcwC/sDtb4lRy0Kby
         ddOcszMGNIs9egdysDYsAkhxOMV31NiigfitRY12JP1BCF2y1OhUYITee6s7xmTERVnC
         lrvTiO4mgJCE0hc73jKQU29A2Sah0/kPfVGO2CNOrP8rjpmB2TO9sd4Ki71ox5fjSoD/
         0vK5TGL3dKdKWhgXOT61wIWZf94LvxxsWE8G83ElY1wH4hiubg4kOqO+wCpFDlQIi4kH
         XV6A==
X-Gm-Message-State: AJcUukf7+V+bAYWubpU+LbCQsGbZV9TtZM9wBTorVq6XfrWkSHx4FPmK
        ROcg/H1pjF3v2DQGEu9MhVwkdElzJDXkRQ==
X-Google-Smtp-Source: ALg8bN7ET00M0k5VI8lVBzNMdi6A83CsHr2S1loHivH85R+UbopGmB+DDRz1YtH+K4Wh6NildFcxZg==
X-Received: by 2002:a62:39cb:: with SMTP id u72mr7937322pfj.223.1548361473976;
        Thu, 24 Jan 2019 12:24:33 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:33 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Li Yu <liyu65@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4/8 v5] dma: k3dma: Delete axi_config
Date:   Thu, 24 Jan 2019 12:24:19 -0800
Message-Id: <1548361463-28372-5-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
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
index 4dce532..e415c85 100644
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
@@ -169,7 +167,6 @@ static void k3_dma_set_desc(struct k3_dma_phy *phy, struct k3_desc_hw *hw)
 	writel_relaxed(hw->count, phy->base + CX_CNT0);
 	writel_relaxed(hw->saddr, phy->base + CX_SRC);
 	writel_relaxed(hw->daddr, phy->base + CX_DST);
-	writel_relaxed(AXI_CFG_DEFAULT, phy->base + AXI_CFG);
 	writel_relaxed(hw->config, phy->base + CX_CFG);
 }
 
-- 
2.7.4

