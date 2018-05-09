Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965044AbeEIPR0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:17:26 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:45950 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935265AbeEIPP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:15:59 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:2:41:69:355:379:541:800:960:968:973:982:988:989:1260:1345:1359:1437:1535:1605:1730:1747:1777:1792:2393:2559:2562:2902:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3874:4051:4119:4321:4605:5007:6119:6261:10004:10848:11026:11473:11658:11914:12043:12291:12295:12296:12438:12555:12679:12683:12895:13161:13229:14394:21080:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: grape74_8b70fc8de3714
X-Filterd-Recvd-Size: 8797
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] device: Add #define dev_fmt similar to #define pr_fmt
Date: Wed,  9 May 2018 08:15:46 -0700
Message-Id: <3f213f4f9ee604c1797af67360d8da1836b34271.1525878372.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525878372.git.joe@perches.com>
References: <cover.1525878372.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a prefixing macro to dev_<level> uses similar to the pr_fmt
prefixing macro used in pr_<level> calls.

This can help avoid some string duplication in dev_<level> uses.

The default, like pr_fmt, is an empty #define dev_fmt(fmt) fmt

Rename the existing dev_<level> functions to _dev_<level> and
introduce #define dev_<level> _dev_<level> macros that use the
new #define dev_fmt

Miscellanea:

o Consistently use #defines with fmt, ... and ##__VA_ARGS__
o Remove unnecessary externs

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/core.c    |  12 +++---
 include/linux/device.h | 103 ++++++++++++++++++++++++++++---------------------
 2 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ad7b50897bcc..9c87a41cef82 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2985,12 +2985,12 @@ void func(const struct device *dev, const char *fmt, ...)	\
 }								\
 EXPORT_SYMBOL(func);
 
-define_dev_printk_level(dev_emerg, KERN_EMERG);
-define_dev_printk_level(dev_alert, KERN_ALERT);
-define_dev_printk_level(dev_crit, KERN_CRIT);
-define_dev_printk_level(dev_err, KERN_ERR);
-define_dev_printk_level(dev_warn, KERN_WARNING);
-define_dev_printk_level(dev_notice, KERN_NOTICE);
+define_dev_printk_level(_dev_emerg, KERN_EMERG);
+define_dev_printk_level(_dev_alert, KERN_ALERT);
+define_dev_printk_level(_dev_crit, KERN_CRIT);
+define_dev_printk_level(_dev_err, KERN_ERR);
+define_dev_printk_level(_dev_warn, KERN_WARNING);
+define_dev_printk_level(_dev_notice, KERN_NOTICE);
 define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
diff --git a/include/linux/device.h b/include/linux/device.h
index 563077d1cdc1..49c6b5d6a9f8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1306,30 +1306,34 @@ struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
 
+#ifndef dev_fmt
+#define dev_fmt(fmt) fmt
+#endif
+
 #ifdef CONFIG_PRINTK
 
-extern __printf(3, 0)
+__printf(3, 0)
 int dev_vprintk_emit(int level, const struct device *dev,
 		     const char *fmt, va_list args);
-extern __printf(3, 4)
+__printf(3, 4)
 int dev_printk_emit(int level, const struct device *dev, const char *fmt, ...);
 
-extern __printf(3, 4)
+__printf(3, 4)
 void dev_printk(const char *level, const struct device *dev,
 		const char *fmt, ...);
-extern __printf(2, 3)
-void dev_emerg(const struct device *dev, const char *fmt, ...);
-extern __printf(2, 3)
-void dev_alert(const struct device *dev, const char *fmt, ...);
-extern __printf(2, 3)
-void dev_crit(const struct device *dev, const char *fmt, ...);
-extern __printf(2, 3)
-void dev_err(const struct device *dev, const char *fmt, ...);
-extern __printf(2, 3)
-void dev_warn(const struct device *dev, const char *fmt, ...);
-extern __printf(2, 3)
-void dev_notice(const struct device *dev, const char *fmt, ...);
-extern __printf(2, 3)
+__printf(2, 3)
+void _dev_emerg(const struct device *dev, const char *fmt, ...);
+__printf(2, 3)
+void _dev_alert(const struct device *dev, const char *fmt, ...);
+__printf(2, 3)
+void _dev_crit(const struct device *dev, const char *fmt, ...);
+__printf(2, 3)
+void _dev_err(const struct device *dev, const char *fmt, ...);
+__printf(2, 3)
+void _dev_warn(const struct device *dev, const char *fmt, ...);
+__printf(2, 3)
+void _dev_notice(const struct device *dev, const char *fmt, ...);
+__printf(2, 3)
 void _dev_info(const struct device *dev, const char *fmt, ...);
 
 #else
