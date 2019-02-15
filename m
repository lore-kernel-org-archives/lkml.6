Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B48B21900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b5avKjzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388608AbfBOTSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:18:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59574 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfBOTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:18:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJHtX1128907;
        Fri, 15 Feb 2019 13:17:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258275;
        bh=5aOXUftpSTvvCexBiVyDIS/uD0/uROkC1XgmXiG7b4E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b5avKjznTswEck3ZzlHxSoMkIbkXVzvHEA43gGbJycNwyopOCTaTC+GPcf15F0yYj
         7eBwErRXLA0M4O9YQrCZl/JLkM0/UISiBMB/AResUKm+UjdQiHZtU0giVsoCGrWbcY
         HZJQ1tYTY7N2UqqV6a12Bk1CZSIAJsNBg53C+wFw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJHtZZ015784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:17:55 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:17:54 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:17:55 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJHV12025256;
        Fri, 15 Feb 2019 13:17:52 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH v2 6/8] mmc: sdhci-omap: Add DISABLE_DTO_FOR_ERASE Quirk
Date:   Sat, 16 Feb 2019 00:50:31 +0530
Message-ID: <20190215192033.24203-7-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Quirk to disable DTO during an erase command.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8a05e94fe612..ae9701d198d5 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -852,6 +852,7 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_RSP_136_HAS_CRC |
+		   SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE |
 		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 	.ops = &sdhci_omap_ops,
 };
-- 
2.19.2

