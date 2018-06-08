Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GlOxKfhUGlvtLAAAmS7hNA
	; Fri, 08 Jun 2018 10:05:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 52370601C3; Fri,  8 Jun 2018 10:05:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D6DE7605A5;
	Fri,  8 Jun 2018 10:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6DE7605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHKFy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:05:54 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:46268 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbeFHKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:05:52 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id wA5q1x00J3XaVaC01A5qux; Fri, 08 Jun 2018 12:05:51 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fREHG-0003RK-3k; Fri, 08 Jun 2018 12:05:50 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fREHG-0006Fb-5N; Fri, 08 Jun 2018 12:05:50 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] pinctrl: actions: Fix uninitialized error in owl_pin_config_set()
Date: Fri,  8 Jun 2018 12:05:47 +0200
Message-Id: <1528452347-23986-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.2:

    drivers/pinctrl/actions/pinctrl-owl.c: In function ‘owl_pin_config_set’:
    drivers/pinctrl/actions/pinctrl-owl.c:336: warning: ‘ret’ may be used uninitialized in this function

Indeed, if num_configs is zero, the uninitialized value will be returned
as an error code.

Fix this by preinitializing it to zero.

Fixes: 2242ddfbf4d699b5 ("pinctrl: actions: Add Actions S900 pinctrl driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/pinctrl/actions/pinctrl-owl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 76243caa08c630c0..b5c880b50bb371f5 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -333,7 +333,7 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
 	unsigned long flags;
 	unsigned int param;
 	u32 reg, bit, width, arg;
-	int ret, i;
+	int ret = 0, i;
 
 	info = &pctrl->soc->padinfo[pin];
 
-- 
2.7.4
