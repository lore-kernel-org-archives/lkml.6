Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B537C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633562145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIA9zmRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633562145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbeK3Bf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbeK3Bf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6642145D;
        Thu, 29 Nov 2018 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501825;
        bh=6Vr+6NE9nbCE7r6CIjUMeC7knsd25fLZHOhDbVzHSLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIA9zmRUucA6isckVOWQRvACml/5lN/nK+fsjXNr5QZwZiUWPKw9Y1K7XWGGYzFMG
         B8zQe4waWI2/Ktz8SEwJDRklwSDH37HLb5QzAEaiOsnw8DRld+8z7YAv4HDNa/CCCG
         8zmpXnkoNm1Q5/YsxBCc2RDOSOGzKZa6k++KG920=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Chen <matt.chen@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.19 022/110] iwlwifi: fix wrong WGDS_WIFI_DATA_SIZE
Date:   Thu, 29 Nov 2018 15:11:53 +0100
Message-Id: <20181129135922.151284720@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Chen <matt.chen@intel.com>

commit 66e839030fd698586734e017fd55c4f2a89dba0b upstream.

>From coreboot/BIOS:
Name ("WGDS", Package() {
 Revision,
 Package() {
     DomainType,                         // 0x7:WiFi ==> We miss this one.
     WgdsWiFiSarDeltaGroup1PowerMax1,    // Group 1 FCC 2400 Max
     WgdsWiFiSarDeltaGroup1PowerChainA1, // Group 1 FCC 2400 A Offset
     WgdsWiFiSarDeltaGroup1PowerChainB1, // Group 1 FCC 2400 B Offset
     WgdsWiFiSarDeltaGroup1PowerMax2,    // Group 1 FCC 5200 Max
     WgdsWiFiSarDeltaGroup1PowerChainA2, // Group 1 FCC 5200 A Offset
     WgdsWiFiSarDeltaGroup1PowerChainB2, // Group 1 FCC 5200 B Offset
     WgdsWiFiSarDeltaGroup2PowerMax1,    // Group 2 EC Jap 2400 Max
     WgdsWiFiSarDeltaGroup2PowerChainA1, // Group 2 EC Jap 2400 A Offset
     WgdsWiFiSarDeltaGroup2PowerChainB1, // Group 2 EC Jap 2400 B Offset
     WgdsWiFiSarDeltaGroup2PowerMax2,    // Group 2 EC Jap 5200 Max
     WgdsWiFiSarDeltaGroup2PowerChainA2, // Group 2 EC Jap 5200 A Offset
     WgdsWiFiSarDeltaGroup2PowerChainB2, // Group 2 EC Jap 5200 B Offset
     WgdsWiFiSarDeltaGroup3PowerMax1,    // Group 3 ROW 2400 Max
     WgdsWiFiSarDeltaGroup3PowerChainA1, // Group 3 ROW 2400 A Offset
     WgdsWiFiSarDeltaGroup3PowerChainB1, // Group 3 ROW 2400 B Offset
     WgdsWiFiSarDeltaGroup3PowerMax2,    // Group 3 ROW 5200 Max
     WgdsWiFiSarDeltaGroup3PowerChainA2, // Group 3 ROW 5200 A Offset
     WgdsWiFiSarDeltaGroup3PowerChainB2, // Group 3 ROW 5200 B Offset
 }
})

When read the ACPI data to find out the WGDS, the DATA_SIZE is never
matched.
>From the above format, it gives 19 numbers, but our driver is hardcode
as 18.
Fix it to pass then can parse the data into our wgds table.
Then we will see:
iwlwifi 0000:01:00.0: U iwl_mvm_sar_geo_init Sending GEO_TX_POWER_LIMIT
iwlwifi 0000:01:00.0: U iwl_mvm_sar_geo_init SAR geographic profile[0]
Band[0]: chain A = 68 chain B = 69 max_tx_power = 54
iwlwifi 0000:01:00.0: U iwl_mvm_sar_geo_init SAR geographic profile[0]
Band[1]: chain A = 48 chain B = 49 max_tx_power = 70
iwlwifi 0000:01:00.0: U iwl_mvm_sar_geo_init SAR geographic profile[1]
Band[0]: chain A = 51 chain B = 67 max_tx_power = 50
iwlwifi 0000:01:00.0: U iwl_mvm_sar_geo_init SAR geographic profile[1]
Band[1]: chain A = 69 chain B = 70 max_tx_power = 68
iwlwifi 0000:01:00.0: U iwl_mvm_sar_geo_init SAR geographic profile[2]
Band[0]: chain A = 49 chain B = 50 max_tx_power = 48
iwlwifi 0000:01:00.0: U iwl_mvm_sar_geo_init SAR geographic profile[2]
Band[1]: chain A = 52 chain B = 53 max_tx_power = 51

Cc: stable@vger.kernel.org # 4.12+
Fixes: a6bff3cb19b7 ("iwlwifi: mvm: add GEO_TX_POWER_LIMIT cmd for geographic tx power table")
Signed-off-by: Matt Chen <matt.chen@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |    4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -6,6 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
+ * Copyright(c) 2018        Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,6 +30,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017        Intel Deutschland GmbH
+ * Copyright(c) 2018        Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -84,7 +86,7 @@
 #define ACPI_WRDS_WIFI_DATA_SIZE	(ACPI_SAR_TABLE_SIZE + 2)
 #define ACPI_EWRD_WIFI_DATA_SIZE	((ACPI_SAR_PROFILE_NUM - 1) * \
 					 ACPI_SAR_TABLE_SIZE + 3)
-#define ACPI_WGDS_WIFI_DATA_SIZE	18
+#define ACPI_WGDS_WIFI_DATA_SIZE	19
 #define ACPI_WRDD_WIFI_DATA_SIZE	2
 #define ACPI_SPLC_WIFI_DATA_SIZE	2
 
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -880,7 +880,7 @@ static int iwl_mvm_sar_geo_init(struct i
 	IWL_DEBUG_RADIO(mvm, "Sending GEO_TX_POWER_LIMIT\n");
 
 	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES * ACPI_WGDS_NUM_BANDS *
-		     ACPI_WGDS_TABLE_SIZE !=  ACPI_WGDS_WIFI_DATA_SIZE);
+		     ACPI_WGDS_TABLE_SIZE + 1 !=  ACPI_WGDS_WIFI_DATA_SIZE);
 
 	BUILD_BUG_ON(ACPI_NUM_GEO_PROFILES > IWL_NUM_GEO_PROFILES);
 


