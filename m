Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51458C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1E72098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g7Uzve4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1E72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbeGJV0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:26:46 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46980 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732334AbeGJV0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:26:46 -0400
Received: by mail-qk0-f193.google.com with SMTP id o2-v6so12384894qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=riqZtrwP4q8pAuZvOBKpjFs0/GDYsfPLYW7ZTSF2rvg=;
        b=g7Uzve4lvMhwYJ1HuyU81kNqVjN/0s0PKiy8XdTMtFwnCL666t8JsG8Xe2gTrdhn5D
         gR0vl4/4hjcTW6+XU43QVNbok/58Ry66WVGGEWrqV3MifeYPzdVQ7kIbSwFhnh9eVvkM
         WS0GGRgyI5S8HxfsDk47LjuVHuQAw4RyLh8iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=riqZtrwP4q8pAuZvOBKpjFs0/GDYsfPLYW7ZTSF2rvg=;
        b=lUtzSSynNqmFdFFHl1U2UnaKSKX7PGfce7gZFqwF7io7+f39GFip5g9DR0lZ4ZKf9P
         Y31VmH7ViD6bCI5pSZMe7lZ9g3op2CQ9t2Fi6A/olU9A3m58gMba8dxVgdUGLGAdrZLR
         w1ULkU3mz3NbJAh9XNh6R1JhUy2y0D0iUy5ifQfXS33iQ5l2UYT7ZbUO3mCq0TxGYYOS
         nbN8+pCOumlSSn3nPFKyfmbOVJO7inq9F4Cg5ZRZ3PeqXzvGX8SxfAWAwUH0Y7HIzSBg
         mGWI7AH48QOn9n5gzhH6zGwg1CWff/Mns8XCd/U6j4ssMuxAGipf04/QFzfVmTtPAjkU
         lqvw==
X-Gm-Message-State: APt69E2rEQF5vgQmqHYH7NLGQ+zzxF4q5BixhtJNyJ0t7y/Bq5dQAYwX
        4AlIw83DWeEv8B9+FUMyApc14Q==
X-Google-Smtp-Source: AAOMgpfthDtpzRNtsiGkbWkfwjfyPWk3NrH55p19U7WJZWls4qWWEDuwK5lKbVZJjfVBW+RhnkwVHg==
X-Received: by 2002:a37:4f10:: with SMTP id d16-v6mr23395037qkb.323.1531257948182;
        Tue, 10 Jul 2018 14:25:48 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b21-v6sm6638912qtp.26.2018.07.10.14.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 14:25:47 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>,
        Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 1/2] arm64: dts: stingray: add PAXC support
Date:   Tue, 10 Jul 2018 14:25:30 -0700
Message-Id: <1531257931-11591-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
References: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PAXC support to Broadcom Stingray SoC

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-pcie.dtsi  | 54 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 11 +++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
new file mode 100644
index 0000000..33a472a
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+
+pcie8: pcie@60400000 {
+	compatible = "brcm,iproc-pcie-paxc-v2";
+	reg = <0 0x60400000 0 0x1000>;
+	linux,pci-domain = <8>;
+
+	bus-range = <0x0 0x1>;
+
+	#address-cells = <3>;
+	#size-cells = <2>;
+	device_type = "pci";
+	ranges = <0x83000000 0 0x10000000 0 0x10000000 0 0x20000000>;
+
+	dma-coherent;
+
+	msi-map = <0x100 &gic_its 0x2000 0x1>, /* PF0 */
+		  <0x108 &gic_its 0x2040 0x8>, /* PF0-VF0-7 */
+		  <0x101 &gic_its 0x2080 0x1>, /* PF1 */
+		  <0x110 &gic_its 0x20c8 0x8>, /* PF1-VF8-15 */
+		  <0x102 &gic_its 0x2100 0x1>, /* PF2 */
+		  <0x118 &gic_its 0x2150 0x8>, /* PF2-VF16-23 */
+		  <0x103 &gic_its 0x2180 0x1>, /* PF3 */
+		  <0x120 &gic_its 0x21d8 0x8>, /* PF3-VF24-31 */
+		  <0x104 &gic_its 0x2200 0x1>, /* PF4 */
+		  <0x128 &gic_its 0x2260 0x8>, /* PF4-VF32-39 */
+		  <0x105 &gic_its 0x2280 0x1>, /* PF5 */
+		  <0x130 &gic_its 0x22e8 0x8>, /* PF5-VF40-47 */
+		  <0x106 &gic_its 0x2300 0x1>, /* PF6 */
+		  <0x138 &gic_its 0x2370 0x8>, /* PF6-VF48-55 */
+		  <0x107 &gic_its 0x2380 0x1>, /* PF7 */
+		  <0x140 &gic_its 0x23f8 0x8>; /* PF7-VF56-63 */
+
+	phys = <&pcie_phy 8>;
+	phy-names = "pcie-phy";
+};
+
+pcie-ss {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x0 0x0 0x40000000 0x800>;
+
+	pcie_phy: phy@0 {
+		compatible = "brcm,sr-pcie-phy";
+		reg = <0x0 0x200>;
+		brcm,sr-cdru = <&cdru>;
+		brcm,sr-mhb = <&mhb>;
+		#phy-cells = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e8be784..4ad4797 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -146,6 +146,11 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	mhb: syscon@60401000 {
+		compatible = "brcm,sr-mhb", "syscon";
+		reg = <0 0x60401000 0 0x38c>;
+	};
+
 	scr {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -265,6 +270,11 @@
 			status = "okay";
 		};
 
+		cdru: syscon@1d000 {
+			compatible = "brcm,sr-cdru", "syscon";
+			reg = <0x0001d000 0x400>;
+		};
+
 		gpio_crmu: gpio@24800 {
 			compatible = "brcm,iproc-gpio";
 			reg = <0x00024800 0x4c>;
@@ -276,6 +286,7 @@
 
 	#include "stingray-fs4.dtsi"
 	#include "stingray-sata.dtsi"
+	#include "stingray-pcie.dtsi"
 
 	hsls {
 		compatible = "simple-bus";
-- 
2.1.4

