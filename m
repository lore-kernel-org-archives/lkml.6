Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CF8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50E620675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QdvAfHp1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QdvAfHp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfBVWTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:19:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44596 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfBVWTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:19:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAD34609A8; Fri, 22 Feb 2019 22:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873949;
        bh=xCNFJvpJoucdMcv9Mi45On077kDW81gZ9ob80pgMpYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdvAfHp1nZbGBe/AztUERgapjtdmvGC/SQtPCm7VJ/DCqiBWGkXztSm0Wa1vIKsdn
         K0nPZHKT6T1c1MNhGgN5qdbj771BmSFDF2NVKGLb76dAz5kM9Mr7bExZwHK115X+yn
         CZiFmuPWjpxZ6kgSfrOMNR7Myx7bdE1+frj5S5ho=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 182CC609A8;
        Fri, 22 Feb 2019 22:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550873949;
        bh=xCNFJvpJoucdMcv9Mi45On077kDW81gZ9ob80pgMpYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdvAfHp1nZbGBe/AztUERgapjtdmvGC/SQtPCm7VJ/DCqiBWGkXztSm0Wa1vIKsdn
         K0nPZHKT6T1c1MNhGgN5qdbj771BmSFDF2NVKGLb76dAz5kM9Mr7bExZwHK115X+yn
         CZiFmuPWjpxZ6kgSfrOMNR7Myx7bdE1+frj5S5ho=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 182CC609A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 5/9] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
Date:   Fri, 22 Feb 2019 15:18:46 -0700
Message-Id: <20190222221850.26939-6-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222221850.26939-1-ilina@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
routed to the PDC as interrupts that can be used to wake the system up
from deep low power modes and suspend.

Cc: devicetree@vger.kernel.org
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
index 665aadb5ea28..f0fedbc5d41a 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
@@ -29,6 +29,11 @@ SDM845 platform.
 	Definition: must be 2. Specifying the pin number and flags, as defined
 		    in <dt-bindings/interrupt-controller/irq.h>
 
+- wakeup-parent:
+	Usage: optional
+	Value type: <phandle>
+	Definition: A phandle to the wakeup interrupt controller for the SoC.
+
 - gpio-controller:
 	Usage: required
 	Value type: <none>
@@ -53,7 +58,6 @@ pin, a group, or a list of pins or groups. This configuration can include the
 mux function to select on those pin(s)/group(s), and various pin configuration
 parameters, such as pull-up, drive strength, etc.
 
-
 PIN CONFIGURATION NODES:
 
 The name of each subnode is not important; all subnodes should be enumerated
@@ -160,6 +164,7 @@ Example:
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		wake-parent = <&pdc_intc>;
 
 		qup9_active: qup9-active {
 			mux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

