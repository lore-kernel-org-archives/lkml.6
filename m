Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2001C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3A120855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBIMvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:51:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:51:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CpYwh2632868
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:51:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CpXG72632864;
        Sat, 9 Feb 2019 04:51:33 -0800
Date:   Sat, 9 Feb 2019 04:51:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-ca45d843a599b0812a655ba58d42dddacd538e31@git.kernel.org>
Cc:     acme@redhat.com, robert.walker@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com, tglx@linutronix.de, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, jolsa@redhat.com,
          suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
          namhyung@kernel.org, mike.leach@linaro.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, coresight@lists.linaro.org, acme@redhat.com,
          robert.walker@arm.com, leo.yan@linaro.org
In-Reply-To: <20190129122842.32041-2-leo.yan@linaro.org>
References: <20190129122842.32041-2-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Add last instruction information in
 packet
Git-Commit-ID: ca45d843a599b0812a655ba58d42dddacd538e31
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

Commit-ID:  ca45d843a599b0812a655ba58d42dddacd538e31
Gitweb:     https://git.kernel.org/tip/ca45d843a599b0812a655ba58d42dddacd538e31
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 29 Jan 2019 20:28:35 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf cs-etm: Add last instruction information in packet

Decoder provides last instruction related information, these information
can be used for trace analysis; specifically we can get to know what
kind of branch instruction has been executed, mainly the information are
contained in three element fields:

  last_i_type: this is significant type for waypoint calculation, it
  indicates the last instruction is one of immediate branch instruction,
  indirect branch instruction, instruction barrier (ISB), or data
  barrier (DSB/DMB).

  last_i_subtype: this is used for instruction sub type, it can be
  branch with link, ARMv8 return instruction, ARMv8 eret instruction
  (return from exception), or ARMv7 instruction which could imply
  return (e.g. MOV PC, LR; POP { ,PC}).

  last_instr_cond: it indicates if the last instruction was conditional.

But these three fields are not saved into cs_etm_packet struct, thus
cs-etm layer don't know related information and cannot generate sample
flags for branch instructions.

This patch add corresponding three new fields in cs_etm_packet struct
and save related value into the packet structure, it is preparation for
supporting sample flags.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190129122842.32041-2-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 9 +++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 8c155575c6c5..8a19310500d9 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -290,6 +290,9 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].instr_count = 0;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].last_instr_size = 0;
+		decoder->packet_buffer[i].last_instr_type = 0;
+		decoder->packet_buffer[i].last_instr_subtype = 0;
+		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -323,6 +326,9 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].instr_count = 0;
 	decoder->packet_buffer[et].last_instr_taken_branch = false;
 	decoder->packet_buffer[et].last_instr_size = 0;
+	decoder->packet_buffer[et].last_instr_type = 0;
+	decoder->packet_buffer[et].last_instr_subtype = 0;
+	decoder->packet_buffer[et].last_instr_cond = 0;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -366,6 +372,9 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 	packet->start_addr = elem->st_addr;
 	packet->end_addr = elem->en_addr;
 	packet->instr_count = elem->num_instr_range;
+	packet->last_instr_type = elem->last_i_type;
+	packet->last_instr_subtype = elem->last_i_subtype;
+	packet->last_instr_cond = elem->last_instr_cond;
 
 	switch (elem->last_i_type) {
 	case OCSD_INSTR_BR:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index a6407d41598f..7cdd6a9c68a7 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -43,6 +43,9 @@ struct cs_etm_packet {
 	u64 start_addr;
 	u64 end_addr;
 	u32 instr_count;
+	u32 last_instr_type;
+	u32 last_instr_subtype;
+	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
 	int cpu;
