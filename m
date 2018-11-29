Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0611C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088C20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A088C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeK2WJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:09:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:38624 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbeK2WJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:09:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 03:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="113631681"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2018 03:04:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A1BF18E; Thu, 29 Nov 2018 13:04:32 +0200 (EET)
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
Subject: [PATCH v5 02/21] lib/vsprintf: Print time and date in human readable format via %pt
Date:   Thu, 29 Nov 2018 12:59:40 +0200
Message-Id: <20181129105956.25933-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
References: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
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
 lib/test_printf.c                         |   6 ++
 lib/vsprintf.c                            | 111 ++++++++++++++++++++++
 3 files changed, 135 insertions(+)

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
index 53527ea822b5..97b7d14961d6 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -418,6 +418,11 @@ struct_va_format(void)
 {
 }
 
+static void __init
+struct_rtc_time(void)
+{
+}
+
 static void __init
 struct_clk(void)
 {
@@ -529,6 +534,7 @@ test_pointer(void)
 	uuid();
 	dentry();
 	struct_va_format();
+	struct_rtc_time();
 	struct_clk();
 	bitmap();
 	netdev_features();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 37a54a6dd594..b7114799b91f 100644
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
@@ -1549,6 +1564,98 @@ char *address_val(char *buf, char *end, const void *addr, const char *fmt)
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
+	bool found;
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
+	found = true;
+	do {
+		switch (fmt[count++]) {
+		case 'r':
+			raw = true;
+			break;
+		default:
+			found = false;
+			break;
+		}
+	} while (found);
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
+char *timeanddate(char *buf, char *end, void *ptr, struct printf_spec spec,
+		  const char *fmt)
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
@@ -1828,6 +1935,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)
+ * - 't[R][dt][r]' For time and date as represented:
+ *      R    struct rtc_time
  * - 'C' For a clock, it prints the name (Common Clock Framework) or address
  *       (legacy clock framework) of the clock
  * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
@@ -1952,6 +2061,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return address_val(buf, end, ptr, fmt);
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
+	case 't':
+		return timeanddate(buf, end, ptr, spec, fmt);
 	case 'C':
 		return clock(buf, end, ptr, spec, fmt);
 	case 'D':
-- 
2.19.2

