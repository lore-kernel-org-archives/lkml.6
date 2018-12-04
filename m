Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1A5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAD52082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Gbxc+l3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAD52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeLDTyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:54:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25421 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeLDTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:54:12 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB4JrsGX009406
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 11:54:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=tQKi4Udz0807FiwGgQcPRYS8lVUJNDOBc/CmlTen8yc=;
 b=Gbxc+l3ChNOSXXGvLtUd4UhktU/0s0R53DDu9wIrI5QlBPlSOfALncGph7MZ5Rouz2pz
 x6bOxu0aBWq04XiQqnxI6T0dtt92pFrzFMBqGHlpNr/CBfLQBYs4gJu/Ko/8DLDzHvaM
 JV592S64hV6OtyeyRzg6g8qsRCnBWkEqoMM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p5x89rdg8-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:54:09 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 4 Dec 2018 11:54:08 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 8262462E176A; Tue,  4 Dec 2018 11:54:02 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <acme@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 perf,bpf 1/3] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Date:   Tue, 4 Dec 2018 11:53:53 -0800
Message-ID: <20181204195355.4079788-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204195355.4079788-1-songliubraving@fb.com>
References: <20181204195355.4079788-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_08:,,
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

Each BPF program may contain up to BPF_MAX_SUBPROGS (256) sub programs.
The following example shows kernel symbols for a BPF program with 7
sub programs:

    ffffffffa0257cf9 t bpf_prog_b07ccb89267cf242_F
    ffffffffa02592e1 t bpf_prog_2dcecc18072623fc_F
    ffffffffa025b0e9 t bpf_prog_bb7a405ebaec5d5c_F
    ffffffffa025dd2c t bpf_prog_a7540d4a39ec1fc7_F
    ffffffffa025fcca t bpf_prog_05762d4ade0e3737_F
    ffffffffa026108f t bpf_prog_db4bd11e35df90d4_F
    ffffffffa0263f00 t bpf_prog_89d64e4abf0f0126_F
    ffffffffa0257cf9 t bpf_prog_ae31629322c4b018__dummy_tracepoi

Note that these sub programs are not allocated in contiguous memory
ranges. Instead, each of them occupies separate page(s). The starting
address of these sub programs are randomized within the page(s) for
security reasons.

The following data structure is used for PERF_RECORD_BPF_EVENT. It is
generated for each _sub program_:

        /*
         * Record different types of bpf events:
         *  enum perf_bpf_event_type {
         *     PERF_BPF_EVENT_UNKNOWN           = 0,
         *     PERF_BPF_EVENT_PROG_LOAD         = 1,
         *     PERF_BPF_EVENT_PROG_UNLOAD       = 2,
         *  };
         *
         * struct {
         *      struct perf_event_header header;
         *      u32                             type;
         *      u32                             flags;
         *      u32                             id; // prog_id or other id
         *      u32                             sub_id; // subprog id
         *
         *      // for bpf_prog types, bpf prog or subprog
         *      u8                              tag[BPF_TAG_SIZE];
         *      u64                             addr;
         *      u64                             len;
         *      char                            name[];
         *      struct sample_id                sample_id;
         * };
         */

This data is designed for different use cases:

  1. For simple perf profiling, addr, len, and name[] works similar to
     PERF_RECORD_MMAP. These raw records are stored in perf.data file.
  2. For perf annotation and other cases that needs more details of the
     BPF program, id and sub_id are used to extract detailed information
     of the prog through sys_bpf(BPF_OBJ_GET_INFO_BY_FD). User space
     tools are responsible to save the detailed information properly, as
     these information will not be available after the bpf program is
     unloaded.

This follows the existing perf model of keeping the ordered records
with enough information for profiling while keeping keys for reliably
finding extra, more voluminous information for further analysis, like
raw jitted binaries augmented with line numbers that can be used for
disassembly, annotation, etc

Currently, PERF_RECORD_BPF_EVENT only support two events:
PERF_BPF_EVENT_PROG_LOAD and PERF_BPF_EVENT_PROG_UNLOAD. But it can be
easily extended to support more events.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/filter.h          |   1 +
 include/linux/perf_event.h      |  10 +++
 include/uapi/linux/perf_event.h |  35 ++++++++-
 kernel/bpf/core.c               |   2 +-
 kernel/bpf/syscall.c            |   3 +
 kernel/events/core.c            | 123 +++++++++++++++++++++++++++++++-
 6 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 448dcc448f1f..ef2d8ef01329 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -955,6 +955,7 @@ bpf_address_lookup(unsigned long addr, unsigned long *size,
 
 void bpf_prog_kallsyms_add(struct bpf_prog *fp);
 void bpf_prog_kallsyms_del(struct bpf_prog *fp);
+void bpf_get_prog_name(const struct bpf_prog *prog, char *sym);
 
 #else /* CONFIG_BPF_JIT */
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..02217bab64d0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1113,6 +1113,12 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 }
 
 extern void perf_event_mmap(struct vm_area_struct *vma);
