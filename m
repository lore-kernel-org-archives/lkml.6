Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1BE218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfB0RZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:25:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:44139 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbfB0RZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:25:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303030790"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 09:25:27 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org
Cc:     thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 1/5] Documentation: dt: edac: Fix Stratix10 IRQ bindings
Date:   Wed, 27 Feb 2019 11:27:21 -0600
Message-Id: <1551288445-22335-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Fix Stratix10 ECC bindings to specify only the single
bit error. On Stratix10 double bit errors are handled
as SErrors instead of interrupts.
Indicate the differences between the ARM64 and ARM32
EDAC architecture in the bindings.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2 No change
---
 .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 23 +++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
index 5626560a6cfd..a0ac50e15912 100644
--- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
@@ -236,33 +236,42 @@ Stratix10 SoCFPGA ECC Manager
 The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
 in a shared register similar to the Arria10. However, ECC requires
 access to registers that can only be read from Secure Monitor with
-SMC calls. Therefore the device tree is slightly different.
+SMC calls. Therefore the device tree is slightly different. Note that
+only 1 interrupt is sent because the double bit errors are treated as
+SErrors instead of IRQ.
 
 Required Properties:
 - compatible : Should be "altr,socfpga-s10-ecc-manager"
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt.
+- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
+	              containing the ECC manager registers.
+- interrupts : Should be single bit error interrupt.
 - interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
 - #interrupt-cells : must be set to 2.
+- #address-cells: must be 1
+- #size-cells: must be 1
+- ranges : standard definition, should translate from local addresses
 
 Subcomponents:
 
 SDRAM ECC
 Required Properties:
 - compatible : Should be "altr,sdram-edac-s10"
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
+- interrupts : Should be single bit error interrupt.
 
 Example:
 
 	eccmgr {
 		compatible = "altr,socfpga-s10-ecc-manager";
-		interrupts = <0 15 4>, <0 95 4>;
+		altr,sysmgr-syscon = <&sysmgr>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupts = <0 15 4>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		ranges;
 
 		sdramedac {
 			compatible = "altr,sdram-edac-s10";
-			interrupts = <16 4>, <48 4>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
-- 
2.7.4

