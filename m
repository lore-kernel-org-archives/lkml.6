Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09AAC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632AB20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fp09qhT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632AB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbeG0WrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:47:15 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35508 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389833AbeG0WrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:47:14 -0400
Received: by mail-qk0-f193.google.com with SMTP id u21-v6so4230634qku.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDhDEieGfZgj7ft9srjOzP1iG7t2NYgyC6j1BwfZdrI=;
        b=fp09qhT5eUP4qmQhc0EZ2p6Pz+C/sLKm71MJJwNspesBpSElPmSHPljuh7vKe0kMIu
         HoZ8jhN1FTDESR8t2AhL2CAp8Y5dt37vIOetFXvq2nxjfpsCrtOT3MdfkHI0ExFuSnfx
         /srJVPQyzHCC1Bt6yxM/MLMl+WcmGkrUl3LsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDhDEieGfZgj7ft9srjOzP1iG7t2NYgyC6j1BwfZdrI=;
        b=bUlAnBNLYOhwiVYOdDI6RsjyUy4TayvdVfSoZ6HyiaRnTf2vBZ/kq7Dt/ijJiBFBn9
         7EkGZBSBqZgvDqe4Wjmd+wOiJ1JQo2QXO9lDwZCvl7ggNhOS/FnIcRnbV+4VBFizhPlj
         poOwZKjv3xvj62ZH20/e+ecn6qHs75nl+FobCvsTaOyT9So4gs9rnYOZgtJpJ0muzuy/
         Q5cjsM7XOoXRMDHvvGmAotMk5SJCtt8EMYQ7HjxpfT077ayNnYXPAN+ybSkur284ZJWI
         5GUwsfqW1ApCwxM31m9khyjD+lFcnD+6iYhKLphP3bh6rro83nIbsPZsgktSFZmEkHFy
         8lAA==
X-Gm-Message-State: AOUpUlHTN91oL6dRcN5SoYgRf3SGPM4YD5VX77qWB5KDFGxlDmFtIWXw
        OrpI9wo2elArxWY8J6fldI4U6A==
X-Google-Smtp-Source: AAOMgpdcsLjbdWbYSRnnTsb9avwrc1L3znW7TqwUonf7M+87LXNTnAnsrVbFlzvxrFYCGdHPMHjHnA==
X-Received: by 2002:a37:ab17:: with SMTP id u23-v6mr7423872qke.279.1532726610576;
        Fri, 27 Jul 2018 14:23:30 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3416622qtc.67.2018.07.27.14.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 14:23:30 -0700 (PDT)
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
Subject: [PATCH v2 3/7] arm64: dts: Fix the base address of the Broadcom iProc mdio mux
Date:   Fri, 27 Jul 2018 14:23:29 -0700
Message-Id: <1532726613-6483-4-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the base address of the mdio mux driver to point to the
start of the mdio mux block's register address space.

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

