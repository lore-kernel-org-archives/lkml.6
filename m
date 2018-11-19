Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3672420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3672420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeKSVPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:15:13 -0500
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:10496 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbeKSVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:15:13 -0500
X-Greylist: delayed 1557 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2018 16:15:11 EST
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1gOgkd-000OCE-Ar; Mon, 19 Nov 2018 11:25:55 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1gOgkd-0007f0-5a; Mon, 19 Nov 2018 11:25:55 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 4/4] ARM: dts: Add stmpe-adc driver to relevant devicetrees
Date:   Mon, 19 Nov 2018 11:25:28 +0100
Message-Id: <20181119102528.2830-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119102528.2830-1-dev@pschenker.ch>
References: <20181119102528.2830-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Activate the stmpe-adc driver as found on Apalis/Colibri iMX6/T30 modules

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2:
 - Put common ADC settings in mfd

 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 23 +++++++++++++++--------
 arch/arm/boot/dts/tegra30-apalis.dtsi  | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-colibri.dtsi | 22 ++++++++++++++--------
 4 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 3dc99dd8dde1..8db476d8978d 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -331,11 +331,18 @@
 		id = <0>;
 		blocks = <0x5>;
 		irq-trigger = <0x1>;
+		/* 3.25 MHz ADC clock speed */
+		st,adc-freq = <1>;
+		/* 12-bit ADC */
+		st,mod-12b = <1>;
+		/* internal ADC reference */
+		st,ref-sel = <0>;
+		/* ADC converstion time: 80 clocks */
+		st,sample-time = <4>;
+		/* forbid to use ADC channels 3-0 (touch) */
 
 		stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
-			/* 3.25 MHz ADC clock speed */
-			st,adc-freq = <1>;
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
 			/* 7 length fractional part in z */
@@ -345,17 +352,16 @@
 			 * current limit value
 			 */
 			st,i-drive = <1>;
-			/* 12-bit ADC */
-			st,mod-12b = <1>;
-			/* internal ADC reference */
-			st,ref-sel = <0>;
-			/* ADC converstion time: 80 clocks */
-			st,sample-time = <4>;
 			/* 1 ms panel driver settling time */
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
 		};
+
+		stmpe_adc {
+			compatible = "st,stmpe-adc";
+			st,norequest-mask = <0x0F>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 87e15e7cb32b..2e303d79c7f8 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -262,11 +262,18 @@
 		id = <0>;
 		blocks = <0x5>;
 		irq-trigger = <0x1>;
+		/* 3.25 MHz ADC clock speed */
+		st,adc-freq = <1>;
+		/* 12-bit ADC */
+		st,mod-12b = <1>;
+		/* internal ADC reference */
+		st,ref-sel = <0>;
+		/* ADC converstion time: 80 clocks */
+		st,sample-time = <4>;
+		/* forbid to use ADC channels 3-0 (touch) */
 
 		stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
-			/* 3.25 MHz ADC clock speed */
-			st,adc-freq = <1>;
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
 			/* 7 length fractional part in z */
@@ -276,17 +283,17 @@
 			 * current limit value
 			 */
 			st,i-drive = <1>;
-			/* 12-bit ADC */
-			st,mod-12b = <1>;
-			/* internal ADC reference */
-			st,ref-sel = <0>;
-			/* ADC converstion time: 80 clocks */
-			st,sample-time = <4>;
 			/* 1 ms panel driver settling time */
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
 		};
+
+		stmpe_adc {
+			compatible = "st,stmpe-adc";
+			/* 3.25 MHz ADC clock speed */
+			st,norequest-mask = <0x0F>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 7f112f192fe9..850b0d13549a 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -976,11 +976,18 @@
 			id = <0>;
 			blocks = <0x5>;
 			irq-trigger = <0x1>;
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq = <1>;
+			/* 12-bit ADC */
+			st,mod-12b = <1>;
+			/* internal ADC reference */
+			st,ref-sel = <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time = <4>;
+			/* forbid to use ADC channels 3-0 (touch) */
 
 			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
-				/* 3.25 MHz ADC clock speed */
-				st,adc-freq = <1>;
 				/* 8 sample average control */
 				st,ave-ctrl = <3>;
 				/* 7 length fractional part in z */
@@ -990,17 +997,16 @@
 				 * current limit value
 				 */
 				st,i-drive = <1>;
-				/* 12-bit ADC */
-				st,mod-12b = <1>;
-				/* internal ADC reference */
-				st,ref-sel = <0>;
-				/* ADC converstion time: 80 clocks */
-				st,sample-time = <4>;
 				/* 1 ms panel driver settling time */
 				st,settling = <3>;
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay = <5>;
 			};
+
+			stmpe_adc {
+				compatible = "st,stmpe-adc";
+				st,norequest-mask = <0x0F>;
+			};
 		};
 
 		/*
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 35af03ca9e90..1f9198bb24ff 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -845,11 +845,18 @@
 			id = <0>;
 			blocks = <0x5>;
 			irq-trigger = <0x1>;
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq = <1>;
+			/* 12-bit ADC */
+			st,mod-12b = <1>;
+			/* internal ADC reference */
+			st,ref-sel = <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time = <4>;
+			/* forbid to use ADC channels 3-0 (touch) */
 
 			stmpe_touchscreen {
 				compatible = "st,stmpe-ts";
-				/* 3.25 MHz ADC clock speed */
-				st,adc-freq = <1>;
 				/* 8 sample average control */
 				st,ave-ctrl = <3>;
 				/* 7 length fractional part in z */
@@ -859,17 +866,16 @@
 				 * current limit value
 				 */
 				st,i-drive = <1>;
-				/* 12-bit ADC */
-				st,mod-12b = <1>;
-				/* internal ADC reference */
-				st,ref-sel = <0>;
-				/* ADC converstion time: 80 clocks */
-				st,sample-time = <4>;
 				/* 1 ms panel driver settling time */
 				st,settling = <3>;
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay = <5>;
 			};
+
+			stmpe_adc {
+				compatible = "st,stmpe-adc";
+				st,norequest-mask = <0x0F>;
+			};
 		};
 
 		/*
-- 
2.19.1

