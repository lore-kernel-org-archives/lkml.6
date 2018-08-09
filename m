Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34531C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33602183D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xwmOmisc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33602183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbeHIRYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:40 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9A62183D;
        Thu,  9 Aug 2018 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826762;
        bh=aYPYAjtUcIP4fj68kAMJRrWRdOh0LRKe8HkqknPio14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xwmOmiscN4j9OVv9u9TgxLK0XriV0XtXxggkQHGBOz3bBP5UWGyzoyfRe+e43eRrT
         KnsibQxAkhHuknw30TErOnidEt479J+zqiW5Turq+x64U60iMXZC8iLY2ZN1WIFQ7P
         mT7QhoCw4do/bONA0n0UNlYEn8gY6R90qhoxbqeM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/44] perf report: Add GUI report support for s390 auxiliary trace
Date:   Thu,  9 Aug 2018 11:57:47 -0300
Message-Id: <20180809145822.21391-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Add support for s390 auxiliary trace support.

Use 'perf record -e rbd000 -- ls' to create the perf.data file.

Use 'perf report' to display the auxiliary trace data.

Output before:

  [root@s35lp76 perf]# ./perf report --stdio
  0x128 [0x10]: failed to process type: 70
  Error:
  failed to process sample
  [root@s35lp76 perf]#

