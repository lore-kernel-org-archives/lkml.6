Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CFFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E289214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BbQP5rkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E289214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbeKVGbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:31:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59448 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388061AbeKVGbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:31:32 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALJtEae013310
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:55:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KLR1Y0qoqMUiYR6nwwD3VxJLBeRRBS+jjHAhQbHb/Oc=;
 b=BbQP5rkI6GV0L+OwFZHAcnOQE9Mq2g/LQWqomylo6EOdznq7heYit5kaadAyTyij7FY5
 ZdQhSS2gMhDbvoK/EA5iOuaJeF63o2esmOQ5UGBrPjQuPc9kPz6Y1K9YAuOrSYW7cARC
 uL0fANNEGe4dNcXk/Hqs9e123oD3Jf2JS9s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nwc1cre9r-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:55:49 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 21 Nov 2018 11:55:35 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C49C262E013D; Wed, 21 Nov 2018 11:55:33 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <acme@kernel.org>, <peterz@infradead.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH perf,bpf 1/5] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Date:   Wed, 21 Nov 2018 11:54:58 -0800
Message-ID: <20181121195502.3259930-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121195502.3259930-1-songliubraving@fb.com>
References: <20181121195502.3259930-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better performance analysis of BPF programs, this patch introduces
PERF_RECORD_BPF_EVENT, a new perf_event_type that exposes BPF program
load/unload information to user space.

        /*
         * Record different types of bpf events:
         *   enum perf_bpf_event_type {
         *      PERF_BPF_EVENT_UNKNOWN          = 0,
         *      PERF_BPF_EVENT_PROG_LOAD        = 1,
         *      PERF_BPF_EVENT_PROG_UNLOAD      = 2,
         *   };
         *
         * struct {
         *      struct perf_event_header header;
         *      u16 type;
         *      u16 flags;
         *      u32 id;  // prog_id or map_id
         * };
         */
        PERF_RECORD_BPF_EVENT                   = 17,

PERF_RECORD_BPF_EVENT contains minimal information about the BPF program.
Perf utility (or other user space tools) should listen to this event and
fetch more details about the event via BPF syscalls
(BPF_PROG_GET_FD_BY_ID, BPF_OBJ_GET_INFO_BY_FD, etc.). We decided not to
include all details of bpf_prog_info in the perf ring buffer because
the interface is under fast developments. Perf utility uses the BPF
syscalls to gather information of already loaded programs. Including
similar information in the perf ring buffer introduces a second ABI.

We picked PERF_RECORD_BPF_EVENT over tracepoints because PERF_RECORD is a
stable ABI; while tracepoints are more likely to change in the future.

Currently, PERF_RECORD_BPF_EVENT only support two events:
PERF_BPF_EVENT_PROG_LOAD and PERF_BPF_EVENT_PROG_UNLOAD. But it can be
easily extended to support more events.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h      |  5 ++
 include/uapi/linux/perf_event.h | 27 ++++++++++-
 kernel/bpf/syscall.c            |  4 ++
 kernel/events/core.c            | 82 ++++++++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..a3126fd5b7f1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1113,6 +1113,9 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 }
 
 extern void perf_event_mmap(struct vm_area_struct *vma);
