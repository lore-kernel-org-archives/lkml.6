Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x224LWKTGwNjxtllJeLuCyDyUpjcd/M5Vr3ThRG6hyXaHauU2GNRwqtMfVJrtUMJoXt4JdnqD
ARC-Seal: i=1; a=rsa-sha256; t=1519163047; cv=none;
        d=google.com; s=arc-20160816;
        b=0Oesuh3F1O9YdfH7vhtibeDuemGvjPK1DpfJ4f/eTHQpO2eyVCzW6dfvSr75TZhp8g
         S8PfI9WiA4WUUZuMQOeqbsuxVH5XuKwUBc9Evv+WyRV1lE+j7zdJ0Xi087utXOal6UMW
         BCNl3vI7kTlF7jQgNQ/DCZ6agcixeCISieVJNG3sW7DH2DDbwraFq4AfSfufkmcW95Ai
         fuzqMrwvbFrlJbe21Ec2HZ5GAjURfyuU2ut0R05CNwIYKWrpCauWH+1R6xme4TaXqq2c
         1K0INrH/ZPhMPREqQ3fIrlNV5e9B/rlGufDjmQ/4xl8SCk7d2ca101gFLxgpqSQkSqE2
         pAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=7xZr1dqy8f5vPgRcyZlbQB/HPKJ6GKuRsExIXjORmus=;
        b=tLWr09PE0y2v7L+GOTXtb6PZAVN6wU847fGNCCruCpzNobteRlGaOxYd2JKzfHlUA5
         pNjtbh6O6CkI6DYKxYicQOrOjinOkPpHUDgPH0h888oeGC0VChp2RTsLQtGEU17exNBp
         rXFhHRvsDibTUsDbYXvYH1hdBVbU+VAXF55eM+/zdaUSWeBIRQ7quwo2g+1rNtHHrL8A
         ATH2vVBFKu2QczS7j/F0PudSTw6/gY2GF/sfMyLOF2Q/OO0s99JxRDt/aokfuQYDEDOl
         xHO65IJmXfRo1sOqFy8IR/rNfnwwGMWb1X/FTu5F3qFGnqLE6dosPaCo/9yXyARzX1Gn
         Zamw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="21687236"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-rtc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Joe Perches <joe@perches.com>,
	Mark Salyzyn <salyzyn@android.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Ingo Molnar <mingo@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 01/21] lib/vsprintf: Print time and date in human readable format via %pt
Date: Tue, 20 Feb 2018 23:43:40 +0200
Message-Id: <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1592957911897092414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are users which print time and date represented by content of
struct rtc_time in human readable format.

Instead of open coding that each time introduce %ptR[dt][rv] specifier.

Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.

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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst |  31 +++++++
 lib/Kconfig                               |   8 ++
 lib/test_printf.c                         |   6 ++
 lib/vsprintf.c                            | 145 ++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 934559b3c130..9aaf0858ddd4 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -412,6 +412,37 @@ Examples::
 
 Passed by reference.
 
+Time and date
+-------------
+
+::
+
+	%pt[R]		YYYY-mm-dd HH:MM:SS
+	%pt[R]d		YYYY-mm-dd
+	%pt[R]t		HH:MM:SS
+	%pt[R][dt]
+
+  R for struct rtc_time
+
+Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
+
+struct rtc_time
+~~~~~~~~~~~~~~~
+
+::
+
+	%ptR[dt][rv]
+
+For printing date and time as represented by struct rtc_time structure in
+human readable format.
+
+By default year will be incremented by 1900 and month by 1. Use %ptRr (raw)
+to suppress this behaviour. On the other hand when %ptRv is applied
+validation mechanism will be in use, i.e. numbers out of range will be
+replaced by ** or ****.
+
+Passed by reference.
+
 struct clk
 ----------
 
diff --git a/lib/Kconfig b/lib/Kconfig
index e96089499371..e48cb7ba7beb 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -605,3 +605,11 @@ config GENERIC_CMPDI2
 
 config GENERIC_UCMPDI2
 	bool
+
+#
+# %p optional extensions for vsnprintf().
+# Should be selected by users.
+#
+
+config PRINTK_PEXT_TIMEDATE
+	bool
diff --git a/lib/test_printf.c b/lib/test_printf.c
index cea592f402ed..54f8960ea531 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -398,6 +398,11 @@ struct_va_format(void)
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
@@ -509,6 +514,7 @@ test_pointer(void)
 	uuid();
 	dentry();
 	struct_va_format();
