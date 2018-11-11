Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B14AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC01620818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC01620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeKLGP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:15:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50902 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730637AbeKLFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:27 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000oO-H7; Sun, 11 Nov 2018 19:58:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001ma-B3; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Tom Zanussi" <tom.zanussi@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Hiraku Toyooka" <hiraku.toyooka@cybertrust.co.jp>,
        "Ingo Molnar" <mingo@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.869359665@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 294/366] ring_buffer: tracing: Inherit the tracing
 setting to next ring buffer
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 73c8d8945505acdcbae137c2e00a1232e0be709f upstream.

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
Fixes: debdd57f5145 ("tracing: Make a snapshot feature available from userspace")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[ Updated commit log and comment in the code ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 16 ++++++++++++++++
 kernel/trace/trace.c        |  6 ++++++
 3 files changed, 23 insertions(+)

--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -162,6 +162,7 @@ void ring_buffer_record_enable(struct ri
 void ring_buffer_record_off(struct ring_buffer *buffer);
 void ring_buffer_record_on(struct ring_buffer *buffer);
 int ring_buffer_record_is_on(struct ring_buffer *buffer);
+int ring_buffer_record_is_set_on(struct ring_buffer *buffer);
 void ring_buffer_record_disable_cpu(struct ring_buffer *buffer, int cpu);
 void ring_buffer_record_enable_cpu(struct ring_buffer *buffer, int cpu);
 
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3165,6 +3165,22 @@ int ring_buffer_record_is_on(struct ring
 }
 
 /**
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
+/**
  * ring_buffer_record_disable_cpu - stop all writes into the cpu_buffer
  * @buffer: The ring buffer to stop writes to.
  * @cpu: The CPU buffer to stop
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1046,6 +1046,12 @@ update_max_tr(struct trace_array *tr, st
 
 	arch_spin_lock(&tr->max_lock);
 
+	/* Inherit the recordable setting from trace_buffer */
+	if (ring_buffer_record_is_set_on(tr->trace_buffer.buffer))
+		ring_buffer_record_on(tr->max_buffer.buffer);
+	else
+		ring_buffer_record_off(tr->max_buffer.buffer);
+
 	buf = tr->trace_buffer.buffer;
 	tr->trace_buffer.buffer = tr->max_buffer.buffer;
 	tr->max_buffer.buffer = buf;

