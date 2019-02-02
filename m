Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BAFC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DE421479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfBBBb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:31:56 -0500
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:49886 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbfBBBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:31:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 41E21182CED28;
        Sat,  2 Feb 2019 01:31:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: way19_1065cc253930e
X-Filterd-Recvd-Size: 8330
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 Feb 2019 01:31:52 +0000 (UTC)
Message-ID: <7399cb84e16538d6ff7c8b4f7718b692c831476b.camel@perches.com>
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Feb 2019 17:31:51 -0800
In-Reply-To: <20190201133704.GA25680@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
         <20190131200723.GZ114153@art_vandelay> <20190131210312.GA8947@ravnborg.org>
         <20190131215417.GA13156@mithrandir> <20190201133704.GA25680@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-01 at 14:37 +0100, Sam Ravnborg wrote:
> Hi Thierry.
> 
> > I'm slightly on the fence about this patch.
> 
> Please ignore patch 3-19, there is no consensus on the logging changes.
> We do not want to apply these and then have to redo parts/all of
> it later.
> 
> But the first two patches has not seen any feedback yet:
> 
>     [PATCH v1 01/19] drm/panel: drop drmP.h usage
>     [PATCH v1 02/19] drm/panel: panel-innolux: drop unused variable
> 
> Please consider these, or maybe wait a little to see if someone
> find time to review.
> 
> I can resend the patches if this is preferred.

My preference would also convert all the
DRM_DEV_<level> uses to drm_dev_<level> eventually.

Also, the macros themselves could change to use a
more consistent mechanism.

This would make the drm logging mechanisms more like
other logging mechanisms used in the kernel.

Something like:
---
Subject: [PATCH] drm: Improve and standardize logging functions

Use a more typical logging style.

Add and use drm_printk and drm_dev_printk functions that include the
test for KERN_ERR use where '*ERROR*' is added to logging output.

Remove the slightly unusual _DRM_PRINTK macro and use the new drm_printk
function instead.
---
 drivers/gpu/drm/drm_print.c | 67 +++++++++++++++++++++++++++++----------------
 include/drm/drm_print.h     | 51 ++++++++++++++++++++--------------
 2 files changed, 74 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 0e7fc3e7dfb4..4e3ae7b5cce1 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -174,22 +174,59 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
 }
 EXPORT_SYMBOL(drm_printf);
 
-void drm_dev_printk(const struct device *dev, const char *level,
-		    const char *format, ...)
+void drm_printk(const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
+	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = KERN_DEFAULT;
+	int level = printk_get_level(format);
+	size_t size = printk_skip_level(format) - format;
+
+	if (size) {
+		memcpy(lvl, format, size);
+		lvl[size] = '\0';
+	}
 
 	va_start(args, format);
-	vaf.fmt = format;
+	vaf.fmt = format + size;
+	vaf.va = &args;
+
+	printk("%s" "[" DRM_NAME ":%ps] %s%pV",
+	       lvl, __builtin_return_address(0),
+	       level == LOGLEVEL_ERR ? "*ERROR* " : "",
+	       &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(drm_printk);
+
+void drm_dev_printk(const struct device *dev, const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = KERN_DEFAULT;
+	int level = printk_get_level(format);
+	size_t size = printk_skip_level(format) - format;
+
+	if (size) {
+		memcpy(lvl, format, size);
+		lvl[size] = '\0';
+	}
+
+	va_start(args, format);
+	vaf.fmt = format + size;
 	vaf.va = &args;
 
 	if (dev)
-		dev_printk(level, dev, "[" DRM_NAME ":%ps] %pV",
-			   __builtin_return_address(0), &vaf);
+		dev_printk(lvl, dev, "[" DRM_NAME ":%ps] %s%pV",
+			   __builtin_return_address(0),
+			   level == LOGLEVEL_ERR ? "*ERROR* " : "",
+			   &vaf);
 	else
-		printk("%s" "[" DRM_NAME ":%ps] %pV",
-		       level, __builtin_return_address(0), &vaf);
+		printk("%s" "[" DRM_NAME ":%ps] %s%pV",
+		       lvl, __builtin_return_address(0),
+		       level == LOGLEVEL_ERR ? "*ERROR* " : "",
+		       &vaf);
 
 	va_end(args);
 }
@@ -237,19 +274,3 @@ void drm_dbg(unsigned int category, const char *format, ...)
 	va_end(args);
 }
 EXPORT_SYMBOL(drm_dbg);
-
-void drm_err(const char *format, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, format);
-	vaf.fmt = format;
-	vaf.va = &args;
-
-	printk(KERN_ERR "[" DRM_NAME ":%ps] *ERROR* %pV",
-	       __builtin_return_address(0), &vaf);
-
-	va_end(args);
-}
-EXPORT_SYMBOL(drm_err);
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index afbc3beef089..9d9fd10e6ff8 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -268,9 +268,8 @@ static inline struct drm_printer drm_debug_printer(const char *prefix)
 #define DRM_UT_LEASE		0x80
 #define DRM_UT_DP		0x100
 
