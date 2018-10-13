Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AD1C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA852087D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA852087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJMO5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:57:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39152 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbeJMO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:57:22 -0400
X-UUID: d7947cc62f9b4d58b981636c62b61373-20181013
X-UUID: d7947cc62f9b4d58b981636c62b61373-20181013
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 706254969; Sat, 13 Oct 2018 15:21:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 13 Oct 2018 15:21:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 13 Oct 2018 15:21:09 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <jjian.zhou@mediatek.com>, <wenbin.mei@mediatek.com>
Subject: [PATCH 2/6] mmc: mediatek: fill the actual clock for mmc debugfs
Date:   Sat, 13 Oct 2018 15:20:46 +0800
Message-ID: <1539415250-32337-3-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8893F9788E1E3399626D3C4D1EE7F7E72F4B24570230ECC84056BC13CC534B3C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as the mmc core layer has the mmc->actual_clock, so fill it
and drop msdc_host->sclk.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 1c1c967..ef45f1d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -391,7 +391,6 @@ struct msdc_host {
 	struct clk *src_clk_cg; /* msdc source clock control gate */
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
-	u32 sclk;		/* SD/MS bus clock frequency */
 	unsigned char timing;
 	bool vqmmc_enabled;
 	u32 latch_ck;
@@ -636,10 +635,10 @@ static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
 
 	host->timeout_ns = ns;
 	host->timeout_clks = clks;
-	if (host->sclk == 0) {
+	if (host->mmc->actual_clock == 0) {
 		timeout = 0;
 	} else {
-		clk_ns  = 1000000000UL / host->sclk;
+		clk_ns  = 1000000000UL / host->mmc->actual_clock;
 		timeout = (ns + clk_ns - 1) / clk_ns + clks;
 		/* in 1048576 sclk cycle unit */
 		timeout = (timeout + (0x1 << 20) - 1) >> 20;
@@ -686,6 +685,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	if (!hz) {
 		dev_dbg(host->dev, "set mclk to 0\n");
 		host->mclk = 0;
+		host->mmc->actual_clock = 0;
 		sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 		return;
 	}
@@ -764,7 +764,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
-	host->sclk = sclk;
+	host->mmc->actual_clock = sclk;
 	host->mclk = hz;
 	host->timing = timing;
 	/* need because clk changed. */
@@ -775,7 +775,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	 * mmc_select_hs400() will drop to 50Mhz and High speed mode,
 	 * tune result of hs200/200Mhz is not suitable for 50Mhz
 	 */
-	if (host->sclk <= 52000000) {
+	if (host->mmc->actual_clock <= 52000000) {
 		writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
 		writel(host->def_tune_para.pad_tune, host->base + tune_reg);
 	} else {
@@ -790,7 +790,8 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 		sdr_set_field(host->base + PAD_CMD_TUNE,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
-	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);
+	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->mmc->actual_clock,
+		timing);
 }
 
 static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
-- 
1.8.1.1.dirty

