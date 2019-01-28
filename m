Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BA5C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41302147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfA1Qz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:55:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49950 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388442AbfA1Qzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:55:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2381EBD;
        Mon, 28 Jan 2019 08:55:50 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300723F59C;
        Mon, 28 Jan 2019 08:55:48 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org, quentin.perret@arm.com
Subject: [PATCH 7/7] arm: dts: vexpress-v2p-ca15_a7: Add cpu dynamic-power-coefficient information
Date:   Mon, 28 Jan 2019 16:55:22 +0000
Message-Id: <20190128165522.31749-8-quentin.perret@arm.com>
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

A CPUfreq driver, like the ARM big.LITTLE driver used on the TC2 board,
which provide the Energy Model with power cost information via the
PM_OPP of_dev_pm_opp_get_cpu_power() function, do need the
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

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index a2ccacd07f4f..00cd9f5bef2e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -42,6 +42,7 @@
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <990>;
 		};
 
 		cpu1: cpu@1 {
@@ -51,6 +52,7 @@
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
 			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <990>;
 		};
 
 		cpu2: cpu@2 {
@@ -60,6 +62,7 @@
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
 			capacity-dmips-mhz = <516>;
+			dynamic-power-coefficient = <133>;
 		};
 
 		cpu3: cpu@3 {
@@ -69,6 +72,7 @@
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
 			capacity-dmips-mhz = <516>;
+			dynamic-power-coefficient = <133>;
 		};
 
 		cpu4: cpu@4 {
@@ -78,6 +82,7 @@
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
 			capacity-dmips-mhz = <516>;
+			dynamic-power-coefficient = <133>;
 		};
 
 		idle-states {
-- 
2.20.1

