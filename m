Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A58EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F9920BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2SBfh9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F9920BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391301AbeGLClL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:41:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43840 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGLClK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:41:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so19620599pfm.10;
        Wed, 11 Jul 2018 19:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ULPlg3Be4vbEje7rTmj0UMFj2MBNyHrkJAQohUVeQ4=;
        b=Z2SBfh9YUtWqy3tU7005dnYRkE1Y+c1DEvogXJ2vZJmyHXkD+LKo8HnBTn6jQb9iUc
         xajquJ9/73vOg69tisjodrTB9Fk8+K7Hj/jGuGIH8LznOhTq8oLx6zUEwyE6XVcZjqPD
         5xHNARFwx5HCmX2IfD1hcoG5vca8JbFEu9M0yqDb14PCElsRqIUCY2TPhQr4yS0jcVDN
         38d4uekejd3z2TumTCtt9AV0PaU8vPpUbSfMLrwJpEpbPslamTRoyYFq/7KxFROt7Dsb
         hA6iA5wGpepraDCvcADRrjAcLfsCZgsdoF6Eld2yllOM8YjdWHUj/+Uq7xr6ukoLi1Pt
         WuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ULPlg3Be4vbEje7rTmj0UMFj2MBNyHrkJAQohUVeQ4=;
        b=rWc2uL/ktoBCFdHLr6rnloeu2KymjSJSedYidUsXiu4wZhBlPHfz4dFz5MQ5tPTLLo
         Gr90qc59G2W38jTfbbC2MqjXioz59t1Xs+Ev3Rzes4JNH+9DqpifWUBgCtPkbHTfI8UU
         sgFUaWM9uhCG8xUQ9lwgWt6wVma993w/s8oGhxY/t1ZwRAZVqNZ+SDcMjC460r0dYEwv
         jsigA+CiMK/trZZY06ymTUE2X7zn73n2F8JS6ski6EH0v8cBn33pMVLyqNSJVKrnFXSw
         X7XL6qq3G/IgvyrDS5v4uaNfmDXHQ4hSI7ANqiKpugRCt1vIxoTwir0kvp4laZj0fB39
         vSgg==
X-Gm-Message-State: AOUpUlFevMSe7xQnY6GWeAV0dL+5krQCUbu83zAYFWGnH9bWQ267X2+w
        djZSOdu1og9GoQ+j3ehuzy8=
X-Google-Smtp-Source: AAOMgpcb/mnqH0nQxnSr1qW4FnyZcVZ1jyoeCy5gZCoesDQby0nM814do0wW466Hs8p2dsLIVG8+PA==
X-Received: by 2002:a65:4b87:: with SMTP id t7-v6mr342099pgq.391.1531362834411;
        Wed, 11 Jul 2018 19:33:54 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id w16-v6sm57260335pfi.101.2018.07.11.19.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 19:33:53 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
Date:   Wed, 11 Jul 2018 19:33:36 -0700
Message-Id: <20180712023337.30112-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712023337.30112-1-andrew.smirnov@gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT code to explicitly configure PAD_AUD3_BB_CK and avoid relying
on defaults.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy@gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index 2941a92d40f1..0bb42c00d72b 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -221,6 +221,8 @@
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_switch>;
 
 			ports {
 				#address-cells = <1>;
@@ -426,6 +428,12 @@
 		>;
 	};
 
+	pinctrl_switch: switchgrp {
+		fsl,pins = <
+			MX51_PAD_AUD3_BB_CK__GPIO4_20		0xc5
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
-- 
2.17.1