-__printf(3, 4)
-void drm_dev_printk(const struct device *dev, const char *level,
-		    const char *format, ...);
+__printf(2, 3)
+void drm_dev_printk(const struct device *dev, const char *format, ...);
 __printf(3, 4)
 void drm_dev_dbg(const struct device *dev, unsigned int category,
 		 const char *format, ...);
@@ -278,26 +277,38 @@ void drm_dev_dbg(const struct device *dev, unsigned int category,
 __printf(2, 3)
 void drm_dbg(unsigned int category, const char *format, ...);
 __printf(1, 2)
-void drm_err(const char *format, ...);
+void drm_printk(const char *format, ...);
 
 /* Macros to make printk easier */
 
-#define _DRM_PRINTK(once, level, fmt, ...)				\
-	printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
-
-#define DRM_INFO(fmt, ...)						\
-	_DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
-#define DRM_NOTE(fmt, ...)						\
-	_DRM_PRINTK(, NOTICE, fmt, ##__VA_ARGS__)
+#define DRM_ERROR(fmt, ...)						\
+	drm_printk(KERN_ERR fmt, ##__VA_ARGS__)
+#define drm_err DRM_ERROR
 #define DRM_WARN(fmt, ...)						\
-	_DRM_PRINTK(, WARNING, fmt, ##__VA_ARGS__)
+	drm_printk(KERN_WARNING fmt, ##__VA_ARGS__)
+#define DRM_NOTE(fmt, ...)						\
+	drm_printk(KERN_NOTICE fmt, ##__VA_ARGS__)
+#define DRM_INFO(fmt, ...)						\
+	drm_printk(KERN_INFO fmt, ##__VA_ARGS__)
+
+#define drm_printk_once(fmt, ...)					\
+({									\
+	static bool __print_once __read_mostly;				\
+	bool __ret_print_once = !__print_once;				\
+									\
+	if (!__print_once) {						\
+		__print_once = true;					\
+		drm_printk(fmt, ##__VA_ARGS__);				\
+	}								\
+	unlikely(__ret_print_once);					\
+})
 
-#define DRM_INFO_ONCE(fmt, ...)						\
-	_DRM_PRINTK(_once, INFO, fmt, ##__VA_ARGS__)
-#define DRM_NOTE_ONCE(fmt, ...)						\
-	_DRM_PRINTK(_once, NOTICE, fmt, ##__VA_ARGS__)
 #define DRM_WARN_ONCE(fmt, ...)						\
-	_DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
+	drm_printk_once(KERN_WARNING fmt, ##__VA_ARGS__)
+#define DRM_NOTE_ONCE(fmt, ...)						\
+	drm_printk_once(KERN_NOTICE fmt, ##__VA_ARGS__)
+#define DRM_INFO_ONCE(fmt, ...)						\
+	drm_printk_once(KERN_INFO fmt, ##__VA_ARGS__)
 
 /**
  * Error output.
@@ -306,9 +317,7 @@ void drm_err(const char *format, ...);
  * @fmt: printf() like format string.
  */
 #define DRM_DEV_ERROR(dev, fmt, ...)					\
-	drm_dev_printk(dev, KERN_ERR, "*ERROR* " fmt, ##__VA_ARGS__)
-#define DRM_ERROR(fmt, ...)						\
-	drm_err(fmt, ##__VA_ARGS__)
+	drm_dev_printk(dev, KERN_ERR fmt, ##__VA_ARGS__)
 
 /**
  * Rate limited error output.  Like DRM_ERROR() but won't flood the log.
@@ -329,7 +338,7 @@ void drm_err(const char *format, ...);
 	DRM_DEV_ERROR_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
 
 #define DRM_DEV_INFO(dev, fmt, ...)					\
-	drm_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
+	drm_dev_printk(dev, KERN_INFO fmt, ##__VA_ARGS__)
 
 #define DRM_DEV_INFO_ONCE(dev, fmt, ...)				\
 ({									\