+extern void perf_event_bpf_event(enum perf_bpf_event_type type,
+				 u16 flags, u32 id);
+
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1333,6 +1336,8 @@ static inline int perf_unregister_guest_info_callbacks
 (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
+static inline void perf_event_bpf_event(enum perf_bpf_event_type type,
+					u16 flags, u32 id)		{ }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f35eb72739c0..72a7da2b713f 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -372,7 +372,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				bpf_event      :  1, /* include bpf events */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -963,9 +964,33 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_NAMESPACES			= 16,
 
+	/*
+	 * Record different types of bpf events:
+	 *  enum perf_bpf_event_type {
+	 *     PERF_BPF_EVENT_UNKNOWN		= 0,
+	 *     PERF_BPF_EVENT_PROG_LOAD		= 1,
+	 *     PERF_BPF_EVENT_PROG_UNLOAD	= 2,
+	 *  };
+	 *
+	 * struct {
+	 *	struct perf_event_header header;
+	 *	u16 type;
+	 *	u16 flags;
+	 *	u32 id;  // prog_id or map_id
+	 * };
+	 */
+	PERF_RECORD_BPF_EVENT			= 17,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
+enum perf_bpf_event_type {
+	PERF_BPF_EVENT_UNKNOWN		= 0,
+	PERF_BPF_EVENT_PROG_LOAD	= 1,
+	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
+	PERF_BPF_EVENT_MAX,		/* non-ABI */
+};
+
 #define PERF_MAX_STACK_DEPTH		127
 #define PERF_MAX_CONTEXTS_PER_STACK	  8
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 18e3be193a05..b37051a13be6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1101,9 +1101,12 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
 {
 	if (atomic_dec_and_test(&prog->aux->refcnt)) {
+		int prog_id = prog->aux->id;
+
 		/* bpf_prog_free_id() must be called first */
 		bpf_prog_free_id(prog, do_idr_lock);
 		bpf_prog_kallsyms_del_all(prog);
+		perf_event_bpf_event(PERF_BPF_EVENT_PROG_UNLOAD, 0, prog_id);
 
 		call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
 	}
@@ -1441,6 +1444,7 @@ static int bpf_prog_load(union bpf_attr *attr)
 	}
 
 	bpf_prog_kallsyms_add(prog);
+	perf_event_bpf_event(PERF_BPF_EVENT_PROG_LOAD, 0, prog->aux->id);
 	return err;
 
 free_used_maps:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a97f34bc14c..54667be6669b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -385,6 +385,7 @@ static atomic_t nr_namespaces_events __read_mostly;
 static atomic_t nr_task_events __read_mostly;
 static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
+static atomic_t nr_bpf_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4235,7 +4236,7 @@ static bool is_sb_event(struct perf_event *event)
 
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
-	    attr->task ||
+	    attr->task || attr->bpf_event ||
 	    attr->context_switch)
 		return true;
 	return false;
@@ -4305,6 +4306,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (has_branch_stack(event))
 		dec = true;
+	if (event->attr.bpf_event)
+		atomic_dec(&nr_bpf_events);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -7650,6 +7653,81 @@ static void perf_log_throttle(struct perf_event *event, int enable)
 	perf_output_end(&handle);
 }
 
+/*
+ * bpf load/unload tracking
+ */
+
+struct perf_bpf_event {
+	struct {
+		struct perf_event_header        header;
+		u16 type;
+		u16 flags;
+		u32 id;
+	} event_id;
+};
+
+static int perf_event_bpf_match(struct perf_event *event)
+{
+	return event->attr.bpf_event;
+}
+
+static void perf_event_bpf_output(struct perf_event *event,
+				   void *data)
+{
+	struct perf_bpf_event *bpf_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	int size = bpf_event->event_id.header.size;
+	int ret;
+
+	if (!perf_event_bpf_match(event))
+		return;
+
+	perf_event_header__init_id(&bpf_event->event_id.header, &sample, event);
+	ret = perf_output_begin(&handle, event,
+				bpf_event->event_id.header.size);
+	if (ret)
+		goto out;
+
+	perf_output_put(&handle, bpf_event->event_id);
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+out:
+	bpf_event->event_id.header.size = size;
+}
+
+static void perf_event_bpf(struct perf_bpf_event *bpf_event)
+{
+	perf_iterate_sb(perf_event_bpf_output,
+		       bpf_event,
+		       NULL);
+}
+
+void perf_event_bpf_event(enum perf_bpf_event_type type, u16 flags, u32 id)
+{
+	struct perf_bpf_event bpf_event;
+
+	if (!atomic_read(&nr_bpf_events))
+		return;
+
+	if (type <= PERF_BPF_EVENT_UNKNOWN || type >= PERF_BPF_EVENT_MAX)
+		return;
+
+	bpf_event = (struct perf_bpf_event){
+		.event_id = {
+			.header = {
+				.type = PERF_RECORD_BPF_EVENT,
+				.size = sizeof(bpf_event.event_id),
+			},
+			.type = type,
+			.flags = flags,
+			.id = id,
+		},
+	};
+	perf_event_bpf(&bpf_event);
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -9871,6 +9949,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (is_cgroup_event(event))
 		inc = true;
+	if (event->attr.bpf_event)
+		atomic_inc(&nr_bpf_events);
 
 	if (inc) {
 		/*
-- 
2.17.1

