Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB002C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698EC214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GOf6HTzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfAITVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:21:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55838 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728207AbfAITVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:21:52 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x09J7MBq011231
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 11:21:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=QBal68Ybxur0yzGFWtPBCbS+Es2aP6z/QP63HGvJI+4=;
 b=GOf6HTzpBDCOqSDDKTtBtk3EbdB1TcXKUPaYRik3kcrD2OaGbw8sEFUtuYRhmnoUKzfy
 Uqwi1vZI0+JseCbXgS4y2QtTWeomiuZu6dEDgNg2R/BceEH+tbFfYNg+zGBm0uSgWl5p
 drMorQyChMQThMmKPCEICyYwgF9LTofUqW0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pwp6v86h8-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 11:21:51 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 9 Jan 2019 11:21:38 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6E7AC62E1B12; Wed,  9 Jan 2019 11:21:37 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v6 perf, bpf-next 3/7] perf, bpf: introduce PERF_RECORD_BPF_EVENT
Date:   Wed, 9 Jan 2019 11:21:07 -0800
Message-ID: <20190109192111.130995-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109192111.130995-1-songliubraving@fb.com>
References: <20190109192111.130995-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
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
index ad106d845b22..d531d4250bff 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -951,6 +951,7 @@ bpf_address_lookup(unsigned long addr, unsigned long *size,
 
 void bpf_prog_kallsyms_add(struct bpf_prog *fp);
 void bpf_prog_kallsyms_del(struct bpf_prog *fp);
+void bpf_get_prog_name(const struct bpf_prog *prog, char *sym);
 
 #else /* CONFIG_BPF_JIT */
 
@@ -1006,6 +1007,12 @@ static inline void bpf_prog_kallsyms_add(struct bpf_prog *fp)
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
index 6b5f08db5ef3..10c560fcc7a4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1119,6 +1119,9 @@ typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
 extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
 			       bool unregister,
 			       perf_ksymbol_get_name_f get_name, void *data);
+extern void perf_event_bpf_event(struct bpf_prog *prog,
+				 enum perf_bpf_event_type type,
+				 u16 flags);
 
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1346,6 +1349,9 @@ static inline void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
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
index 68c4da0227c5..8bd78a34e396 100644
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
@@ -981,6 +982,25 @@ enum perf_event_type {
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
 
@@ -992,6 +1012,13 @@ enum perf_record_ksymbol_type {
 
 #define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
 
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
index f908b9356025..19c49313c709 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -495,7 +495,7 @@ bpf_get_prog_addr_region(const struct bpf_prog *prog,
 	*symbol_end   = addr + hdr->pages * PAGE_SIZE;
 }
 
-static void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
+void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
 {
 	const char *end = sym + KSYM_NAME_LEN;
 	const struct btf_type *type;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b155cd17c1bd..30ebd085790b 100644
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
index ef27f2776999..2f238a8ddaab 100644
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
@@ -7744,6 +7747,121 @@ void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
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
+		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
+				   (u64)(unsigned long)prog->bpf_func,
+				   prog->jited_len, unregister,
+				   perf_event_bpf_get_name, prog);
+	} else {
+		for (i = 0; i < prog->aux->func_cnt; i++) {
+			struct bpf_prog *subprog = prog->aux->func[i];
+
+			perf_event_ksymbol(
+				PERF_RECORD_KSYMBOL_TYPE_BPF,
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