Output after:

  [root@s35lp76 perf]# ./perf report --stdio

      18.21%    18.21%  ls     [kernel.kallsyms]       [k] ftrace_likely_update
       9.52%     9.52%  ls     [kernel.kallsyms]       [k] lock_acquire
       9.38%     9.38%  ls     [kernel.kallsyms]       [k] lock_release
       3.45%     3.45%  ls     [kernel.kallsyms]       [k] lock_acquired
       2.88%     2.88%  ls     [kernel.kallsyms]       [k] link_path_walk
       2.63%     2.63%  ls     [kernel.kallsyms]       [k] __d_lookup
       2.38%     2.38%  ls     [kernel.kallsyms]       [k] __d_lookup_rcu
       2.04%     2.04%  ls     [kernel.kallsyms]       [k] ___might_sleep
       1.83%     1.83%  ls     [kernel.kallsyms]       [k] debug_lockdep_rcu_enabled
       1.44%     1.44%  ls     [kernel.kallsyms]       [k] dput
     ....

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180802074622.13641-4-tmricht@linux.ibm.com
[ Use PRI[xd]64 to fix the build on debian:experimental-x-mips (gcc 8.1.0) and others ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumsf.c | 593 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 585 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 14728b0834c6..d2c78ffd9fee 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -4,6 +4,138 @@
  * Auxtrace support for s390 CPU-Measurement Sampling Facility
  *
  * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
+ *
+ * Auxiliary traces are collected during 'perf record' using rbd000 event.
+ * Several PERF_RECORD_XXX are generated during recording:
+ *
+ * PERF_RECORD_AUX:
+ *	Records that new data landed in the AUX buffer part.
+ * PERF_RECORD_AUXTRACE:
+ *	Defines auxtrace data. Followed by the actual data. The contents of
+ *	the auxtrace data is dependent on the event and the CPU.
+ *	This record is generated by perf record command. For details
+ *	see Documentation/perf.data-file-format.txt.
+ * PERF_RECORD_AUXTRACE_INFO:
+ *	Defines a table of contains for PERF_RECORD_AUXTRACE records. This
+ *	record is generated during 'perf record' command. Each record contains up
+ *	to 256 entries describing offset and size of the AUXTRACE data in the
+ *	perf.data file.
+ * PERF_RECORD_AUXTRACE_ERROR:
+ *	Indicates an error during AUXTRACE collection such as buffer overflow.
+ * PERF_RECORD_FINISHED_ROUND:
+ *	Perf events are not necessarily in time stamp order, as they can be
+ *	collected in parallel on different CPUs. If the events should be
+ *	processed in time order they need to be sorted first.
+ *	Perf report guarantees that there is no reordering over a
+ *	PERF_RECORD_FINISHED_ROUND boundary event. All perf records with a
+ *	time stamp lower than this record are processed (and displayed) before
+ *	the succeeding perf record are processed.
+ *
+ * These records are evaluated during perf report command.
+ *
+ * 1. PERF_RECORD_AUXTRACE_INFO is used to set up the infrastructure for
+ * auxiliary trace data processing. See s390_cpumsf_process_auxtrace_info()
+ * below.
+ * Auxiliary trace data is collected per CPU. To merge the data into the report
+ * an auxtrace_queue is created for each CPU. It is assumed that the auxtrace
+ * data is in ascending order.
+ *
+ * Each queue has a double linked list of auxtrace_buffers. This list contains
+ * the offset and size of a CPU's auxtrace data. During auxtrace processing
+ * the data portion is mmap()'ed.
+ *
+ * To sort the queues in chronological order, all queue access is controlled
+ * by the auxtrace_heap. This is basicly a stack, each stack element has two
+ * entries, the queue number and a time stamp. However the stack is sorted by
+ * the time stamps. The highest time stamp is at the bottom the lowest
+ * (nearest) time stamp is at the top. That sort order is maintained at all
+ * times!
+ *
+ * After the auxtrace infrastructure has been setup, the auxtrace queues are
+ * filled with data (offset/size pairs) and the auxtrace_heap is populated.
+ *
+ * 2. PERF_RECORD_XXX processing triggers access to the auxtrace_queues.
+ * Each record is handled by s390_cpumsf_process_event(). The time stamp of
+ * the perf record is compared with the time stamp located on the auxtrace_heap
+ * top element. If that time stamp is lower than the time stamp from the
+ * record sample, the auxtrace queues will be processed. As auxtrace queues
+ * control many auxtrace_buffers and each buffer can be quite large, the
+ * auxtrace buffer might be processed only partially. In this case the
+ * position in the auxtrace_buffer of that queue is remembered and the time
+ * stamp of the last processed entry of the auxtrace_buffer replaces the
+ * current auxtrace_heap top.
+ *
+ * 3. Auxtrace_queues might run of out data and are feeded by the
+ * PERF_RECORD_AUXTRACE handling, see s390_cpumsf_process_auxtrace_event().
+ *
+ * Event Generation
+ * Each sampling-data entry in the auxilary trace data generates a perf sample.
+ * This sample is filled
+ * with data from the auxtrace such as PID/TID, instruction address, CPU state,
+ * etc. This sample is processed with perf_session__deliver_synth_event() to
+ * be included into the GUI.
+ *
+ * 4. PERF_RECORD_FINISHED_ROUND event is used to process all the remaining
+ * auxiliary traces entries until the time stamp of this record is reached
+ * auxtrace_heap top. This is triggered by ordered_event->deliver().
+ *
+ *
+ * Perf event processing.
+ * Event processing of PERF_RECORD_XXX entries relies on time stamp entries.
+ * This is the function call sequence:
+ *
+ * __cmd_report()
+ * |
+ * perf_session__process_events()
+ * |
+ * __perf_session__process_events()
+ * |
+ * perf_session__process_event()
+ * |  This functions splits the PERF_RECORD_XXX records.
+ * |  - Those generated by perf record command (type number equal or higher
+ * |    than PERF_RECORD_USER_TYPE_START) are handled by
+ * |    perf_session__process_user_event(see below)
+ * |  - Those generated by the kernel are handled by
+ * |    perf_evlist__parse_sample_timestamp()
+ * |
+ * perf_evlist__parse_sample_timestamp()
+ * |  Extract time stamp from sample data.
+ * |
+ * perf_session__queue_event()
+ * |  If timestamp is positive the sample is entered into an ordered_event
+ * |  list, sort order is the timestamp. The event processing is deferred until
+ * |  later (see perf_session__process_user_event()).
+ * |  Other timestamps (0 or -1) are handled immediately by
+ * |  perf_session__deliver_event(). These are events generated at start up
+ * |  of command perf record. They create PERF_RECORD_COMM and PERF_RECORD_MMAP*
+ * |  records. They are needed to create a list of running processes and its
+ * |  memory mappings and layout. They are needed at the beginning to enable
+ * |  command perf report to create process trees and memory mappings.
+ * |
+ * perf_session__deliver_event()
+ * |  Delivers a PERF_RECORD_XXX entry for handling.
+ * |
+ * auxtrace__process_event()
+ * |  The timestamp of the PERF_RECORD_XXX entry is taken to correlate with
+ * |  time stamps from the auxiliary trace buffers. This enables
+ * |  synchronization between auxiliary trace data and the events on the
+ * |  perf.data file.
+ * |
+ * machine__deliver_event()
+ * |  Handles the PERF_RECORD_XXX event. This depends on the record type.
+ *    It might update the process tree, update a process memory map or enter
+ *    a sample with IP and call back chain data into GUI data pool.
+ *
+ *
+ * Deferred processing determined by perf_session__process_user_event() is
+ * finally processed when a PERF_RECORD_FINISHED_ROUND is encountered. These
+ * are generated during command perf record.
+ * The timestamp of PERF_RECORD_FINISHED_ROUND event is taken to process all
+ * PERF_RECORD_XXX entries stored in the ordered_event list. This list was
+ * built up while reading the perf.data file.
+ * Each event is now processed by calling perf_session__deliver_event().
+ * This enables time synchronization between the data in the perf.data file and
+ * the data in the auxiliary trace buffers.
  */
 
 #include <endian.h>
@@ -37,6 +169,14 @@ struct s390_cpumsf {
 	u32			auxtrace_type;
 	u32			pmu_type;
 	u16			machine_type;
+	bool			data_queued;
+};
+
+struct s390_cpumsf_queue {
+	struct s390_cpumsf	*sf;
+	unsigned int		queue_nr;
+	struct auxtrace_buffer	*buffer;
+	int			cpu;
 };
 
 /* Display s390 CPU measurement facility basic-sampling data entry */
@@ -181,8 +321,8 @@ static void s390_cpumsf_dump(struct s390_cpumsf *sf,
 	const char *color = PERF_COLOR_BLUE;
 	struct hws_basic_entry *basic;
 	struct hws_diag_entry *diag;
-	size_t pos = 0;
 	unsigned short bsdes, dsdes;
+	size_t pos = 0;
 
 	color_fprintf(stdout, color,
 		      ". ... s390 AUX data: size %zu bytes\n",
@@ -243,15 +383,414 @@ static void s390_cpumsf_dump_event(struct s390_cpumsf *sf, unsigned char *buf,
 	s390_cpumsf_dump(sf, buf, len);
 }
 
+#define	S390_LPP_PID_MASK	0xffffffff
+
+static bool s390_cpumsf_make_event(size_t pos,
+				   struct hws_basic_entry *basic,
+				   struct s390_cpumsf_queue *sfq)
+{
+	struct perf_sample sample = {
+				.ip = basic->ia,
+				.pid = basic->hpp & S390_LPP_PID_MASK,
+				.tid = basic->hpp & S390_LPP_PID_MASK,
+				.cpumode = PERF_RECORD_MISC_CPUMODE_UNKNOWN,
+				.cpu = sfq->cpu,
+				.period = 1
+			    };
+	union perf_event event;
+
+	memset(&event, 0, sizeof(event));
+	if (basic->CL == 1)	/* Native LPAR mode */
+		sample.cpumode = basic->P ? PERF_RECORD_MISC_USER
+					  : PERF_RECORD_MISC_KERNEL;
+	else if (basic->CL == 2)	/* Guest kernel/user space */
+		sample.cpumode = basic->P ? PERF_RECORD_MISC_GUEST_USER
+					  : PERF_RECORD_MISC_GUEST_KERNEL;
+	else if (basic->gpp || basic->prim_asn != 0xffff)
+		/* Use heuristics on old hardware */
+		sample.cpumode = basic->P ? PERF_RECORD_MISC_GUEST_USER
+					  : PERF_RECORD_MISC_GUEST_KERNEL;
+	else
+		sample.cpumode = basic->P ? PERF_RECORD_MISC_USER
+					  : PERF_RECORD_MISC_KERNEL;
+
+	event.sample.header.type = PERF_RECORD_SAMPLE;
+	event.sample.header.misc = sample.cpumode;
+	event.sample.header.size = sizeof(struct perf_event_header);
+
+	pr_debug4("%s pos:%#zx ip:%#" PRIx64 " P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
+		 __func__, pos, sample.ip, basic->P, basic->CL, sample.pid,
+		 sample.tid, sample.cpumode, sample.cpu);
+	if (perf_session__deliver_synth_event(sfq->sf->session, &event,
+					      &sample)) {
+		pr_err("s390 Auxiliary Trace: failed to deliver event\n");
+		return false;
+	}
+	return true;
+}
+
+static unsigned long long get_trailer_time(const unsigned char *buf)
+{
+	struct hws_trailer_entry *te;
+	unsigned long long aux_time;
+
+	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
+					      - sizeof(*te));
+
+	if (!te->clock_base)	/* TOD_CLOCK_BASE value missing */
+		return 0;
+
+	/* Correct calculation to convert time stamp in trailer entry to
+	 * nano seconds (taken from arch/s390 function tod_to_ns()).
+	 * TOD_CLOCK_BASE is stored in trailer entry member progusage2.
+	 */
+	aux_time = trailer_timestamp(te) - te->progusage2;
+	aux_time = (aux_time >> 9) * 125 + (((aux_time & 0x1ff) * 125) >> 9);
+	return aux_time;
+}
+
+/* Process the data samples of a single queue. The first parameter is a
+ * pointer to the queue, the second parameter is the time stamp. This
+ * is the time stamp:
+ * - of the event that triggered this processing.
+ * - or the time stamp when the last proccesing of this queue stopped.
+ *   In this case it stopped at a 4KB page boundary and record the
+ *   position on where to continue processing on the next invocation
+ *   (see buffer->use_data and buffer->use_size).
+ *
+ * When this function returns the second parameter is updated to
+ * reflect the time stamp of the last processed auxiliary data entry
+ * (taken from the trailer entry of that page). The caller uses this
+ * returned time stamp to record the last processed entry in this
+ * queue.
+ *
+ * The function returns:
+ * 0:  Processing successful. The second parameter returns the
+ *     time stamp from the trailer entry until which position
+ *     processing took place. Subsequent calls resume from this
+ *     position.
+ * <0: An error occurred during processing. The second parameter
+ *     returns the maximum time stamp.
+ * >0: Done on this queue. The second parameter returns the
+ *     maximum time stamp.
+ */
+static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
+{
+	struct s390_cpumsf *sf = sfq->sf;
+	unsigned char *buf = sfq->buffer->use_data;
+	size_t len = sfq->buffer->use_size;
+	struct hws_basic_entry *basic;
+	unsigned short bsdes, dsdes;
+	size_t pos = 0;
+	int err = 1;
+	u64 aux_ts;
+
+	if (!s390_cpumsf_validate(sf->machine_type, buf, len, &bsdes,
+				  &dsdes)) {
+		*ts = ~0ULL;
+		return -1;
+	}
+
+	/* Get trailer entry time stamp and check if entries in
+	 * this auxiliary page are ready for processing. If the
+	 * time stamp of the first entry is too high, whole buffer
+	 * can be skipped. In this case return time stamp.
+	 */
+	aux_ts = get_trailer_time(buf);
+	if (!aux_ts) {
+		pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
+		       sfq->buffer->data_offset);
+		aux_ts = ~0ULL;
+		goto out;
+	}
+	if (aux_ts > *ts) {
+		*ts = aux_ts;
+		return 0;
+	}
+
+	while (pos < len) {
+		/* Handle Basic entry */
+		basic = (struct hws_basic_entry *)(buf + pos);
+		if (s390_cpumsf_make_event(pos, basic, sfq))
+			pos += bsdes;
+		else {
+			err = -EBADF;
+			goto out;
+		}
+
+		pos += dsdes;	/* Skip diagnositic entry */
+
+		/* Check for trailer entry */
+		if (!s390_cpumsf_reached_trailer(bsdes + dsdes, pos)) {
+			pos = (pos + S390_CPUMSF_PAGESZ)
+			       & ~(S390_CPUMSF_PAGESZ - 1);
+			/* Check existence of next page */
+			if (pos >= len)
+				break;
+			aux_ts = get_trailer_time(buf + pos);
+			if (!aux_ts) {
+				aux_ts = ~0ULL;
+				goto out;
+			}
+			if (aux_ts > *ts) {
+				*ts = aux_ts;
+				sfq->buffer->use_data += pos;
+				sfq->buffer->use_size -= pos;
+				return 0;
+			}
+		}
+	}
+out:
+	*ts = aux_ts;
+	sfq->buffer->use_size = 0;
+	sfq->buffer->use_data = NULL;
+	return err;	/* Buffer completely scanned or error */
+}
+
+/* Run the s390 auxiliary trace decoder.
+ * Select the queue buffer to operate on, the caller already selected
+ * the proper queue, depending on second parameter 'ts'.
+ * This is the time stamp until which the auxiliary entries should
+ * be processed. This value is updated by called functions and
+ * returned to the caller.
+ *
+ * Resume processing in the current buffer. If there is no buffer
+ * get a new buffer from the queue and setup start position for
+ * processing.
+ * When a buffer is completely processed remove it from the queue
+ * before returning.
+ *
+ * This function returns
+ * 1: When the queue is empty. Second parameter will be set to
+ *    maximum time stamp.
+ * 0: Normal processing done.
+ * <0: Error during queue buffer setup. This causes the caller
+ *     to stop processing completely.
+ */
+static int s390_cpumsf_run_decoder(struct s390_cpumsf_queue *sfq,
+				   u64 *ts)
+{
+
+	struct auxtrace_buffer *buffer;
+	struct auxtrace_queue *queue;
+	int err;
+
+	queue = &sfq->sf->queues.queue_array[sfq->queue_nr];
+
+	/* Get buffer and last position in buffer to resume
+	 * decoding the auxiliary entries. One buffer might be large
+	 * and decoding might stop in between. This depends on the time
+	 * stamp of the trailer entry in each page of the auxiliary
+	 * data and the time stamp of the event triggering the decoding.
+	 */
+	if (sfq->buffer == NULL) {
+		sfq->buffer = buffer = auxtrace_buffer__next(queue,
+							     sfq->buffer);
+		if (!buffer) {
+			*ts = ~0ULL;
+			return 1;	/* Processing done on this queue */
+		}
+		/* Start with a new buffer on this queue */
+		if (buffer->data) {
+			buffer->use_size = buffer->size;
+			buffer->use_data = buffer->data;
+		}
+	} else
+		buffer = sfq->buffer;
+
+	if (!buffer->data) {
+		int fd = perf_data__fd(sfq->sf->session->data);
+
+		buffer->data = auxtrace_buffer__get_data(buffer, fd);
+		if (!buffer->data)
+			return -ENOMEM;
+		buffer->use_size = buffer->size;
+		buffer->use_data = buffer->data;
+	}
+	pr_debug4("%s queue_nr:%d buffer:%" PRId64 " offset:%#" PRIx64 " size:%#zx rest:%#zx\n",
+		  __func__, sfq->queue_nr, buffer->buffer_nr, buffer->offset,
+		  buffer->size, buffer->use_size);
+	err = s390_cpumsf_samples(sfq, ts);
+
+	/* If non-zero, there is either an error (err < 0) or the buffer is
+	 * completely done (err > 0). The error is unrecoverable, usually
+	 * some descriptors could not be read successfully, so continue with
+	 * the next buffer.
+	 * In both cases the parameter 'ts' has been updated.
+	 */
+	if (err) {
+		sfq->buffer = NULL;
+		list_del(&buffer->list);
+		auxtrace_buffer__free(buffer);
+		if (err > 0)		/* Buffer done, no error */
+			err = 0;
+	}
+	return err;
+}
+
+static struct s390_cpumsf_queue *
+s390_cpumsf_alloc_queue(struct s390_cpumsf *sf, unsigned int queue_nr)
+{
+	struct s390_cpumsf_queue *sfq;
+
+	sfq = zalloc(sizeof(struct s390_cpumsf_queue));
+	if (sfq == NULL)
+		return NULL;
+
+	sfq->sf = sf;
+	sfq->queue_nr = queue_nr;
+	sfq->cpu = -1;
+	return sfq;
+}
+
+static int s390_cpumsf_setup_queue(struct s390_cpumsf *sf,
+				   struct auxtrace_queue *queue,
+				   unsigned int queue_nr, u64 ts)
+{
+	struct s390_cpumsf_queue *sfq = queue->priv;
+
+	if (list_empty(&queue->head))
+		return 0;
+
+	if (sfq == NULL) {
+		sfq = s390_cpumsf_alloc_queue(sf, queue_nr);
+		if (!sfq)
+			return -ENOMEM;
+		queue->priv = sfq;
+
+		if (queue->cpu != -1)
+			sfq->cpu = queue->cpu;
+	}
+	return auxtrace_heap__add(&sf->heap, queue_nr, ts);
+}
+
+static int s390_cpumsf_setup_queues(struct s390_cpumsf *sf, u64 ts)
+{
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < sf->queues.nr_queues; i++) {
+		ret = s390_cpumsf_setup_queue(sf, &sf->queues.queue_array[i],
+					      i, ts);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static int s390_cpumsf_update_queues(struct s390_cpumsf *sf, u64 ts)
+{
+	if (!sf->queues.new_data)
+		return 0;
+
+	sf->queues.new_data = false;
+	return s390_cpumsf_setup_queues(sf, ts);
+}
+
+static int s390_cpumsf_process_queues(struct s390_cpumsf *sf, u64 timestamp)
+{
+	unsigned int queue_nr;
+	u64 ts;
+	int ret;
+
+	while (1) {
+		struct auxtrace_queue *queue;
+		struct s390_cpumsf_queue *sfq;
+
+		if (!sf->heap.heap_cnt)
+			return 0;
+
+		if (sf->heap.heap_array[0].ordinal >= timestamp)
+			return 0;
+
+		queue_nr = sf->heap.heap_array[0].queue_nr;
+		queue = &sf->queues.queue_array[queue_nr];
+		sfq = queue->priv;
+
+		auxtrace_heap__pop(&sf->heap);
+		if (sf->heap.heap_cnt) {
+			ts = sf->heap.heap_array[0].ordinal + 1;
+			if (ts > timestamp)
+				ts = timestamp;
+		} else {
+			ts = timestamp;
+		}
+
+		ret = s390_cpumsf_run_decoder(sfq, &ts);
+		if (ret < 0) {
+			auxtrace_heap__add(&sf->heap, queue_nr, ts);
+			return ret;
+		}
+		if (!ret) {
+			ret = auxtrace_heap__add(&sf->heap, queue_nr, ts);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
+static int s390_cpumsf_synth_error(struct s390_cpumsf *sf, int code, int cpu,
+				   pid_t pid, pid_t tid, u64 ip)
+{
+	char msg[MAX_AUXTRACE_ERROR_MSG];
+	union perf_event event;
+	int err;
+
+	strncpy(msg, "Lost Auxiliary Trace Buffer", sizeof(msg) - 1);
+	auxtrace_synth_error(&event.auxtrace_error, PERF_AUXTRACE_ERROR_ITRACE,
+			     code, cpu, pid, tid, ip, msg);
+
+	err = perf_session__deliver_synth_event(sf->session, &event, NULL);
+	if (err)
+		pr_err("s390 Auxiliary Trace: failed to deliver error event,"
+			"error %d\n", err);
+	return err;
+}
+
+static int s390_cpumsf_lost(struct s390_cpumsf *sf, struct perf_sample *sample)
+{
+	return s390_cpumsf_synth_error(sf, 1, sample->cpu,
+				       sample->pid, sample->tid, 0);
+}
+
 static int
 s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
-			  union perf_event *event __maybe_unused,
-			  struct perf_sample *sample __maybe_unused,
-			  struct perf_tool *tool __maybe_unused)
+			  union perf_event *event,
+			  struct perf_sample *sample,
+			  struct perf_tool *tool)
 {
-	return 0;
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					      auxtrace);
+	u64 timestamp = sample->time;
+	int err = 0;
+
+	if (dump_trace)
+		return 0;
+
+	if (!tool->ordered_events) {
+		pr_err("s390 Auxiliary Trace requires ordered events\n");
+		return -EINVAL;
+	}
+
+	if (event->header.type == PERF_RECORD_AUX &&
+	    event->aux.flags & PERF_AUX_FLAG_TRUNCATED)
+		return s390_cpumsf_lost(sf, sample);
+
+	if (timestamp) {
+		err = s390_cpumsf_update_queues(sf, timestamp);
+		if (!err)
+			err = s390_cpumsf_process_queues(sf, timestamp);
+	}
+	return err;
 }
 
+struct s390_cpumsf_synth {
+	struct perf_tool cpumsf_tool;
+	struct perf_session *session;
+};
+
 static int
 s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
@@ -266,6 +805,9 @@ s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 	off_t data_offset;
 	int err;
 
+	if (sf->data_queued)
+		return 0;
+
 	if (perf_data__is_pipe(session->data)) {
 		data_offset = 0;
 	} else {
@@ -290,17 +832,21 @@ s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
+static void s390_cpumsf_free_events(struct perf_session *session __maybe_unused)
+{
+}
+
 static int s390_cpumsf_flush(struct perf_session *session __maybe_unused,
 			     struct perf_tool *tool __maybe_unused)
 {
 	return 0;
 }
 
-static void s390_cpumsf_free_events(struct perf_session *session)
+static void s390_cpumsf_free_queues(struct perf_session *session)
 {
 	struct s390_cpumsf *sf = container_of(session->auxtrace,
 					      struct s390_cpumsf,
-					       auxtrace);
+					      auxtrace);
 	struct auxtrace_queues *queues = &sf->queues;
 	unsigned int i;
 
@@ -316,7 +862,7 @@ static void s390_cpumsf_free(struct perf_session *session)
 					      auxtrace);
 
 	auxtrace_heap__free(&sf->heap);
-	s390_cpumsf_free_events(session);
+	s390_cpumsf_free_queues(session);
 	session->auxtrace = NULL;
 	free(sf);
 }
@@ -329,6 +875,19 @@ static int s390_cpumsf_get_type(const char *cpuid)
 	return (ret == 1) ? family : 0;
 }
 
