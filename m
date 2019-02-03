Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54541C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2092720855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oGf4Bz8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfBCIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:51:29 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10981 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfBCIv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549183888; x=1580719888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yUbASFQeD3pBbuYlzD8fvQKYvtLT2drGOgj67Fk70Ss=;
  b=oGf4Bz8ciekYF22Q4OO5G4/SgUlAIt1QWqOBjIWcoVKnqB5WN55nT8k/
   IIN8gYXoK10llYzhlm40QECS5clqgos07WqwztT0l4WxTwVEJLV2oo/rR
   ssSevWF3YZIeRoh8FfbMfAReX/809/iQ1ixtMlYy2CbvO9mhQvsl0JKvZ
   eG7cN9mcVlaSgS5VXqTY5PTn49FIcfp0LvQfUgVuTvmPQVw4swSxmxBHO
   72LUzBHMRtfr4Fxj5S8Op5xG1xoU1tIMU2cPyUa7Oseni1h/5xqWcE/jH
   TPB/aku8xXXauZLK3BXcTweQyFOeMMoV4n5T3BOGZQUH2LBB0gDGybGid
   A==;
X-IronPort-AV: E=Sophos;i="5.56,555,1539619200"; 
   d="scan'208";a="102183791"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2019 16:51:28 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 03 Feb 2019 00:30:19 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Feb 2019 00:51:25 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 3/3] mmc: core: Add discard support to sd
Date:   Sun,  3 Feb 2019 10:50:28 +0200
Message-Id: <1549183828-17316-4-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
References: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD spec v5.1 adds discard support. The flows and commands are similar to
mmc, so just set the discard arg in CMD38.

Actually, there is no need to check for the spec version like we are
doing, as it is assured that the reserved bits in earlier versions are
null. Do that anyway to document the spec version that introduce it.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c |  6 +++++-
 drivers/mmc/core/sd.c   | 10 ++++++++++
 include/linux/mmc/sd.h  |  6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5bd58b9..c495935 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2181,7 +2181,10 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (!card->erase_size)
 		return -EOPNOTSUPP;
 
-	if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
+	if (mmc_card_sd(card) && arg == SD_DISCARD_ARG)
+		goto skip_arg_testing;
+
+	if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
 		return -EOPNOTSUPP;
 
 	if ((arg & MMC_SECURE_ARGS) &&
@@ -2200,6 +2203,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (arg == MMC_ERASE_ARG)
 		nr = mmc_align_erase_size(card, &from, &to, nr);
 
+skip_arg_testing:
 	if (nr == 0)
 		return 0;
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 44f4cbc..b554a17 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -231,6 +231,8 @@ static int mmc_read_ssr(struct mmc_card *card)
 {
 	unsigned int au, es, et, eo;
 	__be32 *raw_ssr;
+	u32 resp[4] = {};
+	u8 discard_support;
 	int i;
 
 	if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
@@ -276,6 +278,14 @@ static int mmc_read_ssr(struct mmc_card *card)
 		}
 	}
 
+	/*
+	 * starting SD5.1 discard is supported if DISCARD_SUPPORT (b313) is set
+	 */
+	resp[3] = card->raw_ssr[6];
+	discard_support = UNSTUFF_BITS(resp, 313 - 288, 1);
+	card->discard_arg = (card->scr.sda_specx && discard_support) ?
+			    SD_DISCARD_ARG : SD_ERASE_ARG;
+
 	return 0;
 }
 
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 1ebcf9b..ec94a5a 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -91,4 +91,10 @@
 #define SD_SWITCH_ACCESS_DEF	0
 #define SD_SWITCH_ACCESS_HS	1
 
+/*
+ * Erase/discard
+ */
+#define SD_ERASE_ARG			0x00000000
+#define SD_DISCARD_ARG			0x00000001
+
 #endif /* LINUX_MMC_SD_H */
-- 
1.9.1

