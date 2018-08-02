Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85912C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD2B208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cppJ0kOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD2B208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeHBCmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:18 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37181 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732392AbeHBCmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:17 -0400
Received: by mail-qt0-f196.google.com with SMTP id n6-v6so551083qtl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RwD94yFvz8u5xZo/C2EuBOqHrdsbi50cG7BNSdHptbM=;
        b=cppJ0kOIVzLMf0MZux43INfyV75v/Z05Ywel3f8AAJHLHxIkVlnNBwufWDLQmIKoMI
         IHsaC7XPXspKi7rBOr274t9S4l5j9drPua2x/Sh6l6HbTIJLLrxeUXNXm1faVD51iUHh
         RH4I+j4PDEEmrAmO53rNyXE0aDhdnvJUfxuac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RwD94yFvz8u5xZo/C2EuBOqHrdsbi50cG7BNSdHptbM=;
        b=M7LOCev243466mOlMEcaSOu7QmvA1/dZEjAzkw92LwIxhNQxVz4wq3yz4IL10hjXZ5
         9kZadSQ8ou1uizzSRmOJ8QpQr4Zck9Y8p04P6zIC4ROPUG+JP1r70oRARQf68+wu7R6o
         Lo+CIsSTbCgoDGmzXcRgSCrUOpWODKJmsfMS74IfO8bQ313NSL+49uRphszH+MSvzXHe
         4wqtgY/AFcMxh3cBrNgcT3B2TlXJ+UXphLwqsxfgGRJzDnHSJ1VTGSDbilc3Iqja63Ha
         6tX3MUQQ1mH+pOpksuUKXsk60UWhNSM+jQp3pLWk4E80moxxxx5i/CrE1dlzDPwzelN+
         8Q6w==
X-Gm-Message-State: AOUpUlGM/5jlIOSAie9Bomav1xNSlcgsAAIPxErhxotl+UaCnWJs03o9
        Aje4nKh8lNb0aNDOzxHB3HJI+Q==
X-Google-Smtp-Source: AAOMgpcKLzh6aTraINUuA+9k63n1iy2uW84lTjGW8lVE4vHY6fP5T9VQBZ19NxqSY363B2FP0qMYDw==
X-Received: by 2002:a0c:b587:: with SMTP id g7-v6mr647737qve.94.1533171227701;
        Wed, 01 Aug 2018 17:53:47 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:53:47 -0700 (PDT)
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
Subject: [PATCH v4 3/8] arm64: dts: Fix the base address of the Broadcom iProc mdio mux
Date:   Wed,  1 Aug 2018 17:53:48 -0700
Message-Id: <1533171233-14557-4-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
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

