Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F2BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5100D2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfAVKSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:18:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfAVKSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:18:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAIGkT2907297
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:18:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAIGpw2907294;
        Tue, 22 Jan 2019 02:18:16 -0800
Date:   Tue, 22 Jan 2019 02:18:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-76193a94522f1d4edf2447a536f3f796ce56343b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ast@kernel.org, acme@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, daniel@iogearbox.net,
        songliubraving@fb.com, hpa@zytor.com, peterz@infradead.org
Reply-To: peterz@infradead.org, hpa@zytor.com, daniel@iogearbox.net,
          songliubraving@fb.com, acme@redhat.com, ast@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20190117161521.1341602-2-songliubraving@fb.com>
References: <20190117161521.1341602-2-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf, bpf: Introduce PERF_RECORD_KSYMBOL
Git-Commit-ID: 76193a94522f1d4edf2447a536f3f796ce56343b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  76193a94522f1d4edf2447a536f3f796ce56343b
Gitweb:     https://git.kernel.org/tip/76193a94522f1d4edf2447a536f3f796ce56343b
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Thu, 17 Jan 2019 08:15:13 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 17:00:57 -0300

perf, bpf: Introduce PERF_RECORD_KSYMBOL

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

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-2-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/perf_event.h      |  8 ++++
 include/uapi/linux/perf_event.h | 26 ++++++++++-
 kernel/events/core.c            | 98 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4eb88065a9b5..136fe0495374 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1122,6 +1122,10 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 }
 
 extern void perf_event_mmap(struct vm_area_struct *vma);
+
+extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
+			       bool unregister, const char *sym);
+
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1342,6 +1346,10 @@ static inline int perf_unregister_guest_info_callbacks
 (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
+
+typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
+static inline void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
+				      bool unregister, const char *sym)	{ }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ea19b5d491bf..1dee5c8f166b 100644
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
@@ -963,9 +964,32 @@ enum perf_event_type {
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
index bc525cd1615c..e04ab5f325cf 100644
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
@@ -7653,6 +7656,97 @@ static void perf_log_throttle(struct perf_event *event, int enable)
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
+			const char *sym)
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
+	strlcpy(name, sym, KSYM_NAME_LEN);
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
@@ -9912,6 +10006,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (is_cgroup_event(event))
 		inc = true;
+	if (event->attr.ksymbol)
+		atomic_inc(&nr_ksymbol_events);
 
 	if (inc) {
 		/*
