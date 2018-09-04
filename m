Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1513BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A6020843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxmezNYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A6020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeIDJXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:23:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35405 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeIDJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:23:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7-v6so1043344pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8dnrInycPf/HQ5dYGYALxd9QKDKw+KzD8Sq1rCdWvlo=;
        b=AxmezNYmRY6tHZBkf7MM19ZKYwIvy0dWm6RBmqqdG1gy0K61yXmpLoGs35+GWSC9o2
         4lsENMKPg9Gid0rX69dleqpe5hk1sspJ6a/zK4yNbmKLLbSF4SASkEoJIWuOFJ2ASDbu
         X52ZVWmhLPgPLD6dGeGYe7dlw5R7NJ7SGiNZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8dnrInycPf/HQ5dYGYALxd9QKDKw+KzD8Sq1rCdWvlo=;
        b=CkOMQw21daS1cdHglUoQruQ2tAA7DuinqnVxkR+6JrupktLIr1oJxuf6Yo8D+gKytp
         1F/poZu6EMX5sm3uVNSacBLPHvqXd2Aq2pPDamngSmoelLCr7GwcGIX0xk0gUOJCyq7k
         GR6N+zcmGVdEnIq+J4QqEKyTg1i2z6P6HGKuvad+kxt1RbGoMmQ7tqfeX/2MbfkHobGB
         ei15kCBxUEaFeBuHXQHO8a7XOTQ3+M/oEec1Youk4GOlGrVenuEBr3nzuxvJuBQTvNN9
         KQgoT0Pk3eYJ5DpIcBFiyDKeW1BQXeTEIpW5fjdcMFHISfneOnW78KJzQw3myVRBfVre
         L6Qg==
X-Gm-Message-State: APzg51C5sBX7kGIe273CzVOFwp5yaFL3GX1dn3fGSJHLDjFu8n5u2QCL
        ISAeYoJQ3qyW56qBHQJOjra94g==
X-Google-Smtp-Source: ANB0VdbZvfl6OjVXOd+gGsOlk0my3GP6ICaEO6Me/xaPP+HBIkwZMSL3D2PLLaO6sqXmT8LRVHxReA==
X-Received: by 2002:a63:ad44:: with SMTP id y4-v6mr29084616pgo.138.1536037179918;
        Mon, 03 Sep 2018 21:59:39 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v72-v6sm41180378pfj.22.2018.09.03.21.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 21:59:39 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] arm64: dts: qcom: msm8998: Add smem related nodes
Date:   Mon,  3 Sep 2018 22:01:20 -0700
Message-Id: <20180904050123.26601-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904050123.26601-1-bjorn.andersson@linaro.org>
References: <20180904050123.26601-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reserve-memory nodes, tcsr-mutex nodes and the smem node.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f92f04f9ed6d..335bbc339932 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -20,6 +20,38 @@
 		reg = <0 0 0 0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		memory@85800000 {
+			reg = <0x0 0x85800000 0x0 0x800000>;
+			no-map;
+		};
+
+		smem_mem: smem-mem@86000000 {
+			reg = <0x0 0x86000000 0x0 0x200000>;
+			no-map;
+		};
+
+		memory@86200000 {
+			reg = <0x0 0x86200000 0x0 0x2600000>;
+			no-map;
+		};
+
+		rmtfs {
+			compatible = "qcom,rmtfs-mem";
+
+			size = <0x0 0x200000>;
+			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+	};
+
 	clocks {
 		xo_board {
 			compatible = "fixed-clock";
@@ -205,6 +237,12 @@
 		};
 	};
 
+	tcsr_mutex: hwlock {
+		compatible = "qcom,tcsr-mutex";
+		syscon = <&tcsr_mutex_regs 0 0x1000>;
+		#hwlock-cells = <1>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -225,6 +263,12 @@
 		};
 	};
 
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
 	thermal-zones {
 		cpu-thermal0 {
 			polling-delay-passive = <250>;
@@ -474,6 +518,11 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		tcsr_mutex_regs: syscon@1f40000 {
+			compatible = "syscon";
+			reg = <0x1f40000 0x20000>;
+		};
+
 		apcs_glb: mailbox@9820000 {
 			compatible = "qcom,msm8998-apcs-hmss-global";
 			reg = <0x17911000 0x1000>;
-- 
2.18.0

