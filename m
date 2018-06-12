Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB610C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5571F208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5571F208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933712AbeFLHw1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:52:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:47405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933579AbeFLHvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:51:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 00:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="56615837"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2018 00:51:51 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Date:   Tue, 12 Jun 2018 10:51:15 +0300
Message-Id: <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUX data can be used to annotate perf events such as performance counters
or tracepoints/breakpoints by including it in sample records when
PERF_SAMPLE_AUX flag is set. Such samples would be instrumental in debugging
and profiling by providing, for example, a history of instruction flow
leading up to the event's overflow.

To do this, the AUX event's file descriptor is passed to the perf syscall
with PERF_FLAG_FD_SAMPLE flag set and PERF_SAMPLE_AUX bit set in the sample
type. Also, a new attribute field is added to allow the user to specify the
desired size of the AUX sample: attr.aux_sample_size.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 include/linux/perf_event.h      |  10 ++
 include/uapi/linux/perf_event.h |   8 +-
 kernel/events/core.c            | 158 +++++++++++++++++++++++++++++++-
 3 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7546822a1d74..9f9e341d45cf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -102,6 +102,12 @@ struct perf_branch_stack {
 	struct perf_branch_entry	entries[0];
 };
 
+struct perf_aux_record {
+	u64		size;
+	unsigned long	from;
+	unsigned long	to;
+};
+
 struct task_struct;
 
 /*
@@ -674,6 +680,8 @@ struct perf_event {
 	struct bpf_prog			*prog;
 #endif
 
+	struct perf_event		*sample_event;
+
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call		*tp_event;
 	struct event_filter		*filter;
@@ -882,6 +890,7 @@ struct perf_sample_data {
 	 */
 	u64				addr;
 	struct perf_raw_record		*raw;
+	struct perf_aux_record		aux;
 	struct perf_branch_stack	*br_stack;
 	u64				period;
 	u64				weight;
@@ -933,6 +942,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	/* remaining struct members initialized in perf_prepare_sample() */
 	data->addr = addr;
 	data->raw  = NULL;
+	data->aux.from = data->aux.to = data->aux.size = 0;
 	data->br_stack = NULL;
 	data->period = period;
 	data->weight = 0;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c77c9a2ebbbb..19a22b161e39 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_AUX				= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 };
 
 /*
@@ -298,6 +299,7 @@ enum perf_event_read_format {
 					/* add: sample_stack_user */
 #define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
+#define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -416,6 +418,7 @@ struct perf_event_attr {
 	__u32	aux_watermark;
 	__u16	sample_max_stack;
 	__u16	__reserved_2;	/* align to __u64 */
+	__u64	aux_sample_size;
 };
 
 #define perf_flags(attr)	(*(&(attr)->read_format + 1))
