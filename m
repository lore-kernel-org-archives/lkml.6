Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE4C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8370D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e8tCp+4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfBLHoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:44:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40390 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfBLHoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:44:03 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7hfIw005417;
        Tue, 12 Feb 2019 01:43:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549957421;
        bh=p8DoSGbnagOTgtMc5WkCFpNMdJdrvnQTvwNp+0R+n58=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=e8tCp+4cUSlb/0GrtWsuo2kXxK9Lc3uLSyfhUo9+z4iHx7sjMBxHIOj+FANWisS82
         fVemnlr4m9YY11oN5fqdLjZiReV/6cF9I3S2vTX4TAvMUmcxK0WK9sQkPVTmEA640T
         VBiQYST7SsNpq3BC9Rp0BWj1OCbi4TjNzp5UuWfE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7hfx1020279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 01:43:41 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:43:41 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:43:41 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7gss6000385;
        Tue, 12 Feb 2019 01:43:37 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 10/10] soc: ti: am6: Enable interrupt controller drivers
Date:   Tue, 12 Feb 2019 13:12:37 +0530
Message-ID: <20190212074237.2875-11-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212074237.2875-1-lokeshvutla@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select all the TISCI dependent interrupt controller drivers
for AM6 SoC.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v4:
- None
 drivers/soc/ti/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 7640490c2a6a..145b701a3d96 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -5,6 +5,11 @@ if ARCH_K3
 
 config ARCH_K3_AM6_SOC
 	bool "K3 AM6 SoC"
+	select MAILBOX
+	select TI_MESSAGE_MANAGER
+	select TI_SCI_PROTOCOL
+	select TI_SCI_INTR_IRQCHIP
+	select TI_SCI_INTA_IRQCHIP
 	help
 	  Enable support for TI's AM6 SoC Family support
 
-- 
2.19.2

