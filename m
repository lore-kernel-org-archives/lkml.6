Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 140A6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF8C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BUGwklNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF8C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934325AbeFLUVv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:21:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38110 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeFLUVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:21:46 -0400
Received: by mail-qt0-f196.google.com with SMTP id x34-v6so301563qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1zNdUlBo1ozKLt4Lb7gtVMnNej0ZTqzQP9kBnzh4t18=;
        b=BUGwklNc14u0p1D14rD1Tp7CnUgzPXc3AV9ZYxjfzWXuJgofbqcOczwbAygnSg2/q7
         kKZir4UGk1rb4a7GPaEmj79KV0jJuWCSuFb818Ydd8gNRm7NhGrW0GsUB2CoudVYIUnB
         3+fK6ClOysA86haGr5jSDfHhovogQeUPCREHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1zNdUlBo1ozKLt4Lb7gtVMnNej0ZTqzQP9kBnzh4t18=;
        b=s6pZYe9lRaH+ntQEYtkTQhDe/W7wmrc8bP6RsCAT4Zsl2WDUWAtH5lfj4EWPFBCDvE
         yd6DIdrZD4Ai5MxYwlvC5yI5BH2ZXr8b66YrxEgGFkrmr+XI2OS7Bce53BL5YYoeYaiV
         H8J9QgeP2TDx8hA8BCxO0itB+mAVqgQVvrcovfUSw5t7SJNIxAEdmGG/kWSrCLl+T8Pj
         BoMO4m2Yv3Xx1W0JeDToNnQpNSEZs/AfJ1SI6kq4CGIY4WbYv9exmr0/Jm+v+MAQcgS1
         tlWjpuxvF/1CbNod1SQ2kiSirmboG1lO808ilZa3iMP20HPfjOW2u78lFsayB3Ya5VGX
         oO3A==
X-Gm-Message-State: APt69E3lb9FelDqmzY4gHpGyRWsEv/7HDcTEga1nEkYCliwFLo2LKsXr
        ug4+XpupzI9NooNWLr2UPl94oA==
X-Google-Smtp-Source: ADUXVKIyhgPQ7lDK2z749wShXR8TboUZOFZ9ALCp2B/SDJVD8T5cT3woxL7CrP15ai03vyqc9Ci3OQ==
X-Received: by 2002:a0c:9621:: with SMTP id 30-v6mr1943600qvx.127.1528834905601;
        Tue, 12 Jun 2018 13:21:45 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l9-v6sm635080qtp.25.2018.06.12.13.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 13:21:44 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/5] ARM: dts: cygnus: Fix I2C controller interrupt type
Date:   Tue, 12 Jun 2018 13:21:27 -0700
Message-Id: <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
Cygnus SoC

Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom Cygnus")
Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi bus")
Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 9fe4f5a..835a6f7 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -216,7 +216,7 @@
 			reg = <0x18008000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
@@ -245,7 +245,7 @@
 			reg = <0x1800b000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
-- 
2.1.4

