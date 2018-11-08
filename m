Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E85EC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5C320825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZP5HsXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5C320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeKHSjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:39:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39134 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeKHSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:39:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so414251wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQkj1hz0jEEKFJdYxtoN3LCnWHFTEXeYAE7pWLaze8c=;
        b=bZP5HsXKn+NmVZUSWhMsRAUIB1J4stGd5tz0mcnKqJ8haMeq5yBEqxBOjzyK8AaaAT
         JBJ3ueWEg6b6sV9/RspHgteD14PuGQJvmvdkoNdoE08d1fT9H/ymvM88SjucAmv2IRgM
         yvlf5K+Ernu/tqAZ3JjtWOhJQLwrMBq8TLn2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQkj1hz0jEEKFJdYxtoN3LCnWHFTEXeYAE7pWLaze8c=;
        b=UJSCThc+YNqyf0PhNDe/tc4PCNQcTRbENpeHOLi3bot3BKQuN/kzCd+bRSmEX9mNPZ
         pZbTtGeKRJ3P2sBwKwioimtT4VFKbEi5a5Lx6qaHVq1p9SDMVTd1KenSVV1XUwAUnP7A
         O3e31vLZZovKcbqxpUftGkXdEAUeyaYoPNbOiaGaZl2z6/1bpsXayZwzx2bzZYz4gvGQ
         YCIXi7o+QXUT3Q1m6LJ1V5hN1BuW+f/WY8sUjIvvdvUSjwfxhWCVQU+bHqcOyh4+1j7b
         49VZVqNYm4cNDtEhM/j1V8Zb5o3SmD7uwwjAP2FuHLU128qEN0KTyezot4DkqZCg8RlP
         DDHA==
X-Gm-Message-State: AGRZ1gLTtt3BIzfsERt6tnCOf8cmP9kwjlQFH7+s7EJA51Q/HX+kT6N/
        S/GegDWySa7UYl1t32RNvq6Xag==
X-Google-Smtp-Source: AJdET5dWLP0Ce4B9uITjiq/lmAggodgFZlChTXhroWfVryZH8jjR7e4xWMzgmBWrk3AvoTdTZjH9bg==
X-Received: by 2002:a1c:8314:: with SMTP id f20-v6mr446270wmd.120.1541667919767;
        Thu, 08 Nov 2018 01:05:19 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1094:149:440c:9368:8cda:a020])
        by smtp.gmail.com with ESMTPSA id l140-v6sm6974469wmb.24.2018.11.08.01.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 01:05:19 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 3/4] ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
Date:   Thu,  8 Nov 2018 10:05:01 +0100
Message-Id: <20181108090502.14543-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181108090502.14543-1-benjamin.gaignard@st.com>
References: <20181108090502.14543-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare hwspinlock device for stm32mp157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2 :
- change clock name from hwspinlock to hsem to be align with hardware
  documentation

 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 185541a5b69f..98f824d8b0f0 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -803,6 +803,15 @@
 			status = "disabled";
 		};
 
+		hsem: hwspinlock@4c000000 {
+			compatible = "st,stm32-hwspinlock";
+			#hwlock-cells = <1>;
+			reg = <0x4c000000 0x400>;
+			clocks = <&rcc HSEM>;
+			clock-names = "hwsem";
+			status = "disabled";
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.15.0

