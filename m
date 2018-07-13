Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E084ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA97C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0JTEa0GJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA97C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeGMQoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbeGMQoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:44:00 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9626D20850;
        Fri, 13 Jul 2018 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531499318;
        bh=ZmQGJMHOih9M0KNB61xjV675a9eoetqcRTa0LzDn0RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0JTEa0GJ1nvgbPUISuf0QIAXR0SSgI/PwHsNGGb1azFz+UTuK15Zwc3lNn8FztgV6
         HHzpJ0bxnHVpVC6p9qkN1fL/Ad7r21Aid2iWqlQVFXxIST4UQOWgrNUd4/kMGDzkXN
         eSkAUUvlO20Lp3IFSD/Dgj0WUv5h3cAD+mIvjOrg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/3] [BUGFIX] ring_buffer: tracing: Inherit the tracing setting to next ring buffer
Date:   Sat, 14 Jul 2018 01:28:15 +0900
Message-Id: <153149929558.11274.11730609978254724394.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153149923649.11274.14970833360963898112.stgit@devbox>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inherit the tracing on/off setting on ring_buffer to next
trace buffer when taking a snapshot.

Taking a snapshot is done by swapping with backup ring buffer
(max_tr_buffer). But since the tracing on/off setting is set
in the ring buffer, when swapping it, tracing on/off setting
can also be changed. This causes a strange result like below;

  /sys/kernel/debug/tracing # cat tracing_on
  1
  /sys/kernel/debug/tracing # echo 0 > tracing_on
  /sys/kernel/debug/tracing # echo 1 > snapshot
  /sys/kernel/debug/tracing # cat tracing_on
  1
  /sys/kernel/debug/tracing # echo 1 > snapshot
  /sys/kernel/debug/tracing # cat tracing_on
  0

We don't touch tracing_on, but snapshot changes tracing_on
setting each time. This must be a bug, because user never know
that each "ring_buffer" stores tracing-enable state and
snapshot is done by swapping ring buffers.

This patch fixes above strange behavior.

Fixes: commit debdd57f5145 ("tracing: Make a snapshot feature available from userspace")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Cc: stable@vger.kernel.org
---
 include/linux/ring_buffer.h |    1 +
 kernel/trace/ring_buffer.c  |   12 ++++++++++++
 kernel/trace/trace.c        |    6 ++++++
 3 files changed, 19 insertions(+)

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
index 6a46af21765c..4038ed74ab95 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3227,6 +3227,18 @@ int ring_buffer_record_is_on(struct ring_buffer *buffer)
 }
 
 /**
+ * ring_buffer_record_is_set_on - return true if the ring buffer is set writable
+ * @buffer: The ring buffer to see if write is set enabled
+ *
+ * Returns true if the ring buffer is set writable by ring_buffer_record_on().
+ * Note that this does NOT mean it is in a writable state.
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
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2556d8c097d2..bbd5a94a7ef1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1378,6 +1378,12 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 	arch_spin_lock(&tr->max_lock);
 
+	/* Inherit the recordable setting from trace_buffer */
+	if (ring_buffer_record_is_set_on(tr->trace_buffer.buffer))
+		ring_buffer_record_on(tr->max_buffer.buffer);
+	else
+		ring_buffer_record_off(tr->max_buffer.buffer);
+
 	swap(tr->trace_buffer.buffer, tr->max_buffer.buffer);
 
 	__update_max_tr(tr, tsk, cpu);

