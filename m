Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0061CC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD37214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9fYlfKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD37214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJIVXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:23:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37519 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeJIVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:23:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so873641pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hChhdla9rTd0uwo6Xihafa/FlHoPiHoTl0N1PS2CtQE=;
        b=P9fYlfKW1jr/ywASq1XVvFTGvIGUZaPBqHtk0jZzHS/lrYNP1fhXkUBV22XPzVGZG3
         rmuOU2KgdV8OdoBwKrqeyPANe/JX+371cK5tScZSXir6PPjqdWRs+YT99pglU3w2pNAv
         P41ReJ8m+GEtbRFAmEhk/SMIiFnqtCGfD6jUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hChhdla9rTd0uwo6Xihafa/FlHoPiHoTl0N1PS2CtQE=;
        b=YswBaZZEG+n1KgU1QPyushaSzQW984wnkhGNOjeIT27pLd2XM7JxCozxM1DJSZb72v
         eQJmnB0XkAeHzScHEiNXDs3U4WmsqAeAEcyVpz4bEpg92NDxlvNh+vxSVxNxWflLCGAz
         g8ifVSJIUYs68ShTK1wftr3o8G3zGVQiVwVxo9Z6JabihDX8WLxS7rknYSbrNJj7p2+V
         ziY/cPBMQed80Zy4OMsyLbTj16k0BWi/UpHV4+8stIcpQr1tZ1GX1bgSy73l+3tCB9fz
         trgVjdbD6s6wXVhI2m0R9mwJAiaIvCD16j+q/bXp9DdwX1EarD6EchNelH9kQNzBAZUm
         luvQ==
X-Gm-Message-State: ABuFfogwUOMpXzs+QDIX02LvDwzdwyu9EBVwvJBqwpZLNf7fMWKH0EDh
        tVrL7Y66gGOdLZkX9fK3YE7n
X-Google-Smtp-Source: ACcGV60C4nL+hZxUvfN473ZY8NZH44WwbS4hA1oiMsF3EIuvct1ryAzvcMyNYFMhNh+EqDz3XgiHuA==
X-Received: by 2002:a62:aa17:: with SMTP id e23-v6mr30276853pff.211.1539093972325;
        Tue, 09 Oct 2018 07:06:12 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e64-v6sm28947722pfe.55.2018.10.09.07.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:06:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels and triggers
Date:   Tue,  9 Oct 2018 19:35:22 +0530
Message-Id: <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all 96Boards, the following standard is used for onboard LEDs.

device-name:green:user1  default-trigger: heartbeat
device-name:green:user2  default-trigger: mmc0/disk-activity
                                          (onboard-storage)
device-name:green:user3  default-trigger: mmc1 (SD-card)
device-name:green:user4  default-trigger: none, panic-indicator
device-name:yellow:wlan  default-trigger: phy0tx
device-name:blue:bt      default-trigger: hci0-power

So lets adopt the same for Ultra96, which is one of the 96Boards
CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
consolidate only User LEDs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index eb5e8bddb610..565ceb390f99 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -57,29 +57,30 @@
 	leds {
 		compatible = "gpio-leds";
 		ds2 {
-			label = "ds2";
+			label = "zynqmp-zcu100-revC:green:user1";
 			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		ds3 {
-			label = "ds3";
+			label = "zynqmp-zcu100-revC:green:user2";
 			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0tx"; /* WLAN tx */
+			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		ds4 {
-			label = "ds4";
+			label = "zynqmp-zcu100-revC:green:user3";
 			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0rx"; /* WLAN rx */
+			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 
 		ds5 {
-			label = "ds5";
+			label = "zynqmp-zcu100-revC:green:user4";
 			gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "bluetooth-power";
+			linux,default-trigger = "none";
+			panic-indicator;
 		};
 
 		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
-- 
2.17.1

