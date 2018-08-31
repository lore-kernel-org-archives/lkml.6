Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A1420841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uX2TorP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A1420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeHaX3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:29:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32786 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeHaX3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:29:50 -0400
Received: by mail-qt0-f193.google.com with SMTP id r37-v6so15791603qtc.0;
        Fri, 31 Aug 2018 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n4ZJEGZnhqrGdVeWYMnTCHn9LIITEWAYG3JkHNaGGr8=;
        b=uX2TorP7YJ3Ol8Y870vosCx7MFlNmqM2LQeKVJv+IcNfCB4nSXg/gY8EqcdHojtdYV
         mYZezuFcqhtwSlecXMyEGW1UnBQLXEfmLGog31KPPLZyXJoCRlYW0kzFgOublVRIVv3y
         mLDHsGfzL9CoDQCsrACW8u3fka+giwXWodndeNI7pwLIXJq7D4cEo9iRjw4uQGkBJ3Xy
         uD3lCKOD93pim546aLVBo9bYb5ugBeLEA70/qWo9V0Av9iO6a26xIkHsEtFXFGsRlirY
         7Bb7DaizCD6glyi7TWoge8HM1NkBi5bPnrM6CTvzwAWNt9r9PgmJKTAERp6Yq0Lp7Sho
         TszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n4ZJEGZnhqrGdVeWYMnTCHn9LIITEWAYG3JkHNaGGr8=;
        b=btHIkTRofZICFP8LXa6/psdfeyMSYo/cb1ZwzNT3LEuUv7VXNpPD59SWcQ2NJw8SE/
         TTaKGgdAjfJreI2157MnBqvfZgpa0GtZCQi91uIuCS5NFh233Nqrm5RKRItlVVLkvlVh
         r7Zmq/zQLG9Z6KMK10J3cG5+9JKO9JfM0nDeJrqHtoKMNWXSTA8HAxnpse34BLOAFntk
         jPztM1hxYyk5z/uD7vWD5UjIDWYR4mIv0YVHHOcwVh9KuBkD7y7S9mWgsIVFMADZ4kJx
         du9MZuVrhxFwcvxm5DoRYAHgnOeBiW9vOEtpd7h5eOxXeeAbQK5GA1lszWj6ZqUvN7AM
         khpw==
X-Gm-Message-State: APzg51CYf5qWZrREnNvfE3GqHoas7ROkR6aFHkvkK13e02lX+Z/w7Wk5
        Dj24MUjqA8kEckw4VwPMd10=
X-Google-Smtp-Source: ANB0VdZsaRtQLrOU8YRe5ESYdVlq71QAftniSejVCNLsrSG1O2jha6f2s1eoTWLGO1wUyYXG+UuImQ==
X-Received: by 2002:a0c:d5aa:: with SMTP id g39-v6mr16951817qvi.176.1535743256584;
        Fri, 31 Aug 2018 12:20:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f53-v6sm6949160qtk.40.2018.08.31.12.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 12:20:55 -0700 (PDT)
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
Subject: [PATCH v3 3/3] ARM: dts: NSP: Wire up switch interrupts
Date:   Fri, 31 Aug 2018 12:20:39 -0700
Message-Id: <20180831192039.11842-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831192039.11842-1-f.fainelli@gmail.com>
References: <20180831192039.11842-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Switch Register Access Block (SRAB) has one interrupt for link state
change on each ports (0-5, 7-8) a PHY interrupt, timestamping interrupt
and sleep timer interrupts for each management ports (5,7,8). Wire those
up so we can utilize them to speed up link resolution.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 09ba85046322..ec869a80f9ba 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -377,7 +377,36 @@
 
 		srab: srab@36000 {
 			compatible = "brcm,nsp-srab";
-			reg = <0x36000 0x1000>;
+			reg = <0x36000 0x1000>,
+			      <0x3f308 0x8>,
+			      <0x3f410 0xc>;
+			reg-names = "srab", "mux_config", "sgmii";
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "link_state_p0",
+					  "link_state_p1",
+					  "link_state_p2",
+					  "link_state_p3",
+					  "link_state_p4",
+					  "link_state_p5",
+					  "link_state_p7",
+					  "link_state_p8",
+					  "phy",
+					  "ts",
+					  "imp_sleep_timer_p5",
+					  "imp_sleep_timer_p7",
+					  "imp_sleep_timer_p8";
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
2.17.1

