Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id g68TOQVMGVuIXwAAmS7hNA
	; Thu, 07 Jun 2018 15:15:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D46E56074D; Thu,  7 Jun 2018 15:15:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 67FA160290;
	Thu,  7 Jun 2018 15:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67FA160290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935950AbeFGPP0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:15:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41407 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964826AbeFGPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:46 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbu-0005Zn-HT; Thu, 07 Jun 2018 15:09:54 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb0-0002lq-2N; Thu, 07 Jun 2018 15:08:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Sebastian Reichel" <sebastian.reichel@collabora.co.uk>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.843631960@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 071/410] power: supply: ab8500_charger: Fix an error
 handling path
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit bf59fddde1c3eab89eb8dca8f3d3dc097887d2bb upstream.

'ret' is know to be 0 at this point, because it has not been updated by the
the previous call to 'abx500_mask_and_set_register_interruptible()'.

Fix it by updating 'ret' before checking if an error occurred.

Fixes: 84edbeeab67c ("ab8500-charger: AB8500 charger driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/power/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -3224,7 +3224,7 @@ static int ab8500_charger_init_hw_regist
 	}
 
 	/* Enable backup battery charging */
-	abx500_mask_and_set_register_interruptible(di->dev,
+	ret = abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_RTC, AB8500_RTC_CTRL_REG,
 		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
 	if (ret < 0)
