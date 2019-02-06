Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEF7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3A820823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OS6/QBYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfBFL3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:29:16 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13346 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfBFL3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549452579; x=1580988579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hf68o2SPklx8/aoVG+2qAVZwgKI3ysife7gvRh1XeI0=;
  b=OS6/QBYmi4LZDydwiWTTL2cptPhQkFTGcJE0V9XOyOAVLoYsMS5UmK7l
   xVtiG59iigT4HscGMMOCctiTYarDAsr+glyBa0JjpGGSd3UTwGYgLGRLD
   UYgul4RNdJjdubO0bng7nK2yVEngH3Y7DlOx8fcgWnLNuvyzuZ9jErTWE
   JgTXgG4OCuW6Nf+a23B/loCQ7qBfGBfjIES8oFTHzxHXN8qy5okuiDPhQ
   pu0qx+ta3BtiIlhYyHRnOpqMOjYqWMIsIGT16J5pxu9uoQwJ3vDGRaue2
   z9rRjWpYDYnoJd56gR66YdhXYJqrkomwJ9uyNd/9xv8fXwgEMZKguTnzJ
   g==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="198777088"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2019 19:29:39 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Feb 2019 03:10:01 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2019 03:29:12 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 3/3] mmc: core: Add discard support to sd
Date:   Wed,  6 Feb 2019 13:28:07 +0200
Message-Id: <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
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
 drivers/mmc/core/sd.c   | 10 +++++++++-
 include/linux/mmc/sd.h  |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index de0f1a1..4d62f28 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2164,7 +2164,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  * @card: card to erase
  * @from: first sector to erase
  * @nr: number of sectors to erase
- * @arg: erase command argument (SD supports only %SD_ERASE_ARG)
+ * @arg: erase command argument
  *
  * Caller must claim host before calling this function.
  */
@@ -2181,6 +2181,9 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (!card->erase_size)
 		return -EOPNOTSUPP;
 
+	if (mmc_card_sd(card) && arg == SD_DISCARD_ARG)
+		goto skip_arg_testing;
+
 	if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
 		return -EOPNOTSUPP;
 
@@ -2200,6 +2203,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (arg == MMC_ERASE_ARG)
 		nr = mmc_align_erase_size(card, &from, &to, nr);
 
+skip_arg_testing:
 	if (nr == 0)
 		return 0;
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c2db94d..2b4fc22 100644
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
@@ -276,7 +278,13 @@ static int mmc_read_ssr(struct mmc_card *card)
 		}
 	}
 
-	card->erase_arg = SD_ERASE_ARG;
+	/*
+	 * starting SD5.1 discard is supported if DISCARD_SUPPORT (b313) is set
+	 */
+	resp[3] = card->raw_ssr[6];
+	discard_support = UNSTUFF_BITS(resp, 313 - 288, 1);
+	card->erase_arg = (card->scr.sda_specx && discard_support) ?
+			    SD_DISCARD_ARG : SD_ERASE_ARG;
 
 	return 0;
 }
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 1a6d10f..ec94a5a 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -95,5 +95,6 @@
  * Erase/discard
  */
 #define SD_ERASE_ARG			0x00000000
+#define SD_DISCARD_ARG			0x00000001
 
 #endif /* LINUX_MMC_SD_H */
-- 
1.9.1

