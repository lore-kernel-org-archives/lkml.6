Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B861E216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xirfBIsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B861E216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbeKLIUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388879AbeKLIUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:37 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEC5216FD;
        Sun, 11 Nov 2018 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975440;
        bh=izpXxeFzTOgpbMr5jQAsDHpIpaG99VSaCz/M0zW1+pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xirfBIslYoMXer58xGFTvf8bZVvij79hO4GhNtZ5BwckZUS96hi/jUQ8CmEv3OvBw
         R2IvjuPBcia4nfq94rDIAuXPKvjE3HMP9N/uWvJr3moBK1K7qUFOrcJBv+b7g30OFf
         +i6kaPE2aSkCIFfi4l0f+JEWzsuEIaTV7DFYmOIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.18 192/350] arm: dts: exynos: Add missing cooling device properties for CPUs
Date:   Sun, 11 Nov 2018 14:20:56 -0800
Message-Id: <20181111221716.058337405@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 672f33198bee21ee91e6af2cb8f67cfc8bc97ec1 upstream.

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Fix other missing properties (clocks, OPP, clock latency) as well to
make it all work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos3250.dtsi |   16 ++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |   13 +++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi |    9 +++++++++
 arch/arm/boot/dts/exynos5250.dtsi |   23 +++++++++++++++++++++++
 4 files changed, 61 insertions(+)

--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -78,6 +78,22 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			clocks = <&cmu CLK_ARM_CLK>;
+			clock-names = "cpu";
+			#cooling-cells = <2>;
+
+			operating-points = <
+				1000000 1150000
+				900000  1112500
+				800000  1075000
+				700000  1037500
+				600000  1000000
+				500000  962500
+				400000  925000
+				300000  887500
+				200000  850000
+				100000  850000
+			>;
 		};
 	};
 
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -55,6 +55,19 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x901>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			clock-latency = <160000>;
+
+			operating-points = <
+				1200000 1250000
+				1000000 1150000
+				800000	1075000
+				500000	975000
+				400000	975000
+				200000	950000
+			>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -49,21 +49,30 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA01>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@a02 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA02>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu@a03 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA03>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -84,6 +84,29 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1700000000>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			clock-latency = <140000>;
+
+			operating-points = <
+				1700000 1300000
+				1600000 1250000
+				1500000 1225000
+				1400000 1200000
+				1300000 1150000
+				1200000 1125000
+				1100000 1100000
+				1000000 1075000
+				 900000 1050000
+				 800000 1025000
+				 700000 1012500
+				 600000 1000000
+				 500000  975000
+				 400000  950000
+				 300000  937500
+				 200000  925000
+			>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 


