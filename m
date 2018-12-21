Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4543BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1018E218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="exHXpIll";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mjtfzmNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbeLUI4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:56:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbeLUI4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:56:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 312E660907; Fri, 21 Dec 2018 08:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382597;
        bh=RSaWkv0sl0p/QepSMbG5ESqqjSsQukb5zjhJuvM1qwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exHXpIlljGWP39cQTpftx/hexN1tk+7GtAM32SVY08rcP1xv6g0jiuiA1oRZc9pxN
         2rp/2Gmd9+biQ9pNKa/YvAk3VJxs186SnsBTdINA7zSkS/Fg0bkL17okgCyIFOwO1P
         FH0yrcpfPt+nwnB5BvJQ52x9/xQDw5oO5CwqL3Fo=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B775608FB;
        Fri, 21 Dec 2018 08:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382596;
        bh=RSaWkv0sl0p/QepSMbG5ESqqjSsQukb5zjhJuvM1qwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjtfzmNVnce2ZI5ZCUt0LtpCS35bu1OVZwLB2XSD1YAbbgOTTfuJcUu+xPdiKIIqY
         DhiMepFnu8JL7duWlWdi6NzRcWEgzaaKztc+tDppxsvZI9PWDxJfDYwtv0N3nu37jf
         zEEZm447X9ejvKEqw+u+S3LxGCCM68mBdYbwYM3I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B775608FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 01/10] dt-bindings: opp: Introduce qcom-opp bindings
Date:   Fri, 21 Dec 2018 14:26:13 +0530
Message-Id: <20181221085622.25573-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221085622.25573-1-rnayak@codeaurora.org>
References: <20181221085622.25573-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm Technologies, Inc. platforms, an OPP node needs
to describe an additional level/corner value that is then communicated
to a remote microprocessor by the CPU, which then takes some
actions (like adjusting voltage values across various rails)
based on the value passed.

Describe these bindings in the qcom-opp bindings document.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/opp/qcom-opp.txt      | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
new file mode 100644
index 000000000000..b3850a5ed59a
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
@@ -0,0 +1,28 @@
+Qualcomm OPP bindings to descibe OPP nodes with corner/level values
+
+OPP tables for devices on Qualcomm platforms require an additional
+platform specific corner/level value to be specified.
+This value is passed on to the RPM (Resource Power Manager) by
+the CPU, which then takes the necessary actions to set a voltage
+rail to an appropriate voltage based on the value passed.
+
+The bindings are based on top of the operating-points-v2 bindings
+described in Documentation/devicetree/bindings/opp/opp.txt,
+with the exception that all of the properties are now optional,
+including the opp-hz property.
+
+Additional properties are described below.
+
+* OPP Table Node
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2-qcom-level"
+
+* OPP Node
+
+Required properties:
+- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
+representing a corner/level that's communicated with a remote microprocessor
+(usually called the RPM) which then translates it into a certain voltage on
+a voltage rail.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

