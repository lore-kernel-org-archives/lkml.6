Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0O9rCak+GVtNSwAAmS7hNA
	; Thu, 07 Jun 2018 14:19:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 892A3608BA; Thu,  7 Jun 2018 14:19:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F0214602FC;
	Thu,  7 Jun 2018 14:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0214602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933318AbeFGOSt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:18:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39531 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933094AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0005Zl-Cw; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00038Y-Sl; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        kernel-janitors@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Colin Ian King" <colin.king@canonical.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.268215907@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 286/410] clocksource/drivers/fsl_ftm_timer: Fix error
 return checking
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

From: Colin Ian King <colin.king@canonical.com>

commit f287eb9013ccf199cbfa4eabd80c36fedfc15a73 upstream.

The error checks on freq for a negative error return always fails because
freq is unsigned and can never be negative. Fix this by making freq a
signed long.

Detected with Coccinelle:
drivers/clocksource/fsl_ftm_timer.c:287:5-9: WARNING: Unsigned expression
compared with zero: freq <= 0
drivers/clocksource/fsl_ftm_timer.c:291:5-9: WARNING: Unsigned expression
compared with zero: freq <= 0

Fixes: 2529c3a33079 ("clocksource: Add Freescale FlexTimer Module (FTM) timer support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20180226113614.3092-1-colin.king@canonical.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/clocksource/fsl_ftm_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clocksource/fsl_ftm_timer.c
+++ b/drivers/clocksource/fsl_ftm_timer.c
@@ -282,7 +282,7 @@ static int __init __ftm_clk_init(struct
 
 static unsigned long __init ftm_clk_init(struct device_node *np)
 {
-	unsigned long freq;
+	long freq;
 
 	freq = __ftm_clk_init(np, "ftm-evt-counter-en", "ftm-evt");
 	if (freq <= 0)
