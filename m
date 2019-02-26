Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62869C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F7721848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C60Ruy3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfBZPLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:11:03 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35374 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551193863; x=1582729863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mAEZEtGOxya2eLEALRNd0+4hU5AZnewn6Dh3ASD3l4I=;
  b=C60Ruy3BA6yHH+FmBofjsqa2CiGZYEgQH/kLqjyOkGAOrykiwJZ8Cj+b
   WeCDno1ZnzjYjarJYerWhg+GDLKem3FQ1PDGWgtJ6Vffpf7wBh/VQ5l6A
   cFt0Rude3q815+c1dfWUDlPZO556RPMZjqPzkfykWlTr8+81L7ys8Bk39
   TV9EdkyN3KLc1xliCQud/E88p9VJSyogYV5faH3E3vLMrFvFR27yYOSIf
   0KJUw2fNGR8qE3u3SjQt6u49R/Ih5bl+4B0++4KZauVd1nJRxk2UPaOae
   bbiEaKn+7pE68t9aWhtkytrOyGfECvvuMbE5d5Aju0XFM1P6fsn0LoWtI
   g==;
X-IronPort-AV: E=Sophos;i="5.58,416,1544457600"; 
   d="scan'208";a="107169819"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2019 23:11:03 +0800
IronPort-SDR: 5U/j8OaH9V1z/D6lAT/iR/x6N2LILMXwVhMo+KdeulruPBJ5kHvXEh8Y3AjdGpFou5+8+4DLEv
 LAMBZMDuTaqG18Od1iQzJztYcIX4oq/E2R38OrDlQloATmSZWoDrJ+XnTKQHmakrEdvmTTnn7C
 Pak3F4fWgihuSwrL+ugNO1pXTgLLvK7VJ5U9ZnWancEx+V88L/5+b5G/UmdWrWNDk+MgpHCfAo
 dgIdA7mJXdga3oWGOMzv0nXBbtDy3No1Vvol8Vh3JQMW1pfqjm6bhtDvufXrBhkEOS7ziZlwiT
 SjpQx1Q3fPR1dkMfxTzPdrPr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Feb 2019 06:49:14 -0800
IronPort-SDR: Jy9JbbhQjc8EKVTMIC3MAF0Ti8pMaYesMreBA8fYM+hMpbbTOpQTipKXuDHsmJPKmcDLBWZESc
 bUhRG7dFBLbpFdG6c8aVrZ4qZqCo0H5JRkMKhBAkFSwb386YP2MWU7GmB6y1/7SeTUtQnh6lWj
 MB64Nf1byIVIgALEIGujCHlCydaYBK3TeG0wBci1K/jpo9gbUk8qk2E/QHVFFI6Jex/RzJ1CDr
 ahnIxmgLSMa8mUmYfyIk6Pdib89n4K/eK5aLiwPptZkw7LnCAug6rPi+ct7KOqHPL9fUU51D/x
 5h8=
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2019 07:10:59 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 1/2] mmc: core: Add discard support to sd
Date:   Tue, 26 Feb 2019 17:10:24 +0200
Message-Id: <1551193825-31074-2-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
References: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD spec v5.1 adds discard support. The flows and commands are similar to
mmc, so just set the discard arg in CMD38.

A host which supports DISCARD shall check if the DISCARD_SUPPORT (b313)
is set in the SD_STATUS register.  If the card does not support discard,
the host shall not issue DISCARD command, but ERASE command instead.

Post the DISCARD operation, the card may de-allocate the discarded
blocks partially or completely. So the host mustn't make any assumptions
concerning the content of the discarded region. This is unlike ERASE
command, in which the region is guaranteed to contain either '0's or
'1's, depends on the content of DATA_STAT_AFTER_ERASE (b55) in the scr
register.

One more important difference compared to ERASE is the busy timeout
which we will address on the next patch.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c |  8 ++++----
 drivers/mmc/core/sd.c   | 10 +++++++++-
 include/linux/mmc/sd.h  |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0950edf..b7367ac 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1847,7 +1847,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  * @card: card to erase
  * @from: first sector to erase
  * @nr: number of sectors to erase
- * @arg: erase command argument (SD supports only %SD_ERASE_ARG)
+ * @arg: erase command argument
  *
  * Caller must claim host before calling this function.
  */
@@ -1864,14 +1864,14 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (!card->erase_size)
 		return -EOPNOTSUPP;
 
-	if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
+	if (mmc_card_sd(card) && arg != SD_ERASE_ARG && arg != SD_DISCARD_ARG)
 		return -EOPNOTSUPP;
 
-	if ((arg & MMC_SECURE_ARGS) &&
+	if (mmc_card_mmc(card) && (arg & MMC_SECURE_ARGS) &&
 	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN))
 		return -EOPNOTSUPP;
 
-	if ((arg & MMC_TRIM_ARGS) &&
+	if (mmc_card_mmc(card) && (arg & MMC_TRIM_ARGS) &&
 	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
 		return -EOPNOTSUPP;
 
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

