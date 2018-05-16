Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeEPIl0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:41:26 -0400
Received: from mx.socionext.com ([202.248.49.38]:8665 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752428AbeEPIlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:41:22 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Abylay Ospan <aospan@netup.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] media: helene: fix xtal frequency setting at power on
Date: Wed, 16 May 2018 17:41:20 +0900
Message-Id: <20180516084120.28674-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes crystal frequency setting when power on this device.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
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
