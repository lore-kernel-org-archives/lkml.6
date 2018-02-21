Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeBUU5Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:16 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46939 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeBUU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:14 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 012/100] rtc: coh901331: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:07 +0100
Message-Id: <20180221205635.31314-13-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtc_time_to_tm never generates an invalid tm. It is not necessary to
validate it. Also, the RTC core is always calling rtc_valid_tm after the
read_time callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-coh901331.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index cfc4141d99cd..2fc517498a5d 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -82,7 +82,7 @@ static int coh901331_read_time(struct device *dev, struct rtc_time *tm)
 	if (readl(rtap->virtbase + COH901331_VALID)) {
 		rtc_time_to_tm(readl(rtap->virtbase + COH901331_CUR_TIME), tm);
 		clk_disable(rtap->clk);
-		return rtc_valid_tm(tm);
+		return 0;
 	}
 	clk_disable(rtap->clk);
 	return -EINVAL;
-- 
2.16.1
