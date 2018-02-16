Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeBPTeF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753756AbeBPTTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A99217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Robert Walker <robert.walker@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/41] perf cs-etm: Inject capabilitity for CoreSight traces
Date: Fri, 16 Feb 2018 16:17:32 -0300
Message-Id: <20180216191746.11095-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Walker <robert.walker@arm.com>

Added user space perf functionality to translate CoreSight traces into
instruction events with branch stack.

To invoke the new functionality, use the perf inject tool with
--itrace=il. For example, to translate the ETM trace from perf.data into
last branch records in a new inj.data file:

    $ perf inject --itrace=i100000il128 -i perf.data -o perf.data.new

The 'i' parameter to itrace generates periodic instruction events.  The
period between instruction events can be specified as a number of
instructions suffixed by i (default 100000).

The parameter to 'l' specifies the number of entries in the branch stack
attached to instruction events.

The 'b' parameter to itrace generates events on taken branches.

This patch also fixes the contents of the branch events used in perf
report - previously branch events were generated for each contiguous
range of instructions executed.  These are fixed to generate branch
events between the last address of a range ending in an executed branch
instruction and the start address of the next range.

Based on patches by Sebastian Pop <s.pop@samsung.com> with additional fixes
and support for specifying the instruction period.

Originally-by: Sebastian Pop <s.pop@samsung.com>
Signed-off-by: Robert Walker <robert.walker@arm.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1518607481-4059-2-git-send-email-robert.walker@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  65 +++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   1 +
 tools/perf/util/cs-etm.c                        | 434 +++++++++++++++++++++---
 3 files changed, 436 insertions(+), 64 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 1fb01849f1c7..8ff69dfd725a 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -78,6 +78,8 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
 {
 	ocsd_datapath_resp_t dp_ret;
 
+	decoder->prev_return = OCSD_RESP_CONT;
+
 	dp_ret = ocsd_dt_process_data(decoder->dcd_tree, OCSD_OP_RESET,
 				      0, 0, NULL, NULL);
 	if (OCSD_DATA_RESP_IS_FATAL(dp_ret))
@@ -253,16 +255,16 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 	decoder->packet_count = 0;
 	for (i = 0; i < MAX_BUFFER; i++) {
 		decoder->packet_buffer[i].start_addr = 0xdeadbeefdeadbeefUL;
-		decoder->packet_buffer[i].end_addr   = 0xdeadbeefdeadbeefUL;
-		decoder->packet_buffer[i].exc	     = false;
-		decoder->packet_buffer[i].exc_ret    = false;
-		decoder->packet_buffer[i].cpu	     = INT_MIN;
+		decoder->packet_buffer[i].end_addr = 0xdeadbeefdeadbeefUL;
+		decoder->packet_buffer[i].last_instr_taken_branch = false;
+		decoder->packet_buffer[i].exc = false;
+		decoder->packet_buffer[i].exc_ret = false;
+		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
-			      const ocsd_generic_trace_elem *elem,
 			      const u8 trace_chan_id,
 			      enum cs_etm_sample_type sample_type)
 {
@@ -278,18 +280,16 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 		return OCSD_RESP_FATAL_SYS_ERR;
 
 	et = decoder->tail;
+	et = (et + 1) & (MAX_BUFFER - 1);
+	decoder->tail = et;
+	decoder->packet_count++;
+
 	decoder->packet_buffer[et].sample_type = sample_type;
-	decoder->packet_buffer[et].start_addr = elem->st_addr;
-	decoder->packet_buffer[et].end_addr = elem->en_addr;
 	decoder->packet_buffer[et].exc = false;
 	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
-
-	/* Wrap around if need be */
-	et = (et + 1) & (MAX_BUFFER - 1);
-
-	decoder->tail = et;
-	decoder->packet_count++;
+	decoder->packet_buffer[et].start_addr = 0xdeadbeefdeadbeefUL;
+	decoder->packet_buffer[et].end_addr = 0xdeadbeefdeadbeefUL;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -297,6 +297,40 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	return OCSD_RESP_CONT;
 }
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
+			     const ocsd_generic_trace_elem *elem,
+			     const uint8_t trace_chan_id)
+{
+	int ret = 0;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_RANGE);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+
+	packet->start_addr = elem->st_addr;
+	packet->end_addr = elem->en_addr;
+	switch (elem->last_i_type) {
+	case OCSD_INSTR_BR:
+	case OCSD_INSTR_BR_INDIRECT:
+		packet->last_instr_taken_branch = elem->last_instr_exec;
+		break;
+	case OCSD_INSTR_ISB:
+	case OCSD_INSTR_DSB_DMB:
+	case OCSD_INSTR_OTHER:
+	default:
+		packet->last_instr_taken_branch = false;
+		break;
+	}
+
+	return ret;
+
+}
+
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const void *context,
 				const ocsd_trc_index_t indx __maybe_unused,
