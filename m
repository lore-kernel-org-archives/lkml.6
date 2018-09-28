Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28AFC1B0E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4840620657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oPuu/wEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4840620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeI1XOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:14:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60210 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbeI1XOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:14:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SGeaQN026292
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:49:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=dkM9JHm7fAniAfb3aa1Kn8b5mX3wW71h8uGQBXR/G9I=;
 b=oPuu/wEvZyuDQOB7DT7cJJGqpeGosOEHnADQRy156n2PBWIZ+1ZUusacqgsCJymEOEo5
 NhQqRoOAkS+Pa+ONfOmxR6oqfqn4ogQ6CwRzvBwpHI7RUZWUxyHB5td3yhJ962dB4p64
 h+9hzx3urARXgJV2YuMS7ZUzeQK9Yc/gWkU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msn3b0pxw-15
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:49:24 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.21) with Microsoft SMTP Server (TLS) id 14.3.319.2; Fri, 28 Sep
 2018 09:49:22 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)    id
 9299662E12DE; Fri, 28 Sep 2018 09:49:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2] trace_uprobe: support reference counter in fd-based uprobe
Date:   Fri, 28 Sep 2018 09:49:01 -0700
Message-ID: <20180928164901.19782-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v1 -> v2: Fix PMU_FORMAT_ATTR as Peter suggested

This patch enables uprobes with reference counter in fd-based uprobe.
Highest 32 bits of perf_event_attr.config is used to stored offset
of the reference count (semaphore).

Format information in /sys/bus/event_source/devices/uprobe/format/ is
updated to reflect this new feature.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/trace_events.h    |  3 +-
 kernel/events/core.c            | 49 ++++++++++++++++++++++++++-------
 kernel/trace/trace_event_perf.c |  7 +++--
 kernel/trace/trace_probe.h      |  3 +-
 kernel/trace/trace_uprobe.c     |  4 ++-
 5 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 78a010e19ed4..4130a5497d40 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -575,7 +575,8 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
 			       bool perf_type_tracepoint);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-extern int  perf_uprobe_init(struct perf_event *event, bool is_retprobe);
