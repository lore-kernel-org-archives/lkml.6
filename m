Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B58C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0132215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE2JhT8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0132215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeHRTD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33961 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeHRTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so6121299eds.1;
        Sat, 18 Aug 2018 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=foefKWQWNQ8X8Ch4wMslbP9vC8fmNK3R0kivUMnci4M=;
        b=iE2JhT8qmd9wue+/pK37oTbCiM7AS4BF4MXMskUhDhYw4NQKFXLWPNcHsMoTgw7h/9
         wGpDTtbGEjmi/r6nbshh1znS4Y88Um/+I177MUUB8NxL7KqiKO8aCny6jd7bjXsV+bVd
         VGkTA6DQZ0WJp/iZ57fd2uQ5jtsln9Gj56QmZ2FM98nkKQIvjtsF06XIGPgCELM0xDJW
         0bR0ZrVn4IfpEWOBtE3dqgiixmKMiLFitpXf+qrXhjHUKHUq+tmhtc0UoYVEy3JZjlIX
         U2J897Hp4T8Nbu4hXN0frz8T2S6Q65dzHrXQYNg1CKsMPBcQT5p3KNNkLQHfw1znSwBA
         wzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=foefKWQWNQ8X8Ch4wMslbP9vC8fmNK3R0kivUMnci4M=;
        b=VLd1+jKYJBMvPFRNXmj0mfMx51ocKeBQEHwAUpuu07DhWIQErE5mCULWOYgUciKqA3
         Hp8jZDQZkAMJqd4KC07NcnXuWlBcgkd8r/PmhTjILS7DjSU1u3st0+lxYM9FY7ThOVXZ
         uQZt+E8m6NJuJ8VRkEc5Bb4STwToYsC/kcU602Klkpd3u0HkrREGzUAM3ogFCsVzg1sY
         ioucs7Mrp0cfDsh0YN5ogJKwYsUxsbw5nas0zwClv2K43tCMxWytPrmroN+anBUo8aNX
         q0O7n12Rrt1Qjf7s2baH1HI3DzlUAaRsUZpQdz4Hx5FrjB18roYA0sh3L3tmwyTK584p
         Mk9g==
X-Gm-Message-State: AOUpUlH0akc7q0MVCeMfvTYPXgazgzQ2xFKtX0HyhkXlItIO3LvkW+vY
        RIa1xRLFQTDCUD6l8c4ubS9I3dYL
X-Google-Smtp-Source: AA+uWPz45jXHrfThd38+z/9jsaPZ09gB/It0E0BVCKPEj7OInsv2lvZzaggNuAsiCrND09NVhgm6pw==
X-Received: by 2002:a50:955e:: with SMTP id v30-v6mr48170355eda.268.1534607745268;
        Sat, 18 Aug 2018 08:55:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/19] ARM: dts: tegra20: Update Memory Controller node to the new binding
Date:   Sat, 18 Aug 2018 18:54:18 +0300
Message-Id: <20180818155430.5586-8-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree binding of Memory Controller has been changed: GART has been
squashed into the MC, there are a new mandatory clock and #iommu-cells
properties.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 979f38293fe5..74f6e52291c5 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -617,16 +617,13 @@
 
 	mc: memory-controller@7000f000 {
 		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
+		reg = <0x7000f000 0x400		/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+		clocks = <&tegra_car TEGRA20_CLK_MC>;
+		clock-names = "mc";
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
-	};
-
-	iommu@7000f024 {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
+		#iommu-cells = <0>;
 	};
 
 	memory-controller@7000f400 {
-- 
2.18.0

