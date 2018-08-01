Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37572C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7000208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EDVd+ywn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7000208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbeHATnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38887 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeHATnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:13 -0400
Received: by mail-qk0-f194.google.com with SMTP id 126-v6so13294198qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RwD94yFvz8u5xZo/C2EuBOqHrdsbi50cG7BNSdHptbM=;
        b=EDVd+ywnk47fk/zUjFgVH6f2smjy3L+v5UhNPEHZF78YHEQT0MplbRJDWbA8MfYQW1
         NMS81m+1HEpwtgpsVbQLk3kOHk9cXltM7TfDuUC7O6UOtG4kamo/jJBkB5tlgcmZjTks
         xW4wueDTz1P/3vOCDbLoI7AqW98PBELkg9s10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RwD94yFvz8u5xZo/C2EuBOqHrdsbi50cG7BNSdHptbM=;
        b=DDWRgNszu3O7TkNYhR8UfjD106xQfOue4v10Lrosx8LncCR25PWbD9rLiRxdeNah6G
         KOQhTlrRvzYWmJA5CcIHh2Hi31+UIIIV0RAH879J6hyZV5+YKZ7twxgPQqiivS/Ei1lb
         rb5h1wr66ZnoV/HigSPId92waRgh9COayrQjEsOBNq9uOPkbkoxcKRRcq/XyUW+oAOsd
         CuZuktHOwZyuZs1y35PdWWoHn3tbG15LjWDGhxDVVV56mP/VeMk5lEuNOsDibJPUpH+J
         YY8YiC8+AbuPxglAolIzY4ZUpK2fc9hLYP6HGRjGmnA+wbsDhNCeGdmoiZem1d1i3dah
         5M3A==
X-Gm-Message-State: AOUpUlGHv6tVHcUy9e5F1caWysDyQbRjbuRLLGC9KySB0zmCN2kFTb4X
        XlFugHyUgmflovVq50q5aQj0mw==
X-Google-Smtp-Source: AAOMgpdSR1A7ppHaQgRSMXUHBZYW/vY5S15q1v+ksXewdZUr5kyojdSeg/yLg1RHv25+JXA6JOxtTg==
X-Received: by 2002:a37:5d02:: with SMTP id r2-v6mr25160263qkb.22.1533146181625;
        Wed, 01 Aug 2018 10:56:21 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:21 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH v3 3/8] arm64: dts: Fix the base address of the Broadcom iProc mdio mux
Date:   Wed,  1 Aug 2018 10:56:21 -0700
Message-Id: <1533146186-8374-4-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the base address of the mdio mux driver to point to the
start of the mdio mux block's register address space.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 4 ++--
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 4057197..1a406a7 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -482,9 +482,9 @@
 			status = "disabled";
 		};
 
-		mdio_mux_iproc: mdio-mux@6602023c {
+		mdio_mux_iproc: mdio-mux@66020000 {
 			compatible = "brcm,mdio-mux-iproc";
-			reg = <0x6602023c 0x14>;
+			reg = <0x66020000 0x250>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index b203152..a70e8dd 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -278,9 +278,9 @@
 
 		#include "stingray-pinctrl.dtsi"
 
-		mdio_mux_iproc: mdio-mux@2023c {
+		mdio_mux_iproc: mdio-mux@20000 {
 			compatible = "brcm,mdio-mux-iproc";
-			reg = <0x0002023c 0x14>;
+			reg = <0x00020000 0x250>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
1.9.1

