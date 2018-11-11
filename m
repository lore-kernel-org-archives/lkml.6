Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2756EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26B220862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbl26GSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26B220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeKKO4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:56:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35189 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:56:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15-v6so5242232wmt.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpysccI4tiar+JnEcil+VyAiAvlJ0KJWiSPDxFKq5/g=;
        b=gbl26GSr86Ktyv4GnLNigzAgCGBmDDL1Sg4aOP6qg+7Pjs+qFvdMYabXyelK5wGTW3
         Z8SQh21XkpOTqQz9kIste4Pcy+CEuaVyRxqOo2rGSUZxgg26E0qb/zLpBv27/BmdAqTE
         LxrcsRLQ2erCdqGMMwHn3NBLvcMKxfN04oruE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpysccI4tiar+JnEcil+VyAiAvlJ0KJWiSPDxFKq5/g=;
        b=TGDu3GkJ4l5WD2x0CHUvKF/5suWulGMdg/T8LNTPtvcBQHHyh3sdET/M+xMq5DSQGH
         hGQ9JKi8hthLrkV8eTnLrVLex1xLCgievcdmGRIsS6MUMQcX2Qyeji/GGXDGLuaWf+kX
         Q0Q3julN+Pz9VDduKRnO3UKuqDJDZQ0LQX+sMiM3GhPoIwrN7K6iACBwEKw7VuEQiuLc
         pfxWP+heWraW6EsnaDamWoG9L4NclRkc7W/AFSf9GdOBnQQo47T34S1PooeMwf1tux2X
         mh7H/wSpu6rTgo2FOp5QaJ6CGXv11x8j4r82LDq9GIxo3bg7cGIDSSouWYVtcmRJYH8U
         0ACg==
X-Gm-Message-State: AGRZ1gKBYL7zjwC0O2mGrkViYYulhu+TD/IoLw1Q8wbZgkxIrDZlmcCp
        LD3jF0TtQpnuwA9aw7E0YXBH9nITfmhrPQ==
X-Google-Smtp-Source: AJdET5cumI1agh7WIfSHxhkWg1vnqYOqDsjHQV5w98Radnbzo+2TC5C/AzxQd2r/nIradUjXpvdUjw==
X-Received: by 2002:a1c:3c83:: with SMTP id j125-v6mr3785373wma.65.1541912915586;
        Sat, 10 Nov 2018 21:08:35 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id b66-v6sm4471045wmb.21.2018.11.10.21.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:08:34 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Andi Kleen <andi@firstfloor.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 1/2] perf cs-etm: Set branch instruction flags in packet
Date:   Sun, 11 Nov 2018 13:07:55 +0800
Message-Id: <1541912876-20967-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf sample data contains flags to indicate the hardware trace data
is belonging to which type branch instruction, thus this can be used to
print out the human readable string.  Arm CoreSight ETM sample data is
missed to set flags and it is always set to zeros, this results in perf
tool skips to print string for instruction types.

Arm CoreSight ETM supports different kinds instruction of A64, A32 and
T32; this patch is to set branch instruction flags in packet for these
ISAs.

The brief idea for patch implementation is describe as below:

- For element with OCSD_GEN_TRC_ELEM_TRACE_ON type, it is taken as trace
  beginning packet; for element with OCSD_GEN_TRC_ELEM_NO_SYNC or
  OCSD_GEN_TRC_ELEM_EO_TRACE, these two kinds elements are used to set
  for trace end;

  As Mike suggested the packet stream might have more than one two
  TRACE_ON packets, the first one TRACE_ON packet indicates trace end
  and the second one is taken as trace restarting.  We will handle this
  special case in the upper layer with packet queue handling, which has
  more context so it's more suitable fix up for it.  This will be
  accomplished in the sequential patch.

