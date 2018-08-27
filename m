Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1F1208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liBkAG0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1F1208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeH0Xwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:52:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46317 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeH0Xwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:52:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id a4-v6so61130plm.13;
        Mon, 27 Aug 2018 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n4ZJEGZnhqrGdVeWYMnTCHn9LIITEWAYG3JkHNaGGr8=;
        b=liBkAG0rOypUkIdqFgMqZwZ+G5OrTbSgj5j9imm+Dr0bUjp59zuugdIEauO3Tkl5ma
         gk/fr52Wy1kISBR02xlYq9IGniUMRGS74mluaH+00O7u5s+3JsUC0dsM7yVkgWc3g8si
         CZKDWzY8midOBqMyN3rdf/V3OGCpkEA6wkoNrTOisl1Vt/1cvsAVBtW7iRl00w5WflMd
         lzVrTP3OkT2X7IWivQjO+mK2TzZbl32F0v5dKhrw5T3U+N310mk0M4YvFVoqcET098oz
         kPd2//HNKZ+v3v0G1o3EaAg03lQ/3GOUNNKUeco5eigxR9VIk7HKe1MagIHpIawJBtmb
         7t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n4ZJEGZnhqrGdVeWYMnTCHn9LIITEWAYG3JkHNaGGr8=;
        b=LDo9DmecNelSnNqaYVGu/TrzZkZMpd5KmSAjlKDRSvpfJKMJ3buTdjdm0yBZ9uddXK
         2PmkcxoNKGtVhPVHxvL57nOpU0gFQoAropjniyI0KGR2uzuSMi1+I2i9ENb1jzNAa+KN
         MvTCEVEAsWUTV4lBO8E29QskWYJeC1pxs9D6JOQ1mDH9OK9dHtZ9VtWKysdpNTHxEDC6
         KrIQDR72vQFRepAcdBCG0faiyeDT2KLHnbOCCEQ3dzLnPJqRF2wrP0pu1XkNt/kOwuz6
         YnNZFBeo6pMdT1kNWICzkbVQ6aZ1ikTwl47el5yRp0+8h0Q9FYfk1e2BsmRWrRQaX206
         AcHw==
X-Gm-Message-State: APzg51CnNCBzeFFyU9DLts00ZnrSbQqhI0xIPJF+ZBFLOsiqVY+cI+vE
        2S4dhSHqiloPG2+3dun1VU8=
X-Google-Smtp-Source: ANB0VdYbwWqEQYIBNwywqs+aKtcr5tTaOa3qU1LBuTAoTRvGirBm6/Wc1nTeZBsWUEVBT+bNAovM3w==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr14385026pld.168.1535400280311;
        Mon, 27 Aug 2018 13:04:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o21-v6sm148611pfa.54.2018.08.27.13.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:04:39 -0700 (PDT)
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
Subject: [PATCH 3/3] ARM: dts: NSP: Wire up switch interrupts
Date:   Mon, 27 Aug 2018 13:03:44 -0700
Message-Id: <20180827200344.16158-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827200344.16158-1-f.fainelli@gmail.com>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
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

