Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF1C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645792151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645792151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404268AbeHGVKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:10:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403984AbeHGVKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:10:15 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8B5D13EE;
        Tue,  7 Aug 2018 18:54:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 11/21] ring_buffer: tracing: Inherit the tracing setting to next ring buffer
Date:   Tue,  7 Aug 2018 20:51:25 +0200
Message-Id: <20180807172331.471183203@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Fixes: debdd57f5145 ("tracing: Make a snapshot feature available from userspace")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[ Updated commit log and comment in the code ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ring_buffer.h |    1 +
 kernel/trace/ring_buffer.c  |   16 ++++++++++++++++
 kernel/trace/trace.c        |    6 ++++++
 3 files changed, 23 insertions(+)

--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -160,6 +160,7 @@ void ring_buffer_record_enable(struct ri
 void ring_buffer_record_off(struct ring_buffer *buffer);
 void ring_buffer_record_on(struct ring_buffer *buffer);
 int ring_buffer_record_is_on(struct ring_buffer *buffer);
+int ring_buffer_record_is_set_on(struct ring_buffer *buffer);
 void ring_buffer_record_disable_cpu(struct ring_buffer *buffer, int cpu);
 void ring_buffer_record_enable_cpu(struct ring_buffer *buffer, int cpu);
 
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3110,6 +3110,22 @@ int ring_buffer_record_is_on(struct ring
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
@@ -1366,6 +1366,12 @@ update_max_tr(struct trace_array *tr, st
 
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


