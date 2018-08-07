Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F80C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A90321A18
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Iyq18C3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A90321A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbeHGIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:31:14 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:39265 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbeHGIa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:30:58 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w776HYgj009463;
        Tue, 7 Aug 2018 15:17:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w776HYgj009463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533622661;
        bh=93n/hdv/fu8dAdRrLAHfmbU88lUWS0mHHs+i79buDAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iyq18C3o8zluJ9xaZYliAQo9dwvl8LJpz/YLeIT37PFoUCTXMDe0W2DkPz4HDqJ8f
         pljeYYEypCSbrTh+fV4TpiyVclrtUJfeubpumuGlS2nsAWSETJICW7BrAncHvtc+uV
         lmNC2zSUQoHUaC4ufAE3uhnudrzAHCg4oGwdmRL588mnPffC+50PXb1wgjtVorGR+F
         2B0LEvhgBPiXDHiqcYh6CGCSRfAQZCGXX8I6l+R68n4wNkZt4mYomb3hvolIgvWIoP
         TbiVpWul0QwLir9Dy7EjxJSDKYXlv1lFQ+9zkfS8e3ENcftVq4BctmiJegx85esiCm
         H8/kUdtW43ZIA==
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
Subject: [v0.1 PATCH 7/7] mmc: tmio: refactor CLK_CTL bit calculation
Date:   Tue,  7 Aug 2018 15:17:22 +0900
Message-Id: <1533622642-13989-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
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

