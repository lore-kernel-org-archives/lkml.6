Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F75C5CFEC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C77205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D+qtqD1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C77205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030620AbeFSTn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:43:59 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:43141 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030601AbeFSTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:43:54 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJgsXR013977;
        Tue, 19 Jun 2018 14:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437374;
        bh=TcrvLHU0/p8ER9oN9mDUURhry9J/rUFNdxEx4r1c51Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=D+qtqD1kqIrePuuyNWI7CrciHKyvvy290kfZLwm4C4pScV17aP0maqu1fW5UCxZ6G
         lg6PAGm+JQrv26ZKc3XP2P6wy033QwXZriu2Zy5fJ+exLKhjGctzN4nohQS+E9eymL
         Dgw00GAP9Px5ccCUMa62bu48cMc9UTzfRllQM/C8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgsZ8023377;
        Tue, 19 Jun 2018 14:42:54 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:42:53 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:42:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgreK031556;
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
Subject: [PATCH 4/5] soc: ti: Add Support for AM654 SoC config option
Date:   Tue, 19 Jun 2018 14:42:52 -0500
Message-ID: <20180619194253.27288-5-nm@ti.com>
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

Add option to build AM6 SoC specific components

Signed-off-by: Benjamin Fair <b-fair@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
(new patch broken out from: https://patchwork.kernel.org/patch/10447719/)

 drivers/soc/ti/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 92770d84a288..be4570baad96 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -1,3 +1,17 @@
+# 64-bit ARM SoCs from TI
+if ARM64
+
+if ARCH_K3
+
+config ARCH_K3_AM6_SOC
+	bool "K3 AM6 SoC"
+	help
+	  Enable support for TI's AM6 SoC Family support
+
+endif
+
+endif
+
 #
 # TI SOC drivers
 #
-- 
2.15.1

