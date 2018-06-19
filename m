Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F05C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E766205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hdiSw2h4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E766205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030749AbeFSTpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:45:52 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:43152 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030603AbeFSTn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:43:57 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJgsCC013973;
        Tue, 19 Jun 2018 14:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437374;
        bh=HcCx7LD79bPPiSZoxz2utLNN19xe6/P4tzyC0my9+Yw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hdiSw2h43408SiSTdCTAFtbKoEGv+SuGTFhFsDMB8MyAAIFpQpo4mLS4FNcTMKHHR
         W1vQC4bLriVrxT4ftGrMJlGyw9zc/UMKUc7xgXrMqsn4Qd4odDNshln0QuqP20YDIm
         xBfpLG/aSN/UjHalnhzmMWymHKtzAmYLRESaT2to=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgsPA008175;
        Tue, 19 Jun 2018 14:42:54 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:42:53 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:42:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgrl1025780;
        Tue, 19 Jun 2018 14:42:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/5] arm64: Add support for TI's K3 Multicore SoC architecture
Date:   Tue, 19 Jun 2018 14:42:50 -0500
Message-ID: <20180619194253.27288-3-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194253.27288-1-nm@ti.com>
References: <20180619194253.27288-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Texas Instrument's K3 Multicore SoC architecture
processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since RFC:
 * None

RFC: https://patchwork.kernel.org/patch/10447633/

 arch/arm64/Kconfig.platforms | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac351fc3..52df25bf4f8c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -71,6 +71,13 @@ config ARCH_EXYNOS
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
+config ARCH_K3
+	bool "Texas Instruments Inc. K3 multicore SoC architecture"
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for Texas Instruments' K3 multicore SoC
+	  architecture.
+
 config ARCH_LAYERSCAPE
 	bool "ARMv8 based Freescale Layerscape SoC family"
 	select EDAC_SUPPORT
-- 
2.15.1

