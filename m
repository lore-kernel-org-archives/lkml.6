Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8308C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9864F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eo5utBXW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KVRRRq5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfAREsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:48:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfAREsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:48:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7EE8A60585; Fri, 18 Jan 2019 04:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547786904;
        bh=JlEtVsITCcS+TxqN2QFX79eFG2JwLKoageYOHryOmSQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eo5utBXWOqxGOMA7+X2wDl8ABLYZ+2UyUirKMl86hun1WE0u5BQBEjE7uUEhOSWlz
         5VAM05lSkU5MwupcvqMIQvWdYUUTYFPzYJq3tOJET+hfriwAvHjtVSkVTYnPTugei5
         0tcDUTh/J/5oENIaPvtHdz3qYZ6walgrgcWIaqJA=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AE37601B4;
        Fri, 18 Jan 2019 04:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547786903;
        bh=JlEtVsITCcS+TxqN2QFX79eFG2JwLKoageYOHryOmSQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KVRRRq5L1c7D0X/lRcrM8gVUE25xvF9+KiGIU1nNGR1E5KhyqJ+bo4PTN89lssEvn
         UZtYqRM8Dz4xAjWLI7tQXN9BrUzkd4Cy/3SBxrGitsSTdMPjAWMWzaLN37dN5exvof
         YeGy2hjbNnCKuB2VgjAfqwuSWU1Q+4eDtDNk11UE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AE37601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
Date:   Fri, 18 Jan 2019 10:18:01 +0530
Message-Id: <20190118044801.7312-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since QCOM_RPMPD is bool and it depends on QCOM_SMD_RPM
which is tristate, configurations such as arm64:allmodconfig
result in

CONFIG_QCOM_RPMPD=y
CONFIG_QCOM_SMD_RPM=m

This in turn results in

drivers/soc/qcom/rpmpd.o: In function `rpmpd_send_corner':
rpmpd.c:(.text+0x10c): undefined reference to `qcom_rpm_smd_write'
drivers/soc/qcom/rpmpd.o: In function `rpmpd_power_on':
rpmpd.c:(.text+0x3b4): undefined reference to `qcom_rpm_smd_write'
drivers/soc/qcom/rpmpd.o: In function `rpmpd_power_off':
rpmpd.c:(.text+0x520): undefined reference to `qcom_rpm_smd_write'
make: *** [vmlinux] Error 1

Fix it by making QCOM_RPMPD depend on QCOM_SMD_RPM=y

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
Andy, this one should be applied on top of my v11 to add
rpmpd/rpmhpd drivers [1] and the fix from Bjorn to drop
A family RPM dependency [2]

[1] https://lkml.org/lkml/2019/1/9/1257
[2] https://lkml.org/lkml/2019/1/17/5

 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a5d5167c3f16..1ee298f6bf17 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -109,7 +109,7 @@ config QCOM_RPMHPD
 
 config QCOM_RPMPD
 	bool "Qualcomm RPM Power domain driver"
-	depends on QCOM_SMD_RPM
+	depends on QCOM_SMD_RPM=y
 	help
 	  QCOM RPM Power domain driver to support power-domains with
 	  performance states. The driver communicates a performance state
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

