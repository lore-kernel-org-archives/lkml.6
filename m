Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46479C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E852081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E852081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeLDVXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:23:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:26808 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbeLDVXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:23:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="299319448"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 04 Dec 2018 13:23:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D85E1AC; Tue,  4 Dec 2018 23:23:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v6 01/20] lib/vsprintf: Print time and date in human readable format via %pt
Date:   Tue,  4 Dec 2018 23:23:11 +0200
Message-Id: <20181204212330.69515-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204212330.69515-1-andriy.shevchenko@linux.intel.com>
References: <20181204212330.69515-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are users which print time and date represented by content of
struct rtc_time in human readable format.

Instead of open coding that each time introduce %ptR[dt][r] specifier.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst |  18 ++++
 lib/test_printf.c                         |  61 ++++++++++++-
 lib/vsprintf.c                            | 100 ++++++++++++++++++++++
 3 files changed, 176 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ff48b55040ef..a7fae4538946 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -412,6 +412,24 @@ Examples::
 
 Passed by reference.
 
+Time and date (struct rtc_time)
+-------------------------------
+
+::
+
+	%ptR		YYYY-mm-ddTHH:MM:SS
+	%ptRd		YYYY-mm-dd
+	%ptRt		HH:MM:SS
+	%ptR[dt][r]
+
+For printing date and time as represented by struct rtc_time structure in
+human readable format.
+
+By default year will be incremented by 1900 and month by 1. Use %ptRr (raw)
+to suppress this behaviour.
+
+Passed by reference.
+
 struct clk
 ----------
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 53527ea822b5..659b6cc0d483 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/random.h>
+#include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
@@ -249,12 +250,11 @@ plain_format(void)
 #endif	/* BITS_PER_LONG == 64 */
 
 static int __init
-plain_hash(void)
+plain_hash_to_buffer(const void *p, char *buf, size_t len)
 {
-	char buf[PLAIN_BUF_SIZE];
 	int nchars;
 
-	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
+	nchars = snprintf(buf, len, "%p", p);
 
 	if (nchars != PTR_WIDTH)
 		return -1;
@@ -265,6 +265,20 @@ plain_hash(void)
 		return 0;
 	}
 
+	return 0;
+}
+
+
+static int __init
+plain_hash(void)
+{
+	char buf[PLAIN_BUF_SIZE];
+	int ret;
+
+	ret = plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
+	if (ret)
+		return ret;
+
 	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
 		return -1;
 
@@ -294,6 +308,23 @@ plain(void)
 	}
 }
 
