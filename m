Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5891BECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135F42084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KngN6QU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135F42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbeGSOFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:05:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44095 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeGSOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:05:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so7448784ljq.11;
        Thu, 19 Jul 2018 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xr6zoJuis9T7PH6Y1NR12kXsVCPvALyX6ctcsGCCpqU=;
        b=KngN6QU5bU5Mbn7XwjDYx8vqiezrzzRifZ7ugsuAsgbzIhGO2gb0z0elyB7HujwNAS
         oMD1d1Qtr6Cw2vkHjrr/aBk3dm14jps4LFwJCEwX0LzlyMJr7XxE4W4J6Sxgw9EuMJlu
         ILnO2Q+txZHhT4u/vXDmDalmkXoN1RhPrGedIH7vJzN6dopmBmZskCJYIBEZb7BHMW0p
         wwsPyItk6mZ9ZKzO5nziAAjpsvcgwKm7KXuvM7zjwUXSc8SRFnxVEKZN7MEla4Q//ycN
         QAQNuNq82aIQRuKh9+3EYS3withKN4q9KQq/QZ2Nygoxdp6HgR/9Y+ru5xX0T06fXvsD
         4PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xr6zoJuis9T7PH6Y1NR12kXsVCPvALyX6ctcsGCCpqU=;
        b=Ol1PgQV5uNidpxl7lha7KS41pBw58d4yoY9Lj66kx8weOye7zgFuKRLcLmSGc4mWWQ
         Bqy+5WJL9aasB3OWlua0tahVivNrKJp+FNOcvK49HGvtkX/eSl4Or+h2VBg+XV1qv6B4
         HRdsVF8u2jtItCLV1T0mQs2T6a3TMhciTmSxWz2CMbLYL3FCzm8jOJbcpc03ywt3abh5
         MyoRCKqPCyy/onBcLmsvw0UKkTh7+yybuAT2azllSt5yWVcbEC5QYGSOnRXjbpBlp55W
         WMAn80K3pfjZ1wp3s1W9lo9DsRDE/UWVPG4ne9+cmzP8x/gU2Cwpn7lVclMep0WvCa4f
         cMbQ==
X-Gm-Message-State: AOUpUlFNhnZrRfVgVOAMNldtaS0+Wvp2Qqv5dP/c1peDi8bIHFfwYQwe
        yrTwpOwCrWJiTb9vdJ2T4haDmO6w
X-Google-Smtp-Source: AAOMgpdQ1WDR3GCIiT0QYuTwH4S3+f1IoR5g7dDCRFWkE6jhbMSVDvh6HdjvFLzgOLpKvlSXDEQWOw==
X-Received: by 2002:a19:5418:: with SMTP id i24-v6mr6429942lfb.34.1532006556228;
        Thu, 19 Jul 2018 06:22:36 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1109592ljc.67.2018.07.19.06.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:22:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] ARM: dts: tegra20: Add clock entry to External Memory Controller
Date:   Thu, 19 Jul 2018 16:21:29 +0300
Message-Id: <20180719132132.16153-6-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719132132.16153-1-digetx@gmail.com>
References: <20180719132132.16153-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock entry into the EMC DT node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9eb4163a4390..979f38293fe5 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -633,6 +633,7 @@
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x200>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.18.0

