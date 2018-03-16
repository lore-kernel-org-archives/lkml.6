Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeCPU4d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:56:33 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:49279 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751269AbeCPU4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:56:31 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:1:41:69:355:379:541:800:960:968:973:988:989:1260:1345:1437:1605:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2636:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:4321:4419:4559:4605:5007:6119:6261:8603:9592:10004:10848:11026:11232:11233:11473:11658:11914:12043:12048:12291:12296:12438:12555:12683:12895:12986:13161:13229:14394:21080:21433:21451:21627:30012:30054:30070:30075,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: bead75_72e43968d9503
X-Filterd-Recvd-Size: 10784
From: Joe Perches <joe@perches.com>
To: Daniel Vetter <daniel@ffwll.ch>, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Reduce object size of DRM_DEV_<LEVEL> uses
Date: Fri, 16 Mar 2018 13:56:27 -0700
Message-Id: <e5c164946e15375ac71b69b75f296efdf0b76e6d.1521233717.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are similar to the DRM_<LEVEL> with the addition
of a struct device * to the arguments.

Convert the single drm_dev_printk function into 2 separate functions.
drm_dev_printk with a KERN_<LEVEL> * for generic use and drm_dev_dbg
for conditional masked use.

Remove the __func__ argument and use __builtin_return_address(0) to be
similar to the DRM_<LEVEL> macros uses.

Convert the DRM_DEV_<LEVEL> macros to remove now unnecessary arguments
and use a consistent style.

These macros are rarely used in the generic gpu/drm code so the code
size does not change much for a defconfig, but when more drivers are
enabled, there is ~4k savings.

Many of these macros have no existing use at all.

$ size -t drivers/gpu/drm/built-in.a | tail -1
1877530	  44651	    995	1923176	 1d5868	(TOTALS)

$ size -t drivers/gpu/drm/built-in.a | tail -1
1877527	  44651	    995	1923173	 1d5865	(TOTALS)

$ size -t drivers/gpu/drm/built-in.a | tail -1
17166750	2689238	 108352	19964340	130a1b4	(TOTALS)

$ size -t drivers/gpu/drm/built-in.a | tail -1
17168888	2691734	 108352	19968974	130b3ce	(TOTALS)

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/drm_print.c | 37 +++++++++++++-----
 include/drm/drm_print.h     | 94 ++++++++++++++++++++++-----------------------
 2 files changed, 74 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 79abf6d5b4db..b25f98f33f6c 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -63,16 +63,34 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
 }
 EXPORT_SYMBOL(drm_printf);
 
