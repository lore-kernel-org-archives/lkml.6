Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898A7218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Pb6+hNa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbeLTS3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:29:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732778AbeLTS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:29:10 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBKISCRv023626
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:29:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=lFAtYiZiZBscz24JKcIw8P4m5+9Z3yZ1gwOaxvfZzDA=;
 b=Pb6+hNa3QVphe7i9QtzdYxw5Ohn+Mv1W1YgqQxCPnnqikpj7r7dPVsfWJwPkD0atlehL
 lYvI/ak3XmnPupTpNkevDoBN23LGu/jNf6rfSL2RTAYGA1pXGwsh5J/W/D8b4eIPAM2q
 UZKGpbkzMOtBliOmJDzLMlqk+1IpYsPviek= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pgexwgcyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:29:09 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 20 Dec 2018 10:29:08 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7159062E1444; Thu, 20 Dec 2018 10:29:07 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce PERF_RECORD_BPF_EVENT
Date:   Thu, 20 Dec 2018 10:29:00 -0800
Message-ID: <20181220182904.4193196-4-songliubraving@fb.com>
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

When a bpf program is loaded, PERF_RECORD_KSYMBOL is generated for
each of these sub programs. Therefore, PERF_RECORD_BPF_EVENT is not
needed for simple profiling.

For annotation, user space need to listen to PERF_RECORD_BPF_EVENT
and gather more information about these (sub) programs via sys_bpf.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/filter.h          |   7 ++
 include/linux/perf_event.h      |   6 ++
 include/uapi/linux/perf_event.h |  29 +++++++-
 kernel/bpf/core.c               |   2 +-
 kernel/bpf/syscall.c            |   2 +
 kernel/events/core.c            | 120 ++++++++++++++++++++++++++++++++
 6 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 537e9e7c6e6f..45d23560f90b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -955,6 +955,7 @@ bpf_address_lookup(unsigned long addr, unsigned long *size,
 
 void bpf_prog_kallsyms_add(struct bpf_prog *fp);
 void bpf_prog_kallsyms_del(struct bpf_prog *fp);
+void bpf_get_prog_name(const struct bpf_prog *prog, char *sym);
 
 #else /* CONFIG_BPF_JIT */
 
@@ -1010,6 +1011,12 @@ static inline void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 static inline void bpf_prog_kallsyms_del(struct bpf_prog *fp)
 {
 }
+
+static inline void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
+{
+	sym[0] = '\0';
+}
+
 #endif /* CONFIG_BPF_JIT */
 
 void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 037863e69bb2..8ea0ce650c6f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1118,6 +1118,9 @@ extern void perf_event_mmap(struct vm_area_struct *vma);
 typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
 extern void perf_event_ksymbol(int type, u64 addr, u64 len, bool unregister,
 			       perf_ksymbol_get_name_f get_name, void *data);
+extern void perf_event_bpf_event(struct bpf_prog *prog,
+				 enum perf_bpf_event_type type,
+				 u16 flags);
 
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1345,6 +1348,9 @@ static inline void perf_event_ksymbol(int type, u64 addr, u64 len,
 				      bool unregister,
 				      perf_ksymbol_get_name_f get_name,
 				      void *data) 			{ }
+static inline void perf_event_bpf_event(struct bpf_prog *prog,
+					enum perf_bpf_event_type type,
+					u16 flags)			{ }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 6c9e327e87ed..68db04058408 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -373,7 +373,8 @@ struct perf_event_attr {
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
-				__reserved_1   : 34;
+				bpf_event      :  1, /* include bpf events */
+				__reserved_1   : 33;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -986,9 +987,35 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_KSYMBOL			= 17,
 
+	/*
+	 * Record bpf events:
+	 *  enum perf_bpf_event_type {
+	 *	PERF_BPF_EVENT_UNKNOWN		= 0,
+	 *	PERF_BPF_EVENT_PROG_LOAD	= 1,
+	 *	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
+	 *  };
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u16				type;
+	 *	u16				flags;
+	 *	u32				id;
+	 *	u8				tag[BPF_TAG_SIZE];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_BPF_EVENT			= 18,
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
index 5cdd8da0e7f2..2a8364294f11 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -496,7 +496,7 @@ bpf_get_prog_addr_region(const struct bpf_prog *prog,
 	*symbol_end   = addr + hdr->pages * PAGE_SIZE;
 }
 
-static void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
+void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
 {
 	const char *end = sym + KSYM_NAME_LEN;
 	const struct btf_type *type;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0607db304def..4af63c8c95eb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1211,6 +1211,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
 {
 	if (atomic_dec_and_test(&prog->aux->refcnt)) {
+		perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
 		/* bpf_prog_free_id() must be called first */
 		bpf_prog_free_id(prog, do_idr_lock);
 		bpf_prog_kallsyms_del_all(prog);
@@ -1554,6 +1555,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	}
 
 	bpf_prog_kallsyms_add(prog);
+	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
 	return err;
 
 free_used_maps:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c0ac6dee367c..04feb2b28c46 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -386,6 +386,7 @@ static atomic_t nr_task_events __read_mostly;
 static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
+static atomic_t nr_bpf_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4308,6 +4309,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (event->attr.ksymbol)
 		atomic_dec(&nr_ksymbol_events);
+	if (event->attr.bpf_event)
+		atomic_dec(&nr_bpf_events);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -7744,6 +7747,121 @@ void perf_event_ksymbol(int ksym_type, u64 addr, u64 len, bool unregister,
 	WARN_ONCE(1, "%s: Invalid KSYMBOL type 0x%x\n", __func__, ksym_type);
 }
 
+/*
+ * bpf program load/unload tracking
+ */
+
+struct perf_bpf_event {
+	struct bpf_prog	*prog;
+	struct {
+		struct perf_event_header        header;
+		u16				type;
+		u16				flags;
+		u32				id;
+		u8				tag[BPF_TAG_SIZE];
+	} event_id;
+};
+
+static int perf_event_bpf_match(struct perf_event *event)
+{
+	return event->attr.bpf_event;
+}
+
+static void perf_event_bpf_output(struct perf_event *event, void *data)
+{
+	struct perf_bpf_event *bpf_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	int ret;
+
+	if (!perf_event_bpf_match(event))
+		return;
+
+	perf_event_header__init_id(&bpf_event->event_id.header,
+				   &sample, event);
+	ret = perf_output_begin(&handle, event,
+				bpf_event->event_id.header.size);
+	if (ret)
+		return;
+
+	perf_output_put(&handle, bpf_event->event_id);
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
+static int perf_event_bpf_get_name(char *name, int len, void *data)
+{
+	struct bpf_prog *prog = data;
+
+	bpf_get_prog_name(prog, name);
+	return 0;
+}
+
+static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
+					 enum perf_bpf_event_type type)
+{
+	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
+	int i;
+
+	if (prog->aux->func_cnt == 0) {
+		perf_event_ksymbol(PERF_RECORD_MISC_KSYMBOL_TYPE_BPF,
+				   (u64)(unsigned long)prog->bpf_func,
+				   prog->jited_len, unregister,
+				   perf_event_bpf_get_name, prog);
+	} else {
+		for (i = 0; i < prog->aux->func_cnt; i++) {
+			struct bpf_prog *subprog = prog->aux->func[i];
+
+			perf_event_ksymbol(
+				PERF_RECORD_MISC_KSYMBOL_TYPE_BPF,
+				(u64)(unsigned long)subprog->bpf_func,
+				subprog->jited_len, unregister,
+				perf_event_bpf_get_name, subprog);
+		}
+	}
+}
+
+void perf_event_bpf_event(struct bpf_prog *prog,
+			  enum perf_bpf_event_type type,
+			  u16 flags)
+{
+	struct perf_bpf_event bpf_event;
+
+	if (type <= PERF_BPF_EVENT_UNKNOWN ||
+	    type >= PERF_BPF_EVENT_MAX)
+		return;
+
+	switch (type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		if (atomic_read(&nr_ksymbol_events))
+			perf_event_bpf_emit_ksymbols(prog, type);
+		break;
+	default:
+		break;
+	}
+
+	if (!atomic_read(&nr_bpf_events))
+		return;
+
+	bpf_event = (struct perf_bpf_event){
+		.prog = prog,
+		.event_id = {
+			.header = {
+				.type = PERF_RECORD_BPF_EVENT,
+				.size = sizeof(bpf_event.event_id),
+			},
+			.type = type,
+			.flags = flags,
+			.id = prog->aux->id,
+		},
+	};
+
+	memcpy(bpf_event.event_id.tag, prog->tag, BPF_TAG_SIZE);
+	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -9996,6 +10114,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (event->attr.ksymbol)
 		atomic_inc(&nr_ksymbol_events);
+	if (event->attr.bpf_event)
+		atomic_inc(&nr_bpf_events);
 
 	if (inc) {
 		/*
-- 
2.17.1