+
+#ifdef CONFIG_BPF_SYSCALL
+extern void perf_event_bpf_event_prog(enum perf_bpf_event_type type,
+				      struct bpf_prog *prog);
+#endif
+
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1333,6 +1339,10 @@ static inline int perf_unregister_guest_info_callbacks
 (struct perf_guest_info_callbacks *callbacks)				{ return 0; }
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
+#ifdef CONFIG_BPF_SYSCALL
+static inline void perf_event_bpf_event_prog(enum perf_bpf_event_type type,
+					     struct bpf_prog *prog)	{ }
+#endif
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9de8780ac8d9..0ae3dae55fa8 100644
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
@@ -965,9 +966,41 @@ enum perf_event_type {
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
+	 *	u32				type;
+	 *	u32				flags;
+	 *	u32				id; // prog_id or other id
+	 *	u32				sub_id; // subprog id
+	 *
+	 *	// for bpf_prog types, bpf prog or subprog
+	 *	u8				tag[BPF_TAG_SIZE];
+	 *	u64				addr;
+	 *	u64				len;
+	 *	char				name[];
+	 *	struct sample_id		sample_id;
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
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b1a3545d0ec8..bbe8768f7a42 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -387,7 +387,7 @@ bpf_get_prog_addr_region(const struct bpf_prog *prog,
 	*symbol_end   = addr + hdr->pages * PAGE_SIZE;
 }
 
-static void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
+void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
 {
 	const char *end = sym + KSYM_NAME_LEN;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cf5040fd5434..45ef7922cf69 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1210,6 +1210,8 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
 {
 	if (atomic_dec_and_test(&prog->aux->refcnt)) {
+		perf_event_bpf_event_prog(PERF_BPF_EVENT_PROG_UNLOAD, prog);
+
 		/* bpf_prog_free_id() must be called first */
 		bpf_prog_free_id(prog, do_idr_lock);
 		bpf_prog_kallsyms_del_all(prog);
@@ -1550,6 +1552,7 @@ static int bpf_prog_load(union bpf_attr *attr)
 	}
 
 	bpf_prog_kallsyms_add(prog);
+	perf_event_bpf_event_prog(PERF_BPF_EVENT_PROG_LOAD, prog);
 	return err;
 
 free_used_maps:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a2a6e0b4a881..983f8d03870d 100644
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
@@ -7650,6 +7653,122 @@ static void perf_log_throttle(struct perf_event *event, int enable)
 	perf_output_end(&handle);
 }
 
+/*
+ * bpf load/unload tracking
+ */
+
+struct perf_bpf_event {
+	struct bpf_prog *prog;
+
+	struct {
+		struct perf_event_header        header;
+		u32 type;
+		u32 flags;
+		u32 id;
+		u32 sub_id;
+		u8 tag[BPF_TAG_SIZE];
+		u64 addr;
+		u64 len;
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
+	char name[KSYM_NAME_LEN];
+	int name_len;
+	int ret;
+
+	if (!perf_event_bpf_match(event))
+		return;
+
+	/* get prog name and round up to 64 bit aligned */
+	bpf_get_prog_name(bpf_event->prog, name);
+	name_len = strlen(name) + 1;
+	while (!IS_ALIGNED(name_len, sizeof(u64)))
+		name[name_len++] = '\0';
+	bpf_event->event_id.len += name_len;
+
+	perf_event_header__init_id(&bpf_event->event_id.header, &sample, event);
+	ret = perf_output_begin(&handle, event,
+				bpf_event->event_id.header.size);
+	if (ret)
+		return;
+
+	perf_output_put(&handle, bpf_event->event_id);
+
+	__output_copy(&handle, name, name_len);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
+static void perf_event_bpf(struct perf_bpf_event *bpf_event)
+{
+	perf_iterate_sb(perf_event_bpf_output,
+		       bpf_event,
+		       NULL);
+}
+
+static void perf_event_bpf_event_subprog(
+	enum perf_bpf_event_type type,
+	struct bpf_prog *prog, u32 id, u32 sub_id)
+{
+	struct perf_bpf_event bpf_event = (struct perf_bpf_event){
+		.prog = prog,
+		.event_id = {
+			.header = {
+				.type = PERF_RECORD_BPF_EVENT,
+				.size = sizeof(bpf_event.event_id),
+			},
+			.type = type,
+			/* .flags = 0 */
+			.id = id,
+			.sub_id = sub_id,
+			.addr = (u64)prog->bpf_func,
+			.len = prog->jited_len,
+		},
+	};
+
+	memcpy(bpf_event.event_id.tag, prog->tag, BPF_TAG_SIZE);
+	perf_event_bpf(&bpf_event);
+}
+
+/*
+ * This is call per bpf_prog. In case of multiple sub programs,
+ * this function calls perf_event_bpf_event_subprog() multiple times
+ */
+void perf_event_bpf_event_prog(enum perf_bpf_event_type type,
+			       struct bpf_prog *prog)
+{
+	if (!atomic_read(&nr_bpf_events))
+		return;
+
+	if (type != PERF_BPF_EVENT_PROG_LOAD &&
+	    type != PERF_BPF_EVENT_PROG_UNLOAD)
+		return;
+
+	if (prog->aux->func_cnt == 0) {
+		perf_event_bpf_event_subprog(type, prog,
+					     prog->aux->id, 0);
+	} else {
+		int i;
+
+		for (i = 0; i < prog->aux->func_cnt; i++)
+			perf_event_bpf_event_subprog(type, prog->aux->func[i],
+						     prog->aux->id, i);
+	}
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -9900,6 +10019,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (is_cgroup_event(event))
 		inc = true;
+	if (event->attr.bpf_event)
+		atomic_inc(&nr_bpf_events);
 
 	if (inc) {
 		/*
-- 
2.17.1

