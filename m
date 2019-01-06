Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CF6C43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3995218DE
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfAFIVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:21:04 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44860 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfAFIVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:21:04 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CF3AE211B4;
        Sun,  6 Jan 2019 08:21:03 +0000 (UTC)
Date:   Sun, 6 Jan 2019 08:21:03 +0000
From:   Eric Wong <e@80x24.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Sylvain Chouleur <sylvain.chouleur@intel.com>,
        Patrick McDermott <patrick.mcdermott@libiquity.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: cmos: ignore bogus century byte
Message-ID: <20190106082103.evfgarznrskd4oxh@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older versions of Libreboot and Coreboot had an invalid value
(`3' in my case) in the century byte affecting the GM45 in
the Thinkpad X200.  Not everybody's updated their firmwares,
and Linux <= 4.2 was able to read the RTC without problems,
so workaround this by ignoring invalid values.

Fixes: 3c217e51d8a272b9 ("rtc: cmos: century support")

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Sylvain Chouleur <sylvain.chouleur@intel.com>
Cc: Patrick McDermott <patrick.mcdermott@libiquity.com>
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Eric Wong <e@80x24.org>
---
 drivers/rtc/rtc-mc146818-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 2f1772a358ca..18a6f15e313d 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -82,7 +82,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 	time->tm_year += real_year - 72;
 #endif
 
-	if (century)
+	if (century > 20)
 		time->tm_year += (century - 19) * 100;
 
 	/*
-- 
EW
