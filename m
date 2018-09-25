Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1067C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788972098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VCjagNhS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S76hxZD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788972098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeIYVNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:13:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbeIYVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:13:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6383260C8C; Tue, 25 Sep 2018 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537887906;
        bh=3voHQfnMjwudsGfW1kxVEiavU58zaIT/jD7GDALRsc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCjagNhSEVSvpLE4+frWxtfUrNvkQMeJd3vdy05n45treM/VH4cPyVbJZfSPnXdeh
         q6dxvVItNvnQTLnAeiG2V+btDcqlTNyWgZJOntTNDg4JMnpjISlEbFbUEHR/g4b1b+
         Cx+SNfP5Z+nwha+H2Jgzy76ck/j4022n7yIkDKR0=
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDFDD60B7F;
        Tue, 25 Sep 2018 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537887901;
        bh=3voHQfnMjwudsGfW1kxVEiavU58zaIT/jD7GDALRsc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S76hxZD6qPQdRi28cFQGl0Om9AvIu5LZ+U6kBpdS6tD84Hox0RiZcc+p0jjXqqrx+
         892FPWpB1kQgq5eGfbuoN+L/HAvDSdHwThZCKT9yvJii7FnGa7UiWzdkyNClgzWqzl
         udVqgLIr8vvRv5ILJTEZaECXSxuUWO3F6IhDiV08=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDFDD60B7F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        evgreen@chromium.org, dianders@google.com,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Add flag for restoring dll
Date:   Tue, 25 Sep 2018 20:34:34 +0530
Message-Id: <1537887875-29494-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dll settings of SDHC controller needs to be restored whenever
controller clocks are gated. This restoration is needed only on
few SDHCI-MSM controllers. This dt flag indicates whether dll
restoration is needed or not.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 3720385..207ce36 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -31,6 +31,8 @@ Optional properties:
 					BUS_OFF states in power irq. Should be specified in
 					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
 					Units uA.
+- qcom,restore-dll-config - Flag indicates that restoration of dll config after clock gating
+			    is needed on given platform. This wouldn't be needed for every MSM.
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -49,6 +51,8 @@ Example:
 
 		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 		clock-names = "core", "iface";
+
+		qcom,restore-dll-config;
 	};
 
 	sdhc_2: sdhci@f98a4900 {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

