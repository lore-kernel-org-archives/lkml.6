Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B5AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D437420859
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D437420859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJMO5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:57:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37713 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbeJMO5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:57:30 -0400
X-UUID: 46b492c493cb4826890a91d30b36d529-20181013
X-UUID: 46b492c493cb4826890a91d30b36d529-20181013
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1167127119; Sat, 13 Oct 2018 15:21:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 13 Oct 2018 15:21:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 13 Oct 2018 15:21:19 +0800
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
Subject: [PATCH 6/6] mmc: mediatek: drop too much code of tuning method
Date:   Sat, 13 Oct 2018 15:20:50 +0800
Message-ID: <1539415250-32337-7-git-send-email-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the tuning code is becoming more and more bloated, let's make the
set cmd/data delay to inline function to avoid too much redundant code.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 133 +++++++++++++---------------------------------
 1 file changed, 38 insertions(+), 95 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5b26f2f..6334cc7 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1661,6 +1661,30 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
 	return delay_phase;
 }
 
+static inline void msdc_set_cmd_delay(struct msdc_host *host, u32 value)
+{
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
+
+	if (host->top_base)
+		sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
+			      value);
+	else
+		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+			      value);
+}
+
+static inline void msdc_set_data_delay(struct msdc_host *host, u32 value)
+{
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
+
+	if (host->top_base)
+		sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
+			      PAD_DAT_RD_RXDLY, value);
+	else
+		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_DATRRDLY,
+			      value);
+}
+
 static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
@@ -1681,12 +1705,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
-		if (host->top_base)
-			sdr_set_field(host->top_base + EMMC_TOP_CMD,
-				      PAD_CMD_RXDLY, i);
-		else
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_CMDRDLY, i);
+		msdc_set_cmd_delay(host, i);
 		/*
 		 * Using the same parameters, it may sometimes pass the test,
 		 * but sometimes it may fail. To make sure the parameters are
@@ -1710,12 +1729,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		if (host->top_base)
-			sdr_set_field(host->top_base + EMMC_TOP_CMD,
-				      PAD_CMD_RXDLY, i);
-		else
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_CMDRDLY, i);
+		msdc_set_cmd_delay(host, i);
 		/*
 		 * Using the same parameters, it may sometimes pass the test,
 		 * but sometimes it may fail. To make sure the parameters are
@@ -1739,25 +1753,13 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 		final_maxlen = final_fall_delay.maxlen;
 	if (final_maxlen == final_rise_delay.maxlen) {
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-		if (host->top_base)
-			sdr_set_field(host->base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
-				      final_rise_delay.final_phase);
-		else
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_CMDRDLY,
-				      final_rise_delay.final_phase);
 		final_delay = final_rise_delay.final_phase;
 	} else {
 		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
-		if (host->top_base)
-			sdr_set_field(host->base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
-				      final_fall_delay.final_phase);
-		else
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_CMDRDLY,
-				      final_fall_delay.final_phase);
 		final_delay = final_fall_delay.final_phase;
 	}
+	msdc_set_cmd_delay(host, final_delay);
+
 	if (host->dev_comp->async_fifo || host->hs200_cmd_int_delay)
 		goto skip_internal;
 
@@ -1832,7 +1834,6 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	u32 rise_delay = 0, fall_delay = 0;
 	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
 	u8 final_delay, final_maxlen;
-	u32 tune_reg = host->dev_comp->pad_tune_reg;
 	int i, ret;
 
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_INT_DAT_LATCH_CK_SEL,
@@ -1840,12 +1841,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
 	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
-		if (host->top_base)
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY, i);
-		else
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_DATRRDLY, i);
+		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
 			rise_delay |= (1 << i);
@@ -1859,12 +1855,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		if (host->top_base)
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY, i);
-		else
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_DATRRDLY, i);
+		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
 			fall_delay |= (1 << i);
@@ -1876,28 +1867,13 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	if (final_maxlen == final_rise_delay.maxlen) {
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
-		if (host->top_base)
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY,
-				      final_rise_delay.final_phase);
-		else
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_DATRRDLY,
-				      final_rise_delay.final_phase);
 		final_delay = final_rise_delay.final_phase;
 	} else {
 		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
-		if (host->top_base)
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY,
-				      final_fall_delay.final_phase);
-		else
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_DATRRDLY,
-				      final_fall_delay.final_phase);
 		final_delay = final_fall_delay.final_phase;
 	}
+	msdc_set_data_delay(host, final_delay);
 
 	dev_dbg(host->dev, "Final data pad delay: %x\n", final_delay);
 	return final_delay == 0xff ? -EIO : 0;
@@ -1913,7 +1889,6 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 	u32 rise_delay = 0, fall_delay = 0;
 	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
 	u8 final_delay, final_maxlen;
-	u32 tune_reg = host->dev_comp->pad_tune_reg;
 	int i, ret;
 
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_INT_DAT_LATCH_CK_SEL,
@@ -1923,17 +1898,8 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 	sdr_clr_bits(host->base + MSDC_IOCON,
 		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
 	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
-		if (host->top_base) {
-			sdr_set_field(host->top_base + EMMC_TOP_CMD,
-				      PAD_CMD_RXDLY, i);
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY, i);
-		} else {
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_CMDRDLY, i);
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_DATRRDLY, i);
-		}
+		msdc_set_cmd_delay(host, i);
+		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
 			rise_delay |= (1 << i);
@@ -1948,17 +1914,8 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 	sdr_set_bits(host->base + MSDC_IOCON,
 		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
 	for (i = 0; i < PAD_DELAY_MAX; i++) {
-		if (host->top_base) {
-			sdr_set_field(host->top_base + EMMC_TOP_CMD,
-				      PAD_CMD_RXDLY, i);
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY, i);
-		} else {
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_CMDRDLY, i);
-			sdr_set_field(host->base + tune_reg,
-				      MSDC_PAD_TUNE_DATRRDLY, i);
-		}
+		msdc_set_cmd_delay(host, i);
+		msdc_set_data_delay(host, i);
 		ret = mmc_send_tuning(mmc, opcode, NULL);
 		if (!ret)
 			fall_delay |= (1 << i);
@@ -1979,17 +1936,8 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 		final_delay = final_fall_delay.final_phase;
 	}
 
-	if (host->top_base) {
-		sdr_set_field(host->top_base + EMMC_TOP_CMD,
-			      PAD_CMD_RXDLY, final_delay);
-		sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-			      PAD_DAT_RD_RXDLY, final_delay);
-	} else {
-		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
-			      final_delay);
-		sdr_set_field(host->base + tune_reg,
-			      MSDC_PAD_TUNE_DATRRDLY, final_delay);
-	}
+	msdc_set_cmd_delay(host, final_delay);
+	msdc_set_data_delay(host, final_delay);
 
 	dev_dbg(host->dev, "Final pad delay: %x\n", final_delay);
 	return final_delay == 0xff ? -EIO : 0;
@@ -2006,12 +1954,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (host->hs400_mode) {
 			sdr_clr_bits(host->base + MSDC_IOCON,
 				     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
-			if (host->top_base)
-				sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-					      PAD_DAT_RD_RXDLY, 0);
-			else
-				sdr_set_field(host->base + tune_reg,
-					      MSDC_PAD_TUNE_DATRRDLY, 0);
+			msdc_set_data_delay(host, 0);
 		}
 		goto tune_done;
 	}
-- 
1.8.1.1.dirty

