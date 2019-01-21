Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30BBC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B9C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="MLCtA6Gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfAUMfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:35:30 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:38517 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfAUMfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1T5nvD+tCQpKyRBufKxqWyTlUEXfJKcqTt8V3VNO5N0=; b=MLCtA6GrCVueSgEKaFBHvw38eU
        ByfiCIx0Dpt27Fwz2IIOmz7BVLuyfzxed2ecQXm3YuohNcHJ97XqcWFbZVcuCm9gEG2F5nNo7GX89
        NHOu52wQbzthyz5YM384i+qbmaYRMOYrMZ7e+3xgzKmwIxtYUj5OSfjoMmRPC+PNla1c4PrgGoX/F
        Zxb4bnGSmMKyYFXt3iA19I8d5S4VFRbZdRI43sogM2IgUFSZnxFYB9gbVVH1IIV8trbaB/WtsQ84P
        Q+ueMcoRTq0eFRV9bpH0ToPgwepbGS+dQK1PZKSMecNMtU5bwrGrUpmgchdTX8TMzfwwqaCfP9eZW
        od2i0kRw==;
Received: from lakka.kapsi.fi ([2001:67c:1be8::1] ident=Debian-exim)
        by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mcfrisk@kapsi.fi>)
        id 1glYnJ-0003r1-UE; Mon, 21 Jan 2019 14:35:13 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.84_2)
        (envelope-from <mcfrisk@lakka.kapsi.fi>)
        id 1glYnJ-0004Mv-PI; Mon, 21 Jan 2019 14:35:13 +0200
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ftrace: Add an option for tracing console latencies
Date:   Mon, 21 Jan 2019 14:35:13 +0200
Message-Id: <1548074113-16599-5-git-send-email-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1548074113-16599-1-git-send-email-Viktor.Rosendahl@bmw.de>
References: <1548074113-16599-1-git-send-email-Viktor.Rosendahl@bmw.de>
X-SA-Exim-Connect-IP: 2001:67c:1be8::1
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new option CONFIG_TRACE_CONSOLE_LATENCY will enable the latency
tracers to trace the console latencies. Previously this has always been
implicitely disabled. I guess this is because they are considered
to be well known and unavoidable.

However, for some organizations it may nevertheless be desirable to
trace them. Basically, we want to be able to tell that there are
latencies in the system under test because someone has incorrectly
enabled the serial console.

Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
---
 include/linux/irqflags.h | 13 +++++++++++++
 kernel/printk/printk.c   |  5 +++--
 kernel/trace/Kconfig     | 11 +++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..791bee718448 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -73,6 +73,19 @@ do {						\
 # define start_critical_timings() do { } while (0)
 #endif
 
+#ifdef CONFIG_TRACE_CONSOLE_LATENCY
+
+#define console_stop_critical_timings()  do {} while (0)
+#define console_start_critical_timings() do {} while (0)
+
+#else /* !CONFIG_TRACE_CONSOLE_LATENCY */
+
+/* don't trace print latency */
+#define console_stop_critical_timings()  stop_critical_timings()
+#define console_start_critical_timings() start_critical_timings()
+
+#endif /* !CONFIG_TRACE_CONSOLE_LATENCY */
+
 /*
  * Wrap the arch provided IRQ routines to provide appropriate checks.
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d170374ceb..303b8f656009 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2404,9 +2404,10 @@ void console_unlock(void)
 		 */
 		console_lock_spinning_enable();
 
-		stop_critical_timings();	/* don't trace print latency */
+		/* don't trace print latency if it's disabled */
+		console_stop_critical_timings();
 		call_console_drivers(ext_text, ext_len, text, len);
-		start_critical_timings();
+		console_start_critical_timings();
 
 		if (console_lock_spinning_disable_and_check()) {
 			printk_safe_exit_irqrestore(flags);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index ca80cb08bd39..5063b32de66c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -244,6 +244,17 @@ config PREEMPT_TRACER
 	  modification of /sys/kernel/debug/tracing/trace through the inotify
 	  interface.
 
+	config TRACE_CONSOLE_LATENCY
+	bool "Do not turn off latency tracing for the console"
+	default n
+	depends on IRQSOFF_TRACER || PREEMPT_TRACER
+	help
+	  Some of the console drivers will cause long unavoidable
+	  latencies because they are slow and need to print immediately
+	  in a serialized manner. Because of this their latencies are not
+	  traced by default. This option will change behavior so that
+	  they are traced.
+
 config SCHED_TRACER
 	bool "Scheduling Latency Tracer"
 	select GENERIC_TRACER
-- 
2.17.1

