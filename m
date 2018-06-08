Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eNVdDmjpGVtnFAAAmS7hNA
	; Fri, 08 Jun 2018 02:26:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2497A608BA; Fri,  8 Jun 2018 02:26:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9432260290;
	Fri,  8 Jun 2018 02:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9432260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeFHC0I (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 22:26:08 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58562 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbeFHCYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:24:30 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 4B4CE2A337; Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528423341.git.fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
Date: Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
device found in those models was never supported by this driver.
Attempting to load the driver usually causes a boot hang.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/misc.c           | 6 ++----
 drivers/macintosh/via-pmu68k.c | 4 ----
 include/uapi/linux/pmu.h       | 1 -
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index c68054361615..7ccb799eeb57 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -478,8 +478,7 @@ void mac_poweroff(void)
 		cuda_shutdown();
 #endif
 #ifdef CONFIG_ADB_PMU68K
-	} else if (macintosh_config->adb_type == MAC_ADB_PB1
-		|| macintosh_config->adb_type == MAC_ADB_PB2) {
+	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_shutdown();
 #endif
 	}
@@ -520,8 +519,7 @@ void mac_reset(void)
 		cuda_restart();
 #endif
 #ifdef CONFIG_ADB_PMU68K
-	} else if (macintosh_config->adb_type == MAC_ADB_PB1
-		|| macintosh_config->adb_type == MAC_ADB_PB2) {
+	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
 #endif
 	} else if (CPU_IS_030) {
diff --git a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
index d545ed45e482..bec8e1837d7d 100644
--- a/drivers/macintosh/via-pmu68k.c
+++ b/drivers/macintosh/via-pmu68k.c
@@ -175,9 +175,6 @@ static s8 pmu_data_len[256][2] = {
 int __init find_via_pmu(void)
 {
 	switch (macintosh_config->adb_type) {
-	case MAC_ADB_PB1:
-		pmu_kind = PMU_68K_V1;
-		break;
 	case MAC_ADB_PB2:
 		pmu_kind = PMU_68K_V2;
 		break;
@@ -785,7 +782,6 @@ pmu_enable_backlight(int on)
 	    /* first call: get current backlight value */
 	    if (backlight_level < 0) {
 		switch(pmu_kind) {
-		    case PMU_68K_V1:
 		    case PMU_68K_V2:
 			pmu_request(&req, NULL, 3, PMU_READ_NVRAM, 0x14, 0xe);
 			while (!req.complete)
diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
index 89cb1acea93a..30f64d46f5db 100644
--- a/include/uapi/linux/pmu.h
+++ b/include/uapi/linux/pmu.h
@@ -93,7 +93,6 @@ enum {
 	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
 	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
 	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
-	PMU_68K_V1,		/* 68K PMU, version 1 */
 	PMU_68K_V2, 		/* 68K PMU, version 2 */
 };
 
-- 
2.16.4