@@ -820,6 +823,8 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
+	 *	{ u64			size;
+	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -952,6 +957,7 @@ enum perf_callchain_context {
 #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
 #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
 #define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
+#define PERF_FLAG_FD_SAMPLE		(1UL << 4) /* use fd event to sample AUX data */
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 union perf_mem_data_src {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e1fce335a42a..70918ed33143 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -346,7 +346,8 @@ static void event_function_local(struct perf_event *event, event_f func, void *d
 #define PERF_FLAG_ALL (PERF_FLAG_FD_NO_GROUP |\
 		       PERF_FLAG_FD_OUTPUT  |\
 		       PERF_FLAG_PID_CGROUP |\
-		       PERF_FLAG_FD_CLOEXEC)
+		       PERF_FLAG_FD_CLOEXEC |\
+		       PERF_FLAG_FD_SAMPLE)
 
 /*
  * branch priv levels that need permission checks
@@ -3937,6 +3938,8 @@ static void unaccount_freq_event(void)
 		atomic_dec(&nr_freq_events);
 }
 
+static void put_event(struct perf_event *event);
+
 static void unaccount_event(struct perf_event *event)
 {
 	bool dec = false;
@@ -3970,6 +3973,9 @@ static void unaccount_event(struct perf_event *event)
 			schedule_delayed_work(&perf_sched_work, HZ);
 	}
 
+	if (event->sample_event)
+		put_event(event->sample_event);
+
 	unaccount_event_cpu(event, event->cpu);
 
 	unaccount_pmu_sb_event(event);
@@ -5608,6 +5614,100 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 	}
 }
 
+/*
+ * See if we can take an AUX sample. If we can, prepare for writing
+ * the sample and return its size. In this case, perf_aux_sample_output()
+ * will undo the preparations.
+ */
+static unsigned long perf_aux_sample_size(struct perf_event *event,
+					  struct perf_sample_data *data,
+					  size_t size)
+{
+	struct perf_event *sampler = event->sample_event;
+	struct ring_buffer *rb;
+	int *disable_count;
+
+	data->aux.size = 0;
+
+	if (!sampler || READ_ONCE(sampler->state) != PERF_EVENT_STATE_ACTIVE)
+		goto out;
+
+	if (READ_ONCE(sampler->oncpu) != smp_processor_id())
+		goto out;
+
+	/*
+	 * Non-zero disable count here means that we, being the NMI
+	 * context, are racing with pmu::add, pmu::del or address filter
+	 * adjustment, which we want to avoid.
+	 */
+	disable_count = this_cpu_ptr(sampler->pmu->pmu_disable_count);
+	if (*disable_count)
+		goto out;
+
+	/* Re-enabled in perf_aux_sample_output() */
+	perf_pmu_disable(sampler->pmu);
+
+	rb = ring_buffer_get(sampler);
+	if (!rb) {
+		perf_pmu_enable(sampler->pmu);
+		goto out;
+	}
+
+	/* Restarted in perf_aux_sample_output() */
+	sampler->pmu->stop(sampler, PERF_EF_UPDATE);
+	data->aux.to = rb->aux_head;
+
+	size = min(size, perf_aux_size(rb));
+
+	if (data->aux.to < size)
+		data->aux.from = rb->aux_nr_pages * PAGE_SIZE + data->aux.to -
+			size;
+	else
+		data->aux.from = data->aux.to - size;
+	data->aux.size = ALIGN(size, sizeof(u64));
+	ring_buffer_put(rb);
+
+out:
+	return data->aux.size;
+}
+
+static void perf_aux_sample_output(struct perf_event *event,
+				   struct perf_output_handle *handle,
+				   struct perf_sample_data *data)
+{
+	struct perf_event *sampler = event->sample_event;
+	struct ring_buffer *rb;
+	unsigned long pad;
+	int ret;
+
+	if (WARN_ON_ONCE(!sampler || !data->aux.size))
+		goto out_enable;
+
+	rb = ring_buffer_get(sampler);
+	if (WARN_ON_ONCE(!rb))
+		goto out_enable;
+
+	ret = rb_output_aux(rb, data->aux.from, data->aux.to,
+			    (aux_copyfn)perf_output_copy, handle);
+	if (ret < 0) {
+		pr_warn_ratelimited("failed to copy trace data\n");
+		goto out;
+	}
+
+	pad = data->aux.size - ret;
+	if (pad) {
+		u64 p = 0;
+
+		perf_output_copy(handle, &p, pad);
+	}
+out:
+	ring_buffer_put(rb);
+	sampler->pmu->start(sampler, 0);
+
+out_enable:
+	perf_pmu_enable(sampler->pmu);
+}
+
 static void __perf_event_header__init_id(struct perf_event_header *header,
 					 struct perf_sample_data *data,
 					 struct perf_event *event)
@@ -5926,6 +6026,13 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_AUX) {
+		perf_output_put(handle, data->aux.size);
+
+		if (data->aux.size)
+			perf_aux_sample_output(event, handle, data);
+	}
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -6112,6 +6219,32 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
+
+	if (sample_type & PERF_SAMPLE_AUX) {
+		u64 size;
+
+		header->size += sizeof(u64); /* size */
+
+		/*
+		 * Given the 16bit nature of header::size, an AUX sample can
+		 * easily overflow it, what with all the preceding sample bits.
+		 * Make sure this doesn't happen by using up to U16_MAX bytes
+		 * per sample in total (rounded down to 8 byte boundary).
+		 */
+		size = min_t(size_t, U16_MAX - header->size,
+			     event->attr.aux_sample_size);
+		size = rounddown(size, 8);
+		size = perf_aux_sample_size(event, data, size);
+
+		WARN_ON_ONCE(size + header->size > U16_MAX);
+		header->size += size;
+	}
+	/*
+	 * If you're adding more sample types here, you likely need to do
+	 * something about the overflowing header::size, like repurpose the
+	 * lowest 3 bits of size, which should be always zero at the moment.
+	 */
+	WARN_ON_ONCE(header->size & 7);
 }
 
 static void __always_inline
@@ -9841,6 +9974,17 @@ __perf_event_ctx_lock_double(struct perf_event *group_leader,
 	return gctx;
 }
 
+static bool
+can_sample_for(struct perf_event *sample_event, struct perf_event *event)
+{
+	if (has_aux(sample_event) &&
+	    sample_event->cpu == event->cpu &&
+	    atomic_long_inc_not_zero(&sample_event->refcount))
+		return true;
+
+	return false;
+}
+
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
@@ -9854,6 +9998,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		pid_t, pid, int, cpu, int, group_fd, unsigned long, flags)
 {
 	struct perf_event *group_leader = NULL, *output_event = NULL;
+	struct perf_event *sample_event = NULL;
 	struct perf_event *event, *sibling;
 	struct perf_event_attr attr;
 	struct perf_event_context *ctx, *uninitialized_var(gctx);
@@ -9924,6 +10069,8 @@ SYSCALL_DEFINE5(perf_event_open,
 		group_leader = group.file->private_data;
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;
+		if (flags & PERF_FLAG_FD_SAMPLE)
+			sample_event = group_leader;
 		if (flags & PERF_FLAG_FD_NO_GROUP)
 			group_leader = NULL;
 	}
@@ -10146,6 +10293,15 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
+	if (sample_event) {
+		/* Grabs sample_event's reference on success */
+		if (!can_sample_for(sample_event, event)) {
+			err = -EINVAL;
+			goto err_locked;
+		}
+
+		event->sample_event = sample_event;
+	}
 
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
-- 
2.17.1

