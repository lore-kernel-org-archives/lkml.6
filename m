Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E570BC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B319D21738
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZsfAJvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfASBoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:44:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43277 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbfASBoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:44:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so7423012pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/5nYzCIEonlNYJwustO+jm4nIH/Vxt/bPuViPJ/LH/8=;
        b=EZsfAJvSkY0JpLAG58uwHeVgtm7PsF23KfAEWoyRjoyzJwjDTosNRAdCgkT313oLM8
         bzhOZZyiI66l6s8ZZuOQKuP90WeRlCjou5eGcYsbL1SK/DgAgJaGoXs38uiUKiSz+hia
         OAdOz9gvbXx6g7LU2+WzjLo4aXJBbuWIpgFmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/5nYzCIEonlNYJwustO+jm4nIH/Vxt/bPuViPJ/LH/8=;
        b=RWJRwhLzx3t9O04nLjcMpwSLiESEL+uxVdQzYub2ZesYv+ZTVVCKzgdsAZmWvjMish
         q8HoIO+215q5eKtapoMqwmM/4Md5oGEkC3Ml1T9SCvNOrf+QIOAurQ1ITNW+g/3pNsda
         YAOu+WkESsRQthBpVyIsFlXIf1vvA2rFpUk3rHXH7qOPUVtmrgglTdFdJmanypgyxyjl
         GAbLiemGjNzSGaHE5oh7DjcXO6ix4+3ISZPnExfzlaQFvr7KBXUhhg09BbUY2+GRVZII
         O0iJSQkJZdve5Ex+0s6uzRcA/IZL4ZpfClnZvSGhF61SOQgLegL2fT5i+uqFDj6myTv9
         2mlQ==
X-Gm-Message-State: AJcUukd+i5hsxfPPpGCFxJePpuYr3hHlRT+FVbUTx9F2f9OgeoNFmjpo
        tE9fGtvIxJ5C48XE5/1C5x0p0Q==
X-Google-Smtp-Source: ALg8bN7utYYHnDkIWUL0WAmsm4uj5ug1y+j9IQg8I7m/UCyn3g3sm+bsxjHulxXc3IgXcz5tLUdVoQ==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr21124099pfi.95.1547862260243;
        Fri, 18 Jan 2019 17:44:20 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com. [50.116.3.24])
        by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:44:19 -0800 (PST)
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
Subject: [PATCH v6 4/8] perf cs-etm: Add exception number in exception packet
Date:   Sat, 19 Jan 2019 09:43:43 +0800
Message-Id: <20190119014347.27441-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an exception packet comes, it contains the information for
exception number; the exception number indicates the exception types,
so from it we can know if the exception is taken for interrupt,
system call or other traps, etc.

This patch simply adds a field in cs_etm_packet struct, it records
exception number for exception packet that will then be used to
properly identify exception types to the perf synthesize mechanic.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 +++++++++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e98ee49a1527..294efa76c9e3 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -294,6 +294,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_subtype = 0;
 		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].flags = 0;
+		decoder->packet_buffer[i].exception_number = UINT32_MAX;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_subtype = 0;
 	decoder->packet_buffer[et].last_instr_cond = 0;
 	decoder->packet_buffer[et].flags = 0;
+	decoder->packet_buffer[et].exception_number = UINT32_MAX;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -406,10 +408,20 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
-{
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_EXCEPTION);
+{	int ret = 0;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_EXCEPTION);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+	packet->exception_number = elem->exception_number;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
@@ -443,7 +455,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder,
+		resp = cs_etm_decoder__buffer_exception(decoder, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 23600e57a215..012b4728a46f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -46,6 +46,7 @@ struct cs_etm_packet {
 	u32 last_instr_type;
 	u32 last_instr_subtype;
 	u32 flags;
+	u32 exception_number;
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
-- 
2.17.1

