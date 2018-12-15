Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DA1C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3646020645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OuvlVLDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeLOFWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:22:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42968 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbeLOFWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:22:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so3650280plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HglKz8vxjs8qk+QhBpX1zrDNuVp/Iy4W2AY8RJaIkaA=;
        b=OuvlVLDAhJ7VQb9hbQZn+VYOpb6hAWY59+Lh6uMuWXsNygmDv4L2BYuA4MJgomYWSP
         p24i1QJNxXzD74fUs0mzOLM4sc2Qs3jILUBOpb7Ec8WfCNsaxHrgJ393Y3bDWa6KTyMw
         PY+UGprhe4kL1S+ZzMY648DPyk5JBtK/laIX9ul+JPJ2UEB7+lz9yeoegSVxq92o7Ful
         5MKEPyHRVVyTC16aY47EXPTWtmaTN703897axMbf/bULJNSs0SAk2T4/oSZtVo/IY/P/
         dLjyBB8mzTGWZ5Q6mpnHeHY2MXZrG85/E745gk3vPmnfK6gm4Z23WQnU9Abt2g6P6+El
         MUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HglKz8vxjs8qk+QhBpX1zrDNuVp/Iy4W2AY8RJaIkaA=;
        b=Z1M7zj+Ioz0lLs1mE1GVXuyIflqYIdImH71Q2oe7pZFEl3KJzSfCG5zITNV9/MVB+y
         yYh+/cuTjNQOE9+ixMxH0/GjV9G+XYZo6Wd/UCBqUdHIDdyYkgHkLuxxlMXDhlCNsEDQ
         tYt0P1XkBGmTRWPrvl449Eg7kKFzaUM1/m6OSi8rcSc97g3Sl0Ox6CBvut8cwA4dhkkP
         CiTuAwEUzl+A0uv3REQ0Fg11wl0r3MVa7hiA83J4458Pcpp5TImZop4JBDCr5SagjKNh
         r+YVfsnLr7/i4pYXNipvbbbasOu0b32VRnRpFb7dpt4pQxlrAQ/cOLDZyfeQpHrTtb4L
         YmRQ==
X-Gm-Message-State: AA+aEWYFdN5Ffzt67JqiXtaQBXzZTG0aref9FFNNxEOKoB2pKsKhwzvC
        G83BmZgc/JU4nSGWw5O/2JvpKEb3U1M=
X-Google-Smtp-Source: AFSGD/UTWmZNfv2PFLtZZsmKhpzdzEoWC2JDXZZzOaSXk2HpNwjCgYE8zp8PsTCKF60OUhljPHuLJA==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr5364984plb.238.1544851353465;
        Fri, 14 Dec 2018 21:22:33 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z127sm11351282pfb.80.2018.12.14.21.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 21:22:32 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/7] riscv: dts: add initial support for the SiFive FU540-C000 SoC
Date:   Fri, 14 Dec 2018 21:21:52 -0800
Message-Id: <20181215052154.24347-6-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215052154.24347-1-paul.walmsley@sifive.com>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the SiFive FU540-C000 SoC.  This is a 28nm SoC
based around the SiFive U54-MC core complex and a TileLink
interconnect.

This file is expected to grow considerably as more device drivers are
added to the kernel.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 182 +++++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sifive/fu540-c000.dtsi

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
new file mode 100644
index 000000000000..0ef314cf17b6
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: Apache-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2018 SiFive, Inc */
+/* See the file LICENSE for further information */
+
+/dts-v1/;
+
+#include <linux/clk/sifive-fu540-prci.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "sifive,fu540-c000", "sifive,fu540";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <1000000>;
+		cpu0: cpu@0 {
+			clock-frequency = <0>;
+			compatible = "sifive,e51", "sifive,rocket0";
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <16384>;
+			reg = <0>;
+			riscv,isa = "rv64imac";
+			status = "okay";
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu1: cpu@1 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <1>;
+			riscv,isa = "rv64imafdc";
+			status = "okay";
+			tlb-split;
+			cpu1_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu2: cpu@2 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <2>;
+			riscv,isa = "rv64imafdc";
+			status = "okay";
+			tlb-split;
+			cpu2_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu3: cpu@3 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <3>;
+			riscv,isa = "rv64imafdc";
+			status = "okay";
+			tlb-split;
+			cpu3_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+		cpu4: cpu@4 {
+			clock-frequency = <0>;
+			compatible = "sifive,u54-mc", "sifive,rocket0";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <4>;
+			riscv,isa = "rv64imafdc";
+			status = "okay";
+			tlb-split;
+			cpu4_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "sifive,fu540-c000", "sifive,fu540", "simple-bus";
+		ranges;
+		prci: prci@10000000 {
+			compatible = "sifive,fu540-c000-prci";
+			reg = <0x0 0x10000000 0x0 0x1000>;
+			clocks = <&hfclk>, <&rtcclk>;
+			#clock-cells = <1>;
+		};
+		uart0: serial@10010000 {
+			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+			interrupt-parent = <&plic0>;
+			interrupts = <4>;
+			reg = <0x0 0x10010000 0x0 0x1000>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+		};
+		uart1: serial@10011000 {
+			compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+			interrupt-parent = <&plic0>;
+			interrupts = <5>;
+			reg = <0x0 0x10011000 0x0 0x1000>;
+			clocks = <&prci PRCI_CLK_TLCLK>;
+		};
+		plic0: interrupt-controller@c000000 {
+			#interrupt-cells = <1>;
+			compatible = "riscv,plic0";
+			interrupt-controller;
+			interrupts-extended = <
+				&cpu0_intc 11
+				&cpu1_intc 11 &cpu1_intc 9
+				&cpu2_intc 11 &cpu2_intc 9
+				&cpu3_intc 11 &cpu3_intc 9
+				&cpu4_intc 11 &cpu4_intc 9>;
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+		};
+	};
+};
-- 
2.20.0

