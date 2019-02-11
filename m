Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BDCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868922083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfBKW5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:57:30 -0500
Received: from muru.com ([72.249.23.125]:38134 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfBKW5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:57:30 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 919A580BF;
        Mon, 11 Feb 2019 22:57:39 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Florian Vaussard <florian.vaussard@epfl.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] mfd: twl6040: Fix device init errors for ACCCTL register
Date:   Mon, 11 Feb 2019 14:57:26 -0800
Message-Id: <20190211225726.38355-1-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that we can get a -EREMOTEIO errors on at least omap4 duovero:

twl6040 0-004b: Failed to write 2d = 19: -121

And then any following register access will produce errors.

There 2d offset above is register ACCCTL that gets written on twl6040
powerup. With error checking added to the related regcache_sync() call,
the -EREMOTEIO error is reproducable on twl6040 powerup at least
duovero.

To fix the error, we need to wait until twl6040 is accessible after the
powerup. Based on tests on omap4 duovero, we need to wait over 8ms after
powerup before register write will complete without failures. Let's also
make sure we warn about possible errors too.

Note that we have twl6040_patch[] reg_sequence with the ACCCTL register
configuration and regcache_sync() will write the new value to ACCCTL.

Cc: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/twl6040.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -322,8 +322,19 @@ int twl6040_power(struct twl6040 *twl6040, int on)
 			}
 		}
 
+		/*
+		 * Register access can produce errors after power-up unless we
+		 * wait at least 8ms based on measurements on duovero.
+		 */
+		usleep_range(10000, 12000);
+
 		/* Sync with the HW */
-		regcache_sync(twl6040->regmap);
+		ret = regcache_sync(twl6040->regmap);
+		if (ret) {
+			dev_err(twl6040->dev, "%s register write failed: %i\n",
+				__func__, ret);
+			goto out;
+		}
 
 		/* Default PLL configuration after power up */
 		twl6040->pll = TWL6040_SYSCLK_SEL_LPPLL;
-- 
2.20.1
