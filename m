Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A642C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BA221473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GJHRw9dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BA221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJRXnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:43:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45746 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbeJRXnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:43:14 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9IFfBor071864;
        Thu, 18 Oct 2018 10:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539877271;
        bh=m0a6QgKxwOqk1bCOtWrNe2GMVquZIHMZiiANX0H3/fo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GJHRw9dyNmY662vpQSiwQ5Qt2YgoyzuzSr9fVIlI8mtoEizf9MdS3Eg1714el/FBE
         Z+n2nJPlip1mlvEcUngBuQcGmQpKC2+DfY4IqUvNWZjsTrFMWlTdYsEpPlB/PYWW9e
         hFcBXm2fOb9sH60uKEPOijge90UMpvtzhN41EA6s=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9IFfBXE017462;
        Thu, 18 Oct 2018 10:41:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 18
 Oct 2018 10:41:11 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 18 Oct 2018 10:41:11 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9IFePOp006432;
        Thu, 18 Oct 2018 10:41:07 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 10/10] soc: ti: am6: Enable interrupt controller drivers
Date:   Thu, 18 Oct 2018 21:10:17 +0530
Message-ID: <20181018154017.7112-11-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018154017.7112-1-lokeshvutla@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
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
Changes since v1:
- new patch

 drivers/soc/ti/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index be4570baad96..9ef2a8a92eb4 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -5,6 +5,9 @@ if ARCH_K3
 
 config ARCH_K3_AM6_SOC
 	bool "K3 AM6 SoC"
+	select TI_SCI_PROTOCOL
+	select TI_SCI_INTR_IRQCHIP
+	select TI_SCI_INTA_IRQCHIP
 	help
 	  Enable support for TI's AM6 SoC Family support
 
-- 
2.19.1

