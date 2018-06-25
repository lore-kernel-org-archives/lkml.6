Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D135C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58BC257F9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58BC257F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeFYLXM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:23:12 -0400
Received: from foss.arm.com ([217.140.101.70]:54922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932507AbeFYLXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:23:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB4B22C8;
        Mon, 25 Jun 2018 04:23:04 -0700 (PDT)
Received: from localhost.localdomain.com (unknown [10.1.207.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB62C3F59C;
        Mon, 25 Jun 2018 04:23:02 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 4/6] dts: bindings: Document device tree binding for CATU
Date:   Mon, 25 Jun 2018 12:22:11 +0100
Message-Id: <20180625112213.23492-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180625112213.23492-1-suzuki.poulose@arm.com>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document CATU device-tree bindings. CATU augments the TMC-ETR
by providing an improved Scatter Gather mechanism for streaming
trace data to non-contiguous system RAM pages.

Cc: devicetree@vger.kernel.org
Cc: frowand.list@gmail.com
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt          | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 9aa30a1..5d1ad09 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -39,6 +39,8 @@ its hardware characteristcs.
 
 		- System Trace Macrocell:
 			"arm,coresight-stm", "arm,primecell"; [1]
+		- Coresight Address Translation Unit (CATU)
+			"arm,coresight-catu", "arm,primecell";
 
 	* reg: physical base address and length of the register
 	  set(s) of the component.
@@ -90,6 +92,10 @@ its hardware characteristcs.
 	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
 	  use the SG mode on this system.
 
+* Optional property for CATU :
+	* interrupts : Exactly one SPI may be listed for reporting the address
+	  error
+
 Example:
 
 1. Sinks
@@ -121,6 +127,35 @@ Example:
 		};
 	};
 
+	etr@20070000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20070000 0 0x1000>;
+
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* input port */
+			port@0 {
+				reg =  <0>;
+				etr_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&replicator2_out_port0>;
+				};
+			};
+
+			/* CATU link represented by output port */
+			port@1 {
+				reg = <1>;
+				etr_out_port: endpoint {
+					remote-endpoint = <&catu_in_port>;
+				};
+			};
+		};
+	};
+
 2. Links
 	replicator {
 		/* non-configurable replicators don't show up on the
@@ -250,5 +285,23 @@ Example:
 		};
 	};
 
+5. CATU
+
+	catu@207e0000 {
+		compatible = "arm,coresight-catu", "arm,primecell";
+		reg = <0 0x207e0000 0 0x1000>;
+
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		port {
+			catu_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&etr_out_port>;
+			};
+		};
+	};
+
 [1]. There is currently two version of STM: STM32 and STM500.  Both
 have the same HW interface and as such don't need an explicit binding name.
-- 
2.9.5