@@ -316,9 +350,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		decoder->trace_on = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
-		resp = cs_etm_decoder__buffer_packet(decoder, elem,
-						     trace_chan_id,
-						     CS_ETM_RANGE);
+		resp = cs_etm_decoder__buffer_range(decoder, elem,
+						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
 		decoder->packet_buffer[decoder->tail].exc = true;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 3d2e6205d186..a4fdd285b145 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -30,6 +30,7 @@ struct cs_etm_packet {
 	enum cs_etm_sample_type sample_type;
 	u64 start_addr;
 	u64 end_addr;
+	u8 last_instr_taken_branch;
 	u8 exc;
 	u8 exc_ret;
 	int cpu;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f2c98774e665..6e595d96c04d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -32,6 +32,14 @@
 
 #define MAX_TIMESTAMP (~0ULL)
 
+/*
+ * A64 instructions are always 4 bytes
+ *
+ * Only A64 is supported, so can use this constant for converting between
+ * addresses and instruction counts, calculting offsets etc
+ */
+#define A64_INSTR_SIZE 4
+
 struct cs_etm_auxtrace {
 	struct auxtrace auxtrace;
 	struct auxtrace_queues queues;
@@ -45,11 +53,15 @@ struct cs_etm_auxtrace {
 	u8 snapshot_mode;
 	u8 data_queued;
 	u8 sample_branches;
+	u8 sample_instructions;
 
 	int num_cpu;
 	u32 auxtrace_type;
 	u64 branches_sample_type;
 	u64 branches_id;
+	u64 instructions_sample_type;
+	u64 instructions_sample_period;
+	u64 instructions_id;
 	u64 **metadata;
 	u64 kernel_start;
 	unsigned int pmu_type;
@@ -68,6 +80,12 @@ struct cs_etm_queue {
 	u64 time;
 	u64 timestamp;
 	u64 offset;
+	u64 period_instructions;
+	struct branch_stack *last_branch;
+	struct branch_stack *last_branch_rb;
+	size_t last_branch_pos;
+	struct cs_etm_packet *prev_packet;
+	struct cs_etm_packet *packet;
 };
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
@@ -180,6 +198,10 @@ static void cs_etm__free_queue(void *priv)
 	thread__zput(etmq->thread);
 	cs_etm_decoder__free(etmq->decoder);
 	zfree(&etmq->event_buf);
+	zfree(&etmq->last_branch);
+	zfree(&etmq->last_branch_rb);
+	zfree(&etmq->prev_packet);
+	zfree(&etmq->packet);
 	free(etmq);
 }
 
@@ -276,11 +298,35 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params;
 	struct cs_etm_queue *etmq;
+	size_t szp = sizeof(struct cs_etm_packet);
 
 	etmq = zalloc(sizeof(*etmq));
 	if (!etmq)
 		return NULL;
 
+	etmq->packet = zalloc(szp);
+	if (!etmq->packet)
+		goto out_free;
+
+	if (etm->synth_opts.last_branch || etm->sample_branches) {
+		etmq->prev_packet = zalloc(szp);
+		if (!etmq->prev_packet)
+			goto out_free;
+	}
+
+	if (etm->synth_opts.last_branch) {
+		size_t sz = sizeof(struct branch_stack);
+
+		sz += etm->synth_opts.last_branch_sz *
+		      sizeof(struct branch_entry);
+		etmq->last_branch = zalloc(sz);
+		if (!etmq->last_branch)
+			goto out_free;
+		etmq->last_branch_rb = zalloc(sz);
+		if (!etmq->last_branch_rb)
+			goto out_free;
+	}
+
 	etmq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
 	if (!etmq->event_buf)
 		goto out_free;
@@ -335,6 +381,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 		goto out_free_decoder;
 
 	etmq->offset = 0;
+	etmq->period_instructions = 0;
 
 	return etmq;
 
@@ -342,6 +389,10 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	cs_etm_decoder__free(etmq->decoder);
 out_free:
 	zfree(&etmq->event_buf);
+	zfree(&etmq->last_branch);
+	zfree(&etmq->last_branch_rb);
+	zfree(&etmq->prev_packet);
+	zfree(&etmq->packet);
 	free(etmq);
 
 	return NULL;
@@ -395,6 +446,129 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
 	return 0;
 }
 
+static inline void cs_etm__copy_last_branch_rb(struct cs_etm_queue *etmq)
+{
+	struct branch_stack *bs_src = etmq->last_branch_rb;
+	struct branch_stack *bs_dst = etmq->last_branch;
+	size_t nr = 0;
+
+	/*
+	 * Set the number of records before early exit: ->nr is used to
+	 * determine how many branches to copy from ->entries.
+	 */
+	bs_dst->nr = bs_src->nr;
+
+	/*
+	 * Early exit when there is nothing to copy.
+	 */
+	if (!bs_src->nr)
+		return;
+
+	/*
+	 * As bs_src->entries is a circular buffer, we need to copy from it in
+	 * two steps.  First, copy the branches from the most recently inserted
+	 * branch ->last_branch_pos until the end of bs_src->entries buffer.
+	 */
+	nr = etmq->etm->synth_opts.last_branch_sz - etmq->last_branch_pos;
+	memcpy(&bs_dst->entries[0],
+	       &bs_src->entries[etmq->last_branch_pos],
+	       sizeof(struct branch_entry) * nr);
+
+	/*
+	 * If we wrapped around at least once, the branches from the beginning
+	 * of the bs_src->entries buffer and until the ->last_branch_pos element
+	 * are older valid branches: copy them over.  The total number of
+	 * branches copied over will be equal to the number of branches asked by
+	 * the user in last_branch_sz.
+	 */
+	if (bs_src->nr >= etmq->etm->synth_opts.last_branch_sz) {
+		memcpy(&bs_dst->entries[nr],
+		       &bs_src->entries[0],
+		       sizeof(struct branch_entry) * etmq->last_branch_pos);
+	}
+}
+
+static inline void cs_etm__reset_last_branch_rb(struct cs_etm_queue *etmq)
+{
+	etmq->last_branch_pos = 0;
+	etmq->last_branch_rb->nr = 0;
+}
+
+static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
+{
+	/*
+	 * The packet records the execution range with an exclusive end address
+	 *
+	 * A64 instructions are constant size, so the last executed
+	 * instruction is A64_INSTR_SIZE before the end address
+	 * Will need to do instruction level decode for T32 instructions as
+	 * they can be variable size (not yet supported).
+	 */
+	return packet->end_addr - A64_INSTR_SIZE;
+}
+
+static inline u64 cs_etm__instr_count(const struct cs_etm_packet *packet)
+{
+	/*
+	 * Only A64 instructions are currently supported, so can get
+	 * instruction count by dividing.
+	 * Will need to do instruction level decode for T32 instructions as
+	 * they can be variable size (not yet supported).
+	 */
+	return (packet->end_addr - packet->start_addr) / A64_INSTR_SIZE;
+}
+
+static inline u64 cs_etm__instr_addr(const struct cs_etm_packet *packet,
+				     u64 offset)
+{
+	/*
+	 * Only A64 instructions are currently supported, so can get
+	 * instruction address by muliplying.
+	 * Will need to do instruction level decode for T32 instructions as
+	 * they can be variable size (not yet supported).
+	 */
+	return packet->start_addr + offset * A64_INSTR_SIZE;
+}
+
+static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq)
+{
+	struct branch_stack *bs = etmq->last_branch_rb;
+	struct branch_entry *be;
+
+	/*
+	 * The branches are recorded in a circular buffer in reverse
+	 * chronological order: we start recording from the last element of the
+	 * buffer down.  After writing the first element of the stack, move the
+	 * insert position back to the end of the buffer.
+	 */
+	if (!etmq->last_branch_pos)
+		etmq->last_branch_pos = etmq->etm->synth_opts.last_branch_sz;
+
+	etmq->last_branch_pos -= 1;
+
+	be       = &bs->entries[etmq->last_branch_pos];
+	be->from = cs_etm__last_executed_instr(etmq->prev_packet);
+	be->to	 = etmq->packet->start_addr;
+	/* No support for mispredict */
+	be->flags.mispred = 0;
+	be->flags.predicted = 1;
+
+	/*
+	 * Increment bs->nr until reaching the number of last branches asked by
+	 * the user on the command line.
+	 */
+	if (bs->nr < etmq->etm->synth_opts.last_branch_sz)
+		bs->nr += 1;
+}
+
+static int cs_etm__inject_event(union perf_event *event,
+			       struct perf_sample *sample, u64 type)
+{
+	event->header.size = perf_event__sample_event_size(sample, type, 0);
+	return perf_event__synthesize_sample(event, type, 0, sample);
+}
+
+
 static int
 cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 {
@@ -459,35 +633,105 @@ static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
 	}
 }
 
