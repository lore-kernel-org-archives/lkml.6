Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69545C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F74C2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F74C2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbeG0A0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731846AbeG0AZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:25:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3B820891;
        Thu, 26 Jul 2018 23:06:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fipLP-00069O-Cx; Thu, 26 Jul 2018 19:06:51 -0400
Message-Id: <20180726230651.289642501@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 26 Jul 2018 19:06:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/7] ring_buffer: tracing: Inherit the tracing setting to next ring buffer
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Maintain the tracing on/off setting of the ring_buffer when switching
to the trace buffer snapshot.

Taking a snapshot is done by swapping the backup ring buffer
(max_tr_buffer). But since the tracing on/off setting is defined
by the ring buffer, when swapping it, the tracing on/off setting
can also be changed. This causes a strange result like below:

  /sys/kernel/debug/tracing # cat tracing_on
  1
  /sys/kernel/debug/tracing # echo 0 > tracing_on
  /sys/kernel/debug/tracing # cat tracing_on
  0
  /sys/kernel/debug/tracing # echo 1 > snapshot
  /sys/kernel/debug/tracing # cat tracing_on
  1
  /sys/kernel/debug/tracing # echo 1 > snapshot
  /sys/kernel/debug/tracing # cat tracing_on
  0

We don't touch tracing_on, but snapshot changes tracing_on
setting each time. This is an anomaly, because user doesn't know
that each "ring_buffer" stores its own tracing-enable state and
the snapshot is done by swapping ring buffers.

Link: http://lkml.kernel.org/r/153149929558.11274.11730609978254724394.stgit@devbox

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Cc: stable@vger.kernel.org
Fixes: debdd57f5145 ("tracing: Make a snapshot feature available from userspace")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[ Updated commit log and comment in the code ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 16 ++++++++++++++++
 kernel/trace/trace.c        |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index b72ebdff0b77..003d09ab308d 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -165,6 +165,7 @@ void ring_buffer_record_enable(struct ring_buffer *buffer);
 void ring_buffer_record_off(struct ring_buffer *buffer);
 void ring_buffer_record_on(struct ring_buffer *buffer);
 int ring_buffer_record_is_on(struct ring_buffer *buffer);
+int ring_buffer_record_is_set_on(struct ring_buffer *buffer);
 void ring_buffer_record_disable_cpu(struct ring_buffer *buffer, int cpu);
 void ring_buffer_record_enable_cpu(struct ring_buffer *buffer, int cpu);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6a46af21765c..0b0b688ea166 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3226,6 +3226,22 @@ int ring_buffer_record_is_on(struct ring_buffer *buffer)
 	return !atomic_read(&buffer->record_disabled);
 }
 
+/**
+ * ring_buffer_record_is_set_on - return true if the ring buffer is set writable
+ * @buffer: The ring buffer to see if write is set enabled
+ *
+ * Returns true if the ring buffer is set writable by ring_buffer_record_on().
+ * Note that this does NOT mean it is in a writable state.
+ *
+ * It may return true when the ring buffer has been disabled by
+ * ring_buffer_record_disable(), as that is a temporary disabling of
+ * the ring buffer.
+ */
+int ring_buffer_record_is_set_on(struct ring_buffer *buffer)
+{
+	return !(atomic_read(&buffer->record_disabled) & RB_BUFFER_OFF);
+}
+
 /**
  * ring_buffer_record_disable_cpu - stop all writes into the cpu_buffer
  * @buffer: The ring buffer to stop writes to.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 87cf25171fb8..823687997b01 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1373,6 +1373,12 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	arch_spin_lock(&tr->max_lock);
 
+	/* Inherit the recordable setting from trace_buffer */
+	if (ring_buffer_record_is_set_on(tr->trace_buffer.buffer))
+		ring_buffer_record_on(tr->max_buffer.buffer);
+	else
+		ring_buffer_record_off(tr->max_buffer.buffer);
+
 	swap(tr->trace_buffer.buffer, tr->max_buffer.buffer);
 
 	__update_max_tr(tr, tsk, cpu);
-- 
2.17.1


