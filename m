Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485FF21A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XkYhHSma";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VVOAETes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485FF21A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbeHFPhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:37:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeHFPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:37:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 06E5460541; Mon,  6 Aug 2018 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562123;
        bh=IHtR6MLY3iZf4801tR1wH3CgxqOCaZO3kbJrWoI3qq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkYhHSmauLuParnOon6OJiLyoZCKnLhODiakzRRPhMnrVs7y3RHfjxkNKWCoHZtr1
         my2nMSwRmrBgbtbTG7J6RVdWVa/ASnww+z1ipFEloNoumZUu2N56BAF+QUSRAkGLSG
         VX6bXMjx32EAXlANCKhm6cyxOSUPalSVM50ucYS4=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEC1A60B1E;
        Mon,  6 Aug 2018 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562121;
        bh=IHtR6MLY3iZf4801tR1wH3CgxqOCaZO3kbJrWoI3qq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VVOAETes/MimA5OeNXKvaiD+LLaJN98Z3jyOeFN4g4k7ag90VEwvQascncqJdK0qw
         cbHA3U1ER0Q4oEt5qmqUst+7Z4JaFnOXjMizP8naWecdBHs8Ds4ne+PtXJvESJ5bwu
         fbiKTp/ZbJ9vNyZU/u02fGTST1/s//mzRrSGJMBQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEC1A60B1E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v4 4/4] venus: firmware: register separate driver for firmware device
Date:   Mon,  6 Aug 2018 18:58:05 +0530
Message-Id: <1533562085-8773-5-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A separate child device is added for video firmware.
This is needed to
[1] configure the firmware context bank with the desired SID.
[2] ensure that the iova for firmware region is from 0x0.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
---
 .../devicetree/bindings/media/qcom,venus.txt       | 17 +++++++-
 drivers/media/platform/qcom/venus/core.c           | 50 +++++++++++++++++++---
 drivers/media/platform/qcom/venus/firmware.c       | 18 ++++++++
 drivers/media/platform/qcom/venus/firmware.h       |  2 +
 4 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
index 00d0d1b..975fb12 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus.txt
+++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
@@ -53,7 +53,7 @@
 
 * Subnodes
 The Venus video-codec node must contain two subnodes representing
-video-decoder and video-encoder.
+video-decoder and video-encoder, one optional firmware subnode.
 
 Every of video-encoder or video-decoder subnode should have:
 
@@ -79,6 +79,17 @@ Every of video-encoder or video-decoder subnode should have:
 		    power domain which is responsible for collapsing
 		    and restoring power to the subcore.
 
+The firmware sub node must have:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Value should contain "venus-firmware"
+- iommus:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: A list of phandle and IOMMU specifier pairs.
+
 * An Example
 	video-codec@1d00000 {
 		compatible = "qcom,msm8916-venus";
@@ -105,4 +116,8 @@ Every of video-encoder or video-decoder subnode should have:
 			clock-names = "core";
 			power-domains = <&mmcc VENUS_CORE1_GDSC>;
 		};
+		venus-firmware {
+			compatible = "qcom,venus-firmware";
+			iommus = <&apps_smmu 0x10b2 0x0>;
+		}
 	};
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 393994e..555ba21 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -179,6 +179,21 @@ static u32 to_v4l2_codec_type(u32 codec)
 	}
 }
 
+static int store_firmware_dev(struct device *dev, void *data)
+{
+	struct venus_core *core = data;
+
+	if (!core)
+		return -EINVAL;
+
+	if (of_device_is_compatible(dev->of_node, "qcom,venus-firmware")) {
+		core->fw.dev = dev;
+		core->no_tz = true;
+	}
+
+	return 0;
+}
+
 static int venus_enumerate_codecs(struct venus_core *core, u32 type)
 {
 	const struct hfi_inst_ops dummy_ops = {};
@@ -284,6 +299,13 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_runtime_disable;
 
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_runtime_disable;
+
+	/* Attempt to store firmware device */
+	device_for_each_child(dev, core, store_firmware_dev);
+
 	ret = venus_boot(core);
 	if (ret)
 		goto err_runtime_disable;
@@ -308,10 +330,6 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core_deinit;
 
-	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
-	if (ret)
-		goto err_dev_unregister;
-
 	ret = pm_runtime_put_sync(dev);
 	if (ret)
 		goto err_dev_unregister;
@@ -488,7 +506,29 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
 		.pm = &venus_pm_ops,
 	},
 };
-module_platform_driver(qcom_venus_driver);
+
+static int __init venus_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&qcom_video_firmware_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&qcom_venus_driver);
+	if (ret)
+		platform_driver_unregister(&qcom_video_firmware_driver);
+
+	return ret;
+}
+module_init(venus_init);
+
+static void __exit venus_exit(void)
+{
+	platform_driver_unregister(&qcom_venus_driver);
+	platform_driver_unregister(&qcom_video_firmware_driver);
+}
+module_exit(venus_exit);
 
 MODULE_ALIAS("platform:qcom-venus");
 MODULE_DESCRIPTION("Qualcomm Venus video encoder and decoder driver");
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 30130d4..d26797d 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -12,6 +12,7 @@
  *
  */
 
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
@@ -226,3 +227,20 @@ int venus_shutdown(struct venus_core *core)
 
 	return ret;
 }
+
+static const struct of_device_id firmware_dt_match[] = {
+	{ .compatible = "qcom,venus-firmware" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, firmware_dt_match);
+
+struct platform_driver qcom_video_firmware_driver = {
+	.driver = {
+			.name = "qcom-video-firmware",
+			.of_match_table = firmware_dt_match,
+	},
+};
+
+MODULE_ALIAS("platform:qcom-video-firmware");
+MODULE_DESCRIPTION("Qualcomm Venus firmware driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
index 8456b59..de5e057 100644
--- a/drivers/media/platform/qcom/venus/firmware.h
+++ b/drivers/media/platform/qcom/venus/firmware.h
@@ -16,6 +16,8 @@
 
 struct device;
 
+extern struct platform_driver qcom_video_firmware_driver;
+
 int venus_boot(struct venus_core *core);
 int venus_shutdown(struct venus_core *core);
 int venus_set_hw_state(struct venus_core *core, bool suspend);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

