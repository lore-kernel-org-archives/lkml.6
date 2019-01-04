Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9D3C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919B5218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqNw1S/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfADU4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:56:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40203 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfADU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so18819218pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jkv+KKhij9Erx9l7SBMC7LanjV56Iw/ajdYdzBZJLX8=;
        b=EqNw1S/fQaKgVv4J60j++aJJzgDL4dSEOTQvE5Zq3OmcQ5nshcdWlQL6oHlzla50wA
         y6hnyD+vhk8D1Yr5tq6+k2MQLwyD1qe5jxmnv4J9Z9ZL5GfJ+saygSHldfn13G0eH2t3
         pqY003UzQYoJTQlMRykk/MmNFGsrAcwQOqueY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jkv+KKhij9Erx9l7SBMC7LanjV56Iw/ajdYdzBZJLX8=;
        b=UWNxU65pgmyOx0Rc+HXsBFR9saE6QMIhu98ymH54aVYde6o5tsXhTjDuV+euUA48oI
         MzhQnSlNaDtrp4pirFIhBim6TWR95xh6Sk3OVZD/Q8aKB162kqQvGsjbOSiGl7s6GUsr
         jcmLpKlokIeIuWvz5AoJgHZown4dHi9uvybLf8s0tPuocqCNLFGr9PGXPpT1SfCCt7dC
         mg4456llwroySFKaLZLWhN4+4eXtt7E7mF7oOoeJclCVnEFGEi2dhA5dCAooEBK+BICe
         /pn4tBPrzBBS/MqbxGQO8E6KZB1bIFBwkVqAAQqGcX8esB997M5De1cXJnfR/zWkF01U
         64UA==
X-Gm-Message-State: AJcUukdqMhfP7dREvoui/PXGZvaHAop6MsuqrgdNmhHJSpo/vAocogyh
        UJsbGKoUvlMSkObDLT2civhLKLrFnQSBGg==
X-Google-Smtp-Source: ALg8bN6HxDW9gGC8/qDPWUFCcBsGFAASOGUaQ4hqkmk0VglGMaTxj6/z77WLotjj8Kx+clYr98+RAA==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr49261866pgc.72.1546635398861;
        Fri, 04 Jan 2019 12:56:38 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id l3sm98058334pga.92.2019.01.04.12.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 12:56:37 -0800 (PST)
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
Subject: [PATCH 4/8 v2] dma: k3dma: Delete axi_config
Date:   Fri,  4 Jan 2019 12:56:24 -0800
Message-Id: <1546635388-13795-5-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
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

