Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF5120870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF5120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeG3OTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:19:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58401 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbeG3OTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:19:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 092F420876; Mon, 30 Jul 2018 14:44:24 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E9E020765;
        Mon, 30 Jul 2018 14:44:23 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net
Cc:     kishon@ti.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next 02/10] dt-bindings: net: ocelot: remove hsio from the list of register address spaces
Date:   Mon, 30 Jul 2018 14:43:47 +0200
Message-Id: <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSIO register address space should be handled outside of the MAC
controller as there are some registers for PLL5 configuring,
SerDes/switch port muxing and a thermal sensor IP, so let's remove it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 Documentation/devicetree/bindings/mips/mscc.txt       | 16 ++++++++++++-
 Documentation/devicetree/bindings/net/mscc-ocelot.txt |  9 ++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
index ae15ec3..bc817e9 100644
--- a/Documentation/devicetree/bindings/mips/mscc.txt
+++ b/Documentation/devicetree/bindings/mips/mscc.txt
@@ -41,3 +41,19 @@ Example:
 		compatible = "mscc,ocelot-cpu-syscon", "syscon";
 		reg = <0x70000000 0x2c>;
 	};
+
+o HSIO regs:
+
+The SoC has a few registers (HSIO) handling miscellaneous functionalities:
+configuration and status of PLL5, RCOMP, SyncE, SerDes configurations and
+status, SerDes muxing and a thermal sensor.
+
+Required properties:
+- compatible: Should be "mscc,ocelot-hsio", "syscon", "simple-mfd"
+- reg : Should contain registers location and length
+
+Example:
+	syscon@10d0000 {
+		compatible = "mscc,ocelot-hsio", "syscon", "simple-mfd";
+		reg = <0x10d0000 0x10000>;
+	};
diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
index 0a84711..9e5c17d 100644
--- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
+++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
@@ -12,7 +12,6 @@ Required properties:
   - "sys"
   - "rew"
   - "qs"
-  - "hsio"
   - "qsys"
   - "ana"
   - "portX" with X from 0 to the number of last port index available on that
@@ -45,7 +44,6 @@ Example:
 		reg = <0x1010000 0x10000>,
 		      <0x1030000 0x10000>,
 		      <0x1080000 0x100>,
-		      <0x10d0000 0x10000>,
 		      <0x11e0000 0x100>,
 		      <0x11f0000 0x100>,
 		      <0x1200000 0x100>,
@@ -59,10 +57,9 @@ Example:
 		      <0x1280000 0x100>,
 		      <0x1800000 0x80000>,
 		      <0x1880000 0x10000>;
-		reg-names = "sys", "rew", "qs", "hsio", "port0",
-			    "port1", "port2", "port3", "port4", "port5",
-			    "port6", "port7", "port8", "port9", "port10",
-			    "qsys", "ana";
+		reg-names = "sys", "rew", "qs", "port0", "port1", "port2",
+			    "port3", "port4", "port5", "port6", "port7",
+			    "port8", "port9", "port10", "qsys", "ana";
 		interrupts = <21 22>;
 		interrupt-names = "xtr", "inj";
 
-- 
git-series 0.9.1
