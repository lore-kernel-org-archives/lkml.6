Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A5C04AB9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D886021477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L6AUjbei";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ug93zm3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D886021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeHXSVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:21:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:21:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 21C8760BFA; Fri, 24 Aug 2018 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535121978;
        bh=rcczfEhX8QHkFrzW6tXzD7l0ykXX2A23rSFVW71pJas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=L6AUjbeizQKwVTF2EbFzlwP2tvSv/A/zebPYMH4jPD2F1w/SN1aO7Srj30LbefaWQ
         9wRrmNgKn5Wx7OPoqq8P3/U05L9YqELqGFyrUF5SPY4oUGvq7cVGm2LhE3+ZgGx/39
         3NeTJvZ8dPojbXH2P1//PgCqgHmrtOtIFeuvh8+0=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2356760C4F;
        Fri, 24 Aug 2018 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535121974;
        bh=rcczfEhX8QHkFrzW6tXzD7l0ykXX2A23rSFVW71pJas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ug93zm3Uj9CDYUxJcNZUEHYSkQbToURrDBRmhWrdX9kgot9KrYPqPRII3bJjr+o7N
         fzBRO5PKtsLot0qyXlTbJfz3tHQbzx3a9xoKUfFHEjdJG791KfvG9HfbYQJmCX6wRT
         lLs4O7GeeZNKMKpLRYhL6TV9wMI0yCfGfAwH318E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2356760C4F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [RFC PATCH v2 3/3] dynamic_debug: Add support for dynamic register trace
Date:   Fri, 24 Aug 2018 20:15:27 +0530
Message-Id: <9015a7a4aafa9935be769c07918743df63d6f648.1535119711.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce dynamic debug filtering mechanism to register
tracing as dynamic_rtb() which will reduce a lot of
overhead otherwise of tracing all the register reads/writes
in all files.

Now we can just specify the file name or any wildcard pattern
as any other dynamic debug facility in bootargs and dynamic rtb
will just trace them and the output can be seen in pstore.

TODO: Now we use same 'p' flag but will add a separate flag for register trace
later.

Also add asm-generic/io-instrumented.h file for instrumentation of IO
operations such as read/write{b,w,l,q} as per Will's suggestion to not touch
arch code and let core generate instrumentation.
This can be extended to arm as well later for tracing.

Example for tracing all register reads/writes in drivers/soc/qcom/* below:

  # dyndbg="file drivers/soc/qcom/* +p" in bootargs
  # reboot -f
  # mount -t pstore pstore /sys/fs/pstore
  # cat /sys/fs/pstore/rtb-ramoops-0
    [LOGK_WRITE] ts:1373030419  data:ffff00000d5065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
    [LOGK_WRITE] ts:1373360576  data:ffff00000d506608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 arch/arm64/include/asm/io.h           | 26 +++++++++-------------
 include/asm-generic/io-instrumented.h | 32 +++++++++++++++++++++++++++
 include/linux/dynamic_debug.h         | 13 +++++++++++
 kernel/trace/Kconfig                  |  1 +
 4 files changed, 56 insertions(+), 16 deletions(-)
 create mode 100644 include/asm-generic/io-instrumented.h

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 35b2e50f17fb..aafd4b0be9f0 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -22,6 +22,7 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
+#include <linux/rtb.h>
 
 #include <asm/byteorder.h>
 #include <asm/barrier.h>
@@ -36,32 +37,27 @@
 /*
  * Generic IO read/write.  These perform native-endian accesses.
  */
