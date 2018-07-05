Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306FDC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE35920847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7BLU1+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE35920847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeGENOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:14:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50214 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754305AbeGENFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so11041607wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JTs56AHvy6n4KWdfQCk5+mkf+fJThH/BkJrEXFnLkOk=;
        b=i7BLU1+i6u6aYm292awS7/VVhRt8OUoCtcevBsE+dyXgQk1Vr9nxm++Db6twC+VBsU
         5Od0HbxpM7l/gnd76vfvWocAmNB4lhbcal1ok6mNj8U/QSEkiw8w1UNNn73qAz0rBtkh
         vCZoqwPi5K4KVj6HJ/fa0K4rkseK6RWgYcWsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JTs56AHvy6n4KWdfQCk5+mkf+fJThH/BkJrEXFnLkOk=;
        b=eOS0PsrFLVvx9Pl7yu8QmE65bt3vhhAeMN/Be68Ms97KZISeXSQNKe0saZ0usAiTkN
         vn8pFifYMOdChLlxj4cfPJ5Piga5kKQfqCQ2hpaGhBMkxGt7IF6gzNt7tPsqEoFjQ15S
         P8aE+hC/5v3yIGOCQHGkYOM1B7Cgm5/2l8MkDP5MFoUjp6NjOPiNU1kubHdHA/EbOzor
         igmNbb8aXgPNhLo+WX7F7KVQtl1xcdXckYxCmFWB5LnpRBBOeqiACqtOhitTL9oeDeq+
         Pa0MB87c9EJbZtqoNHEWHTcGvyEFe1gwCl7X0UDTq8po9ZIBxgyeCkB4iqtsUkiwyP61
         LxZg==
X-Gm-Message-State: APt69E1k70ivynkaYYwnsYe2ew/rLEzwQkqFwsNT7bYWRlda745RTvLi
        qN0Hvj6ogXWSPx6RoY4Fl3Nt1g==
X-Google-Smtp-Source: AAOMgpexuQH+OZnpEnbP+TxLEyvi9ainjPp+/FX2rGUKw13gBVzq85NQDgyb8/2jg+PDz4N436+1qA==
X-Received: by 2002:a1c:ac03:: with SMTP id v3-v6mr3962769wme.100.1530795914473;
        Thu, 05 Jul 2018 06:05:14 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:13 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 07/27] venus: hfi_venus: add halt AXI support for Venus 4xx
Date:   Thu,  5 Jul 2018 16:03:41 +0300
Message-Id: <20180705130401.24315-8-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
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

