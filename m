Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F65C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC5321721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JLl4MQTk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dkyc32QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAVGer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:34:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAVGeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:34:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6802B6098A; Tue, 22 Jan 2019 06:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138884;
        bh=t+7VFsYr21LVGhDoaiu71aEFa4FmA54Z0rNp7gXcbag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLl4MQTk3A2hxFYrMUMoECnaUQPMbMKbVawcMUsknj94Uug2lD1Iw6hTRwHg0V+93
         mwKNBqdJg8+3PHqxQzQFR5/Am69Z8nFfmpIeY2GJKyArti6rcVPt8REZv8qdMa/8SY
         F7YuGfa+ryUbtPHp8bJpkEUxcizBUJzv4Ucj+AUg=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE6E76095F;
        Tue, 22 Jan 2019 06:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548138877;
        bh=t+7VFsYr21LVGhDoaiu71aEFa4FmA54Z0rNp7gXcbag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dkyc32QO63cJ9YXD7K4kbfLq8G6r4jmH2qSsiMXhF/Wd83Z2UFc1MV1N5vcJ6mYnT
         n8quJGFPCLUTJjspFfnkkQqB3lpvoKyVXLDgBSubYE97uUeVcnbxb4jyfIqnB+n6NE
         AgX5drNrcMcxiKpLMwEwQq8QbjLaS5yaCkRDMtao=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE6E76095F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 5/6] tty: serial: qcom_geni_serial: Add interconnect support
Date:   Tue, 22 Jan 2019 12:03:35 +0530
Message-Id: <1548138816-1149-6-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the interconnect paths for Uart based Serial Engine device
and vote accordingly based on maximum supported Uart frequency.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a72d6d9..e2ea499 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/interconnect.h>
 
 /* UART specific GENI registers */
 #define SE_UART_LOOPBACK_CFG		0x22c
@@ -1348,6 +1349,22 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Set the bus quota to a reasonable value */
+	port->se.avg_bw = console ? Bps_to_icc(1000) : Bps_to_icc(2500);
+	port->se.peak_bw = Bps_to_icc(76800000);
+	ret = geni_interconnect_init(&port->se);
+	if (ret) {
+		dev_err(&pdev->dev, "interconnect_init failed %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Vote for interconnect path early. This has to move as part of
+	 * Runtime PM APIs when implemented for better control betwen
+	 * console and non-console usecases
+	 */
+	geni_icc_update_bw(&port->se, true);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
@@ -1385,8 +1402,15 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
+	int ret;
+
+	ret = uart_suspend_port(uport->private_data, uport);
+	if (ret)
+		return ret;
+
+	geni_icc_update_bw(&port->se, false);
 
-	return uart_suspend_port(uport->private_data, uport);
+	return 0;
 }
 
 static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
@@ -1394,6 +1418,7 @@ static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
+	geni_icc_update_bw(&port->se, true);
 	return uart_resume_port(uport->private_data, uport);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

