Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F6C04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212BD2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q73C1ZRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212BD2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeHWINc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:13:32 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47906 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeHWINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:13:32 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7N4ilM6021677;
        Thu, 23 Aug 2018 13:44:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7N4ilM6021677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534999493;
        bh=UU49DOX5Plapppxt4m+9dukAaHdhDZcQWKgbWh+VqwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q73C1ZRYqewG411KLr6dOPoanNvFoSRQ6HZHtYFKFKLvoIgoYFzrdH+sXE1tbwreQ
         N4X/5JgRhVkX7hgZrd/kD5DrjDSxY47ns3ycXj4CgDPC+VT6UmRKtMNzkBK/8dfMcb
         Jn0U5NNjT3zlBBF/qE/GjNuoJQ7O23MgZlj3UFJ+iLuIG2ZvPfzDEBzLQoYju9XdZC
         ZWiG9+HLI/KugbD7NtRHL7H6kvBpbSQBXnuh/l/ptjKrOUDYxczW0Wy02iFCYC25wZ
         6acPjvxMME3dr7jG/GusWAqcBXYBsLCNqHgIU16P+33nIVAZN6E6xzhfbJkaP38baH
         Aa70O9SgHWVow==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] mmc: tmio: refactor CLK_CTL bit calculation
Date:   Thu, 23 Aug 2018 13:44:20 +0900
Message-Id: <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
          clock <<= 1;

... is too tricky, hence I replaced with

  roundup_pow_of_two(divisor) >> 2

'(clk >> 22) & 0x1' is the bit test for the 1/1 divisor, but
it is not clear.  'divisor <= 1' is easier to understand.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/tmio_mmc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index b031a77..e04c322 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -48,19 +48,27 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 			       unsigned int new_clock)
 {
-	u32 clk = 0, clock;
+	unsigned int clock, divisor;
+	u32 clk = 0;
+	int clk_sel;
 
 	if (new_clock == 0) {
 		tmio_mmc_clk_stop(host);
 		return;
 	}
 
-	clock = host->mmc->f_min;
+	divisor = host->pdata->hclk / new_clock;
 
-	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
-		clock <<= 1;
+	if (divisor <= 1) {
+		clk_sel = 1;
+		clk = 0;
+	} else {
+		clk_sel = 0;
+		/* bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/2 */
+		clk = roundup_pow_of_two(divisor) >> 2;
+	}
 
-	host->pdata->set_clk_div(host->pdev, (clk >> 22) & 1);
+	host->pdata->set_clk_div(host->pdev, clk_sel);
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-- 
2.7.4

