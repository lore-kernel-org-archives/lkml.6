Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbeEaGOF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:14:05 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:41037 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbeEaGOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:14:04 -0400
X-QQ-mid: bizesmtp7t1527747236t0xkpqe6c
X-QQ-SSF: 01400000007000F0FG22000A0000000
X-QQ-FEAT: lRjdLcu6z5rErUlKClaR2EafU9lEjXbOfR71ch+TC66DrzrdrS7gcDT0x8gAa
        ryMh753UMZcAooUZefPi7ipBMKIrGgHDAJt+NM+KqZsJDvU2khoIZn+DSWwtgOOgRJxoe+U
        BVM9cc1Q26PzVvOcjDbfdJWSeFRQTjkTpQ95eRac0eObkazCp4EEjS/ERqwXsq+Cqy72U45
        NAT2i+oiOvBBbBqmkT2gbueVope6+ArwRYfvcRbrNgaalsf79lTu0CZz+Bllv2xVO6qIYt9
        vOiqntI0Lb4IOOW68BG1p2cnpfM5N8/+kTMA==
X-QQ-GoodBg: 2
From: Linkui <xiaolinkui@kylinos.cn>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH]  It assume 20xx not 19xx.
Date: Thu, 31 May 2018 14:13:51 +0800
Message-Id: <20180531061351.6981-1-xiaolinkui@kylinos.cn>
X-Mailer: git-send-email 2.17.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linkui Xiao <xiaolinkui@kylinos.cn>

If we settime between 1970 and 2000.
for example:
root# date 052915571978
root# hwclock -w

It will be wrong, this patch fix the bug.

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/rtc/rtc-ds1307.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index a13e59e..8c218a1 100644
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
2.7.4
