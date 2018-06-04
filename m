Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeFDCzg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 22:55:36 -0400
Received: from SMTPBG19.QQ.COM ([183.60.61.236]:52091 "EHLO smtpbg320.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751445AbeFDCzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 22:55:35 -0400
X-QQ-mid: bizesmtp6t1528080477tjz15i597
X-QQ-SSF: 01400000000000F0FG22B00A0000000
X-QQ-FEAT: AU3gs7VM8fVpzxHGrWROQZXwfEBC7OywgxjJJ5n/y6BqHs/W83VjgURI7zYBZ
        mNATMzDdNoZbubyXaEmT9ep3PKcTYqd32gJ4tCwWlNJIu4+Cv5sOct6xLicmd/Yv/TQVdar
        p3YKBR7g5G3c75cXt1o4mp5herCXlK60BrKJsK+te5lDV3u1eS30zFmJXd0899t2043O4Vv
        BhZ43nKuikJrwfgbnTR9crfHKlNQxEVM/W506M9dz4KfuWh9P7zz8YBiqDys8dvRa1+5qx2
        j1nT2EuGsEve0cev04P/ZgPf8=
X-QQ-GoodBg: 2
From: Linkui <xiaolinkui@kylinos.cn>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc:ds1307:it assume 20xx not 19xx.
Date: Mon,  4 Jun 2018 10:47:42 +0800
Message-Id: <20180604024742.29240-1-xiaolinkui@kylinos.cn>
X-Mailer: git-send-email 2.17.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we settime between 1970 and 2000.
for example:
$ date 052915571978
$ hwclock -w

it will be wrong, this patch fix it.

Signed-off-by: Linkui <xiaolinkui@kylinos.cn>
---
 drivers/rtc/rtc-ds1307.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a13e59edff53..8c218a16569d 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -425,7 +425,9 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 	t->tm_mday = bcd2bin(regs[DS1307_REG_MDAY] & 0x3f);
 	tmp = regs[DS1307_REG_MONTH] & 0x1f;
 	t->tm_mon = bcd2bin(tmp) - 1;
-	t->tm_year = bcd2bin(regs[DS1307_REG_YEAR]) + 100;
+	t->tm_year = bcd2bin(regs[DS1307_REG_YEAR]);
+	if (t->tm_year >= 0 && t->tm_year <= 69)
+		t->tm_year += 100;
 
 	if (regs[chip->century_reg] & chip->century_bit &&
 	    IS_ENABLED(CONFIG_RTC_DRV_DS1307_CENTURY))
@@ -454,7 +456,7 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		t->tm_hour, t->tm_mday,
 		t->tm_mon, t->tm_year, t->tm_wday);
 
-	if (t->tm_year < 100)
+	if (t->tm_year < 0)
 		return -EINVAL;
 
 #ifdef CONFIG_RTC_DRV_DS1307_CENTURY
@@ -472,8 +474,9 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 	regs[DS1307_REG_MDAY] = bin2bcd(t->tm_mday);
 	regs[DS1307_REG_MONTH] = bin2bcd(t->tm_mon + 1);
 
-	/* assume 20YY not 19YY */
-	tmp = t->tm_year - 100;
+	tmp = t->tm_year;
+	if (tmp >= 100 && tmp <= 169)
+		tmp -= 100;
 	regs[DS1307_REG_YEAR] = bin2bcd(tmp);
 
 	if (chip->century_enable_bit)
-- 
2.17.0
