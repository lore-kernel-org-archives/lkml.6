Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA9C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55520645
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hF0Sqty3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SkqE3K7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F55520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeIIBQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:16:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIIBQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:16:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AA1B060B13; Sat,  8 Sep 2018 20:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438544;
        bh=dcL3X7HX8ZGPU0DB9PsLxCltgveK0h3iXWnF5pjRVPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hF0Sqty3xJkmFLuqZqpZOln93XWsjDwBx5FBF+dFP6vj4k7RVzS/YMNj3XZydOvHd
         h1No5e575pcy3JlBacATehZejm8Il5InjUT/Upui8POBla0GFeVbVjlgnbzJEd/4o/
         V/p+t1bX0MFHHmKY8Ouug6H0a4cvwvC+oP7s9xUQ=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CFC460C1C;
        Sat,  8 Sep 2018 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438534;
        bh=dcL3X7HX8ZGPU0DB9PsLxCltgveK0h3iXWnF5pjRVPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkqE3K7bQaKZCAfx06p9amAaL8dor2EU0VQi4ypFPCupbiJOg3YgUI13vkt8O54XF
         vRS8xd9nR87+YCstYqOmNNpaFmZYqDEepgQIVZDratLMUh3Xj77O5e/SftA/dYnazA
         xFAFvTt3ugOQyTUBxPJMiAXt/nMnJlb8ROJhBuwI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CFC460C1C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
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
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 6/6] dynamic_debug: Add flag for dynamic event tracing
Date:   Sun,  9 Sep 2018 01:57:07 +0530
Message-Id: <3f0166ff19ae44dbf92cbb239ebf25fa8a4f243c.1536430404.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging a specific driver or subsystem can be a lot easier
if we can trace events specific to that driver or subsystem.
This type of filtering can be achieved using existing
dynamic debug library which provides a way to filter based
on files, functions and modules.

Using this, provide an additional flag 'e' to filter event
tracing to specified input.

For example, tracing all IO read/write can be overwhelming
and of no use when debugging a specific driver or a subsystem.
So switch to dynamic event tracing for register accesses.

Example for tracing register accesses in drivers/soc/qcom/*
and the pstore output is given below:

  # dyndbg="file drivers/soc/qcom/* +e" trace_event=io tp_pstore
  # reboot -f
  # mount -t pstore pstore /sys/fs/pstore
  # cat /sys/fs/pstore/event-ramoops-0
    io_write: type=writel cpu=1 ts:1423596253 data=0xffff00000d2065a4 caller=qcom_smsm_probe+0x524/0x670
    io_write: type=writel cpu=1 ts:1423945889 data=0xffff00000d206608 caller=qcom_smsm_probe+0x524/0x670

Note: Tracing is activated only when flag is enabled either
through command line or through dynamic debug control file.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 include/asm-generic/io-instrumented.h | 28 +++++++++++++++++++++++++--
 include/linux/dynamic_debug.h         |  1 +
 lib/dynamic_debug.c                   |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/io-instrumented.h b/include/asm-generic/io-instrumented.h
index 7b050e2487ed..023f28571ea3 100644
--- a/include/asm-generic/io-instrumented.h
+++ b/include/asm-generic/io-instrumented.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_IO_INSTRUMENTED_H
 #define _ASM_GENERIC_IO_INSTRUMENTED_H
 
+#include <linux/dynamic_debug.h>
+
 #if defined(CONFIG_TRACING_EVENTS_IO)
 #include <linux/tracepoint-defs.h>
 
@@ -19,7 +21,7 @@ static inline void do_trace_io_read(const char *type, void *addr) {}
 #define __raw_write(v, a, _l)	({						\
 	volatile void __iomem *_a = (a);					\
 	if (io_tracepoint_active(__tracepoint_io_write))			\
-		do_trace_io_write(__stringify(write##_l), (void __force *)(_a));\
+		dynamic_io_write(__stringify(write##_l), (void __force *)(_a));	\
 	arch_raw_write##_l((v), _a);						\
 	})
 
@@ -32,7 +34,7 @@ static inline void do_trace_io_read(const char *type, void *addr) {}
 	_t __a;									\
 	const volatile void __iomem *_a = (a);					\
 	if (io_tracepoint_active(__tracepoint_io_read))				\
-		do_trace_io_read(__stringify(read##_l), (void __force *)(_a));	\
+		dynamic_io_read(__stringify(read##_l), (void __force *)(_a));	\
 	__a = arch_raw_read##_l(_a);						\
 	__a;									\
 	})
@@ -42,4 +44,26 @@ static inline void do_trace_io_read(const char *type, void *addr) {}
 #define __raw_readl(a)	__raw_read((a), l, u32)
 #define __raw_readq(a)	__raw_read((a), q, u64)
 
+#if defined(CONFIG_DYNAMIC_DEBUG) && defined(CONFIG_TRACING_EVENTS_IO)
+#define dynamic_io_write(type, addr)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, type);		\
+	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_EVENT))		\
+		do_trace_io_write(type, addr);				\
+} while (0)
+
+#define dynamic_io_read(type, addr)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, type);		\
+	if (unlikely(descriptor.flags & _DPRINTK_FLAGS_EVENT))		\
+		do_trace_io_read(type, addr);				\
+} while (0)
+#elif defined(CONFIG_TRACING_EVENTS_IO)
+#define dynamic_io_write(type, addr)	do_trace_io_write(type, addr)
+#define dynamic_io_read(type, addr)	do_trace_io_read(type, addr)
+#else
+#define dynamic_io_write(type, addr)
+#define dynamic_io_read(type, addr)
+#endif /* CONFIG_DYNAMIC_DEBUG && CONFIG_TRACING_EVENTS_IO */
+
 #endif /* _ASM_GENERIC_IO_INSTRUMENTED_H */
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2fd8006153c3..14e595c51002 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_EVENT		(1<<5)
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c7c96bc7654a..694957a8ae54 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -78,6 +78,7 @@ static inline const char *trim_prefix(const char *path)
 
 static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
+	{ _DPRINTK_FLAGS_EVENT, 'e' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