-#define DRM_PRINTK_FMT "[" DRM_NAME ":%s]%s %pV"
-
 void drm_dev_printk(const struct device *dev, const char *level,
-		    unsigned int category, const char *function_name,
-		    const char *prefix, const char *format, ...)
+		    const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	if (dev)
+		dev_printk(level, dev, "[" DRM_NAME ":%ps] %pV",
+			   __builtin_return_address(0), &vaf);
+	else
+		printk("%s" "[" DRM_NAME ":%ps] %pV",
+		       level, __builtin_return_address(0), &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(drm_dev_printk);
+
+void drm_dev_dbg(const struct device *dev, unsigned int category,
+		 const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
 
-	if (category != DRM_UT_NONE && !(drm_debug & category))
+	if (!(drm_debug & category))
 		return;
 
 	va_start(args, format);
@@ -80,14 +98,15 @@ void drm_dev_printk(const struct device *dev, const char *level,
 	vaf.va = &args;
 
 	if (dev)
-		dev_printk(level, dev, DRM_PRINTK_FMT, function_name, prefix,
-			   &vaf);
+		dev_printk(KERN_DEBUG, dev, "[" DRM_NAME ":%ps] %pV",
+			   __builtin_return_address(0), &vaf);
 	else
-		printk("%s" DRM_PRINTK_FMT, level, function_name, prefix, &vaf);
+		printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
+		       __builtin_return_address(0), &vaf);
 
 	va_end(args);
 }
-EXPORT_SYMBOL(drm_dev_printk);
+EXPORT_SYMBOL(drm_dev_dbg);
 
 void drm_dbg(unsigned int category, const char *format, ...)
 {
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 3a40c5a3a5fa..e1a46e9991cc 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -196,10 +196,13 @@ static inline struct drm_printer drm_debug_printer(const char *prefix)
 #define DRM_UT_STATE		0x40
 #define DRM_UT_LEASE		0x80
 
-__printf(6, 7)
+__printf(3, 4)
 void drm_dev_printk(const struct device *dev, const char *level,
-		    unsigned int category, const char *function_name,
-		    const char *prefix, const char *format, ...);
+		    const char *format, ...);
+__printf(3, 4)
+void drm_dev_dbg(const struct device *dev, unsigned int category,
+		 const char *format, ...);
+
 __printf(2, 3)
 void drm_dbg(unsigned int category, const char *format, ...);
 __printf(1, 2)
@@ -208,10 +211,7 @@ void drm_err(const char *format, ...);
 /* Macros to make printk easier */
 
 #define _DRM_PRINTK(once, level, fmt, ...)				\
-	do {								\
-		printk##once(KERN_##level "[" DRM_NAME "] " fmt,	\
-			     ##__VA_ARGS__);				\
-	} while (0)
+	printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
 
 #define DRM_INFO(fmt, ...)						\
 	_DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
@@ -234,8 +234,7 @@ void drm_err(const char *format, ...);
  * @fmt: printf() like format string.
  */
 #define DRM_DEV_ERROR(dev, fmt, ...)					\
-	drm_dev_printk(dev, KERN_ERR, DRM_UT_NONE, __func__, " *ERROR*",\
-		       fmt, ##__VA_ARGS__)
+	drm_dev_printk(dev, KERN_ERR, "*ERROR* " fmt, ##__VA_ARGS__)
 #define DRM_ERROR(fmt, ...)						\
 	drm_err(fmt, ##__VA_ARGS__)
 
@@ -258,8 +257,7 @@ void drm_err(const char *format, ...);
 	DRM_DEV_ERROR_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
 
 #define DRM_DEV_INFO(dev, fmt, ...)					\
-	drm_dev_printk(dev, KERN_INFO, DRM_UT_NONE, __func__, "", fmt,	\
-		       ##__VA_ARGS__)
+	drm_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
 
 #define DRM_DEV_INFO_ONCE(dev, fmt, ...)				\
 ({									\
@@ -276,53 +274,46 @@ void drm_err(const char *format, ...);
  * @dev: device pointer
  * @fmt: printf() like format string.
  */
-#define DRM_DEV_DEBUG(dev, fmt, args...)				\
-	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_CORE, __func__, "", fmt,	\
-		       ##args)
+#define DRM_DEV_DEBUG(dev, fmt, ...)					\
+	drm_dev_dbg(dev, DRM_UT_CORE, fmt, ##__VA_ARGS__)
 #define DRM_DEBUG(fmt, ...)						\
 	drm_dbg(DRM_UT_CORE, fmt, ##__VA_ARGS__)
 
-#define DRM_DEV_DEBUG_DRIVER(dev, fmt, args...)				\
-	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_DRIVER, __func__, "",	\
-		       fmt, ##args)
+#define DRM_DEV_DEBUG_DRIVER(dev, fmt, ...)				\
+	drm_dev_dbg(dev, DRM_UT_DRIVER,	fmt, ##__VA_ARGS__)
 #define DRM_DEBUG_DRIVER(fmt, ...)					\
 	drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
 
-#define DRM_DEV_DEBUG_KMS(dev, fmt, args...)				\
-	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_KMS, __func__, "", fmt,	\
-		       ##args)
+#define DRM_DEV_DEBUG_KMS(dev, fmt, ...)				\
+	drm_dev_dbg(dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
 #define DRM_DEBUG_KMS(fmt, ...)						\
 	drm_dbg(DRM_UT_KMS, fmt, ##__VA_ARGS__)
 
-#define DRM_DEV_DEBUG_PRIME(dev, fmt, args...)				\
-	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_PRIME, __func__, "",	\
-		       fmt, ##args)
+#define DRM_DEV_DEBUG_PRIME(dev, fmt, ...)				\
+	drm_dev_dbg(dev, DRM_UT_PRIME, fmt, ##__VA_ARGS__)
 #define DRM_DEBUG_PRIME(fmt, ...)					\
 	drm_dbg(DRM_UT_PRIME, fmt, ##__VA_ARGS__)
 
-#define DRM_DEV_DEBUG_ATOMIC(dev, fmt, args...)				\
-	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_ATOMIC, __func__, "",	\
-		       fmt, ##args)
+#define DRM_DEV_DEBUG_ATOMIC(dev, fmt, ...)				\
+	drm_dev_dbg(dev, DRM_UT_ATOMIC,	fmt, ##__VA_ARGS__)
 #define DRM_DEBUG_ATOMIC(fmt, ...)					\
 	drm_dbg(DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
 
-#define DRM_DEV_DEBUG_VBL(dev, fmt, args...)				\
-	drm_dev_printk(dev, KERN_DEBUG, DRM_UT_VBL, __func__, "", fmt,	\
-		       ##args)
+#define DRM_DEV_DEBUG_VBL(dev, fmt, ...)				\
+	drm_dev_dbg(dev, DRM_UT_VBL, fmt, ##__VA_ARGS__)
 #define DRM_DEBUG_VBL(fmt, ...)						\
 	drm_dbg(DRM_UT_VBL, fmt, ##__VA_ARGS__)
 
 #define DRM_DEBUG_LEASE(fmt, ...)					\
 	drm_dbg(DRM_UT_LEASE, fmt, ##__VA_ARGS__)
 
-#define _DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, level, fmt, args...)	\
+#define _DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, category, fmt, ...)	\
 ({									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	if (__ratelimit(&_rs))						\
-		drm_dev_printk(dev, KERN_DEBUG, DRM_UT_ ## level,	\
-			       __func__, "", fmt, ##args);		\
+		drm_dev_dbg(dev, category, fmt, ##__VA_ARGS__);		\
 })
 
 /**
@@ -331,21 +322,28 @@ void drm_err(const char *format, ...);
  * @dev: device pointer
  * @fmt: printf() like format string.
  */
-#define DRM_DEV_DEBUG_RATELIMITED(dev, fmt, args...)			\
-	DEV__DRM_DEFINE_DEBUG_RATELIMITED(dev, CORE, fmt, ##args)
-#define DRM_DEBUG_RATELIMITED(fmt, args...)				\
-	DRM_DEV_DEBUG_RATELIMITED(NULL, fmt, ##args)
-#define DRM_DEV_DEBUG_DRIVER_RATELIMITED(dev, fmt, args...)		\
-	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, DRIVER, fmt, ##args)
-#define DRM_DEBUG_DRIVER_RATELIMITED(fmt, args...)			\
-	DRM_DEV_DEBUG_DRIVER_RATELIMITED(NULL, fmt, ##args)
-#define DRM_DEV_DEBUG_KMS_RATELIMITED(dev, fmt, args...)		\
-	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, KMS, fmt, ##args)
-#define DRM_DEBUG_KMS_RATELIMITED(fmt, args...)				\
-	DRM_DEV_DEBUG_KMS_RATELIMITED(NULL, fmt, ##args)
-#define DRM_DEV_DEBUG_PRIME_RATELIMITED(dev, fmt, args...)		\
-	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, PRIME, fmt, ##args)
-#define DRM_DEBUG_PRIME_RATELIMITED(fmt, args...)			\
-	DRM_DEV_DEBUG_PRIME_RATELIMITED(NULL, fmt, ##args)
+#define DRM_DEV_DEBUG_RATELIMITED(dev, fmt, ...)			\
+	_DEV_DRM_DEFINE_DEBUG_RATELIMITED(dev, DRM_UT_CORE,		\
+					  fmt, ##__VA_ARGS__)
+#define DRM_DEBUG_RATELIMITED(fmt, ...)					\
+	DRM_DEV_DEBUG_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
+
+#define DRM_DEV_DEBUG_DRIVER_RATELIMITED(dev, fmt, ...)			\
+	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, DRM_UT_DRIVER,		\
+					  fmt, ##__VA_ARGS__)
+#define DRM_DEBUG_DRIVER_RATELIMITED(fmt, ...)				\
+	DRM_DEV_DEBUG_DRIVER_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
+
+#define DRM_DEV_DEBUG_KMS_RATELIMITED(dev, fmt, ...)			\
+	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, DRM_UT_KMS,		\
+					  fmt, ##__VA_ARGS__)
+#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...)				\
+	DRM_DEV_DEBUG_KMS_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
+
+#define DRM_DEV_DEBUG_PRIME_RATELIMITED(dev, fmt, ...)			\
+	_DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, DRM_UT_PRIME,		\
+					  fmt, ##__VA_ARGS__)
+#define DRM_DEBUG_PRIME_RATELIMITED(fmt, ...)				\
+	DRM_DEV_DEBUG_PRIME_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
 
 #endif /* DRM_PRINT_H_ */
-- 
2.15.0
