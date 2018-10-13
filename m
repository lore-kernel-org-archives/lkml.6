Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3EBC71123
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2E220859
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2E220859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJMO52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:57:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41730 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726668AbeJMO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:57:27 -0400
X-UUID: f8b93d0ad1c0472887eae7b1c64f9aa6-20181013
X-UUID: f8b93d0ad1c0472887eae7b1c64f9aa6-20181013
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1330527948; Sat, 13 Oct 2018 15:21:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 13 Oct 2018 15:21:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 13 Oct 2018 15:21:14 +0800
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
Subject: [PATCH 4/6] mmc: mediatek: tune CMD/DATA together
Date:   Sat, 13 Oct 2018 15:20:48 +0800
Message-ID: <1539415250-32337-5-git-send-email-chaotian.jing@mediatek.com>
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

for MSDC IP which supports both data tune and async fifo, it can
tune cmd/data together. which can save the time and make the tune
result of CMD more stable as data line are 4bit or 8bit.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index fe80a1d..09d7e44 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1773,12 +1773,98 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	return final_delay == 0xff ? -EIO : 0;
 }
 
+/*
+ * MSDC IP which supports data tune + async fifo can do CMD/DAT tune
+ * together, which can save the tuning time.
+ */
+static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	u32 rise_delay = 0, fall_delay = 0;
+	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
+	u8 final_delay, final_maxlen;
+	u32 tune_reg = host->dev_comp->pad_tune_reg;
+	int i, ret;
+
+	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_INT_DAT_LATCH_CK_SEL,
+		      host->latch_ck);
+
+	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+	sdr_clr_bits(host->base + MSDC_IOCON,
+		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_CMDRDLY, i);
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_DATRRDLY, i);
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret)
+			rise_delay |= (1 << i);
+	}
+	final_rise_delay = get_best_delay(host, rise_delay);
+	/* if rising edge has enough margin, then do not scan falling edge */
+	if (final_rise_delay.maxlen >= 12 ||
+	    (final_rise_delay.start == 0 && final_rise_delay.maxlen >= 4))
+		goto skip_fall;
+
+	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+	sdr_set_bits(host->base + MSDC_IOCON,
+		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+	for (i = 0; i < PAD_DELAY_MAX; i++) {
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_CMDRDLY, i);
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_DATRRDLY, i);
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret)
+			fall_delay |= (1 << i);
+	}
+	final_fall_delay = get_best_delay(host, fall_delay);
+
+skip_fall:
+	final_maxlen = max(final_rise_delay.maxlen, final_fall_delay.maxlen);
+	if (final_maxlen == final_rise_delay.maxlen) {
+		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+		sdr_clr_bits(host->base + MSDC_IOCON,
+			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+			      final_rise_delay.final_phase);
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_DATRRDLY,
+			      final_rise_delay.final_phase);
+		final_delay = final_rise_delay.final_phase;
+	} else {
+		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
+		sdr_set_bits(host->base + MSDC_IOCON,
+			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
+			      final_fall_delay.final_phase);
+		sdr_set_field(host->base + tune_reg,
+			      MSDC_PAD_TUNE_DATRRDLY,
+			      final_fall_delay.final_phase);
+		final_delay = final_fall_delay.final_phase;
+	}
+
+	dev_dbg(host->dev, "Final pad delay: %x\n", final_delay);
+	return final_delay == 0xff ? -EIO : 0;
+}
+
 static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
+	if (host->dev_comp->data_tune && host->dev_comp->async_fifo) {
+		ret = msdc_tune_together(mmc, opcode);
+		if (host->hs400_mode) {
+			sdr_clr_bits(host->base + MSDC_IOCON,
+				     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
+			sdr_set_field(host->base + tune_reg,
+				      MSDC_PAD_TUNE_DATRRDLY, 0);
+		}
+		goto tune_done;
+	}
 	if (host->hs400_mode &&
 	    host->dev_comp->hs400_tune)
 		ret = hs400_tune_response(mmc, opcode);
@@ -1794,6 +1880,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 			dev_err(host->dev, "Tune data fail!\n");
 	}
 
+tune_done:
 	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
 	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
 	host->saved_tune_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
-- 
1.8.1.1.dirty

