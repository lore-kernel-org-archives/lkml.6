Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6216DC46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CFC2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqpfGP0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CFC2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeJ2Sbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:31:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37805 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbeJ2Sbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:31:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id j23-v6so3736817pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLzRC/KoanQ3Q5K4K9dSGjby1oMGO+7mKnxsVzSkG80=;
        b=UqpfGP0y4a0XVR5XmPWfmU2gcJBdOFyV/s6u1ofBMMYrnjTHVK4pBHDZo3FOVqiK/0
         E8/VFEtos9QeFecDjI0WWI/VNe4Dngo2PZa/rDwJzDXOy/wECWzzl70mZiTaps1Oe1ks
         nwSE0dSujh4pAUV1LkO5bVT6uWmhX9Jej6AzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLzRC/KoanQ3Q5K4K9dSGjby1oMGO+7mKnxsVzSkG80=;
        b=LZV+HLuXqNQ28775/buN9UHg1qPTzdA7SntRrQ1gwPRGPdhY+sTmhROtpT5zl3X0Pi
         IjcZMIqWOH8MltEE7ouyn5ksLAHqlAvpxGeUwlcEe0jviQPA9WoU9mG60n8JIqXtEJkM
         Nsoms2IhefScLgpe83MgtdpPOyQircZfVZIPFmw7Do8RWbPaqfKIiR6do/LubS89phns
         TsNUQygGnZNACg9mrJkDOmjbr1ZpnEjIXUHE5GHclI+fk6xeVjnGToElHZohgFSrWFwl
         RWAhmogwwVK4CVFQD+z3BglcmQb62H+Yv/Vzv/Lfeaizc7D4eO51k5krW5r2+aUWNaj0
         6Dmg==
X-Gm-Message-State: AGRZ1gKQA2Fn4zpYrgwv55XNdKGZsWpBjDmIBrLcLrPMgvKpSHFV04i6
        QACb4xREpd1rtIDM8+tcjQd3
X-Google-Smtp-Source: AJdET5f9dQUx99LPWezamoSEHIQQSPgOUJWrajpyvuB9yqEtV7rpht2fw/LybeVhnX+x3OS1270qxQ==
X-Received: by 2002:a63:c949:: with SMTP id y9-v6mr12958292pgg.331.1540806239504;
        Mon, 29 Oct 2018 02:43:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id b62-v6sm21162056pfa.159.2018.10.29.02.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:43:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com, pavel@ucw.cz,
        andy.gross@linaro.org
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        koen.kooi@linaro.org, nicolas.dechesne@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 6/7] arm64: dts: xilinx: ultra96: Standardize LED labels and triggers
Date:   Mon, 29 Oct 2018 15:12:44 +0530
Message-Id: <20181029094245.7886-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all 96Boards, the following standard is used for onboard LEDs.

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
green:user3  default-trigger: mmc1 (SD-card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

So lets adopt the same for Ultra96, which is one of the 96Boards
CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
consolidate only User LEDs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index eb5e8bddb610..c08a8753215b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -57,29 +57,30 @@
 	leds {
 		compatible = "gpio-leds";
 		ds2 {
-			label = "ds2";
+			label = "green:user1";
 			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		ds3 {
-			label = "ds3";
+			label = "green:user2";
 			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0tx"; /* WLAN tx */
+			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		ds4 {
-			label = "ds4";
+			label = "green:user3";
 			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0rx"; /* WLAN rx */
+			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 
 		ds5 {
-			label = "ds5";
+			label = "green:user4";
 			gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "bluetooth-power";
+			linux,default-trigger = "none";
+			panic-indicator;
 		};
 
 		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
-- 
2.17.1

