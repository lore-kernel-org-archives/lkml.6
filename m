Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45032C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA15820842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aA1A98sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA15820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbeGENNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:13:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40597 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754319AbeGENFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so10717331wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g23pTkthDir6WiafxRO9C54UE8+PUxr4OXpPgPQrngc=;
        b=aA1A98sKJlU5oj/d+KWTGm94IdY7FQtGWYw5qkP1mFGRuqgGlWlP4fF8N7R8/TG80a
         jQn9AawpggzvVGbCjR0sHp78xlTQxLO1pRiI1xBJl8khInMH1dMIxOalewou4FK8D31J
         fOyuYjhoVGbHwAG8Wa+3wDVwrR3R3FLRY8DHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g23pTkthDir6WiafxRO9C54UE8+PUxr4OXpPgPQrngc=;
        b=PEE6t5o/67LGGjtiFXyPb43Bkoi+RbZ7JefMFojOiVII502QWfweC8wESW7GXvsdjb
         F8twk8BixqjIguZ+5pDv2dDJ3kxtPT8czmvtDEJhfRErJ8eO8SXyb4CdgqdVhKq/xzY0
         nj3qkhGhaLLFGIwGif8f6uGsLiiPZWIXjSHvDLcpT7hK3xHiXTOZDwokwxMzaGecdnjd
         l6zbJJNnn+Bm5hDSkeSmre4Q1aLTjW4rmKMA4BtV/VqiYvzkbCqJn1iHukqWWY6JO5II
         KLqiV8KfA65FYR2aaqrc6KIctaBISdccBvuzYoULcTrwRp2VdvSmJvdzk96RiH6RRSiI
         0DdQ==
X-Gm-Message-State: APt69E1zhGdnWwFACzjeCpv8T1fz5Lv3ifSMWxtRzK5crAuLjqaxcway
        QfXMcMMx7raGrJ+dZFfhd8GEPA==
X-Google-Smtp-Source: AAOMgpezbWaKWcMth/zMbnBJhbu4DI9HiGw0VtmXE7vkxcbfRT5bSwoIKrVb/wtyhUvzWFQ8YU6Zjw==
X-Received: by 2002:a1c:d9c4:: with SMTP id q187-v6mr3966331wmg.156.1530795915537;
        Thu, 05 Jul 2018 06:05:15 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:15 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 08/27] venus: hfi_venus: fix suspend function for venus 3xx versions
Date:   Thu,  5 Jul 2018 16:03:42 +0300
Message-Id: <20180705130401.24315-9-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the suspend function for Venus 3xx versions by
add a check for WFI (wait for interrupt) bit. This bit
is on when the ARM9 is idle and entered in low power mode.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c    | 72 ++++++++++++++++--------
 drivers/media/platform/qcom/venus/hfi_venus_io.h |  1 +
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 784b3ad1a9f6..72a8547eab39 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1444,13 +1444,40 @@ static int venus_suspend_1xx(struct venus_core *core)
 	return 0;
 }
 
+static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
+{
+	u32 ctrl_status, cpu_status;
+
+	cpu_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
+	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+
+	if (cpu_status & WRAPPER_CPU_STATUS_WFI &&
+	    ctrl_status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
+		return true;
+
+	return false;
+}
+
+static bool venus_cpu_idle_and_pc_ready(struct venus_hfi_device *hdev)
+{
+	u32 ctrl_status, cpu_status;
+
+	cpu_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
+	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+
+	if (cpu_status & WRAPPER_CPU_STATUS_WFI &&
+	    ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)
+		return true;
+
+	return false;
+}
+
 static int venus_suspend_3xx(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	struct device *dev = core->dev;
-	u32 ctrl_status, wfi_status;
+	bool val;
 	int ret;
-	int cnt = 100;
 
 	if (!hdev->power_enabled || hdev->suspended)
 		return 0;
@@ -1464,29 +1491,30 @@ static int venus_suspend_3xx(struct venus_core *core)
 		return -EINVAL;
 	}
 
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
-	if (!(ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)) {
-		wfi_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
-		ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
-
-		ret = venus_prepare_power_collapse(hdev, false);
-		if (ret) {
-			dev_err(dev, "prepare for power collapse fail (%d)\n",
-				ret);
-			return ret;
-		}
+	/*
+	 * Power collapse sequence for Venus 3xx and 4xx versions:
+	 * 1. Check for ARM9 and video core to be idle by checking WFI bit
+	 *    (bit 0) in CPU status register and by checking Idle (bit 30) in
+	 *    Control status register for video core.
+	 * 2. Send a command to prepare for power collapse.
+	 * 3. Check for WFI and PC_READY bits.
+	 */
+	ret = readx_poll_timeout(venus_cpu_and_video_core_idle, hdev, val, val,
+				 1500, 100 * 1500);
+	if (ret)
+		return ret;
 
-		cnt = 100;
-		while (cnt--) {
-			wfi_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
-			ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
-			if (ctrl_status & CPU_CS_SCIACMDARG0_PC_READY &&
-			    wfi_status & BIT(0))
-				break;
-			usleep_range(1000, 1500);
-		}
+	ret = venus_prepare_power_collapse(hdev, false);
+	if (ret) {
+		dev_err(dev, "prepare for power collapse fail (%d)\n", ret);
+		return ret;
 	}
 
+	ret = readx_poll_timeout(venus_cpu_idle_and_pc_ready, hdev, val, val,
+				 1500, 100 * 1500);
+	if (ret)
+		return ret;
+
 	mutex_lock(&hdev->lock);
 
 	ret = venus_power_off(hdev);
diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
index c0b18de1e396..def0926a6dee 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
+++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
@@ -110,6 +110,7 @@
 
 #define WRAPPER_CPU_CGC_DIS			(WRAPPER_BASE + 0x2010)
 #define WRAPPER_CPU_STATUS			(WRAPPER_BASE + 0x2014)
+#define WRAPPER_CPU_STATUS_WFI			BIT(0)
 #define WRAPPER_SW_RESET			(WRAPPER_BASE + 0x3000)
 
 /* Venus 4xx */
-- 
2.14.1

