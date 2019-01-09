Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3978C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9078220859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s4+87stl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfAIMk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:40:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47940 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfAIMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:40:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x09CeMFl051496;
        Wed, 9 Jan 2019 06:40:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547037622;
        bh=n7rP53C1I+KPeUkkzbx/weUeZp2I8+PfwHYQnGJ+2vk=;
        h=From:To:CC:Subject:Date;
        b=s4+87stloGK1BjDnCZbhE/WAPi2ID0mytlFKxmRavqJOM8VTW/vZmwjzjbhr/HYso
         psR36GSlZPslsSL3LRKnHQWwQNo6y3j+buZz2+WrhIf5+caRYms4XZ1Mkc4nH0piUu
         6NfYDVLsOjbNfu32VdUuByTmLeYtQK8SLOB8MJGc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x09CeMnf055344
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 06:40:22 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 06:40:22 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 06:40:22 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x09CeJOl010973;
        Wed, 9 Jan 2019 06:40:19 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <j-keerthy@ti.com>, <edubezval@gmail.com>, <olof@lixom.net>,
        <faiz_abbas@ti.com>
Subject: [PATCH] mmc: Fix Kconfig warnings on keystone_defconfig
Date:   Wed, 9 Jan 2019 18:13:12 +0530
Message-ID: <20190109124312.10154-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
SDR104/HS200 tuning failures (i929)") added a select on TI_SOC_THERMAL
for the driver to get temperature for tuning.

However, this causes the following warning on keystone_defconfig because
keystone does not support TI_SOC_THERMAL:

"WARNING: unmet direct dependencies detected for TI_SOC_THERMAL"

Fix this by changing the select to imply.

Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
SDR104/HS200 tuning failures (i929)")
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e26b8145efb3..bc61eefcb695 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -978,7 +978,7 @@ config MMC_SDHCI_OMAP
 	tristate "TI SDHCI Controller Support"
 	depends on MMC_SDHCI_PLTFM && OF
 	select THERMAL
-	select TI_SOC_THERMAL
+	imply TI_SOC_THERMAL
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's DRA7 SOCs. The controller supports
-- 
2.19.2