+static void __init
+test_hashed(const char *fmt, const void *p)
+{
+	char buf[PLAIN_BUF_SIZE];
+	int ret;
+
+	/*
+	 * No need to increase failed test counter since this is assumed
+	 * to be called after plain().
+	 */
+	ret = plain_hash_to_buffer(p, buf, PLAIN_BUF_SIZE);
+	if (ret)
+		return;
+
+	test(buf, fmt, p);
+}
+
 static void __init
 symbol_ptr(void)
 {
@@ -418,6 +449,29 @@ struct_va_format(void)
 {
 }
 
+static void __init
+struct_rtc_time(void)
+{
+	/* 1543210543 */
+	const struct rtc_time tm = {
+		.tm_sec = 43,
+		.tm_min = 35,
+		.tm_hour = 5,
+		.tm_mday = 26,
+		.tm_mon = 10,
+		.tm_year = 118,
+	};
+
+	test_hashed("%pt", &tm);
+
+	test("2018-11-26T05:35:43", "%ptR", &tm);
+	test("0118-10-26T05:35:43", "%ptRr", &tm);
+	test("05:35:43|2018-11-26", "%ptRt|%ptRd", &tm, &tm);
+	test("05:35:43|0118-10-26", "%ptRtr|%ptRdr", &tm, &tm);
+	test("05:35:43|2018-11-26", "%ptRttr|%ptRdtr", &tm, &tm);
+	test("05:35:43 tr|2018-11-26 tr", "%ptRt tr|%ptRd tr", &tm, &tm);
+}
+
 static void __init
 struct_clk(void)
 {
@@ -529,6 +583,7 @@ test_pointer(void)
 	uuid();
 	dentry();
 	struct_va_format();
+	struct_rtc_time();
 	struct_clk();
 	bitmap();
 	netdev_features();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 37a54a6dd594..3add92329bae 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -30,6 +30,7 @@
 #include <linux/ioport.h>
 #include <linux/dcache.h>
 #include <linux/cred.h>
+#include <linux/rtc.h>
 #include <linux/uuid.h>
 #include <linux/of.h>
 #include <net/addrconf.h>
@@ -822,6 +823,20 @@ static const struct printf_spec default_dec_spec = {
 	.precision = -1,
 };
 
+static const struct printf_spec default_dec02_spec = {
+	.base = 10,
+	.field_width = 2,
+	.precision = -1,
+	.flags = ZEROPAD,
+};
+
+static const struct printf_spec default_dec04_spec = {
+	.base = 10,
+	.field_width = 4,
+	.precision = -1,
+	.flags = ZEROPAD,
+};
+
 static noinline_for_stack
 char *resource_string(char *buf, char *end, struct resource *res,
 		      struct printf_spec spec, const char *fmt)
@@ -1549,6 +1564,87 @@ char *address_val(char *buf, char *end, const void *addr, const char *fmt)
 	return special_hex_number(buf, end, num, size);
 }
 
+static noinline_for_stack
+char *date_str(char *buf, char *end, const struct rtc_time *tm, bool r)
+{
+	int year = tm->tm_year + (r ? 0 : 1900);
+	int mon = tm->tm_mon + (r ? 0 : 1);
+
+	buf = number(buf, end, year, default_dec04_spec);
+	if (buf < end)
+		*buf = '-';
+	buf++;
+
+	buf = number(buf, end, mon, default_dec02_spec);
+	if (buf < end)
+		*buf = '-';
+	buf++;
+
+	return number(buf, end, tm->tm_mday, default_dec02_spec);
+}
+
+static noinline_for_stack
+char *time_str(char *buf, char *end, const struct rtc_time *tm, bool r)
+{
+	buf = number(buf, end, tm->tm_hour, default_dec02_spec);
+	if (buf < end)
+		*buf = ':';
+	buf++;
+
+	buf = number(buf, end, tm->tm_min, default_dec02_spec);
+	if (buf < end)
+		*buf = ':';
+	buf++;
+
+	return number(buf, end, tm->tm_sec, default_dec02_spec);
+}
+
+static noinline_for_stack
+char *rtc_str(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
+{
+	bool have_t = true, have_d = true;
+	bool raw = false;
+	int count = 2;
+
+	switch (fmt[count]) {
+	case 'd':
+		have_t = false;
+		count++;
+		break;
+	case 't':
+		have_d = false;
+		count++;
+		break;
+	}
+
+	raw = fmt[count] == 'r';
+
+	if (have_d)
+		buf = date_str(buf, end, tm, raw);
+	if (have_d && have_t) {
+		/* Respect ISO 8601 */
+		if (buf < end)
+			*buf = 'T';
+		buf++;
+	}
+	if (have_t)
+		buf = time_str(buf, end, tm, raw);
+
+	return buf;
+}
+
+static noinline_for_stack
+char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
+		    const char *fmt)
+{
+	switch (fmt[1]) {
+	case 'R':
+		return rtc_str(buf, end, (const struct rtc_time *)ptr, fmt);
+	default:
+		return ptr_to_id(buf, end, ptr, spec);
+	}
+}
+
 static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
@@ -1828,6 +1924,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)
+ * - 't[R][dt][r]' For time and date as represented:
+ *      R    struct rtc_time
  * - 'C' For a clock, it prints the name (Common Clock Framework) or address
  *       (legacy clock framework) of the clock
  * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
@@ -1952,6 +2050,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return address_val(buf, end, ptr, fmt);
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
+	case 't':
+		return time_and_date(buf, end, ptr, spec, fmt);
 	case 'C':
 		return clock(buf, end, ptr, spec, fmt);
 	case 'D':
-- 
2.19.2