- For instruction range packet, mainly base on three factors to decide
  the branch instruction types:

  elem->last_i_type
  elem->last_i_subtype
  elem->last_instr_cond

  If the instruction is immediate branch but without link and return
  flag, we consider it as function internal branch;  in fact the
  immediate branch also can be used to invoke the function entry,
  usually this is only used in assembly code to directly call a symbol
  and don't expect to return back; after reviewing kernel normal
  functions and user space programs, both of them are very seldom to use
  immediate branch for function call.  On the other hand, if we want to
  decide the immediate branch is for function branch jumping or for
  function calling, we need to rely on the start address of next packet
  and check the symbol offset for the start address,  this will
  introduce much complexity in the implementation.  So for this version
  we simply consider immediate branch as function internal branch.
  Moreover, we rely on 'elem->last_instr_cond' to decide if the branch
  instruction is a conditional branch or not.

  If the instruction is immediate branch with link, it's instruction
  'BL' and which is used for function call.

  If the instruction is indirect branch and with subtype
  OCSD_S_INSTR_V7_IMPLIED_RET, the decoders gives the hint the function
  return for below cases related with A32/T32 instruction; set this
  branch flag as function return (Thanks for Al's suggestion).

    BX R14
    MOV PC, LR
    POP {…, PC}
    LDR PC, [SP], #offset

  If the instruction is indirect branch without link, this is
  corresponding to instruction 'BR', this instruction usually is used
  for dynamic link lib with below usage; so we think it's a return
  instruction.

    0000000000000680 <.plt>:
     680:   a9bf7bf0        stp     x16, x30, [sp, #-16]!
     684:   90000090        adrp    x16, 10000 <__FRAME_END__+0xf630>
     688:   f947fe11        ldr     x17, [x16, #4088]
     68c:   913fe210        add     x16, x16, #0xff8
     690:   d61f0220        br      x17

  If the instruction is indirect branch with link, e.g BLR, we think
  it's a function call.

  For function return, ARMv8 introduces a dedicated instruction 'ret',
  which has flag of OCSD_S_INSTR_V8_RET.

- For exception packets, this patch divides into three types:

  The first type of exception is caused by external logics like bus,
  interrupt controller, debug module or PE reset or halt; this is
  corresponding to flags "bcyi" which defined in doc perf-script.txt;

  The second type is for system call, this is set as "bcs" by following
  definition in the doc;

  The third type is for CPU trap, data and instruction prefetch abort,
  alignment abort; usually these exceptions are synchronous for CPU, so
  set them as "bci" type.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Al Grant <Al.Grant@arm.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 168 ++++++++++++++++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   1 +
 2 files changed, 169 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index d1a6cbc..0e50c52 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -303,6 +303,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].instr_count = 0;
 	decoder->packet_buffer[et].last_instr_taken_branch = false;
 	decoder->packet_buffer[et].last_instr_size = 0;
+	decoder->packet_buffer[et].flags = 0;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -437,6 +438,171 @@ cs_etm_decoder__buffer_exception_ret(struct cs_etm_decoder *decoder,
 					     CS_ETM_EXCEPTION_RET);
 }
 
+static void cs_etm_decoder__set_sample_flags(
+				const void *context,
+				const ocsd_generic_trace_elem *elem)
+{
+	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
+	struct cs_etm_packet *packet;
+	u32 exc_num;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+
+	switch (elem->elem_type) {
+	case OCSD_GEN_TRC_ELEM_TRACE_ON:
+		packet->flags = PERF_IP_FLAG_BRANCH |
+				PERF_IP_FLAG_TRACE_BEGIN;
+		break;
+
+	case OCSD_GEN_TRC_ELEM_NO_SYNC:
+	case OCSD_GEN_TRC_ELEM_EO_TRACE:
+		packet->flags = PERF_IP_FLAG_BRANCH |
+				PERF_IP_FLAG_TRACE_END;
+		break;
+
+	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
+		/*
+		 * Immediate branch instruction without neither link nor
+		 * return flag, it's normal branch instruction within
+		 * the function.
+		 */
+		if (elem->last_i_type == OCSD_INSTR_BR &&
+		    elem->last_i_subtype == OCSD_S_INSTR_NONE) {
+			packet->flags = PERF_IP_FLAG_BRANCH;
+
+			if (elem->last_instr_cond)
+				packet->flags |= PERF_IP_FLAG_CONDITIONAL;
+		}
+
+		/*
+		 * Immediate branch instruction with link (e.g. BL), this is
+		 * branch instruction for function call.
+		 */
+		if (elem->last_i_type == OCSD_INSTR_BR &&
+		    elem->last_i_subtype == OCSD_S_INSTR_BR_LINK)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL;
+
+		/*
+		 * Indirect branch instruction with subtype of
+		 * OCSD_S_INSTR_V7_IMPLIED_RET, this is explicit hint for
+		 * function return for A32/T32.
+		 */
+		if (elem->last_i_type == OCSD_INSTR_BR_INDIRECT &&
+		    elem->last_i_subtype == OCSD_S_INSTR_V7_IMPLIED_RET)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+
+		/*
+		 * Indirect branch instruction without link (e.g. BR), usually
+		 * this is used for function return, especially for functions
+		 * within dynamic link lib.
+		 */
+		if (elem->last_i_type == OCSD_INSTR_BR_INDIRECT &&
+		    elem->last_i_subtype == OCSD_S_INSTR_NONE)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+
+		/*
+		 * Indirect branch instruction with link (e.g. BLR), this is
+		 * branch instruction for function call.
+		 */
+		if (elem->last_i_type == OCSD_INSTR_BR_INDIRECT &&
+		    elem->last_i_subtype == OCSD_S_INSTR_BR_LINK)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL;
+
+		/* Return instruction for function return. */
+		if (elem->last_i_type == OCSD_INSTR_BR_INDIRECT &&
+		    elem->last_i_subtype == OCSD_S_INSTR_V8_RET)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+
+		break;
+
+	case OCSD_GEN_TRC_ELEM_EXCEPTION:
+
+#define OCSD_EXC_RESET			0
+#define OCSD_EXC_DEBUG_HALT		1
+#define OCSD_EXC_CALL			2
+#define OCSD_EXC_TRAP			3
+#define OCSD_EXC_SYSTEM_ERROR		4
+#define OCSD_EXC_INST_DEBUG		6
+#define OCSD_EXC_DATA_DEBUG		7
+#define OCSD_EXC_ALIGNMENT		10
+#define OCSD_EXC_INST_FAULT		11
+#define OCSD_EXC_DATA_FAULT		12
+#define OCSD_EXC_IRQ			14
+#define OCSD_EXC_FIQ			15
+
+		exc_num = decoder->exc_num[packet->cpu];
+
+		/*
+		 * The exceptions are triggered by external signals
+		 * from bus, interrupt controller, debug module,
+		 * PE reset or halt.
+		 */
+		if (exc_num == OCSD_EXC_RESET ||
+		    exc_num == OCSD_EXC_DEBUG_HALT ||
+		    exc_num == OCSD_EXC_SYSTEM_ERROR ||
+		    exc_num == OCSD_EXC_INST_DEBUG ||
+		    exc_num == OCSD_EXC_DATA_DEBUG ||
+		    exc_num == OCSD_EXC_IRQ ||
+		    exc_num == OCSD_EXC_FIQ)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_ASYNC |
+					PERF_IP_FLAG_INTERRUPT;
+
+		/* The exception is for system call. */
+		if (exc_num == OCSD_EXC_CALL)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_SYSCALLRET;
+
+		/*
+		 * The exception is introduced by trap, instruction &
+		 * data fault or alignment errors.
+		 */
+		if (exc_num == OCSD_EXC_TRAP ||
+		    exc_num == OCSD_EXC_ALIGNMENT ||
+		    exc_num == OCSD_EXC_INST_FAULT ||
+		    exc_num == OCSD_EXC_DATA_FAULT)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_INTERRUPT;
+
+		break;
+
+	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
+
+		exc_num = decoder->exc_num[packet->cpu];
+
+		if (exc_num == OCSD_EXC_CALL)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN |
+					PERF_IP_FLAG_SYSCALLRET;
+		else
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN |
+					PERF_IP_FLAG_INTERRUPT;
+
+		break;
+
+	case OCSD_GEN_TRC_ELEM_UNKNOWN:
+	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
+	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
+	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
+	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
+	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
+	case OCSD_GEN_TRC_ELEM_EVENT:
+	case OCSD_GEN_TRC_ELEM_SWTRACE:
+	case OCSD_GEN_TRC_ELEM_CUSTOM:
+	default:
+		break;
+	}
+}
+
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const void *context,
 				const ocsd_trc_index_t indx __maybe_unused,
@@ -484,6 +650,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		break;
 	}
 
+	cs_etm_decoder__set_sample_flags(context, elem);
+
 	return resp;
 }
 
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 0d1c18d..71df908 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -47,6 +47,7 @@ struct cs_etm_packet {
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
 	int cpu;
+	u32 flags;
 };
 
 struct cs_etm_queue;
-- 
2.7.4

