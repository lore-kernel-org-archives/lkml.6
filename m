Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C93C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F03324090
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgqxqkXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F03324090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeGENGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:06:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43955 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbeGENFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so1136256wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ThhxevIU3epv9lgxlCyqJq5OSMzAnmUAMY3rX7cEds=;
        b=jgqxqkXdJU6dIeNwID5AYkTWa0npGfEEiYElQwgS3tx/Siu9P0xX2mWthp3kJ+TvH+
         y1h4slnHe1fFV2igclZa/RitP51INZB6d6u9GpQFPV8PdG7X0WivGEzILLCwWi2cDstu
         N8GKlqqS9IDw/cvCBuLGmL+hkDQJHtSLsdUhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ThhxevIU3epv9lgxlCyqJq5OSMzAnmUAMY3rX7cEds=;
        b=G3INeTgs4a2CL20VYcCFbKbOZEu5uTAHCCeSkwSElISSCXVVKcylgrUpALFwA6PTrv
         aoWIto42WDRdYqQ+agaUVYCHIHmZQFaUum3wM5upYX4qjURzuZanUQfHkGHnX98AT4GO
         DblfgyuplSTrCOcpC62RyHbYqTq8mYIYrTBppIt6nzxLIAZdyNfmk6xsfIi3OiyubBu+
         s1oFRwXIQvfDn0aL+wdzQeyFRX4MHqRwolY1JcCt56W8EcjcnO6eKOD63rgz8JImg9ws
         WPxDq7jJI0WVQGSLBwzXrkvKSzUqVhrwsifroaUSbRvbn8k1kHoWm0+WgBEr9NEXR6iZ
         dYWA==
X-Gm-Message-State: APt69E2dNrIO52V0qwuY6l2g+JgBdMyef2MHFr8ZxvcbVmtPEFUKChWO
        QBhzBd7R2YB+YdwbgVdeTm3j+Q==
X-Google-Smtp-Source: AAOMgpfM+ky3X2shxoMmgbHNqf+pIsipxrmc/ehNWgMQJ1egHvxf3IkqGwbquXWFt+dooOTSeIZtRw==
X-Received: by 2002:adf:874b:: with SMTP id 11-v6mr4227776wrz.117.1530795935999;
        Thu, 05 Jul 2018 06:05:35 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:35 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 26/27] venus: core: add sdm845 DT compatible and resource data
Date:   Thu,  5 Jul 2018 16:04:00 +0300
Message-Id: <20180705130401.24315-27-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds sdm845 DT compatible string with it's resource
data table.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/qcom,venus.txt       |  1 +
 drivers/media/platform/qcom/venus/core.c           | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
index 2693449daf73..00d0d1bf7647 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus.txt
+++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
@@ -6,6 +6,7 @@
 	Definition: Value should contain one of:
 		- "qcom,msm8916-venus"
 		- "qcom,msm8996-venus"
+		- "qcom,sdm845-venus"
 - reg:
 	Usage: required
 	Value type: <prop-encoded-array>
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 381bfdd688db..bb6add9d340e 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -450,9 +450,31 @@ static const struct venus_resources msm8996_res = {
 	.fwname = "qcom/venus-4.2/venus.mdt",
 };
 
+static const struct freq_tbl sdm845_freq_table[] = {
+	{ 1944000, 380000000 },	/* 4k UHD @ 60 */
+	{  972000, 320000000 },	/* 4k UHD @ 30 */
+	{  489600, 200000000 },	/* 1080p @ 60 */
+	{  244800, 100000000 },	/* 1080p @ 30 */
+};
+
+static const struct venus_resources sdm845_res = {
+	.freq_tbl = sdm845_freq_table,
+	.freq_tbl_size = ARRAY_SIZE(sdm845_freq_table),
+	.clks = {"core", "iface", "bus" },
+	.clks_num = 3,
+	.max_load = 2563200,
+	.hfi_version = HFI_VERSION_4XX,
+	.vmem_id = VIDC_RESOURCE_NONE,
+	.vmem_size = 0,
+	.vmem_addr = 0,
+	.dma_mask = 0xe0000000 - 1,
+	.fwname = "qcom/venus-5.2/venus.mdt",
+};
+
 static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
 	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
+	{ .compatible = "qcom,sdm845-venus", .data = &sdm845_res, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, venus_dt_match);
-- 
2.14.1