+static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
+					    u64 addr, u64 period)
+{
+	int ret = 0;
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	union perf_event *event = etmq->event_buf;
+	struct perf_sample sample = {.ip = 0,};
+
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.misc = PERF_RECORD_MISC_USER;
+	event->sample.header.size = sizeof(struct perf_event_header);
+
+	sample.ip = addr;
+	sample.pid = etmq->pid;
+	sample.tid = etmq->tid;
+	sample.id = etmq->etm->instructions_id;
+	sample.stream_id = etmq->etm->instructions_id;
+	sample.period = period;
+	sample.cpu = etmq->packet->cpu;
+	sample.flags = 0;
+	sample.insn_len = 1;
+	sample.cpumode = event->header.misc;
+
+	if (etm->synth_opts.last_branch) {
+		cs_etm__copy_last_branch_rb(etmq);
+		sample.branch_stack = etmq->last_branch;
+	}
+
+	if (etm->synth_opts.inject) {
+		ret = cs_etm__inject_event(event, &sample,
+					   etm->instructions_sample_type);
+		if (ret)
+			return ret;
+	}
+
+	ret = perf_session__deliver_synth_event(etm->session, event, &sample);
+
+	if (ret)
+		pr_err(
+			"CS ETM Trace: failed to deliver instruction event, error %d\n",
+			ret);
+
+	if (etm->synth_opts.last_branch)
+		cs_etm__reset_last_branch_rb(etmq);
+
+	return ret;
+}
+
 /*
  * The cs etm packet encodes an instruction range between a branch target
  * and the next taken branch. Generate sample accordingly.
  */
