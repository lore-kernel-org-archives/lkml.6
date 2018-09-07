Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99102C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502A62075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p874fP7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502A62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeIGQ5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:57:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55006 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeIGQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:57:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so14529532wmb.4;
        Fri, 07 Sep 2018 05:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I9ORE5suc9rtFSv5V5fLA6rRDjUjBIzD1lVEyDy+Phw=;
        b=p874fP7DTtt9cWqbrXQhYbF+hjKV5QNlym6CGD2oAGcetp9CFxybOzDyyCK0fgs2Jq
         FdVVhD0lCK7sXg5tAwLA2yudK7bzrZVLLAhjzIVWroXVAoom4rEMYjFO4F4MvJl1kxGo
         FvKHpkaFZe+vGMyxt02NoGqw2+0nbL3g1Fa/mrbWT6TCn9pEY3i7k1lhekkV2Xbdl7cR
         BVgKaPbMx79CjM8+twy+DNGWayXjYh3i3uD+jiM0r3CWdp9rafNbnldJzV4uuOEuBgxp
         +d2P9fFHvvqskfV0cRPaA6BTh9SsgcjobZhhBcNxqokjanULVDTDAOf2BvoCryY2v3hf
         J4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I9ORE5suc9rtFSv5V5fLA6rRDjUjBIzD1lVEyDy+Phw=;
        b=hMyXxTGBR6l0eRD0yAAkE30qGWYxNxy1IFmeuqrwtktBldyr8tSKfrAb+IOt3Hy5XC
         zPDY9qMws/IEyk8shVfI0ru6rom81oi0Byvx8ym2YTFRBmE/Tcam6C8sAtcaddv2dLQp
         GUbii2/a/32/LpqZRYQMJr9OLybBPK7yPGUlMLryh1JY9S6phiL4TsoIU6ieSBu/Hrsz
         qF4GnKHLoGfnO8Oz35ecmpXHr2vkhS0fKpwhj/3XtwBC9WYfqNBDWW05UTkRgVbshSp9
         g1uofp1AwvPLMg8psp5dfrQOaW8wLRGTvWdTYGXhNpEE95SS17w7LgOzTynp3iVc7pst
         88pA==
X-Gm-Message-State: APzg51Ddyczc/1PwftVRJl+k+cVFoOafWK1i0f6fbAmecQXvAtj+dq2C
        XeyySqnQOKpk+RT5kOAzSC4=
X-Google-Smtp-Source: ANB0VdaKPUZE+rlIV+BfX7n5uvHirtlsQ5hgZXOHau72tkHCU9x6NNXyv2k4sSDlXLgDZigOaUNxCg==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr4884377wmz.95.1536322586826;
        Fri, 07 Sep 2018 05:16:26 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id r13-v6sm6329913wmf.34.2018.09.07.05.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 05:16:26 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     narmstrong@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for Bluetooth
Date:   Fri,  7 Sep 2018 16:15:36 +0400
Message-Id: <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the uart_A used by the brmcfmac sdio module in the
WeTek Hub and WeTek Play 2 devices. meson_uart_probe seems to mandate
an alias (without it, BT is not working) so this is also included.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 70325b2..e75ace7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -10,6 +10,7 @@
 / {
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
 		ethernet0 = &ethmac;
 	};
 
@@ -239,6 +240,18 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
+/* This is connected to the Bluetooth module: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 /* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
-- 
2.7.4

