Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73521C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7D520863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfBLP0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:26:02 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.251]:48568 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728273AbfBLP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:26:02 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 080FED7D7C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:26:01 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tZwegfSYh2PzOtZwegAGOt; Tue, 12 Feb 2019 09:26:01 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=47564 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtZwd-000Tii-Mq; Tue, 12 Feb 2019 09:25:59 -0600
Date:   Tue, 12 Feb 2019 09:25:58 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] mmc: sdhci-xenon: Mark expected switch fall-through
Message-ID: <20190212152558.GA21933@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gtZwd-000Tii-Mq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:47564
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/mmc/host/sdhci-xenon-phy.c: In function ‘xenon_emmc_phy_slow_mode’:
drivers/mmc/host/sdhci-xenon-phy.c:527:47: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if ((priv->init_card_type == MMC_TYPE_SDIO) ||
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
       params->slow_mode) {
       ~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-xenon-phy.c:534:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 5b5eb53a63d2..8d07ee1b8f08 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -530,7 +530,7 @@ static bool xenon_emmc_phy_slow_mode(struct sdhci_host *host,
 			ret = true;
 			break;
 		}
-		/* else: fall through */
+		/* fall through */
 	default:
 		reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
 		ret = false;
-- 
2.20.1