-static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
-				       struct cs_etm_packet *packet)
+static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 {
 	int ret = 0;
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct perf_sample sample = {.ip = 0,};
 	union perf_event *event = etmq->event_buf;
-	u64 start_addr = packet->start_addr;
-	u64 end_addr = packet->end_addr;
+	struct dummy_branch_stack {
+		u64			nr;
+		struct branch_entry	entries;
+	} dummy_bs;
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = PERF_RECORD_MISC_USER;
 	event->sample.header.size = sizeof(struct perf_event_header);
 
-	sample.ip = start_addr;
+	sample.ip = cs_etm__last_executed_instr(etmq->prev_packet);
 	sample.pid = etmq->pid;
 	sample.tid = etmq->tid;
-	sample.addr = end_addr;
+	sample.addr = etmq->packet->start_addr;
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
 	sample.period = 1;
-	sample.cpu = packet->cpu;
+	sample.cpu = etmq->packet->cpu;
 	sample.flags = 0;
 	sample.cpumode = PERF_RECORD_MISC_USER;
 
+	/*
+	 * perf report cannot handle events without a branch stack
+	 */
+	if (etm->synth_opts.last_branch) {
+		dummy_bs = (struct dummy_branch_stack){
+			.nr = 1,
+			.entries = {
+				.from = sample.ip,
+				.to = sample.addr,
+			},
+		};
+		sample.branch_stack = (struct branch_stack *)&dummy_bs;
+	}
+
+	if (etm->synth_opts.inject) {
+		ret = cs_etm__inject_event(event, &sample,
+					   etm->branches_sample_type);
+		if (ret)
+			return ret;
+	}
+
 	ret = perf_session__deliver_synth_event(etm->session, event, &sample);
 
 	if (ret)
@@ -584,6 +828,24 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		etm->sample_branches = true;
 		etm->branches_sample_type = attr.sample_type;
 		etm->branches_id = id;
+		id += 1;
+		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
+	}
+
+	if (etm->synth_opts.last_branch)
+		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+
+	if (etm->synth_opts.instructions) {
+		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
+		attr.sample_period = etm->synth_opts.period;
+		etm->instructions_sample_period = attr.sample_period;
+		err = cs_etm__synth_event(session, &attr, id);
+		if (err)
+			return err;
+		etm->sample_instructions = true;
+		etm->instructions_sample_type = attr.sample_type;
+		etm->instructions_id = id;
+		id += 1;
 	}
 
 	return 0;
