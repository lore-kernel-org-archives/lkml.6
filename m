Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E64C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714DA20892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYgZ6R/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714DA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389569AbeKPUQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:16:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46473 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389547AbeKPUQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:16:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so10386910pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HClVvGiwOuWgQ6TjJ14HNKIrS62CNCv2+c1OlYODQLQ=;
        b=EYgZ6R/GukaNgdoqsL+uxEcbK4u50GApx9Jrvrdq5PtjcvbOzdKihSLY8qHyk4JUah
         JmTUeiVCXXf0NaYEjIQgSxfEqzMrhj2guSYLHqQs7ijcz+wlMZZbhmO5xNnUky32xYNo
         fr7LO3IgRE/Gm4kOImnuv0ghPrZqulGfKR3WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HClVvGiwOuWgQ6TjJ14HNKIrS62CNCv2+c1OlYODQLQ=;
        b=X/9JP9Q6PdzILX9P/uOIZBqkL+aq9nfZfzBrWcqQHOwqZMW4gd4CA2smbIv2gM/UY5
         3WHtYTFTMuxUfECy3lD1ZagW45govbl0cqLJEJX+8vFGtDmrPWdRFqIxx+bW9AjYxSIv
         HVSe4a7i342gP4FEl52i8Ixa7Aap5RX8TgVpvkXNm/RzwNhURe5rtIrfphB9w9mKUOBA
         w9maKwJiSRXKiKgNB2ZIyj5rI+oFHHBxrkf2+AQAqAN0+wW9ZP7keCac148+J3cxU7M3
         mWeb3+bUCcInR8jvJjxTfTxk/tzSjp36Ubuz8b4HVbDDsIfly40+reWzI6PsVKw3mL1o
         ZrvA==
X-Gm-Message-State: AGRZ1gK2pEPpgRFSodPk6BPFCVRR/Gu0+OH38YoyXzJCbuJqhnhv1jI+
        qghvd5fLGttATFrZykpmhtaU9A==
X-Google-Smtp-Source: AJdET5cORx44UTQ4adNwvGIigFS0ZpcMALU2BSxZXv3g94Lib06777UYHkmWoxoxwF6PydFVvWvZIw==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr9300065pgo.14.1542362705320;
        Fri, 16 Nov 2018 02:05:05 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id y9-v6sm32421519pfe.152.2018.11.16.02.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:05:04 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] arm64: dts: hi3660: Add missing cooling device properties for CPUs
Date:   Fri, 16 Nov 2018 15:34:27 +0530
Message-Id: <042e5e647a7b54f4322024f1b3e286b6b6d69175.1542362530.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f432b0a88c65..d943a96eedee 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -79,6 +79,7 @@
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -91,6 +92,7 @@
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -103,6 +105,7 @@
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@100 {
@@ -129,6 +132,7 @@
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@102 {
@@ -141,6 +145,7 @@
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@103 {
@@ -153,6 +158,7 @@
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		idle-states {
-- 
2.19.1.568.g152ad8e3369a

