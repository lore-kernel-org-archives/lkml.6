Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85BCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937632147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbfA1Q4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:56:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388484AbfA1Qzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:55:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6E3D15BE;
        Mon, 28 Jan 2019 08:55:47 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CEB3F7B4;
        Mon, 28 Jan 2019 08:55:45 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org, quentin.perret@arm.com
Subject: [PATCH 6/7] arm64: dts: juno: Add cpu dynamic-power-coefficient information
Date:   Mon, 28 Jan 2019 16:55:21 +0000
Message-Id: <20190128165522.31749-7-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128165522.31749-1-quentin.perret@arm.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

A CPUfreq driver, like the scpi driver used on Juno boards, which
provide the Energy Model with power cost information via the PM_OPP
of_dev_pm_opp_get_cpu_power() function, do need the
dynamic-power-coefficient (C) in the device tree.

Method used to obtain the C value:
C is computed by measuring energy (E) consumption of a frequency domain
(FD) over a 10s runtime (t) sysbench workload running at each Operating
Performance Point (OPP) affine to 1 or 2 CPUs of that FD while the other
CPUs of the system are hotplugged out.
By definition all CPUs of a FD have the the same micro-architecture. An
OPP is characterized by a certain frequency (f) and voltage (V) value.
The corresponding power values (P) are calculated by dividing the delta
of the E values between the runs with 2 and 1 CPUs by t.

With n data tuples (P, f, V), n equal to number of OPPs for this
frequency domain, we can solve C by:

P = Pstat + Pdyn

P = Pstat + CV²f

Cx = (Px - P1)/(Vx²fx - V1²f1) with x = {2, ..., n}

The C value is the arithmetic mean out of {C2, ..., Cn}.

Since DVFS is broken on Juno r1, no dynamic-power-coefficient
information has been added to its dts file.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 arch/arm64/boot/dts/arm/juno-r2.dts | 6 ++++++
 arch/arm64/boot/dts/arm/juno.dts    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index ab77adb4f3c2..66f0ec79c864 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -99,6 +99,7 @@
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <450>;
 		};
 
 		A72_1: cpu@1 {
@@ -116,6 +117,7 @@
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <450>;
 		};
 
 		A53_0: cpu@100 {
@@ -133,6 +135,7 @@
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <485>;
+			dynamic-power-coefficient = <140>;
 		};
 
 		A53_1: cpu@101 {
@@ -150,6 +153,7 @@
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <485>;
+			dynamic-power-coefficient = <140>;
 		};
 
 		A53_2: cpu@102 {
@@ -167,6 +171,7 @@
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <485>;
+			dynamic-power-coefficient = <140>;
 		};
 
 		A53_3: cpu@103 {
@@ -184,6 +189,7 @@
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <485>;
+			dynamic-power-coefficient = <140>;
 		};
 
 		A72_L2: l2-cache0 {
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 08d4ba1716c3..9890afdda77b 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -98,6 +98,7 @@
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <530>;
 		};
 
 		A57_1: cpu@1 {
@@ -115,6 +116,7 @@
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <530>;
 		};
 
 		A53_0: cpu@100 {
@@ -132,6 +134,7 @@
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <578>;
+			dynamic-power-coefficient = <140>;
 		};
 
 		A53_1: cpu@101 {
@@ -149,6 +152,7 @@
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <578>;
+			dynamic-power-coefficient = <140>;
 		};
 
 		A53_2: cpu@102 {
@@ -166,6 +170,7 @@
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <578>;
+			dynamic-power-coefficient = <140>;
 		};
 
 		A53_3: cpu@103 {
@@ -183,6 +188,7 @@
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <578>;
+			dynamic-power-coefficient = <140>;
 		};
 
 		A57_L2: l2-cache0 {
-- 
2.20.1

