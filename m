Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27040C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28392083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JgT/xUME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28392083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbeGZTzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:55:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33652 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbeGZTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:54:35 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15-v6so2587068qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCYxXF4NPzvvJ1VwO4jyNg04RUZXhkap/acOlejT33c=;
        b=JgT/xUME3xO42BFQz2K8Am8yycUyzd+48lbfZSGNW2PjLs9u4gbcr/iRhAYyjszn9/
         2ArPY0BjX9flYzuYMC5APIleHYzkmtywXhecVLbVg6tCAyWx6osA1QSxy+a00nd7y/Jp
         qmjTAmRWQIUSR36P6uohLBdIcJt7/iT9FSOvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCYxXF4NPzvvJ1VwO4jyNg04RUZXhkap/acOlejT33c=;
        b=NSoMkPoW4T0P8l9IAxX57UiV32rXDMlFP/3hAryAUbqcCXSR1lG1Jnh7EVPnZhgxtr
         gXjSiQIg2HoU5XwXvsy0rvV4UX/icR+1hk3D2FdR8KjHNXCl7A9EM8Ulj7HS7ZLSqNJb
         0OFrRDMwaFjujAO2fLswQd2ZmW6iM3eEI0rhlKoabO4xOnBEUORWrJ98olhjX9jYaoUy
         2mBcTph85jEVrjyHbeRikY/3zwCxeytvRZrxMsOPPLWAzWj7TveeHw+VzRPq27IO2gQD
         w87grf8Hhe0nspjA2yq+xMnFJX7pQb/VIe+3neWvGxEmtaysl9U6ww9nLfw6Kn2rDnOE
         FACQ==
X-Gm-Message-State: AOUpUlHovij0TcF/3LCwi2lD3RHxcCYEHcvNV+Dk2YjPL7RDj4sJ7qMR
        IX3OpMB2qOAghOXUoUTxYzg1Xg==
X-Google-Smtp-Source: AAOMgpdFz3sdjLWzA8ve/Ef/75ELsLb2t9u1PFc9a3nuaJuUNyItKJnPVdYpPD8XImQyEQlqkqMXvw==
X-Received: by 2002:ac8:3864:: with SMTP id r33-v6mr2976527qtb.24.1532630191718;
        Thu, 26 Jul 2018 11:36:31 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1383359qkd.47.2018.07.26.11.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 11:36:31 -0700 (PDT)
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
Subject: [PATCH 3/7] arm64: dts: Fix the base address of the Broadcom iProc mdio mux
Date:   Thu, 26 Jul 2018 11:36:20 -0700
Message-Id: <1532630184-29450-4-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the base address of the mdio mux driver to point to the start of
the mdio mux block's register address space.

Fixes: fd898f75dac7 ("arm64: dts: Add MDIO multiplexer DT node for Stingray")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
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

