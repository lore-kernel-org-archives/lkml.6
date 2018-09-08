Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3342C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCC220873
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eh873Sm8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fGmEfsSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCC220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIIBPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:15:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48184 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIIBPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:15:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C5DA760BE5; Sat,  8 Sep 2018 20:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438517;
        bh=C/LmQnYfl6uhopQ+JIJ/5yeYbPDjbnsOKnwIwHTeK20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh873Sm83cyaiaS1HhzOsrlPCUbANXxQQXlCzWDIHR3hxNoU/GuyJV5Ym5p/63qTV
         PIUkCkLCR/Vl6Zcu0w4Vn1Xfj0b6iVyBqZZQZxidJAQPfvRiiqCr0Oq5e/zu65YQSr
         tFzS9kcluDtE88GCFpJ7sazhUDYC8K00V6nMhgVY=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6FEC60BE2;
        Sat,  8 Sep 2018 20:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438511;
        bh=C/LmQnYfl6uhopQ+JIJ/5yeYbPDjbnsOKnwIwHTeK20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGmEfsSGvH+m8EHSnOJCoE7lE+VGDErRPsektqsELsKsR9SfNEsL6l+2dJbL96BDh
         tR1fij8qIELbUFxBCoSGHNNhYf624/nQDzHxHIy8zFK9LW4qSPo4xEPyQTkuu8CseD
         cepgLH7dzf4lgErgmFzIrSxAZMXDbYh0XR+gqinA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6FEC60BE2
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
Subject: [PATCH 4/6] arm64/io: Add tracepoint for register accesses
Date:   Sun,  9 Sep 2018 01:57:05 +0530
Message-Id: <84677d700f0e894142bf3460292c695bb1a946e4.1536430404.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic IO read/write i.e., __raw_{read,write}{b,l,w,q} are
typically used to read/write from/to memory mapped registers,
which can cause hangs or some undefined behaviour if access
unclocked. Tracing these register accesses can be very helpful
to debug such issues during initial development stages.
This can be used later for tracing arm IO register accesses.

Sample output format of register access trace is below:

  io_write: type=writel cpu=3 ts:1424714326 data=0xffff00000d1065a4 caller=qcom_smsm_probe+0x52c/0x678
  io_write: type=writel cpu=3 ts:1424962659 data=0xffff00000d106608 caller=qcom_smsm_probe+0x52c/0x678

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 arch/arm64/kernel/io.c         | 22 +++++++++++
 include/asm-generic/io-trace.h | 70 ++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 include/asm-generic/io-trace.h

diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index 79b17384effa..a9db07f66477 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -19,6 +19,10 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/sched/clock.h>
+
+#define CREATE_TRACE_POINTS
+#include <asm-generic/io-trace.h>
 
 /*
  * Copy data from IO memory space to "real" memory space.
@@ -106,3 +110,21 @@ void __memset_io(volatile void __iomem *dst, int c, size_t count)
 	}
 }
 EXPORT_SYMBOL(__memset_io);
+
+#if defined(CONFIG_TRACING_EVENTS_IO)
+void do_trace_io_write(const char *type, void *addr)
+{
+	trace_io_write(type, raw_smp_processor_id(), sched_clock(), addr,
+		       _RET_IP_);
+}
+EXPORT_SYMBOL(do_trace_io_write);
+EXPORT_TRACEPOINT_SYMBOL(io_write);
+
+void do_trace_io_read(const char *type, void *addr)
+{
+	trace_io_read(type, raw_smp_processor_id(), sched_clock(), addr,
+		      _RET_IP_);
+}
+EXPORT_SYMBOL(do_trace_io_read);
+EXPORT_TRACEPOINT_SYMBOL(io_read);
+#endif
diff --git a/include/asm-generic/io-trace.h b/include/asm-generic/io-trace.h
new file mode 100644
index 000000000000..e57b52d8976a
--- /dev/null
+++ b/include/asm-generic/io-trace.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM io
+
+#if !defined(CONFIG_TRACING_EVENTS_IO)
+#define NOTRACE
+#endif
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE io-trace
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH asm-generic
+
+#if !defined(_TRACE_IO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IO_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Tracepoint for generic IO read/write, i.e., __raw_{read,write}{b,l,w,q}()
+ */
+DECLARE_EVENT_CLASS(io_trace_class,
+
+	TP_PROTO(const char *type, int cpu, u64 ts, void *addr,
+		 unsigned long ret_ip),
+
+	TP_ARGS(type, cpu, ts, addr, ret_ip),
+
+	TP_STRUCT__entry(
+		__string(	type,		type	)
+		__field(	int,		cpu	)
+		__field(	u64,		ts	)
+		__field(	void *,		addr	)
+		__field(	unsigned long,	ret_ip	)
+	),
+
+	TP_fast_assign(
+		__assign_str(type, type);
+		__entry->cpu	= cpu;
+		__entry->ts	= ts;
+		__entry->addr	= addr;
+		__entry->ret_ip	= ret_ip;
+	),
+
+	TP_printk("type=%s cpu=%d ts:%llu data=0x%lx caller=%pS",
+		  __get_str(type), __entry->cpu, __entry->ts,
+		  (unsigned long)__entry->addr, (void *)__entry->ret_ip)
+);
+
+DEFINE_EVENT(io_trace_class, io_read,
+
+	TP_PROTO(const char *type, int cpu, u64 ts, void *addr,
+		 unsigned long ret_ip),
+
+	TP_ARGS(type, cpu, ts, addr, ret_ip)
+);
+
+DEFINE_EVENT(io_trace_class, io_write,
+
+	TP_PROTO(const char *type, int cpu, u64 ts, void *addr,
+		 unsigned long ret_ip),
+
+	TP_ARGS(type, cpu, ts, addr, ret_ip)
+);
+
+#endif /* _TRACE_IO_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

