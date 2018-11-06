Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A02C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D576820866
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D576820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbeKFQHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:07:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56427 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387649AbeKFQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:06:13 -0500
X-UUID: cf2fd36573ad455298853a169057e97b-20181106
X-UUID: cf2fd36573ad455298853a169057e97b-20181106
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1874491118; Tue, 06 Nov 2018 14:42:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 6 Nov 2018 14:42:22 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 6 Nov 2018 14:42:22 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v1 02/11] clk: mediatek: add new member to mtk_pll_data
Date:   Tue, 6 Nov 2018 14:41:57 +0800
Message-ID: <20181106064206.17535-4-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181106064206.17535-1-weiyi.lu@mediatek.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Owen Chen <owen.chen@mediatek.com>

1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
   add a variable to indicate this change and
   backward-compatible.
2. fmin: The pll freqency lower-bound is vary from 1GMhz to
   1.5Ghz, add a variable to indicate platform-dependent.

Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 drivers/clk/mediatek/clk-pll.c | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f83c2bbb677e..1882221fe994 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -215,7 +215,9 @@ struct mtk_pll_data {
 	const struct clk_ops *ops;
 	u32 rst_bar_mask;
 	unsigned long fmax;
+	unsigned long fmin;
 	int pcwbits;
+	int pcwibits;
 	uint32_t pcw_reg;
 	int pcw_shift;
 	const struct mtk_pll_div_table *div_table;
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index f54e4015b0b1..0ec2c62d9383 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -69,11 +69,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
 {
 	int pcwbits = pll->data->pcwbits;
 	int pcwfbits;
+	int ibits;
 	u64 vco;
 	u8 c = 0;
 
 	/* The fractional part of the PLL divider. */
-	pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
+	ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
+	pcwfbits = pcwbits > ibits ? pcwbits - ibits : 0;
 
 	vco = (u64)fin * pcw;
 
@@ -138,9 +140,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 		u32 freq, u32 fin)
 {
-	unsigned long fmin = 1000 * MHZ;
+	unsigned long fmin = pll->data->fmin ? pll->data->fmin : 1000 * MHZ;
 	const struct mtk_pll_div_table *div_table = pll->data->div_table;
 	u64 _pcw;
+	int ibits;
 	u32 val;
 
 	if (freq > pll->data->fmax)
@@ -164,7 +167,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 	}
 
 	/* _pcw = freq * postdiv / fin * 2^pcwfbits */
-	_pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
+	ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
+	_pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
 	do_div(_pcw, fin);
 
 	*pcw = (u32)_pcw;
-- 
2.18.0

