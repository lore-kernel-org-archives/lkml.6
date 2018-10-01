Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D901208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Lad5CemX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D901208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeJATJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:09:31 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:19147 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJATJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:09:29 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w91CVGkA019301;
        Mon, 1 Oct 2018 21:31:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w91CVGkA019301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538397079;
        bh=PEzsMrwJXw0LoSxVFtwvUIo6tex365qXteYhXs9PfIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lad5CemXH1TEKWVzTN3q9QYbYm53l3Vm3ZFvZye54fdMX2IOAOWcEB9fTB78/Ixfd
         h0EenAumHtagTjLB+uWRIPL8ZQ5Ilig653TE78yKF3qKRoDXLTrZ081t8HX+rPQizo
         /3rgn8ggoMX5RolQtQ3JOqoWVgmvMCS3pVb674wsaFzn80fjlnxZOqGKTHeM8UrAuL
         MyNnpcOBg9e0ZZzZ9vTldsQdB38bK7Z2CA2C4cz1QtyZ3SjCwoQBmqZ2v/wxmJ6QuG
         qumaiX6nAoxsL7Fo9UE9KFsLfW/aTJMF1efsC4QrGfcPinuYQlXMMqCv76gTk3HpFy
         1RrEs31REDJTQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag
Date:   Mon,  1 Oct 2018 21:31:02 +0900
Message-Id: <1538397062-19162-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TMIO_MMC_HAVE_HIGH_REG is confusing due to its counter-intuitive name.

All the TMIO MMC variants (TMIO MMC, Renesas SDHI, UniPhier SD) actually
have high registers.  It is just that each of them implements its own
registers there.  The original IP from Panasonic only defines registers
0x00-0xff in the bus_shift=1 review.  The register area above them is
platform-dependent.

In fact, TMIO_MMC_HAVE_HIGH_REG is set only by tmio-mmc.c and used to
test the accessibility of CTL_SDIO_REGS.  Because it is specific to
the TMIO MFD variant, the right thing to do is to move such registers
to tmio_mmc.c and delete the TMIO_MMC_HAVE_HIGH_REG flag.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc.c | 7 +++++--
 drivers/mmc/host/tmio_mmc.h | 3 ---
 include/linux/mfd/tmio.h    | 7 -------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index c8e90cf..9348608 100644
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
@@ -153,8 +158,6 @@ static int tmio_mmc_probe(struct platform_device *pdev)
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

