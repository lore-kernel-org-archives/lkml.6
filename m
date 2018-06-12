Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F3CEAC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB792086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ca5wkO1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB792086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934497AbeFLUWc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:22:32 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41297 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934330AbeFLUVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:21:55 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so290736qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A8BbuCMBqTL/RiQC0WVvQBMaVvaV6yGsZQ2d/r1DNBA=;
        b=Ca5wkO1MWhLjTEWfH9NZIsVwZE5FkduzwcorggiE77OO55X0FXVHsN317WjPUv8mBb
         dijHikAMEM/MouAqD5r7CKXsAjtWgxPfFL8Kgoe2sXHma3N+PKO5dRZ4rteg/cnYRouh
         f9pHjqeFj7TUk0aG83cEeffCGxBvAFDKqyj70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A8BbuCMBqTL/RiQC0WVvQBMaVvaV6yGsZQ2d/r1DNBA=;
        b=l7fRYvDc0GT2oHoB2u7xNB0dV7ilQFvOiQb+P7WN2NvxpDGYELF2YpVb//eZ/Aahs1
         ak8i5tO2hHXciop+DZ6cOEvKLyLvHzO71XVomlXvq+riJFYxGDVMJ4CqJCtVaM2bdS9z
         RL/FKKays6E6ieQIM1QNO5MSamL19xn1Yyv+BBvnxFugtoKCXrm+N1KuCF7fmyJtzeNI
         Ib2VaDYzTthcAzeA7BwwRT/f6m7PqMg91635+hxo4qZA2IBa+/8Z0yA+w6JzG0Pnd8Zo
         z9P5vKyAA+XxQ8n3QCTxuObnpWoABoVn94A2eZsWNNtsB2LpNUAsZZ62lfxaaOMVu8xc
         wMbA==
X-Gm-Message-State: APt69E0G88yJxocUedEz7/+O22Ua5mXEvO70/Wk4BMpK4gxNafwA5v4Q
        q0VYvoG5uGwvmhiUS6XrLr6MMQ==
X-Google-Smtp-Source: ADUXVKIhV74j46pUlgT112UhQUpc+ZbMm7uO3m0QZ9J0xJmfyurm8m9jBjkLWpv2x2R5j/vq55T1aw==
X-Received: by 2002:ac8:19ca:: with SMTP id s10-v6mr1973965qtk.303.1528834915080;
        Tue, 12 Jun 2018 13:21:55 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l9-v6sm635080qtp.25.2018.06.12.13.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 13:21:54 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 4/5] ARM64: dts: ns2: Fix PCIe controller interrupt type
Date:   Tue, 12 Jun 2018 13:21:30 -0700
Message-Id: <1528834891-17807-5-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for
Broadcom NS2 SoC

Fixes: fd5e5dd56a2f ("arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2")
Fixes: 63a913c157f5 ("arm64: dts: move ns2 into northstar2 directory")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index c0e4896..4057197 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -118,7 +118,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <0>;
 
@@ -149,7 +149,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <4>;
 
-- 
2.1.4