+	struct_rtc_time();
 	struct_clk();
 	bitmap();
 	netdev_features();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 28d7aca6a805..90ea28aefc26 100644
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
@@ -709,6 +710,20 @@ static const struct printf_spec default_dec_spec = {
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
@@ -1443,6 +1458,132 @@ char *address_val(char *buf, char *end, const void *addr, const char *fmt)
 	return special_hex_number(buf, end, num, size);
 }
 
+static noinline_for_stack
+char *date_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
+{
+	int year = tm->tm_year + (r ? 0 : 1900);
+	int mon = tm->tm_mon + (r ? 0 : 1);
+
+	if (unlikely(v && (unsigned int)tm->tm_year > 200))
+		buf = string(buf, end, "****", default_str_spec);
+	else
+		buf = number(buf, end, year, default_dec04_spec);
+
+	if (buf < end)
+		*buf = '-';
+	buf++;
+
+	if (unlikely(v && (unsigned int)tm->tm_mon > 11))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, mon, default_dec02_spec);
+
+	if (buf < end)
+		*buf = '-';
+	buf++;
+
+	if (unlikely(v && (unsigned int)tm->tm_mday > 31))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, tm->tm_mday, default_dec02_spec);
+
+	return buf;
+}
+
+static noinline_for_stack
+char *time_str(char *buf, char *end, const struct rtc_time *tm, bool v, bool r)
+{
+	if (unlikely(v && (unsigned int)tm->tm_hour > 24))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, tm->tm_hour, default_dec02_spec);
+
+	if (buf < end)
+		*buf = ':';
+	buf++;
+
+	if (unlikely(v && (unsigned int)tm->tm_min > 59))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, tm->tm_min, default_dec02_spec);
+
+	if (buf < end)
+		*buf = ':';
+	buf++;
+
+	if (unlikely(v && (unsigned int)tm->tm_sec > 59))
+		buf = string(buf, end, "**", default_str_spec);
+	else
+		buf = number(buf, end, tm->tm_sec, default_dec02_spec);
+
+	return buf;
+}
+
+static noinline_for_stack
+char *rtc_str(char *buf, char *end, const struct rtc_time *tm, const char *fmt)
+{
+	bool have_t = true, have_d = true;
+	bool validate = false;
+	bool raw = false;
+	int count = 1;
+	bool found;
+
+	switch (fmt[++count]) {
+	case 'd':
+		have_t = false;
+		break;
+	case 't':
+		have_d = false;
+		break;
+	}
+
+	/* No %pt[dt] supplied */
+	if (have_d && have_t)
+		--count;
+
+	found = true;
+	do {
+		switch (fmt[++count]) {
+		case 'r':
+			raw = true;
+			break;
+		case 'v':
+			validate = true;
+			break;
+		default:
+			found = false;
+			break;
+		}
+	} while (found);
+
+	if (have_d)
+		buf = date_str(buf, end, tm, validate, raw);
+	if (have_d && have_t) {
+		if (buf < end)
+			*buf = ' ';
+		buf++;
+	}
+	if (have_t)
+		buf = time_str(buf, end, tm, validate, raw);
+
+	return buf;
+}
+
+static noinline_for_stack
+char *timeanddate(char *buf, char *end, void *ptr, const char *fmt)
+{
+	if (!IS_ENABLED(CONFIG_PRINTK_PEXT_TIMEDATE))
+		return string(buf, end, NULL, default_str_spec);
+
+	switch (fmt[1]) {
+	case 'R':
+		return rtc_str(buf, end, (const struct rtc_time *)ptr, fmt);
+	default:
+		break;
+	}
+	return special_hex_number(buf, end, (unsigned long)ptr, sizeof(void *));
+}
+
 static noinline_for_stack
 char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 	    const char *fmt)
@@ -1776,6 +1917,8 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)
+ * - 't[R][dt][rv]' For time and date as represented:
+ *      R    struct rtc_time
  * - 'C' For a clock, it prints the name (Common Clock Framework) or address
  *       (legacy clock framework) of the clock
  * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
@@ -1906,6 +2049,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return address_val(buf, end, ptr, fmt);
 	case 'd':
 		return dentry_name(buf, end, ptr, spec, fmt);
+	case 't':
+		return timeanddate(buf, end, ptr, fmt);
 	case 'C':
 		return clock(buf, end, ptr, spec, fmt);
 	case 'D':
-- 
2.15.1