@@ -1347,26 +1351,26 @@ static inline void __dev_printk(const char *level, const struct device *dev,
 {}
 static inline __printf(3, 4)
 void dev_printk(const char *level, const struct device *dev,
-		const char *fmt, ...)
+		 const char *fmt, ...)
 {}
 
 static inline __printf(2, 3)
-void dev_emerg(const struct device *dev, const char *fmt, ...)
+void _dev_emerg(const struct device *dev, const char *fmt, ...)
 {}
 static inline __printf(2, 3)
-void dev_crit(const struct device *dev, const char *fmt, ...)
+void _dev_crit(const struct device *dev, const char *fmt, ...)
 {}
 static inline __printf(2, 3)
-void dev_alert(const struct device *dev, const char *fmt, ...)
+void _dev_alert(const struct device *dev, const char *fmt, ...)
 {}
 static inline __printf(2, 3)
-void dev_err(const struct device *dev, const char *fmt, ...)
+void _dev_err(const struct device *dev, const char *fmt, ...)
 {}
 static inline __printf(2, 3)
-void dev_warn(const struct device *dev, const char *fmt, ...)
+void _dev_warn(const struct device *dev, const char *fmt, ...)
 {}
 static inline __printf(2, 3)
-void dev_notice(const struct device *dev, const char *fmt, ...)
+void _dev_notice(const struct device *dev, const char *fmt, ...)
 {}
 static inline __printf(2, 3)
 void _dev_info(const struct device *dev, const char *fmt, ...)
@@ -1375,27 +1379,36 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 #endif
 
 /*
- * Stupid hackaround for existing uses of non-printk uses dev_info
- *
- * Note that the definition of dev_info below is actually _dev_info
- * and a macro is used to avoid redefining dev_info
+ * #defines for all the dev_<level> macros to prefix with whatever
+ * possible use of #define dev_fmt(fmt) ...
  */
 
-#define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
+#define dev_emerg(dev, fmt, ...)					\
+	_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_crit(dev, fmt, ...)						\
+	_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_alert(dev, fmt, ...)					\
+	_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_err(dev, fmt, ...)						\
+	_dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_warn(dev, fmt, ...)						\
+	_dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_notice(dev, fmt, ...)					\
+	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_info(dev, fmt, ...)						\
+	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
-#define dev_dbg(dev, format, ...)		     \
-do {						     \
-	dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
-} while (0)
+#define dev_dbg(dev, fmt, ...)						\
+	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
 #elif defined(DEBUG)
-#define dev_dbg(dev, format, arg...)		\
-	dev_printk(KERN_DEBUG, dev, format, ##arg)
+#define dev_dbg(dev, fmt, ...)						\
+	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #else
-#define dev_dbg(dev, format, arg...)				\
-({								\
-	if (0)							\
-		dev_printk(KERN_DEBUG, dev, format, ##arg);	\
+#define dev_dbg(dev, fmt, ...)						\
+({									\
+	if (0)								\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
 })
 #endif
 
@@ -1467,7 +1480,7 @@ do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
 	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT) &&	\
 	    __ratelimit(&_rs))						\
-		__dynamic_dev_dbg(&descriptor, dev, fmt,		\
+		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
 } while (0)
 #elif defined(DEBUG)
@@ -1477,23 +1490,23 @@ do {									\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
 	if (__ratelimit(&_rs))						\
-		dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__);	\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
 } while (0)
 #else
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
 do {									\
 	if (0)								\
-		dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__);	\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
 } while (0)
 #endif
 
 #ifdef VERBOSE_DEBUG
 #define dev_vdbg	dev_dbg
 #else
-#define dev_vdbg(dev, format, arg...)				\
-({								\
-	if (0)							\
-		dev_printk(KERN_DEBUG, dev, format, ##arg);	\
+#define dev_vdbg(dev, fmt, ...)						\
+({									\
+	if (0)								\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
 })
 #endif
 
-- 
2.15.0
