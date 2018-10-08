Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D9C676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D654820841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="km9+3ZIJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BLUOELN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D654820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJHUeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:34:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:34:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7980060C1D; Mon,  8 Oct 2018 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539004959;
        bh=nSLT5lHo5MhIbh9ymFOKPVTgS1R7enMrsy0vHjPgusE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=km9+3ZIJ9OIZFsaJYwenK8Il1HXmqa4hI/WBfDa8FbD3lvCCScyNUcEdG14wNTJ+w
         QZ/7rkVlQbHpi59FgNBOgyIx/Xu0CVD+lce6CXwuIhweXsyFu0dYhWI0kLHUODVdPo
         K6biAAVJCNd2ArMbxq+5OlNfoAwJxrYLoAt84+C4=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C375D6083C;
        Mon,  8 Oct 2018 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539004958;
        bh=nSLT5lHo5MhIbh9ymFOKPVTgS1R7enMrsy0vHjPgusE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLUOELN5lM3QoZ3sBhJRnDLCHRWrsAiWFBjwzc4hTOqK3XrZa9sOlwhbREVUlmpjN
         AR0EFfSlND/UGI0HmqKcI1GHk0XM3k+JBCVAfN/HpdHK4ixBxC1CLY5LRnSgQjTF9H
         td14PULluBX0+k0g438yMdyYgv30q9LnD3LIrwDI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C375D6083C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, evgreen@chromium.org, dianders@google.com
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 2/3] dt-bindings: mmc: sdhci-msm: Add entries for passing load values
Date:   Mon,  8 Oct 2018 18:48:58 +0530
Message-Id: <1539004739-32060-3-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

The load a particular sdhc controller should request from a regulator
is device specific and hence each device should individually vote for
the required load.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 502b3b8..cb22178 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -25,6 +25,10 @@ Required properties:
 	"xo"	- TCXO clock (optional)
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
+- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
+					BUS_OFF states in power irq. Should be specified in
+					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
+					Units uA.
 
 Example:
 
@@ -36,7 +40,9 @@ Example:
 		non-removable;
 
 		vmmc-supply = <&pm8941_l20>;
+		qcom,vmmc-current-level-microamp = <200 570000>;
 		vqmmc-supply = <&pm8941_s3>;
+		qcom,vqmmc-current-level-microamp = <200 325000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
@@ -53,7 +59,9 @@ Example:
 		cd-gpios = <&msmgpio 62 0x1>;
 
 		vmmc-supply = <&pm8941_l21>;
+		qcom,vmmc-current-level-microamp = <200 800000>;
 		vqmmc-supply = <&pm8941_l13>;
+		qcom,vqmmc-current-level-microamp = <200 22000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

