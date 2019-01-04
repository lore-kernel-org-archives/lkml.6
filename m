Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2FCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAAC21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfADTa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:30:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:16842 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfADTaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:30:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 11:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="135404215"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2019 11:30:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD91917F; Fri,  4 Jan 2019 21:30:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 1/4] lib/vsprintf: Print time64_t in human readable format
Date:   Fri,  4 Jan 2019 21:30:06 +0200
Message-Id: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are users which print time and date represented by content of
time64_t type in human readable format.

Instead of open coding that each time introduce %ptT[dt][r] specifier.

Few test cases for %ptT specifier has been added as well.

Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst | 22 +++++++------
 lib/test_printf.c                         | 11 +++++--
 lib/vsprintf.c                            | 39 ++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index a7fae4538946..e33c130db76a 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -412,21 +412,23 @@ Examples::
 
 Passed by reference.
 
-Time and date (struct rtc_time)
--------------------------------
+Time and date
+-------------
 
 ::
 
-	%ptR		YYYY-mm-ddTHH:MM:SS
-	%ptRd		YYYY-mm-dd
-	%ptRt		HH:MM:SS
-	%ptR[dt][r]
+	%pt[RT]			YYYY-mm-ddTHH:MM:SS
+	%pt[RT]d		YYYY-mm-dd
+	%pt[RT]t		HH:MM:SS
+	%pt[RT][dt][r]
 
-For printing date and time as represented by struct rtc_time structure in
-human readable format.
+For printing date and time as represented by
+	R  struct rtc_time structure
+	T  time64_t type
+in human readable format.
 
-By default year will be incremented by 1900 and month by 1. Use %ptRr (raw)
-to suppress this behaviour.
+By default year will be incremented by 1900 and month by 1.
+Use %pt[RT]r (raw) to suppress this behaviour.
 
 Passed by reference.
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 659b6cc0d483..a0295fbd874f 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -450,7 +450,7 @@ struct_va_format(void)
 }
 
 static void __init
-struct_rtc_time(void)
+time_and_date(void)
 {
 	/* 1543210543 */
 	const struct rtc_time tm = {
@@ -461,6 +461,8 @@ struct_rtc_time(void)
 		.tm_mon = 10,
 		.tm_year = 118,
 	};
+	/* 2019-01-04T15:32:23 */
+	time64_t t = 1546615943;
 
 	test_hashed("%pt", &tm);
 
@@ -470,6 +472,11 @@ struct_rtc_time(void)
 	test("05:35:43|0118-10-26", "%ptRtr|%ptRdr", &tm, &tm);
 	test("05:35:43|2018-11-26", "%ptRttr|%ptRdtr", &tm, &tm);
 	test("05:35:43 tr|2018-11-26 tr", "%ptRt tr|%ptRd tr", &tm, &tm);
+
+	test("2019-01-04T15:32:23", "%ptT", &t);
+	test("0119-00-04T15:32:23", "%ptTr", &t);
+	test("15:32:23|2019-01-04", "%ptTt|%ptTd", &t, &t);
+	test("15:32:23|0119-00-04", "%ptTtr|%ptTdr", &t, &t);
 }
 
 static void __init
@@ -583,7 +590,7 @@ test_pointer(void)
 	uuid();
 	dentry();
 	struct_va_format();
-	struct_rtc_time();
+	time_and_date();
 	struct_clk();
 	bitmap();
 	netdev_features();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3add92329bae..0457af8b10a9 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -31,6 +31,7 @@
 #include <linux/dcache.h>
 #include <linux/cred.h>
 #include <linux/rtc.h>
+#include <linux/time.h>
 #include <linux/uuid.h>
 #include <linux/of.h>
 #include <net/addrconf.h>
@@ -1633,6 +1634,39 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
 	return buf;
 }
 
+static noinline_for_stack
+void time64_to_rtc_time(time64_t time, struct rtc_time *rtc_time)
+{
+#ifdef CONFIG_RTC_LIB
+	rtc_time64_to_tm(time, rtc_time);
+#else
+	struct tm tm;
+
+	time64_to_tm(time, 0, &tm);
+
+	rtc_time->tm_sec = tm.tm_sec;
+	rtc_time->tm_min = tm.tm_min;
+	rtc_time->tm_hour = tm.tm_hour;
+	rtc_time->tm_mday = tm.tm_mday;
+	rtc_time->tm_mon = tm.tm_mon;
+	rtc_time->tm_year = tm.tm_year;
+	rtc_time->tm_wday = tm.tm_wday;
+	rtc_time->tm_yday = tm.tm_yday;
+
+	rtc_time->tm_isdst = 0;
+#endif
+}
+
+static noinline_for_stack
+char *time64_str(char *buf, char *end, const time64_t *t, const char *fmt)
+{
+	struct rtc_time tm;
+
+	time64_to_rtc_time(*t, &tm);
+
+	return rtc_str(buf, end, &tm, fmt);
+}
+
 static noinline_for_stack
 char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 		    const char *fmt)
@@ -1640,6 +1674,8 @@ char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 	switch (fmt[1]) {
 	case 'R':
 		return rtc_str(buf, end, (const struct rtc_time *)ptr, fmt);
+	case 'T':
+		return time64_str(buf, end, (const time64_t *)ptr, fmt);
 	default:
 		return ptr_to_id(buf, end, ptr, spec);
 	}
@@ -1924,8 +1960,9 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)
- * - 't[R][dt][r]' For time and date as represented:
+ * - 't[RT][dt][r]' For time and date as represented by:
  *      R    struct rtc_time
+ *      T    time64_t
  * - 'C' For a clock, it prints the name (Common Clock Framework) or address
  *       (legacy clock framework) of the clock
  * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
-- 
2.19.2

