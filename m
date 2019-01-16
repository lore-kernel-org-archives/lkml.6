Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CFDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74F720657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PtlhFtaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfAPQaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:30:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727530AbfAPQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:29:57 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0GGLsY2019650
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:29:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KFHTPxrgwBB4twvm8Ad7dIV8YDmfFJFH9z4PCrDj7AA=;
 b=PtlhFtaYTJJ9wHH4I1AkpooBk2PD1eb4a1oDqwfAbKwRzkj9GZvC3wbbySign182MiEP
 QI4wWpSNUj4Ps4p6D5rrdvnck6qcITZhYewNw/uEhwb5dVI4BSX+9BaAXGUdUqhq5UX4
 OYWfG7uZCIfnsOPMLgMi2hpVMpUogk6oJ6Y= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2q24rugp51-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:29:56 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 16 Jan 2019 08:29:52 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DE60B62E1D13; Wed, 16 Jan 2019 08:29:49 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <dsahern@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce PERF_RECORD_KSYMBOL
Date:   Wed, 16 Jan 2019 08:29:23 -0800
Message-ID: <20190116162931.1542429-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116162931.1542429-1-songliubraving@fb.com>
References: <20190116162931.1542429-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better performance analysis of dynamically JITed and loaded kernel
functions, such as BPF programs, this patch introduces
PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
register/unregister information to user space.

The following data structure is used for PERF_RECORD_KSYMBOL.

    /*
     * struct {
     *      struct perf_event_header        header;
     *      u64                             addr;
     *      u32                             len;
     *      u16                             ksym_type;
     *      u16                             flags;
     *      char                            name[];
     *      struct sample_id                sample_id;
     * };
     */

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h      | 13 +++++
 include/uapi/linux/perf_event.h | 26 ++++++++-
 kernel/events/core.c            | 98 ++++++++++++++++++++++++++++++++-
 3 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551a5add..77b2560f2dc7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1113,6 +1113,13 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 }
 
 extern void perf_event_mmap(struct vm_area_struct *vma);
+
+/* callback function to generate ksymbol name */
+typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
+extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
+			       bool unregister,
+			       perf_ksymbol_get_name_f get_name, void *data);
+
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1333,6 +1340,12 @@ static inline int perf_unregister_guest_info_callbacks
 (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
+
+typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
+static inline void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
+				      bool unregister,
+				      perf_ksymbol_get_name_f get_name,
+				      void *data)			{ }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9de8780ac8d9..68c4da0227c5 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -372,7 +372,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				ksymbol        :  1, /* include ksymbol events */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -965,9 +966,32 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_NAMESPACES			= 16,
 
+	/*
+	 * Record ksymbol register/unregister events:
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u32				len;
+	 *	u16				ksym_type;
+	 *	u16				flags;
+	 *	char				name[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_KSYMBOL			= 17,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
+enum perf_record_ksymbol_type {
+	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
+	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
+	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
+};
+
+#define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
+
 #define PERF_MAX_STACK_DEPTH		127
 #define PERF_MAX_CONTEXTS_PER_STACK	  8
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..ef27f2776999 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -385,6 +385,7 @@ static atomic_t nr_namespaces_events __read_mostly;
 static atomic_t nr_task_events __read_mostly;
 static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
+static atomic_t nr_ksymbol_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4235,7 +4236,7 @@ static bool is_sb_event(struct perf_event *event)
 
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
-	    attr->task ||
+	    attr->task || attr->ksymbol ||
 	    attr->context_switch)
 		return true;
 	return false;
@@ -4305,6 +4306,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (has_branch_stack(event))
 		dec = true;
+	if (event->attr.ksymbol)
+		atomic_dec(&nr_ksymbol_events);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -7650,6 +7653,97 @@ static void perf_log_throttle(struct perf_event *event, int enable)
 	perf_output_end(&handle);
 }
 
+/*
+ * ksymbol register/unregister tracking
+ */
+
+struct perf_ksymbol_event {
+	const char	*name;
+	int		name_len;
+	struct {
+		struct perf_event_header        header;
+		u64				addr;
+		u32				len;
+		u16				ksym_type;
+		u16				flags;
+	} event_id;
+};
+
+static int perf_event_ksymbol_match(struct perf_event *event)
+{
+	return event->attr.ksymbol;
+}
+
+static void perf_event_ksymbol_output(struct perf_event *event, void *data)
+{
+	struct perf_ksymbol_event *ksymbol_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	int ret;
+
+	if (!perf_event_ksymbol_match(event))
+		return;
+
+	perf_event_header__init_id(&ksymbol_event->event_id.header,
+				   &sample, event);
+	ret = perf_output_begin(&handle, event,
+				ksymbol_event->event_id.header.size);
+	if (ret)
+		return;
+
+	perf_output_put(&handle, ksymbol_event->event_id);
+	__output_copy(&handle, ksymbol_event->name, ksymbol_event->name_len);
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
+void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
+			perf_ksymbol_get_name_f get_name, void *data)
+{
+	struct perf_ksymbol_event ksymbol_event;
+	char name[KSYM_NAME_LEN];
+	u16 flags = 0;
+	int name_len;
+
+	if (!atomic_read(&nr_ksymbol_events))
+		return;
+
+	if (ksym_type >= PERF_RECORD_KSYMBOL_TYPE_MAX ||
+	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
+		goto err;
+
+	get_name(name, KSYM_NAME_LEN, data);
+	name_len = strlen(name) + 1;
+	while (!IS_ALIGNED(name_len, sizeof(u64)))
+		name[name_len++] = '\0';
+	BUILD_BUG_ON(KSYM_NAME_LEN % sizeof(u64));
+
+	if (unregister)
+		flags |= PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER;
+
+	ksymbol_event = (struct perf_ksymbol_event){
+		.name = name,
+		.name_len = name_len,
+		.event_id = {
+			.header = {
+				.type = PERF_RECORD_KSYMBOL,
+				.size = sizeof(ksymbol_event.event_id) +
+					name_len,
+			},
+			.addr = addr,
+			.len = len,
+			.ksym_type = ksym_type,
+			.flags = flags,
+		},
+	};
+
+	perf_iterate_sb(perf_event_ksymbol_output, &ksymbol_event, NULL);
+	return;
+err:
+	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -9900,6 +9994,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (is_cgroup_event(event))
 		inc = true;
+	if (event->attr.ksymbol)
+		atomic_inc(&nr_ksymbol_events);
 
 	if (inc) {
 		/*
-- 
2.17.1

