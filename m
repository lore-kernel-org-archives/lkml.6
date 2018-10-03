Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E66C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E56213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJpZuUlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E56213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJCV1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33113 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeJCV12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id o21-v6so4340878lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s31a5XHCk1LHbjCX4EljRqRwb2bVRICfynyfVhTJkR0=;
        b=cJpZuUltyX6boYTW8n4eqSmCtDpkBhfsHeqYJhTyPZ6bb6+Rvz0bCRdZgp3y+Sb2Hb
         idkNPCM6mStTSZ3vEPyZL81N7AKdv835h4VsriHXyryb0vHe3etv9zGCi3JNVe1XcuDb
         iKugtj2VvyCC1IJtpJj+OsFeoUpbrUy9sSCpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s31a5XHCk1LHbjCX4EljRqRwb2bVRICfynyfVhTJkR0=;
        b=oROUZXP3tQjWK0w7sQo1CECUP+UHWOONHquwU+HD8rB5eLeX1QidQlvQBHxfAJY4Es
         slxSAEbikO7l5u6eQeIpCrCxMxZnLbgvipr30DeObwpDRrpSheiYsKFEyNCJ9H4qXVRc
         KeKUvRnBd/NKYUcld40co/g5J1rK9s/iast9ThXaHgLRZhMkEOBqsksYpkTY+XhzoEkb
         VybGwHqzrkF5mB5CO8g4PMxikydjaYBEHlRq3s2rAhoJsyARqlCkPaonus15ZUZQUiOp
         cqLeD/EFPizojGVIAxLei7iaOhCQ8zB7hsL6rYjwMlju/k1z0ttE3tKf7Ei2rhMIBPhv
         pViA==
X-Gm-Message-State: ABuFfoid6my5dDLXxr7UaBcpaoz2zno7PIuX93mKxrq9MdPYVAYGL63g
        DmCS4lHeMNuUloBeh0wLstWDEw==
X-Google-Smtp-Source: ACcGV63w+k8Ky9ZPT8u3CThlZWEmR6v2MMxYmqJi3yPsnkwQAG4RywU2Gz8ZjEHETXI75Fzvgn697Q==
X-Received: by 2002:a19:8f57:: with SMTP id r84-v6mr1172229lfd.131.1538577526472;
        Wed, 03 Oct 2018 07:38:46 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v9 04/11] dt: psci: Update DT bindings to support hierarchical PSCI states
Date:   Wed,  3 Oct 2018 16:38:17 +0200
Message-Id: <20181003143824.13059-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Update DT bindings to represent hierarchical CPU and CPU PM domain idle
states for PSCI. Also update the PSCI examples to clearly show how
flattened and hierarchical idle states can be represented in DT.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/arm/psci.txt          | 156 ++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index a2c4f1d52492..17aa3d3a1c8e 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -105,7 +105,163 @@ Case 3: PSCI v0.2 and PSCI v0.1.
 		...
 	};
 
+ARM systems can have multiple cores sometimes in hierarchical arrangement.
+This often, but not always, maps directly to the processor power topology of
+the system. Individual nodes in a topology have their own specific power states
+and can be better represented in DT hierarchically.
+
+For these cases, the definitions of the idle states for the CPUs and the CPU
+topology, must conform to the domain idle state specification [3]. The domain
+idle states themselves, must be compatible with the defined 'domain-idle-state'
+binding [1], and also need to specify the arm,psci-suspend-param property for
+each idle state.
+
+DT allows representing CPUs and CPU idle states in two different ways -
+
+The flattened model as given in Example 1, lists CPU's idle states followed by
+the domain idle state that the CPUs may choose. Note that the idle states are
+all compatible with "arm,idle-state".
+
+Example 2 represents the hierarchical model of CPUs and domain idle states.
+CPUs define their domain provider in their psci DT node. The domain controls
+the power to the CPU and possibly other h/w blocks that would enter an idle
+state along with the CPU. The CPU's idle states may therefore be considered as
+the domain's idle states and have the compatible "arm,idle-state". Such domains
+may also be embedded within another domain that may represent common h/w blocks
+between these CPUs. The idle states of the CPU topology shall be represented as
+the domain's idle states.
+
+In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order to use it,
+the hierarchical representation must be used.
+
+Example 1: Flattened representation of CPU and domain idle states
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>,
+					  <&CLUSTER_PWRDN>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_PWRDN>, <&CLUSTER_RET>,
+					  <&CLUSTER_PWRDN>;
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+Example 2: Hierarchical representation of CPU and domain idle states
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD0>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD1>;
+		};
+
+		idle-states {
+			CPU_PWRDN: cpu-power-down {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x000001>;
+				entry-latency-us = <10>;
+				exit-latency-us = <10>;
+				min-residency-us = <100>;
+			};
+
+			CLUSTER_RET: cluster-retention {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000010>;
+				entry-latency-us = <500>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_PWRDN: cluster-power-down {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000030>;
+				entry-latency-us = <2000>;
+				exit-latency-us = <2000>;
+				min-residency-us = <6000>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CPU_PWRDN>;
+			power-domains = <&CLUSTER_PD>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&CPU_PWRDN>;
+			power-domains = <&CLUSTER_PD>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+		};
+	};
+
 [1] Kernel documentation - ARM idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
 [2] Power State Coordination Interface (PSCI) specification
     http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
+[3]. PM Domains description
+    Documentation/devicetree/bindings/power/power_domain.txt
-- 
2.17.1

