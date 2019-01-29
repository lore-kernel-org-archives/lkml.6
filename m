Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E20C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DB92083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMhZ5/O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfA2M3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:29:54 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:36681 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2M3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:29:52 -0500
Received: by mail-pf1-f182.google.com with SMTP id b85so9599799pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=euu22pFQ6c9B3mZ1+UtLKySuzqAo82xzEXBgVuSFGfs=;
        b=AMhZ5/O1hNqtAFBJUQruSRENmMh8lJg50fOVNoKhhzNkp8NA9s7yvPtNzKen+3YJG6
         NUy8pnxLr5ZTx4OoqZTa1yDkaZnGz1VdeXBE77mXtYqat31xRQfRjh0touot1/iulW2j
         idEpIUGkLisvveyAZUiytbe6EauWO4R1IOHBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=euu22pFQ6c9B3mZ1+UtLKySuzqAo82xzEXBgVuSFGfs=;
        b=pK1SGfOD7ScyP2V5xOvSL0U2GL/EXP3CrF64dnAjQaFgrj/ZgEdceorXHuyQNuDP3F
         BCr6U8qzsNbaw4rxfXW1WSKbJYg05fpZL7HqIC1v5hfItUzQKmpu6rBveW2SgsjK4rv+
         x3lRTQOHqKXAU+RYkq+hKC/Mxbl1wICRjxQvTEuulyNMnEUzzqhPpJ2vVvWLX18O3P49
         8RVeLFr/Ig8PcvzDnzS7h3Rmdu+LmQQdRk0GN6m6TbQZaj+xGk1Li4KBfF/RUJuhBPFq
         3B0JBKRXi+ICBD+4duOpP3pUvcLN5xN4c6gTX2n/dJk9WW6eZmdbVq3HlF3DvZo2S254
         l0SQ==
X-Gm-Message-State: AJcUukePBH37vXqMf4PkN9Ma6+6/rL0u6L/fJ6tpD8XomTysCQSrFLSe
        KBKXHuzSSPRCZnZyRMSRpvNVdw==
X-Google-Smtp-Source: ALg8bN5AZJ3hYW8LJ/8abK5HrGwAgGNgr9Y3cXE3kcvTXJPyONe32Aqfm/CCN7ALlhicQyTc1a4R+A==
X-Received: by 2002:a63:d747:: with SMTP id w7mr22989225pgi.360.1548764991762;
        Tue, 29 Jan 2019 04:29:51 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com. [192.155.82.141])
        by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:29:51 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 1/8] perf cs-etm: Add last instruction information in packet
Date:   Tue, 29 Jan 2019 20:28:35 +0800
Message-Id: <20190129122842.32041-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129122842.32041-1-leo.yan@linaro.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decoder provides last instruction related information, these information
can be used for trace analysis; specifically we can get to know what
kind of branch instruction has been executed, mainly the information
are contained in three element fields:

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
-- 
2.17.1

