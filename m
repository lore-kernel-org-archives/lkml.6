Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CF8D0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8290B208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoDC2T97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8290B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935972AbeFMPJV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:09:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35518 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935956AbeFMPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id l10-v6so3163721wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JTs56AHvy6n4KWdfQCk5+mkf+fJThH/BkJrEXFnLkOk=;
        b=YoDC2T97GMSTnDtT1J5RA8dxlqoBLa65csQZd7HMtglZjLp8Et/bXB8KhPwkhNejD3
         Mj81L36jR68fKP6AIbwsY5u9emz5NVxP3ZDod6SdVur87rhZeRY8X5VqCgBbzNAXL7GJ
         JyVUtHFINcPWD3rfzwP2FeuaKrwqC6il7eyLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JTs56AHvy6n4KWdfQCk5+mkf+fJThH/BkJrEXFnLkOk=;
        b=SZOR7JnkTXcaYTVOAvP0xQKHVf7p9nowuGywnoWVKE5mhml7CABcoye0UglQHutV8U
         v6IyY6bHnKT+j44Zx4h7JU7lAYIU6WP707mE64jrdag+fEp9RQcLWAT51IszLPFOJ4Xj
         dPg674P3DI3vsYru5NBtxNWTJtF1nmrghaWZalCewjYMKDK7xBzAeZzsuYBkXejqd5kd
         IR1WeA3l0DKp6g890KypMD+Kdzi0IX9uHAs0CU43xreX6swPFRrqm3a6mLbwSFFZ2WKr
         bU7TOYN3mp9AIIfNzezF2VaVDZzrIsuylEYUIPWBtSl10tR0E/iuiyWHaMzgOs4Ok0yR
         x9Eg==
X-Gm-Message-State: APt69E0PQ8UYIopu7t2WOGAiVPD4I8bnEieZpUIvLl6850qUCtvhGhaw
        7US5WChf9uIYodkbolrc2dQIMQ==
X-Google-Smtp-Source: ADUXVKIAyaoqIZp+JmZz66YjO90txq5AQGuxItAjyrvHl1zOSa/Dc9q/NswNI/m8jAjNKHhcjR38AQ==
X-Received: by 2002:adf:86ae:: with SMTP id 43-v6mr4158751wrx.281.1528902555195;
        Wed, 13 Jun 2018 08:09:15 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:14 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 07/27] venus: hfi_venus: add halt AXI support for Venus 4xx
Date:   Wed, 13 Jun 2018 18:07:41 +0300
Message-Id: <20180613150801.11702-8-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AXI halt support for version 4xx by using venus wrapper
registers.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c    | 18 ++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_venus_io.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 734ce11b0ed0..784b3ad1a9f6 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -532,6 +532,24 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
 	u32 val;
 	int ret;
 
+	if (IS_V4(hdev->core)) {
+		val = venus_readl(hdev, WRAPPER_CPU_AXI_HALT);
+		val |= WRAPPER_CPU_AXI_HALT_HALT;
+		venus_writel(hdev, WRAPPER_CPU_AXI_HALT, val);
+
+		ret = readl_poll_timeout(base + WRAPPER_CPU_AXI_HALT_STATUS,
+					 val,
+					 val & WRAPPER_CPU_AXI_HALT_STATUS_IDLE,
+					 POLL_INTERVAL_US,
+					 VBIF_AXI_HALT_ACK_TIMEOUT_US);
+		if (ret) {
+			dev_err(dev, "AXI bus port halt timeout\n");
+			return ret;
+		}
+
+		return 0;
+	}
+
 	/* Halt AXI and AXI IMEM VBIF Access */
 	val = venus_readl(hdev, VBIF_AXI_HALT_CTRL0);
 	val |= VBIF_AXI_HALT_CTRL0_HALT_REQ;
diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
index d327b5cea334..c0b18de1e396 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
+++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
@@ -104,7 +104,9 @@
 
 #define WRAPPER_CPU_CLOCK_CONFIG		(WRAPPER_BASE + 0x2000)
 #define WRAPPER_CPU_AXI_HALT			(WRAPPER_BASE + 0x2008)
+#define WRAPPER_CPU_AXI_HALT_HALT		BIT(16)
 #define WRAPPER_CPU_AXI_HALT_STATUS		(WRAPPER_BASE + 0x200c)
+#define WRAPPER_CPU_AXI_HALT_STATUS_IDLE	BIT(24)
 
 #define WRAPPER_CPU_CGC_DIS			(WRAPPER_BASE + 0x2010)
 #define WRAPPER_CPU_STATUS			(WRAPPER_BASE + 0x2014)
-- 
2.14.1

