Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3414EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF22080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbeLNUj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:39:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLNUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:39:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKd08t1455671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:39:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKcxRq1455668;
        Fri, 14 Dec 2018 12:38:59 -0800
Date:   Fri, 14 Dec 2018 12:38:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Robert Walker <tipbot@zytor.com>
Message-ID: <tip-c7d74f860abca8027ec77e0801a95a90a5d9bf90@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, robert.walker@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        leo.yan@linaro.org, jolsa@redhat.com, mathieu.poirier@linaro.org,
        hpa@zytor.com, namhyung@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com
Reply-To: leo.yan@linaro.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, robert.walker@arm.com, acme@redhat.com,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, mathieu.poirier@linaro.org, hpa@zytor.com,
          namhyung@kernel.org, jolsa@redhat.com
In-Reply-To: <1543839526-30348-1-git-send-email-robert.walker@arm.com>
References: <1543839526-30348-1-git-send-email-robert.walker@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Support for ARM A32/T32 instruction
 sets in CoreSight trace
Git-Commit-ID: c7d74f860abca8027ec77e0801a95a90a5d9bf90
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

Commit-ID:  c7d74f860abca8027ec77e0801a95a90a5d9bf90
Gitweb:     https://git.kernel.org/tip/c7d74f860abca8027ec77e0801a95a90a5d9bf90
Author:     Robert Walker <robert.walker@arm.com>
AuthorDate: Mon, 3 Dec 2018 12:18:46 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 3 Dec 2018 12:02:51 -0300

perf cs-etm: Support for ARM A32/T32 instruction sets in CoreSight trace

This patch adds support for generating instruction samples from trace of
AArch32 programs using the A32 and T32 instruction sets.

T32 has variable 2 or 4 byte instruction size, so the conversion between
addresses and instruction counts requires extra information from the
trace decoder, requiring version 0.10.0 of OpenCSD.  A check for the
OpenCSD library version has been added to the feature check for OpenCSD.

Signed-off-by: Robert Walker <robert.walker@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1543839526-30348-1-git-send-email-robert.walker@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-libopencsd.c           |  8 +++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 29 ++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++++
 tools/perf/util/cs-etm.c                        | 70 +++++++++++--------------
 4 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index 5ff1246e6194..d68eb4fb40cc 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -1,6 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <opencsd/c_api/opencsd_c_api.h>
 