@@ -591,20 +853,68 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 
 static int cs_etm__sample(struct cs_etm_queue *etmq)
 {
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	struct cs_etm_packet *tmp;
 	int ret;
-	struct cs_etm_packet packet;
+	u64 instrs_executed;
 
-	while (1) {
-		ret = cs_etm_decoder__get_packet(etmq->decoder, &packet);
-		if (ret <= 0)
+	instrs_executed = cs_etm__instr_count(etmq->packet);
+	etmq->period_instructions += instrs_executed;
+
+	/*
+	 * Record a branch when the last instruction in
+	 * PREV_PACKET is a branch.
+	 */
+	if (etm->synth_opts.last_branch &&
+	    etmq->prev_packet &&
+	    etmq->prev_packet->last_instr_taken_branch)
+		cs_etm__update_last_branch_rb(etmq);
+
+	if (etm->sample_instructions &&
+	    etmq->period_instructions >= etm->instructions_sample_period) {
+		/*
+		 * Emit instruction sample periodically
+		 * TODO: allow period to be defined in cycles and clock time
+		 */
+
+		/* Get number of instructions executed after the sample point */
+		u64 instrs_over = etmq->period_instructions -
+			etm->instructions_sample_period;
+
+		/*
+		 * Calculate the address of the sampled instruction (-1 as
+		 * sample is reported as though instruction has just been
+		 * executed, but PC has not advanced to next instruction)
+		 */
+		u64 offset = (instrs_executed - instrs_over - 1);
+		u64 addr = cs_etm__instr_addr(etmq->packet, offset);
+
+		ret = cs_etm__synth_instruction_sample(
+			etmq, addr, etm->instructions_sample_period);
+		if (ret)
+			return ret;
+
+		/* Carry remaining instructions into next sample period */
+		etmq->period_instructions = instrs_over;
+	}
+
+	if (etm->sample_branches &&
+	    etmq->prev_packet &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
+	    etmq->prev_packet->last_instr_taken_branch) {
+		ret = cs_etm__synth_branch_sample(etmq);
+		if (ret)
 			return ret;
+	}
 
+	if (etm->sample_branches || etm->synth_opts.last_branch) {
 		/*
-		 * If the packet contains an instruction range, generate an
-		 * instruction sequence event.
+		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
+		 * the next incoming packet.
 		 */
-		if (packet.sample_type & CS_ETM_RANGE)
-			cs_etm__synth_branch_sample(etmq, &packet);
+		tmp = etmq->packet;
+		etmq->packet = etmq->prev_packet;
+		etmq->prev_packet = tmp;
 	}
 
 	return 0;
@@ -621,45 +931,73 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 		etm->kernel_start = machine__kernel_start(etm->machine);
 
 	/* Go through each buffer in the queue and decode them one by one */
-more:
-	buffer_used = 0;
-	memset(&buffer, 0, sizeof(buffer));
-	err = cs_etm__get_trace(&buffer, etmq);
-	if (err <= 0)
-		return err;
-	/*
-	 * We cannot assume consecutive blocks in the data file are contiguous,
-	 * reset the decoder to force re-sync.
-	 */
-	err = cs_etm_decoder__reset(etmq->decoder);
-	if (err != 0)
-		return err;
-
-	/* Run trace decoder until buffer consumed or end of trace */
-	do {
-		processed = 0;
-
-		err = cs_etm_decoder__process_data_block(
-						etmq->decoder,
-						etmq->offset,
-						&buffer.buf[buffer_used],
-						buffer.len - buffer_used,
-						&processed);
-
-		if (err)
+	while (1) {
+		buffer_used = 0;
+		memset(&buffer, 0, sizeof(buffer));
+		err = cs_etm__get_trace(&buffer, etmq);
+		if (err <= 0)
+			return err;
+		/*
+		 * We cannot assume consecutive blocks in the data file are
+		 * contiguous, reset the decoder to force re-sync.
+		 */
+		err = cs_etm_decoder__reset(etmq->decoder);
+		if (err != 0)
 			return err;
 
-		etmq->offset += processed;
-		buffer_used += processed;
+		/* Run trace decoder until buffer consumed or end of trace */
+		do {
+			processed = 0;
+			err = cs_etm_decoder__process_data_block(
+				etmq->decoder,
+				etmq->offset,
+				&buffer.buf[buffer_used],
+				buffer.len - buffer_used,
+				&processed);
+			if (err)
+				return err;
+
+			etmq->offset += processed;
+			buffer_used += processed;
+
+			/* Process each packet in this chunk */
+			while (1) {
+				err = cs_etm_decoder__get_packet(etmq->decoder,
+								 etmq->packet);
+				if (err <= 0)
+					/*
+					 * Stop processing this chunk on
+					 * end of data or error
+					 */
+					break;
+
+				/*
+				 * If the packet contains an instruction
+				 * range, generate instruction sequence
+				 * events.
+				 */
+				if (etmq->packet->sample_type & CS_ETM_RANGE)
+					err = cs_etm__sample(etmq);
+			}
+		} while (buffer.len > buffer_used);
 
 		/*
-		 * Nothing to do with an error condition, let's hope the next
-		 * chunk will be better.
+		 * Generate a last branch event for the branches left in
+		 * the circular buffer at the end of the trace.
 		 */
-		err = cs_etm__sample(etmq);
-	} while (buffer.len > buffer_used);
+		if (etm->sample_instructions &&
+		    etmq->etm->synth_opts.last_branch) {
+			struct branch_stack *bs = etmq->last_branch_rb;
+			struct branch_entry *be =
+				&bs->entries[etmq->last_branch_pos];
+
+			err = cs_etm__synth_instruction_sample(
+				etmq, be->to, etmq->period_instructions);
+			if (err)
+				return err;
+		}
 
-goto more;
+	}
 
 	return err;
 }
-- 
2.14.3
