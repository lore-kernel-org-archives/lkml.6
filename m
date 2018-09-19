Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEBBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B2821522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VZwmP4V8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B2821522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbeITDpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43238 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbeITDpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so6148391edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rhTN80KIGMXY8QDeATsRJD8wo06KKUTBtr9XgTEHd6o=;
        b=VZwmP4V8U7Tvpa3DekdlZWV0jFduXrzVJLgMdDAu4s6obAETRX56LpaRQ6kTVQgs4l
         tgvv9sHJwKYIfkCDN+khlKy9PxG6+B0HwxME9pXHViCK5//H7FIAiFblYJby37TxSYfI
         6P3hWVeWyJGiBsh2luEGqJ5aQEZEaOEyGTwVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rhTN80KIGMXY8QDeATsRJD8wo06KKUTBtr9XgTEHd6o=;
        b=O6SvgqpLZUuLIVP0I1EEcoR/324x1ha6ObVlYaFYdfYp7VRNFOFogEgGR9zj3YZpuW
         CdH5RMCGeXrCT1SiTCHNQLwHbuhI42JIb45CRUk2vQ0ZtGQHTEhF2nwslxSMv9/yATJI
         QFrrKYnGa++3bROT9mVSymG0G8lLoXqhcKYs98NiLaAmHEEZDdWNKs9IYhLZ5UXrpQyt
         OYbPBAjBNZK8OkyqtFfBtyc2NqHjIsWjarO/HXhpLMYIO2sr+01pOPu1C1A2d7iTdzvy
         Gtg7CSUxiwqf7KVsUiMSfYvA2YI8iaCyvkMrVTHLJvgiu9ik/OTVKmIWsvLE7is9ygcd
         eVBA==
X-Gm-Message-State: APzg51D1RIf9bhbY1L5vRE2X5azUR2MuMmU/6yFVUSyIXKXaGWmIOOU0
        MdLWGvHoFA4XcwabxEnzVqXV0g==
X-Google-Smtp-Source: ANB0VdaO25QPGP5IfB690suO07EsEmzsTspLoGOdAZbCQqzznF+1slnfQGill1vtNvio87vzbTrzrA==
X-Received: by 2002:a50:d01a:: with SMTP id j26-v6mr63252008edf.15.1537394736052;
        Wed, 19 Sep 2018 15:05:36 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:35 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 20/22] dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Thu, 20 Sep 2018 00:04:42 +0200
Message-Id: <20180919220444.23190-21-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
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
index 4966c4fbe7f7..a4113f746826 100644
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
2.16.4

