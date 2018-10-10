Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACD12075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="g6p1KaYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACD12075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJJLMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:12:38 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:61156 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJLMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:12:38 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w9A3pfev028281;
        Wed, 10 Oct 2018 12:51:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w9A3pfev028281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539143503;
        bh=9iNuA11QGszCWRWbyhbi0OF/6tEffh8se4mdynffqow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6p1KaYVxXckQGEgplO/kFg2N/X7zWX7SkGqApAg4LdXyA2Ju4CKisOq8lTE4fxac
         XcehBc/drEUzWIBYr+/HxP8Lo61yUF/iIsNzxeicr/kpVlBdnWn5kN53N5vvRX5KR8
         mKMJBHt+mdwRsVZ//UyfvpqtI5PSFfO7/4DtCFlfVtATkzYOBC+7f2wfc20kv7+ya9
         O6q+MmLYPltApdGN2H5nMwPxyhVfc8+/eyLlzbHqd+/1aNuuS3/XqrcuTjjOPQawks
         i2SY4oYMRgEUdtwefmq5bdcZZW8vSpyjMHGfDPpZkYl9fdI/0er0So/JNA3Q59SFPw
         dsdHCkjFCs0wQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag
Date:   Wed, 10 Oct 2018 12:51:32 +0900
Message-Id: <1539143492-32605-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TMIO_MMC_HAVE_HIGH_REG is confusing due to its counter-intuitive name.

All the TMIO MMC variants (TMIO MMC, Renesas SDHI, UniPhier SD) actually
have high registers. It is just that each of them implements its own
registers there. The original IP from Panasonic only defines registers
0x00-0xff in the bus_shift=1 review. The register area above them is
platform-dependent.

In fact, TMIO_MMC_HAVE_HIGH_REG is set only by tmio-mmc.c and used to
test the accessibility of CTL_SDIO_REGS. Because it is specific to
the TMIO MFD variant, the right thing to do is to move such registers
to tmio_mmc.c and delete the TMIO_MMC_HAVE_HIGH_REG flag.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/tmio_mmc.c | 7 +++++--
 drivers/mmc/host/tmio_mmc.h | 3 ---
 include/linux/mfd/tmio.h    | 7 -------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 00d291c..4e91020 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -24,6 +24,11 @@
 
 #include "tmio_mmc.h"
 
+/* Registers specific to this variant */
+#define CTL_SDIO_REGS		0x100
+#define CTL_CLK_AND_WAIT_CTL	0x138
+#define CTL_RESET_SDIO		0x1e0
+
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
@@ -161,8 +166,6 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 		goto cell_disable;
 	}
 
-	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
-
 	host = tmio_mmc_host_alloc(pdev, pdata);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index a1a661b..18b4308 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -47,9 +47,6 @@
 #define CTL_RESET_SD 0xe0
 #define CTL_VERSION 0xe2
 #define CTL_SDIF_MODE 0xe6
-#define CTL_SDIO_REGS 0x100
-#define CTL_CLK_AND_WAIT_CTL 0x138
-#define CTL_RESET_SDIO 0x1e0
 
 /* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take */
 #define TMIO_STOP_STP		BIT(0)
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 7786621..1e70060 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -62,13 +62,6 @@
 #define TMIO_MMC_USE_GPIO_CD		BIT(5)
 
 /*
- * Some controllers doesn't have over 0x100 register.
- * it is used to checking accessibility of
- * CTL_SD_CARD_CLK_CTL / CTL_CLK_AND_WAIT_CTL
- */
-#define TMIO_MMC_HAVE_HIGH_REG		BIT(6)
-
-/*
  * Some controllers have CMD12 automatically
  * issue/non-issue register
  */
-- 
2.7.4