+/*
+ * Check OpenCSD library version is sufficient to provide required features
+ */
+#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
+#if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
+#error "OpenCSD >= 0.10.0 is required"
+#endif
+
 int main(void)
 {
 	(void)ocsd_get_version();
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 938def6d0bb9..5efb616bd609 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -263,9 +263,12 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 	decoder->tail = 0;
 	decoder->packet_count = 0;
 	for (i = 0; i < MAX_BUFFER; i++) {
+		decoder->packet_buffer[i].isa = CS_ETM_ISA_UNKNOWN;
 		decoder->packet_buffer[i].start_addr = CS_ETM_INVAL_ADDR;
 		decoder->packet_buffer[i].end_addr = CS_ETM_INVAL_ADDR;
+		decoder->packet_buffer[i].instr_count = 0;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
+		decoder->packet_buffer[i].last_instr_size = 0;
 		decoder->packet_buffer[i].exc = false;
 		decoder->packet_buffer[i].exc_ret = false;
 		decoder->packet_buffer[i].cpu = INT_MIN;
@@ -294,11 +297,15 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_count++;
 
 	decoder->packet_buffer[et].sample_type = sample_type;
+	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
 	decoder->packet_buffer[et].exc = false;
 	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
 	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
+	decoder->packet_buffer[et].instr_count = 0;
+	decoder->packet_buffer[et].last_instr_taken_branch = false;
+	decoder->packet_buffer[et].last_instr_size = 0;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -321,8 +328,28 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 
 	packet = &decoder->packet_buffer[decoder->tail];
 
+	switch (elem->isa) {
+	case ocsd_isa_aarch64:
+		packet->isa = CS_ETM_ISA_A64;
+		break;
+	case ocsd_isa_arm:
+		packet->isa = CS_ETM_ISA_A32;
+		break;
+	case ocsd_isa_thumb2:
+		packet->isa = CS_ETM_ISA_T32;
+		break;
+	case ocsd_isa_tee:
+	case ocsd_isa_jazelle:
+	case ocsd_isa_custom:
+	case ocsd_isa_unknown:
+	default:
+		packet->isa = CS_ETM_ISA_UNKNOWN;
+	}
+
 	packet->start_addr = elem->st_addr;
 	packet->end_addr = elem->en_addr;
+	packet->instr_count = elem->num_instr_range;
+
 	switch (elem->last_i_type) {
 	case OCSD_INSTR_BR:
 	case OCSD_INSTR_BR_INDIRECT:
@@ -336,6 +363,8 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 		break;
 	}
 
+	packet->last_instr_size = elem->last_instr_sz;
+
 	return ret;
 }
 
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 612b5755f742..9351bd10d864 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -28,11 +28,21 @@ enum cs_etm_sample_type {
 	CS_ETM_TRACE_ON = 1 << 1,
 };
 
+enum cs_etm_isa {
+	CS_ETM_ISA_UNKNOWN,
+	CS_ETM_ISA_A64,
+	CS_ETM_ISA_A32,
+	CS_ETM_ISA_T32,
+};
+
 struct cs_etm_packet {
 	enum cs_etm_sample_type sample_type;
+	enum cs_etm_isa isa;
 	u64 start_addr;
 	u64 end_addr;
+	u32 instr_count;
 	u8 last_instr_taken_branch;
+	u8 last_instr_size;
 	u8 exc;
 	u8 exc_ret;
 	int cpu;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 73430b73570d..48ad217bf0df 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -31,14 +31,6 @@
 
 #define MAX_TIMESTAMP (~0ULL)
 
-/*
- * A64 instructions are always 4 bytes
- *
- * Only A64 is supported, so can use this constant for converting between
- * addresses and instruction counts, calculting offsets etc
- */
-#define A64_INSTR_SIZE 4
-
 struct cs_etm_auxtrace {
 	struct auxtrace auxtrace;
 	struct auxtrace_queues queues;
@@ -510,21 +502,17 @@ static inline void cs_etm__reset_last_branch_rb(struct cs_etm_queue *etmq)
 	etmq->last_branch_rb->nr = 0;
 }
 
-static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
-{
-	/* Returns 0 for the CS_ETM_TRACE_ON packet */
-	if (packet->sample_type == CS_ETM_TRACE_ON)
-		return 0;
+static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
+					 u64 addr) {
+	u8 instrBytes[2];
 
+	cs_etm__mem_access(etmq, addr, ARRAY_SIZE(instrBytes), instrBytes);
 	/*
-	 * The packet records the execution range with an exclusive end address
-	 *
-	 * A64 instructions are constant size, so the last executed
-	 * instruction is A64_INSTR_SIZE before the end address
-	 * Will need to do instruction level decode for T32 instructions as
-	 * they can be variable size (not yet supported).
+	 * T32 instruction size is indicated by bits[15:11] of the first
+	 * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
+	 * denote a 32-bit instruction.
 	 */
-	return packet->end_addr - A64_INSTR_SIZE;
+	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
 }
 
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
@@ -536,27 +524,32 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 	return packet->start_addr;
 }
 
-static inline u64 cs_etm__instr_count(const struct cs_etm_packet *packet)
+static inline
+u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 {
-	/*
-	 * Only A64 instructions are currently supported, so can get
-	 * instruction count by dividing.
-	 * Will need to do instruction level decode for T32 instructions as
-	 * they can be variable size (not yet supported).
-	 */
-	return (packet->end_addr - packet->start_addr) / A64_INSTR_SIZE;
+	/* Returns 0 for the CS_ETM_TRACE_ON packet */
+	if (packet->sample_type == CS_ETM_TRACE_ON)
+		return 0;
+
+	return packet->end_addr - packet->last_instr_size;
 }
 
-static inline u64 cs_etm__instr_addr(const struct cs_etm_packet *packet,
+static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
+				     const struct cs_etm_packet *packet,
 				     u64 offset)
 {
-	/*
-	 * Only A64 instructions are currently supported, so can get
-	 * instruction address by muliplying.
-	 * Will need to do instruction level decode for T32 instructions as
-	 * they can be variable size (not yet supported).
-	 */
-	return packet->start_addr + offset * A64_INSTR_SIZE;
+	if (packet->isa == CS_ETM_ISA_T32) {
+		u64 addr = packet->start_addr;
+
+		while (offset > 0) {
+			addr += cs_etm__t32_instr_size(etmq, addr);
+			offset--;
+		}
+		return addr;
+	}
+
+	/* Assume a 4 byte instruction size (A32/A64) */
+	return packet->start_addr + offset * 4;
 }
 
 static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq)
@@ -888,9 +881,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 	int ret;
-	u64 instrs_executed;
+	u64 instrs_executed = etmq->packet->instr_count;
 
-	instrs_executed = cs_etm__instr_count(etmq->packet);
 	etmq->period_instructions += instrs_executed;
 
 	/*
@@ -920,7 +912,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		 * executed, but PC has not advanced to next instruction)
 		 */
 		u64 offset = (instrs_executed - instrs_over - 1);
-		u64 addr = cs_etm__instr_addr(etmq->packet, offset);
+		u64 addr = cs_etm__instr_addr(etmq, etmq->packet, offset);
 
 		ret = cs_etm__synth_instruction_sample(
 			etmq, addr, etm->instructions_sample_period);
