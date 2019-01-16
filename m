Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA3CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D77A206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5fkpDZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405664AbfAPRKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:10:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37245 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405577AbfAPRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so3095977pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+fP/xi0ogaPcZ5aUHlMSoUJnZJ6VWVBpkuoagJMFKE=;
        b=Z5fkpDZ4b5JbyklHDHH6gvem0MfBvX4qsqUi4fVqQKQ59GG1s+jrR/2RKqFdnz+YXV
         DmvO0ufG1StGxto256QlzqATW/s2kUPVorRCbdtDYe6DmKla8ZAYIQ1+unFN7XIPwtSp
         j+QU9fVMf+fuEYtM3x8tICsMYiBne4i2Y6LmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9+fP/xi0ogaPcZ5aUHlMSoUJnZJ6VWVBpkuoagJMFKE=;
        b=tqfzZZMwCzMBm3FjijPWwGwLd/DNa9SPhts18KSPSBLiRkWYxy6oYllfEO/03hQsmf
         fpe67SeZFk6Q2MYhztz3Oq66OuatybAPRDmw9J5P9Tj58Ki+JkrhUomtXzaBOq51Q5rA
         trIb4CJMvE3vwP3NMbmtrPxb5Q/dKrOAtcWMMdj5UlzkSTJdBJkrkYYJ2kUpWLd+htbq
         EqUgfuDjkPRtJGoaUdXqOS693WsEVHpQrH75RHAydi0UyCcrClSduNRH4OxS5u8H62mJ
         0HxrW/7QlCVmNUIzczy9R11kxatB9dsa8IjcGcYcIjMIL5zhDg9wKfFMQVdUhJ5+z8lW
         DFvQ==
X-Gm-Message-State: AJcUukfWc7CiQu8usHt0kXTkqJOsBbq0b4ru1dSc9SDII9OPJA2veueR
        UfZ4NwipMKQWhgMxiZ8uunYn7d/nkQ5ylg==
X-Google-Smtp-Source: ALg8bN5YTCRPAPyEAHSrDhwBPRWMDltlu7Lq7S/LJmFqSAi9sEsbGYN4AxKAA7scsUXo4VHpgGyqUQ==
X-Received: by 2002:a63:9e19:: with SMTP id s25mr9779115pgd.203.1547658649609;
        Wed, 16 Jan 2019 09:10:49 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:48 -0800 (PST)
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
Subject: [PATCH 4/8 v4] dma: k3dma: Delete axi_config
Date:   Wed, 16 Jan 2019 09:10:25 -0800
Message-Id: <1547658629-25378-5-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
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