+/* Check itrace options set on perf report command.
+ * Return true, if none are set or all options specified can be
+ * handled on s390.
+ * Return false otherwise.
+ */
+static bool check_auxtrace_itrace(struct itrace_synth_opts *itops)
+{
+	if (!itops || !itops->set)
+		return true;
+	pr_err("No --itrace options supported\n");
+	return false;
+}
+
 int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 				      struct perf_session *session)
 {
@@ -343,6 +902,11 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	if (sf == NULL)
 		return -ENOMEM;
 
+	if (!check_auxtrace_itrace(session->itrace_synth_opts)) {
+		err = -EINVAL;
+		goto err_free;
+	}
+
 	err = auxtrace_queues__init(&sf->queues);
 	if (err)
 		goto err_free;
@@ -360,8 +924,21 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->auxtrace.free = s390_cpumsf_free;
 	session->auxtrace = &sf->auxtrace;
 
+	if (dump_trace)
+		return 0;
+
+	err = auxtrace_queues__process_index(&sf->queues, session);
+	if (err)
+		goto err_free_queues;
+
+	if (sf->queues.populated)
+		sf->data_queued = true;
+
 	return 0;
 
+err_free_queues:
+	auxtrace_queues__free(&sf->queues);
+	session->auxtrace = NULL;
 err_free:
 	free(sf);
 	return err;
-- 
2.14.4

