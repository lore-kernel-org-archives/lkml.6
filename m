Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BCAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E982120827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YUa2XjB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E982120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeKJIyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34861 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeKJIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so2978902ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIZFEFvzkPZA9DrPR+t1P6RqDjylV60S7jW3I5FB+J4=;
        b=YUa2XjB3kjAlibCWVKzxlBUMktrQ1UdqxzQkShxHkPUywJAOzYODiJuu0qpYzeWAoU
         9Vcp9Zr3e0nEM1GlvmrdRNfiPaxXBqdNUuUHb7L1VHNjvqq7MyLMUmt7p0nE4/pJ0LgO
         T8Mc9hye5tdKDcagtPozBpPWH1ZBBiZgfzST4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIZFEFvzkPZA9DrPR+t1P6RqDjylV60S7jW3I5FB+J4=;
        b=CbD8E5YrVioJGgS5yndgdMnlwU5v3unzTASjfRNGpQcd7BMQGzo74KPu5Gm1R765Ka
         OJXFaDQ38zckLmJ0npMqJkPaf4bMk7VTNF01Eutl2J9ctsMwznQ/XSCLDwdDH+Pbn+vj
         wk48BmTPDxD5Z2BTgHIxVwmJa7MRC1yyzfUm5Hg+dIhk/6yg2Ibp+L+vs1X1mCjMiffn
         0IfPFjVkCBX0bjsSqhUpw2VG/PsbUK/mT9twss7Zd8DcEDvDRj6LUcFxuS2NHb6eE7sG
         GjOxX1dhZ0iIUSMUqBZCM/LFJ/z+dOaz30VZ0EueduPhuLzoCKXYo3a+WxSWhwpwtFWF
         kPUw==
X-Gm-Message-State: AGRZ1gKEx4UYrHZn/2JxoJuQ5F2RtcNaMD03Cqa06AqU0PzlVGcwEhjO
        ACf63eEgxukPr3IX5GO0WTacMA==
X-Google-Smtp-Source: AJdET5cSGVow9fUda08X1lJboiayVLwst8Rcd+9NzAaajX1ENv0hZhTvKEjPA9hwOm+iB5w/UnTdxA==
X-Received: by 2002:a2e:59ca:: with SMTP id g71-v6mr6823012ljf.79.1541805084530;
        Fri, 09 Nov 2018 15:11:24 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:24 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 20/23] dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Sat, 10 Nov 2018 00:10:18 +0100
Message-Id: <20181109231021.11658-21-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the same idea for struct bug_entry, an architecture can opt-in
to use relative pointers in struct _ddebug. It only makes sense for 64
bit architectures, where one saves 16 bytes per entry (out of 40 or 56,
depending on CONFIG_JUMP_LABEL). The architecture is responsible for
providing a suitable DEFINE_DYNAMIC_DEBUG_METADATA macro in
<asm/dynamic_debug.h>.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/dynamic_debug.h | 14 ++++++++++++++
 lib/Kconfig.debug             |  3 +++
 lib/dynamic_debug.c           | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e1be30e8422b..cc4222a20aa1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -16,10 +16,17 @@ struct _ddebug {
 	 * These fields are used to drive the user interface
 	 * for selecting and displaying debug callsites.
 	 */
+#ifdef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
+	signed int modname_disp;
+	signed int function_disp;
+	signed int filename_disp;
+	signed int format_disp;
+#else
 	const char *modname;
 	const char *function;
 	const char *filename;
 	const char *format;
+#endif
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -70,6 +77,12 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev,
 			  const char *fmt, ...);
 
+#ifdef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
+#include <asm/dynamic_debug.h>
+#ifndef DEFINE_DYNAMIC_DEBUG_METADATA
+# error "asm/dynamic_debug.h must provide definition of DEFINE_DYNAMIC_DEBUG_METADATA"
+#endif
+#else
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
 	static struct _ddebug  __aligned(8)			\
 	__attribute__((section("__verbose"))) name = {		\
@@ -80,6 +93,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		.flags_lineno = _DPRINTK_FLAGS_LINENO_INIT,	\
 		_DPRINTK_KEY_INIT				\
 	}
+#endif
 
 #ifdef HAVE_JUMP_LABEL
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8224fd..1cac0ed659b6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -146,6 +146,9 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DYNAMIC_DEBUG_RELATIVE_POINTERS
+	bool
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9d4c840ff0de..61e61b36e479 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,6 +37,24 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
+#ifdef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
+static inline const char *dd_modname(const struct _ddebug *dd)
+{
+	return (const char *)dd + dd->modname_disp;
+}
+static inline const char *dd_function(const struct _ddebug *dd)
+{
+	return (const char *)dd + dd->function_disp;
+}
+static inline const char *dd_filename(const struct _ddebug *dd)
+{
+	return (const char *)dd + dd->filename_disp;
+}
+static inline const char *dd_format(const struct _ddebug *dd)
+{
+	return (const char *)dd + dd->format_disp;
+}
+#else
 static inline const char *dd_modname(const struct _ddebug *dd)
 {
 	return dd->modname;
@@ -53,6 +71,8 @@ static inline const char *dd_format(const struct _ddebug *dd)
 {
 	return dd->format;
 }
+#endif
+
 static inline unsigned dd_lineno(const struct _ddebug *dd)
 {
 	return dd->flags_lineno >> 8;
-- 
2.19.1.6.gbde171bbf5

