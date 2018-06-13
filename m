Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AACE3C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C8E208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C8E208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935370AbeFMKj0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:39:26 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47974 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935242AbeFMKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:38:04 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 179AB28585; Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <de5703e6c8e86ae86a9ac0d2a71f2103c4a1d30a.1528885172.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
Date:   Wed, 13 Jun 2018 06:38:01 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
device found in those models was never supported by this driver.
Attempting to load the driver usually causes a boot hang.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/mac/misc.c           | 6 ++----
 drivers/macintosh/via-pmu68k.c | 4 ----
 include/uapi/linux/pmu.h       | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

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
index 89cb1acea93a..e128f609281a 100644
--- a/include/uapi/linux/pmu.h
+++ b/include/uapi/linux/pmu.h
@@ -93,7 +93,7 @@ enum {
 	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
 	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
 	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
-	PMU_68K_V1,		/* 68K PMU, version 1 */
+	PMU_68K_V1,		/* Unused/deprecated */
 	PMU_68K_V2, 		/* 68K PMU, version 2 */
 };
 
-- 
2.16.4

