Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6181C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8F62414E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8F62414E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeGENdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:33:31 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41377 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753844AbeGENdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:24 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 09D09CD66;
        Thu,  5 Jul 2018 16:33:18 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 30/34] media: camss: Add support for RAW MIPI14 on 8x96
Date:   Thu,  5 Jul 2018 16:33:01 +0300
Message-Id: <1530797585-8555-31-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for RAW MIPI14 format for RDI mode on 8x96.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid.c   | 30 ++++++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-csiphy.c |  4 ++++
 drivers/media/platform/qcom/camss/camss-ispif.c  |  4 ++++
 drivers/media/platform/qcom/camss/camss-vfe.c    |  4 ++++
 drivers/media/platform/qcom/camss/camss-video.c  |  8 +++++++
 5 files changed, 50 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 8e9d724..0b7f90d 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -63,11 +63,13 @@
 #define DATA_TYPE_RAW_8BIT		0x2a
 #define DATA_TYPE_RAW_10BIT		0x2b
 #define DATA_TYPE_RAW_12BIT		0x2c
+#define DATA_TYPE_RAW_14BIT		0x2d
 
 #define DECODE_FORMAT_UNCOMPRESSED_6_BIT	0x0
 #define DECODE_FORMAT_UNCOMPRESSED_8_BIT	0x1
 #define DECODE_FORMAT_UNCOMPRESSED_10_BIT	0x2
 #define DECODE_FORMAT_UNCOMPRESSED_12_BIT	0x3
+#define DECODE_FORMAT_UNCOMPRESSED_14_BIT	0x8
 
 #define CSID_RESET_TIMEOUT_MS 500
 
@@ -306,6 +308,34 @@ static const struct csid_format csid_formats_8x96[] = {
 		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
 		12,
 		1,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR14_1X14,
+		DATA_TYPE_RAW_14BIT,
+		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
+		14,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG14_1X14,
+		DATA_TYPE_RAW_14BIT,
+		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
+		14,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG14_1X14,
+		DATA_TYPE_RAW_14BIT,
+		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
+		14,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB14_1X14,
+		DATA_TYPE_RAW_14BIT,
+		DECODE_FORMAT_UNCOMPRESSED_14_BIT,
+		14,
+		1,
 	}
 };
 
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 8d2bcaa..0b7bf1e 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -67,6 +67,10 @@ static const struct csiphy_format csiphy_formats_8x96[] = {
 	{ MEDIA_BUS_FMT_SGBRG12_1X12, 12 },
 	{ MEDIA_BUS_FMT_SGRBG12_1X12, 12 },
 	{ MEDIA_BUS_FMT_SRGGB12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SBGGR14_1X14, 14 },
+	{ MEDIA_BUS_FMT_SGBRG14_1X14, 14 },
+	{ MEDIA_BUS_FMT_SGRBG14_1X14, 14 },
+	{ MEDIA_BUS_FMT_SRGGB14_1X14, 14 },
 };
 
 /*
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 707bca6..649596a 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -140,6 +140,10 @@ static const u32 ispif_formats_8x96[] = {
 	MEDIA_BUS_FMT_SGBRG12_1X12,
 	MEDIA_BUS_FMT_SGRBG12_1X12,
 	MEDIA_BUS_FMT_SRGGB12_1X12,
+	MEDIA_BUS_FMT_SBGGR14_1X14,
+	MEDIA_BUS_FMT_SGBRG14_1X14,
+	MEDIA_BUS_FMT_SGRBG14_1X14,
+	MEDIA_BUS_FMT_SRGGB14_1X14,
 };
 
 /*
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 69735da..269b7c8 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -97,6 +97,10 @@ static const struct vfe_format formats_rdi_8x96[] = {
 	{ MEDIA_BUS_FMT_SGBRG12_1X12, 12 },
 	{ MEDIA_BUS_FMT_SGRBG12_1X12, 12 },
 	{ MEDIA_BUS_FMT_SRGGB12_1X12, 12 },
+	{ MEDIA_BUS_FMT_SBGGR14_1X14, 14 },
+	{ MEDIA_BUS_FMT_SGBRG14_1X14, 14 },
+	{ MEDIA_BUS_FMT_SGRBG14_1X14, 14 },
+	{ MEDIA_BUS_FMT_SRGGB14_1X14, 14 },
 };
 
 static const struct vfe_format formats_pix_8x96[] = {
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 28d53bf..2e19bc8 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -111,6 +111,14 @@ static const struct camss_format_info formats_rdi_8x96[] = {
 	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
 	{ MEDIA_BUS_FMT_SRGGB12_1X12, V4L2_PIX_FMT_SRGGB12P, 1,
 	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+	{ MEDIA_BUS_FMT_SBGGR14_1X14, V4L2_PIX_FMT_SBGGR14P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 14 } },
+	{ MEDIA_BUS_FMT_SGBRG14_1X14, V4L2_PIX_FMT_SGBRG14P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 14 } },
+	{ MEDIA_BUS_FMT_SGRBG14_1X14, V4L2_PIX_FMT_SGRBG14P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 14 } },
+	{ MEDIA_BUS_FMT_SRGGB14_1X14, V4L2_PIX_FMT_SRGGB14P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 14 } },
 };
 
 static const struct camss_format_info formats_pix_8x16[] = {
-- 
2.7.4

