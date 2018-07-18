Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA80020693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA80020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbeGRBnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:43:11 -0400
Received: from mx.socionext.com ([202.248.49.38]:16378 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731151AbeGRBnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:43:11 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Jul 2018 10:07:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 39DAF60034;
        Wed, 18 Jul 2018 10:07:55 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 18 Jul 2018 10:07:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 9D3A04039E;
        Wed, 18 Jul 2018 10:07:54 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 6D653120424;
        Wed, 18 Jul 2018 10:07:54 +0900 (JST)
From:   Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [RESEND PATCH] media: helene: fix xtal frequency setting at power on
Date:   Wed, 18 Jul 2018 10:07:53 +0900
Message-Id: <20180718010753.18717-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes crystal frequency setting when power on this device.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Abylay Ospan <aospan@netup.ru>

---

Changes from before:
  - Add Abylay's Ack

---
 drivers/media/dvb-frontends/helene.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-frontends/helene.c
index 0a4f312c4368..8fcf7a00782a 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -924,7 +924,10 @@ static int helene_x_pon(struct helene_priv *priv)
 	helene_write_regs(priv, 0x99, cdata, sizeof(cdata));
 
 	/* 0x81 - 0x94 */
-	data[0] = 0x18; /* xtal 24 MHz */
+	if (priv->xtal == SONY_HELENE_XTAL_16000)
+		data[0] = 0x10; /* xtal 16 MHz */
+	else
+		data[0] = 0x18; /* xtal 24 MHz */
 	data[1] = (uint8_t)(0x80 | (0x04 & 0x1F)); /* 4 x 25 = 100uA */
 	data[2] = (uint8_t)(0x80 | (0x26 & 0x7F)); /* 38 x 0.25 = 9.5pF */
 	data[3] = 0x80; /* REFOUT signal output 500mVpp */
-- 
2.17.0

