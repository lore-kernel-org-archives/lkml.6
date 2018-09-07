Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC62C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E812083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNjqM0uM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E812083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIHAS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:18:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46648 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeIHAS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:18:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so12287237edr.13;
        Fri, 07 Sep 2018 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJrQID3vkkCsjGwPMfrmYZZREgjR0YqazRFRVxF0ghE=;
        b=VNjqM0uMo1Ihsckr0EwkTd2N2yhdGU2pypk2GgKfjIggtjbPtHxWbl4sIY3u+mdOPD
         F/Gk78GuS4+FMSrJYJ0sdQpwyWK5Jn00zodfXOxZ9FweRdw5wBjw8nPMDf3r5bSAjknv
         pKKVTi+RbcQrld2T5ROkKR9/5ljbJ4ifxgMrwmFWrVEKTehod8NTC/MoUnTqVkw9e/GM
         jhr88bgZy71xnZb58jUdJGT/tDYTEYv65jOyWGvYbLSOBmwgqOOwbPRHV+nKtKDfy7ag
         r2n+Jp6p1/VV63TU0QHgQh+Z3hlnJrvNJ6unNGG0AHZPYAP5Oy+TWbWPxob1iKb00mXz
         WckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dJrQID3vkkCsjGwPMfrmYZZREgjR0YqazRFRVxF0ghE=;
        b=kzq2cpw8qzhltjfKsPdJPrpKHu8jI+LkF6Zzjnlcpv5vMxxkKDxtBqIm6VNjZd2bBP
         5tPL3OtLjr2MAPWy2iz51zMtmOO9f2g/TMM3GD3XwT9yWvS69IbRrgsE7bqX+U2Kwl3w
         BbuUP2HIopUKaDJKBjtfDlOkPGRAHrspyiU3P3T61PDRUIDfOs5xFHRKIe/oXvBRrnq2
         Pbb79LqBCKw2UL4WEby7EU1SVlkT9aQEVi56taIPcCddsAMp5c/sMSarpRv45hGicbgJ
         GRuSN4nOT83SY4EVxjZtNTaQez3f93xZM44edSD9THpAEYf2pR8f9d3v5h5ngOfaoeEA
         PJ2w==
X-Gm-Message-State: APzg51CHoDjxxde50knNO+rzUIWzSzzj03LE3n9etpnK1a4iicEHG3Gy
        OOKCMxsoOycTB86wqOqh4hY=
X-Google-Smtp-Source: ANB0Vda7kp4s3hynEgkOS3BQffFZGxg7hzuI44HZHysqPMQJJRTVtbrCWAcJ+zhUYfEN/oyhaHr0nw==
X-Received: by 2002:a50:b306:: with SMTP id q6-v6mr10296791edd.264.1536348961693;
        Fri, 07 Sep 2018 12:36:01 -0700 (PDT)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id h34-v6sm4868808eda.58.2018.09.07.12.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:36:01 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v1 3/5] dts: add nxp,quartz_load_12.5pf to all pcf8523 nodes
Date:   Fri,  7 Sep 2018 21:35:06 +0200
Message-Id: <20180907193508.24974-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180822183555.GA24084@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Søren Andersen <san@skov.dk>

Add "nxp,quartz_load_12.5pf" to all pcf8523 nodes.

The device tree binding for the pcf8523 now includes
a property "nxp,quartz_load_12.5pf" to specify
that the connected x-tal has an internal capacitance
of 12.5 pF.
Add this to all pcf8523 nodes, because this was implicit before,
at least in the Linux kernel where the driver was hardcoded
to set the rtc to use 12.5 pF.

Signed-off-by: Søren Andersen <san@skov.dk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts | 1 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts   | 1 +
 arch/arm/boot/dts/imx6q-h100.dts             | 1 +
 arch/arm/boot/dts/imx6q-novena.dts           | 1 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi       | 1 +
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi  | 1 +
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
index d598b6391362..d1a0e3521e2b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
@@ -200,6 +200,7 @@
 	rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		nxp,quartz_load_12.5pf;
 	};
 
 	tmp75@48 {
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 2c5aa90a546d..b5088414e610 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -201,6 +201,7 @@
 	rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		nxp,quartz_load_12.5pf;
 	};
 
 	ucd90160@64 {
diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index 714e09e04dcb..3b6116069b11 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -173,6 +173,7 @@
 	rtc: pcf8523@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		nxp,quartz_load_12.5pf;
 	};
 
 	sgtl5000: sgtl5000@a {
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index fcd824dc485b..6a2eaaa6e220 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -257,6 +257,7 @@
 	rtc: pcf8523@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		nxp,quartz_load_12.5pf;
 	};
 
 	sbs_battery: bq20z75@b {
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 9332a31e6c8b..e0f601bce3d3 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -143,6 +143,7 @@
 	rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		nxp,quartz_load_12.5pf;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 0e64016e765f..7848b818078e 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -189,6 +189,7 @@
 	rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		nxp,quartz_load_12.5pf;
 	};
 
 	/* Pro baseboard model */
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index c413f9c3540f..7bc264234085 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -222,6 +222,7 @@
 	pcf8523: rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		nxp,quartz_load_12.5pf;
 	};
 
 	sgtl5000: codec@a {
-- 
2.12.0

