Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63392C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FBD2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NVJPP4S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FBD2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934398AbeFLUV5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:21:57 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44113 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934327AbeFLUVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:21:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id l33-v6so283103qta.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9opAhrkVfhHM2teMB/ZFbF4J/yGuZ0kGsqB/+QV37+8=;
        b=NVJPP4S+1Ubg2rKbmusXwHgJkB+NxjKGlmsW1nyJYTshVklCNHBghC00zUn0zuH2wh
         XyqfC1Zg3yCQBT3D1OV6EBB3X5dqNQPDXUatF31b3+AGZMm2Dt4BvbTpifdPOH1NPBg3
         A2vxY8Ynkcho/+JAHSFBfgVEPibP4/8jugckg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9opAhrkVfhHM2teMB/ZFbF4J/yGuZ0kGsqB/+QV37+8=;
        b=F//FJdnNBvQXeGRJvjP+I4CN7EMkzy6udNLo/V68mryTlptAOi/j1YJfHH8+2WF5Ip
         v/UTNL0pGRvedKLAzOvcGuog034ydxGFd90N86+CR7YOMtapcdmZRTlxrTXYLEXlXQr2
         pldSW+CJr3bPVYyqbAM2SCeTx7cmZfDk8FqgdysTc1jisNEUITksOAz38wK2HNHXvYve
         jM6ck7sVwlIyHy2mC1o55HzAU1TX0vgLuyZX1/qjog5CHSdyx/htDHKZQMmHjwOYmajQ
         fDxn79T+WUbFqCBJuQrfHgp+UWvg4XF5N/z6vqf0AMW9L+4Qf0pMZc14GT54MHGhx9Z7
         WjIg==
X-Gm-Message-State: APt69E2YzsDDl6+hvBG55l3QMKPfZ1IRGuV+Gec3xIDfBOGkEc2QPjQS
        45yTOOVyuRc+TsOqOTFnHhG8BA==
X-Google-Smtp-Source: ADUXVKI/mipEtXr3sS+a4lJ4AbZf6M/ECcvmJpLhr7qj7BFAFFhv0Z7oP9vqrUoi0jqhQrPCnRZJIw==
X-Received: by 2002:ac8:bc9:: with SMTP id p9-v6mr1925449qti.175.1528834911997;
        Tue, 12 Jun 2018 13:21:51 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l9-v6sm635080qtp.25.2018.06.12.13.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 13:21:50 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 3/5] ARM64: dts: ns2: Fix I2C controller interrupt type
Date:   Tue, 12 Jun 2018 13:21:29 -0700
Message-Id: <1528834891-17807-4-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for
Broadcom NS2 SoC

Fixes: 7ac674e8df7a ("arm64: dts: Add I2C nodes for NS2")
Fixes: 63a913c157f5 ("arm64: dts: move ns2 into northstar2 directory")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 4a2a6af..c0e4896 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -566,7 +566,7 @@
 			reg = <0x66080000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 394 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
@@ -594,7 +594,7 @@
 			reg = <0x660b0000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 395 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
-- 
2.1.4

