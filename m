Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F323C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441F822419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441F822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeKNDQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:16:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:53821 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbeKNDQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:16:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="88989652"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2018 09:17:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CEAB93AD; Tue, 13 Nov 2018 19:17:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 02/20] rtc: Switch to use %ptR
Date:   Tue, 13 Nov 2018 19:17:11 +0200
Message-Id: <20181113171729.19645-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
References: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/rtc.c      |  7 +++----
 drivers/rtc/hctosys.c   |  8 ++------
 drivers/rtc/interface.c |  8 ++------
 drivers/rtc/rtc-proc.c  | 36 +++++-------------------------------
 drivers/rtc/rtc-sysfs.c | 16 ++++++----------
 5 files changed, 18 insertions(+), 57 deletions(-)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index 4948c8bda6b1..0cde96822a87 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -1125,11 +1125,10 @@ static int rtc_proc_show(struct seq_file *seq, void *v)
 	 * time or for Universal Standard Time (GMT). Probably local though.
 	 */
 	seq_printf(seq,
-		   "rtc_time\t: %02d:%02d:%02d\n"
-		   "rtc_date\t: %04d-%02d-%02d\n"
+		   "rtc_time\t: %ptRt\n"
+		   "rtc_date\t: %ptRd\n"
 		   "rtc_epoch\t: %04lu\n",
-		   tm.tm_hour, tm.tm_min, tm.tm_sec,
-		   tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, epoch);
+		   &tm, &tm, epoch);
 
 	get_rtc_alm_time(&tm);
 
diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
index b9ec4a16db1f..ff2092a0d38c 100644
--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -58,12 +58,8 @@ static int __init rtc_hctosys(void)
 
 	err = do_settimeofday64(&tv64);
 
-	dev_info(rtc->dev.parent,
-		"setting system clock to "
-		"%d-%02d-%02d %02d:%02d:%02d UTC (%lld)\n",
-		tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-		tm.tm_hour, tm.tm_min, tm.tm_sec,
-		(long long) tv64.tv_sec);
+	dev_info(rtc->dev.parent, "setting system clock to %ptR UTC (%lld)\n",
+		 &tm, (long long)tv64.tv_sec);
 
 err_read:
 	rtc_class_close(rtc);
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 612a83d3ddcc..e8d77b1eaeb2 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -368,12 +368,8 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	err = rtc_valid_tm(&alarm->time);
 
 done:
-	if (err) {
-		dev_warn(&rtc->dev, "invalid alarm value: %d-%d-%d %d:%d:%d\n",
-			alarm->time.tm_year + 1900, alarm->time.tm_mon + 1,
-			alarm->time.tm_mday, alarm->time.tm_hour, alarm->time.tm_min,
-			alarm->time.tm_sec);
-	}
+	if (err)
+		dev_warn(&rtc->dev, "invalid alarm value: %ptR\n", &alarm->time);
 
 	return err;
 }
diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index a9dd9218fae2..98091ecb84ff 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -50,41 +50,15 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 	err = rtc_read_time(rtc, &tm);
 	if (err == 0) {
 		seq_printf(seq,
-			"rtc_time\t: %02d:%02d:%02d\n"
-			"rtc_date\t: %04d-%02d-%02d\n",
-			tm.tm_hour, tm.tm_min, tm.tm_sec,
-			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
+				"rtc_time\t: %ptRt\n"
+				"rtc_date\t: %ptRd\n",
+				&tm, &tm);
 	}
 
 	err = rtc_read_alarm(rtc, &alrm);
 	if (err == 0) {
-		seq_printf(seq, "alrm_time\t: ");
-		if ((unsigned int)alrm.time.tm_hour <= 24)
-			seq_printf(seq, "%02d:", alrm.time.tm_hour);
-		else
-			seq_printf(seq, "**:");
-		if ((unsigned int)alrm.time.tm_min <= 59)
-			seq_printf(seq, "%02d:", alrm.time.tm_min);
-		else
-			seq_printf(seq, "**:");
-		if ((unsigned int)alrm.time.tm_sec <= 59)
-			seq_printf(seq, "%02d\n", alrm.time.tm_sec);
-		else
-			seq_printf(seq, "**\n");
-
-		seq_printf(seq, "alrm_date\t: ");
-		if ((unsigned int)alrm.time.tm_year <= 200)
-			seq_printf(seq, "%04d-", alrm.time.tm_year + 1900);
-		else
-			seq_printf(seq, "****-");
-		if ((unsigned int)alrm.time.tm_mon <= 11)
-			seq_printf(seq, "%02d-", alrm.time.tm_mon + 1);
-		else
-			seq_printf(seq, "**-");
-		if (alrm.time.tm_mday && (unsigned int)alrm.time.tm_mday <= 31)
-			seq_printf(seq, "%02d\n", alrm.time.tm_mday);
-		else
-			seq_printf(seq, "**\n");
+		seq_printf(seq, "alrm_time\t: %ptRtv\n", &alrm.time);
+		seq_printf(seq, "alrm_date\t: %ptRdv\n", &alrm.time);
 		seq_printf(seq, "alarm_IRQ\t: %s\n",
 				alrm.enabled ? "yes" : "no");
 		seq_printf(seq, "alrm_pending\t: %s\n",
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 9746c32eee2e..a8f22ee726bb 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -39,12 +39,10 @@ date_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct rtc_time tm;
 
 	retval = rtc_read_time(to_rtc_device(dev), &tm);
-	if (retval == 0) {
-		retval = sprintf(buf, "%04d-%02d-%02d\n",
-			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
-	}
+	if (retval)
+		return retval;
 
-	return retval;
+	return sprintf(buf, "%ptRd\n", &tm);
 }
 static DEVICE_ATTR_RO(date);
 
@@ -55,12 +53,10 @@ time_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct rtc_time tm;
 
 	retval = rtc_read_time(to_rtc_device(dev), &tm);
-	if (retval == 0) {
-		retval = sprintf(buf, "%02d:%02d:%02d\n",
-			tm.tm_hour, tm.tm_min, tm.tm_sec);
-	}
+	if (retval)
+		return retval;
 
-	return retval;
+	return sprintf(buf, "%ptRt\n", &tm);
 }
 static DEVICE_ATTR_RO(time);
 
-- 
2.19.1

