Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20249C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D953D2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAVKUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:20:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfAVKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:20:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAJWTb2907405
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:19:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAJVIs2907402;
        Tue, 22 Jan 2019 02:19:31 -0800
Date:   Tue, 22 Jan 2019 02:19:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-6ee52e2a3fe4ea35520720736e6791df1fb67106@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        songliubraving@fb.com, peterz@infradead.org, daniel@iogearbox.net,
        peterz@infradeaed.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        ast@kernel.org
Reply-To: ast@kernel.org, peterz@infradeaed.org, daniel@iogearbox.net,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, songliubraving@fb.com, peterz@infradead.org,
          acme@redhat.com
In-Reply-To: <20190117161521.1341602-4-songliubraving@fb.com>
References: <20190117161521.1341602-4-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf, bpf: Introduce PERF_RECORD_BPF_EVENT
Git-Commit-ID: 6ee52e2a3fe4ea35520720736e6791df1fb67106
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

Commit-ID:  6ee52e2a3fe4ea35520720736e6791df1fb67106
Gitweb:     https://git.kernel.org/tip/6ee52e2a3fe4ea35520720736e6791df1fb67106
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Thu, 17 Jan 2019 08:15:15 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 17:00:57 -0300

perf, bpf: Introduce PERF_RECORD_BPF_EVENT

For better performance analysis of BPF programs, this patch introduces
PERF_RECORD_BPF_EVENT, a new perf_event_type that exposes BPF program
load/unload information to user space.

Each BPF program may contain up to BPF_MAX_SUBPROGS (256) sub programs.
The following example shows kernel symbols for a BPF program with 7 sub
programs:

    ffffffffa0257cf9 t bpf_prog_b07ccb89267cf242_F
    ffffffffa02592e1 t bpf_prog_2dcecc18072623fc_F
    ffffffffa025b0e9 t bpf_prog_bb7a405ebaec5d5c_F
    ffffffffa025dd2c t bpf_prog_a7540d4a39ec1fc7_F
    ffffffffa025fcca t bpf_prog_05762d4ade0e3737_F
    ffffffffa026108f t bpf_prog_db4bd11e35df90d4_F
    ffffffffa0263f00 t bpf_prog_89d64e4abf0f0126_F
    ffffffffa0257cf9 t bpf_prog_ae31629322c4b018__dummy_tracepoi

When a bpf program is loaded, PERF_RECORD_KSYMBOL is generated for each
of these sub programs. Therefore, PERF_RECORD_BPF_EVENT is not needed
for simple profiling.

For annotation, user space need to listen to PERF_RECORD_BPF_EVENT and
gather more information about these (sub) programs via sys_bpf.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradeaed.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-4-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/filter.h          |   7 +++
 include/linux/perf_event.h      |   6 +++
 include/uapi/linux/perf_event.h |  29 +++++++++-
 kernel/bpf/core.c               |   2 +-
 kernel/bpf/syscall.c            |   2 +
 kernel/events/core.c            | 115 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 159 insertions(+), 2 deletions(-)

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
index 136fe0495374..a79e59fc3b7d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1125,6 +1125,9 @@ extern void perf_event_mmap(struct vm_area_struct *vma);
 
 extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
 			       bool unregister, const char *sym);
+extern void perf_event_bpf_event(struct bpf_prog *prog,
+				 enum perf_bpf_event_type type,
+				 u16 flags);
 
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1350,6 +1353,9 @@ static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
 typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
 static inline void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
 				      bool unregister, const char *sym)	{ }
+static inline void perf_event_bpf_event(struct bpf_prog *prog,
+					enum perf_bpf_event_type type,
+					u16 flags)			{ }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1dee5c8f166b..7198ddd0c6b1 100644
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
@@ -979,6 +980,25 @@ enum perf_event_type {
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
 
@@ -990,6 +1010,13 @@ enum perf_record_ksymbol_type {
 
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
index e04ab5f325cf..236bb8ddb7bc 100644
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
@@ -7747,6 +7750,116 @@ err:
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
+static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
+					 enum perf_bpf_event_type type)
+{
+	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
+	char sym[KSYM_NAME_LEN];
+	int i;
+
+	if (prog->aux->func_cnt == 0) {
+		bpf_get_prog_name(prog, sym);
+		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
+				   (u64)(unsigned long)prog->bpf_func,
+				   prog->jited_len, unregister, sym);
+	} else {
+		for (i = 0; i < prog->aux->func_cnt; i++) {
+			struct bpf_prog *subprog = prog->aux->func[i];
+
+			bpf_get_prog_name(subprog, sym);
+			perf_event_ksymbol(
+				PERF_RECORD_KSYMBOL_TYPE_BPF,
+				(u64)(unsigned long)subprog->bpf_func,
+				subprog->jited_len, unregister, sym);
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
+	BUILD_BUG_ON(BPF_TAG_SIZE % sizeof(u64));
+
+	memcpy(bpf_event.event_id.tag, prog->tag, BPF_TAG_SIZE);
+	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -10008,6 +10121,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (event->attr.ksymbol)
 		atomic_inc(&nr_ksymbol_events);
+	if (event->attr.bpf_event)
+		atomic_inc(&nr_bpf_events);
 
 	if (inc) {
 		/*