+extern int  perf_uprobe_init(struct perf_event *event,
+			     unsigned long ref_ctr_offset, bool is_retprobe);
 extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c80549bf82c6..65b30773af3e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8368,30 +8368,39 @@ static struct pmu perf_tracepoint = {
  *
  * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
  *                               if not set, create kprobe/uprobe
+ *
+ * The following values specify a reference counter (or semaphore in the
+ * terminology of tools like dtrace, systemtap, etc.) Userspace Statically
+ * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
+ *
+ * PERF_UPROBE_REF_CTR_OFFSET_BITS	# of bits in config as th offset
+ * PERF_UPROBE_REF_CTR_OFFSET_SHIFT	# of bits to shift left
  */
 enum perf_probe_config {
 	PERF_PROBE_CONFIG_IS_RETPROBE = 1U << 0,  /* [k,u]retprobe */
+	PERF_UPROBE_REF_CTR_OFFSET_BITS = 32,
+	PERF_UPROBE_REF_CTR_OFFSET_SHIFT = 64 - PERF_UPROBE_REF_CTR_OFFSET_BITS,
 };
 
 PMU_FORMAT_ATTR(retprobe, "config:0");
+#endif
 
-static struct attribute *probe_attrs[] = {
+#ifdef CONFIG_KPROBE_EVENTS
+static struct attribute *kprobe_attrs[] = {
 	&format_attr_retprobe.attr,
 	NULL,
 };
 
-static struct attribute_group probe_format_group = {
+static struct attribute_group kprobe_format_group = {
 	.name = "format",
-	.attrs = probe_attrs,
+	.attrs = kprobe_attrs,
 };
 
-static const struct attribute_group *probe_attr_groups[] = {
-	&probe_format_group,
+static const struct attribute_group *kprobe_attr_groups[] = {
+	&kprobe_format_group,
 	NULL,
 };
-#endif
 
-#ifdef CONFIG_KPROBE_EVENTS
 static int perf_kprobe_event_init(struct perf_event *event);
 static struct pmu perf_kprobe = {
 	.task_ctx_nr	= perf_sw_context,
@@ -8401,7 +8410,7 @@ static struct pmu perf_kprobe = {
 	.start		= perf_swevent_start,
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
-	.attr_groups	= probe_attr_groups,
+	.attr_groups	= kprobe_attr_groups,
 };
 
 static int perf_kprobe_event_init(struct perf_event *event)
@@ -8433,6 +8442,24 @@ static int perf_kprobe_event_init(struct perf_event *event)
 #endif /* CONFIG_KPROBE_EVENTS */
 
 #ifdef CONFIG_UPROBE_EVENTS
+PMU_FORMAT_ATTR(ref_ctr_offset, "config:32-63");
+
+static struct attribute *uprobe_attrs[] = {
+	&format_attr_retprobe.attr,
+	&format_attr_ref_ctr_offset.attr,
+	NULL,
+};
+
+static struct attribute_group uprobe_format_group = {
+	.name = "format",
+	.attrs = uprobe_attrs,
+};
+
+static const struct attribute_group *uprobe_attr_groups[] = {
+	&uprobe_format_group,
+	NULL,
+};
+
 static int perf_uprobe_event_init(struct perf_event *event);
 static struct pmu perf_uprobe = {
 	.task_ctx_nr	= perf_sw_context,
@@ -8442,12 +8469,13 @@ static struct pmu perf_uprobe = {
 	.start		= perf_swevent_start,
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
-	.attr_groups	= probe_attr_groups,
+	.attr_groups	= uprobe_attr_groups,
 };
 
 static int perf_uprobe_event_init(struct perf_event *event)
 {
 	int err;
+	unsigned long ref_ctr_offset;
 	bool is_retprobe;
 
 	if (event->attr.type != perf_uprobe.type)
@@ -8463,7 +8491,8 @@ static int perf_uprobe_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 
 	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
-	err = perf_uprobe_init(event, is_retprobe);
+	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
+	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
 	if (err)
 		return err;
 
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 69a3fe926e8c..76217bbef815 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -290,7 +290,8 @@ void perf_kprobe_destroy(struct perf_event *p_event)
 #endif /* CONFIG_KPROBE_EVENTS */
 
 #ifdef CONFIG_UPROBE_EVENTS
-int perf_uprobe_init(struct perf_event *p_event, bool is_retprobe)
+int perf_uprobe_init(struct perf_event *p_event,
+		     unsigned long ref_ctr_offset, bool is_retprobe)
 {
 	int ret;
 	char *path = NULL;
@@ -312,8 +313,8 @@ int perf_uprobe_init(struct perf_event *p_event, bool is_retprobe)
 		goto out;
 	}
 
-	tp_event = create_local_trace_uprobe(
-		path, p_event->attr.probe_offset, is_retprobe);
+	tp_event = create_local_trace_uprobe(path, p_event->attr.probe_offset,
+					     ref_ctr_offset, is_retprobe);
 	if (IS_ERR(tp_event)) {
 		ret = PTR_ERR(tp_event);
 		goto out;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 5f52668e165d..03b10f3201a5 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -412,6 +412,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 extern void destroy_local_trace_kprobe(struct trace_event_call *event_call);
 
 extern struct trace_event_call *
-create_local_trace_uprobe(char *name, unsigned long offs, bool is_return);
+create_local_trace_uprobe(char *name, unsigned long offs,
+			  unsigned long ref_ctr_offset, bool is_return);
 extern void destroy_local_trace_uprobe(struct trace_event_call *event_call);
 #endif
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3a7c73c40007..d09638706fe0 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1405,7 +1405,8 @@ static int unregister_uprobe_event(struct trace_uprobe *tu)
 
 #ifdef CONFIG_PERF_EVENTS
 struct trace_event_call *
-create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
+create_local_trace_uprobe(char *name, unsigned long offs,
+			  unsigned long ref_ctr_offset, bool is_return)
 {
 	struct trace_uprobe *tu;
 	struct path path;
@@ -1437,6 +1438,7 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
 
 	tu->offset = offs;
 	tu->path = path;
+	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->filename = kstrdup(name, GFP_KERNEL);
 	init_trace_event_call(tu, &tu->tp.call);
 
-- 
2.17.1