-#define __raw_writeb __raw_writeb
-static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+static inline void arch_raw_writeb(u8 val, volatile void __iomem *addr)
 {
 	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
-#define __raw_writew __raw_writew
-static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+static inline void arch_raw_writew(u16 val, volatile void __iomem *addr)
 {
 	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
-#define __raw_writel __raw_writel
-static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+static inline void arch_raw_writel(u32 val, volatile void __iomem *addr)
 {
 	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
-#define __raw_writeq __raw_writeq
-static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+static inline void arch_raw_writeq(u64 val, volatile void __iomem *addr)
 {
 	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
 }
 
-#define __raw_readb __raw_readb
-static inline u8 __raw_readb(const volatile void __iomem *addr)
+static inline u8 arch_raw_readb(const volatile void __iomem *addr)
 {
 	u8 val;
 	asm volatile(ALTERNATIVE("ldrb %w0, [%1]",
@@ -71,8 +67,7 @@ static inline u8 __raw_readb(const volatile void __iomem *addr)
 	return val;
 }
 
-#define __raw_readw __raw_readw
-static inline u16 __raw_readw(const volatile void __iomem *addr)
+static inline u16 arch_raw_readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
@@ -83,8 +78,7 @@ static inline u16 __raw_readw(const volatile void __iomem *addr)
 	return val;
 }
 
-#define __raw_readl __raw_readl
-static inline u32 __raw_readl(const volatile void __iomem *addr)
+static inline u32 arch_raw_readl(const volatile void __iomem *addr)
 {
 	u32 val;
 	asm volatile(ALTERNATIVE("ldr %w0, [%1]",
@@ -94,8 +88,7 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 	return val;
 }
 
-#define __raw_readq __raw_readq
-static inline u64 __raw_readq(const volatile void __iomem *addr)
+static inline u64 arch_raw_readq(const volatile void __iomem *addr)
 {
 	u64 val;
 	asm volatile(ALTERNATIVE("ldr %0, [%1]",
@@ -193,6 +186,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
 #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
 
+#include <asm-generic/io-instrumented.h>
 #include <asm-generic/io.h>
 
 /*
diff --git a/include/asm-generic/io-instrumented.h b/include/asm-generic/io-instrumented.h
new file mode 100644
index 000000000000..ce273742b98c
--- /dev/null
+++ b/include/asm-generic/io-instrumented.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_GENERIC_IO_INSTRUMENTED_H
+#define _ASM_GENERIC_IO_INSTRUMENTED_H
+
+#include <linux/dynamic_debug.h>
+
+#define __raw_write(v, a, _t) ({			\
+	volatile void __iomem *_a = (a);		\
+	dynamic_rtb("LOGK_WRITE", (void __force *)(_a));\
+	arch_raw_write##_t((v), _a);			\
+	})
+
+#define __raw_writeb(v, a)	__raw_write((v), a, b)
+#define __raw_writew(v, a)	__raw_write((v), a, w)
+#define __raw_writel(v, a)	__raw_write((v), a, l)
+#define __raw_writeq(v, a)	__raw_write((v), a, q)
+
+#define __raw_read(a, _l, _t)    ({					\
+	_t __a;								\
+	const volatile void __iomem *_a = (const volatile void __iomem *)(a);\
+	dynamic_rtb("LOGK_READ", (void __force *)(_a));			\
+	__a = arch_raw_read##_l(_a);					\
+	__a;								\
+	})
+
+#define __raw_readb(a)	__raw_read((a), b, u8)
+#define __raw_readw(a)	__raw_read((a), w, u16)
+#define __raw_readl(a)	__raw_read((a), l, u32)
+#define __raw_readq(a)	__raw_read((a), q, u64)
+
+#endif
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2fd8006153c3..946b60f48401 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -155,6 +155,18 @@ do {								\
 			       buf, len, ascii);		\
 } while (0)
 
+#if defined(CONFIG_RTB)
+#define dynamic_rtb(log_type, data)				\
+do {								\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,		\
+		__builtin_constant_p(log_type) ? log_type : "rtb");\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
+		uncached_logk(log_type, data);			\
+} while (0)
+#else
+#define dynamic_rtb(log_type, data)
+#endif
+
 #else
 
 #include <linux/string.h>
@@ -181,6 +193,7 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 	do { if (0) printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); } while (0)
 #define dynamic_dev_dbg(dev, fmt, ...)					\
 	do { if (0) dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__); } while (0)
+#define dynamic_rtb(log_type, data)
 #endif
 
 #endif
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fd46c7e0016f..59f01091b5ee 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -776,6 +776,7 @@ config TRACING_EVENTS_GPIO
 
 config RTB
 	bool "Register Trace Buffer"
+	depends on DYNAMIC_DEBUG
 	help
 	  Add support for logging different events to a small uncached
 	  region. This is designed to aid in debugging reset cases where the
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

