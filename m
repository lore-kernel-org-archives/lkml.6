Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A17C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394A0218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qs8hcmsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbeLTS30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:29:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56736 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389097AbeLTS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:29:22 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBKIPYoX014252
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:29:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=vmv2Jmzw92ALmjS4UtH5tIE6j+Wo0B0S2fP7rXtd1OQ=;
 b=qs8hcmsXvAAIzRRMvoKeP02v0h8UU7qJCl0Ffcbehp6r2mXGqeEySY45Pn3H5hfiEmYl
 uvM5vcRsmfggCXskrRF7m5dgbgtdLLZz6e3hPD/T9rshM+LMo6fLrap6xHOdti5OgUeK
 lnmJ8lizEUkmPwukEzPxja+9q/uVyp0Btvg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pgey9gcn9-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:29:21 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 20 Dec 2018 10:29:11 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1F09462E0FD0; Thu, 20 Dec 2018 10:29:07 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 perf, bpf-next 1/7] perf, bpf: Introduce PERF_RECORD_KSYMBOL
Date:   Thu, 20 Dec 2018 10:28:58 -0800
Message-ID: <20181220182904.4193196-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220182904.4193196-1-songliubraving@fb.com>
References: <20181220182904.4193196-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_09:,,
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
     *      u64                             len;
     *      char                            name[];
     *      struct sample_id                sample_id;
     * };
     */

PERF_RECORD_KSYMBOL uses 4 more bits (bit 3-6) in header.misc:
Bit 3 is used to differentiate register vs. unregister. Bit 4-6
encode types of the ksymbol. The following are details of the
assignment of these bits:

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h      | 12 ++++
 include/uapi/linux/perf_event.h | 23 +++++++-
 kernel/events/core.c            | 98 ++++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..037863e69bb2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1113,6 +1113,12 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 }
 
 extern void perf_event_mmap(struct vm_area_struct *vma);
+
+/* callback function to generate ksymbol name */
+typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
+extern void perf_event_ksymbol(int type, u64 addr, u64 len, bool unregister,
+			       perf_ksymbol_get_name_f get_name, void *data);
+
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1333,6 +1339,12 @@ static inline int perf_unregister_guest_info_callbacks
 (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
+
+typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
+static inline void perf_event_ksymbol(int type, u64 addr, u64 len,
+				      bool unregister,
+				      perf_ksymbol_get_name_f get_name,
+				      void *data) 			{ }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9de8780ac8d9..6c9e327e87ed 100644
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
@@ -648,11 +649,18 @@ struct perf_event_mmap_page {
  *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
  *   PERF_RECORD_MISC_FORK_EXEC  - PERF_RECORD_FORK event (perf internal)
  *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
+ *   PERF_RECORD_MISC_KSYMBOL_*  - PERF_RECORD_KSYMBOL event
  */
 #define PERF_RECORD_MISC_MMAP_DATA		(1 << 13)
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_FORK_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
+
+#define PERF_RECORD_MISC_KSYMBOL_UNREGISTER	(1 << 3)
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_MASK	(7 << 4)
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_UNKNOWN	(0 << 4)
+#define PERF_RECORD_MISC_KSYMBOL_TYPE_BPF	(1 << 4)
+
 /*
  * These PERF_RECORD_MISC_* flags below are safely reused
  * for the following events:
@@ -965,6 +973,19 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_NAMESPACES			= 16,
 
+	/*
+	 * Record ksymbol register/unregister events:
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u64				len;
+	 *	char				name[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_KSYMBOL			= 17,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 84530ab358c3..c0ac6dee367c 100644
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
+		u64				len;
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
+void perf_event_ksymbol(int ksym_type, u64 addr, u64 len, bool unregister,
+			perf_ksymbol_get_name_f get_name, void *data)
+{
+	struct perf_ksymbol_event ksymbol_event;
+	char name[KSYM_NAME_LEN];
+	int name_len;
+
+	if (!atomic_read(&nr_ksymbol_events))
+		return;
+
+	if (ksym_type & ~PERF_RECORD_MISC_KSYMBOL_TYPE_MASK)
+		goto err;
+
+	switch (ksym_type & PERF_RECORD_MISC_KSYMBOL_TYPE_MASK) {
+	case PERF_RECORD_MISC_KSYMBOL_TYPE_BPF:
+		break;
+	case PERF_RECORD_MISC_KSYMBOL_TYPE_UNKNOWN:
+	default:
+		goto err;
+	}
+
+	get_name(name, KSYM_NAME_LEN, data);
+	name_len = strlen(name) + 1;
+	while (!IS_ALIGNED(name_len, sizeof(u64)))
+		name[name_len++] = '\0';
+	BUILD_BUG_ON(KSYM_NAME_LEN % sizeof(u64));
+
+	ksymbol_event = (struct perf_ksymbol_event){
+		.name = name,
+		.name_len = name_len,
+		.event_id = {
+			.header = {
+				.type = PERF_RECORD_KSYMBOL,
+				.misc = ksym_type,
+				.size = sizeof(ksymbol_event.event_id) +
+					name_len,
+			},
+			.addr = addr,
+			.len = len,
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

