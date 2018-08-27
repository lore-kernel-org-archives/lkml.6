Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C1DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBEF208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwosVQIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBEF208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeH0Xwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:52:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38122 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeH0Xwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:52:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so82601pfh.5;
        Mon, 27 Aug 2018 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ReTvAwrgFWOoEexg0hgEP07gzw3p2GvoRnRvhI5zJ5I=;
        b=JwosVQIPWRKKgl6BPbGfRUNz39BEO++kVHbRLKRBkDtNaJhdcCwcckdpDVNYpde1Pn
         b/9wvsY1eY0oaR6rqbIcHoKIufQTHtdCozbLuAKXA7g0lc0ktxJs7MHg7oG4DjauBivJ
         V8Dw2Y1UgNhceDBAf1kg3B6GEb2oZpE5fXETGNHHl+5ONQQJPj9oH0wIqtJ1+ZwJ19e6
         3I2jR7fnHb49h9GgJb4Zt4d+RcFi2nB1KWqgRbZ2mWg34JxADBAwPgGP+2Jq0bdszySr
         MXwG/eZ9LGiVQ0X2EVAXubg/5X7SA6/mo505yhMWJ5Gi4ALqCT7GjlurBPsb3RZzPH//
         zkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ReTvAwrgFWOoEexg0hgEP07gzw3p2GvoRnRvhI5zJ5I=;
        b=UokaxZN+AzBvetgvBiQBsAdkr4ehmxVeYw+aQ/zAlGDdYUNM6bz2WNNc51hsHxwABI
         9KHtNjq8BFiIVv/VnFx7BMbUnowvdr3N2fZ7tTVlRDolAXCmu0sEgHZHdZoYtyLJFil3
         ozKTK2e40Al/fvUwdfd5awDN+vJXWH25y0BO6bk9jHnrGdZzenho4GLn4z+RXw2DWIPF
         +IC3DZCetpS0hetFE5YXmDsjN7KKTBygziEaHjOalRbOoTUeEa5WkgnwCKYHv4bV9lUV
         klAHoOuyH4wox5JVNf8nJrqedMA6lBVpyf8d+T1P5LQbgvNPtvbVupVCYfJZs4huLlfu
         njaw==
X-Gm-Message-State: APzg51D5wIttga8agQ/NK1fo7sTNWY+0Y1xc2oIAYjvALZUoO4uEqm62
        YjSvn2mBsyNwpqSgknDK17Y=
X-Google-Smtp-Source: ANB0VdYRMbZwC2WiYP7ODbnwDV7kcsbZd3ICDt5Hp4sxncQGW38SpfUGkCQoithcy90Dqa09TS4AfQ==
X-Received: by 2002:a62:7a01:: with SMTP id v1-v6mr15604269pfc.153.1535400276653;
        Mon, 27 Aug 2018 13:04:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o21-v6sm148611pfa.54.2018.08.27.13.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:04:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk
Subject: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
Date:   Mon, 27 Aug 2018 13:03:42 -0700
Message-Id: <20180827200344.16158-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827200344.16158-1-f.fainelli@gmail.com>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SFP connected to port 5 of the switch and wire up all GPIOs
to the SFP cage. Because of a hardware limitation of the i2c controller
on the iProc SoCs which prevents large i2c (> 256 bytes) transactions to
work, we use the i2c-gpio interface instead, which does not have that
limitation. This allows us to read the SFP module EEPROM, which would
not be possible otherwise since it exceeds that size during a single
read transfer.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index ea3fc194f8f3..05751c895a0e 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -58,6 +58,24 @@
 		open-source;
 		priority = <200>;
 	};
+
+	/* Hardware I2C block has limitations on number of bytes it can
+	 * transfer, which breaks with SFP/SFF modules.
+	 */
+	i2c1: i2c1 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpioa 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpioa 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c1>;
+		mod-def0-gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
+		los-gpios = <&gpioa 24 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpioa 30 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpioa 26 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &amac0 {
@@ -210,6 +228,17 @@
 			reg = <4>;
 		};
 
+		port@5 {
+			label = "sfp";
+			phy-mode = "sgmii";
+			reg = <5>;
+			sfp = <&sfp>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
 		port@8 {
 			ethernet = <&amac2>;
 			label = "cpu";
-- 
2.17.1

