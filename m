Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B96C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C52222D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191669;
	bh=fbyBVb3RzYOoCKxaDHT5y2hX46bmgahi6LOZy34ChAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VScF2v4uANCo/CIzI8prh32LFpFG30Nmui7LObHjPtqOtjZ15POKL+XBbCa0nN9ud
	 hB0j6ftUod2ze8Py90plAuRZAUzy0+0YgMGzAwVuW2cYy/xojp3WnYUvPqwHTGJNzp
	 vfahIaN5bDezCkBAtXCezZqwbEzf3OSB80anj6ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfBOArr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbfBOArm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:42 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8039F2229F;
        Fri, 15 Feb 2019 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191661;
        bh=fbyBVb3RzYOoCKxaDHT5y2hX46bmgahi6LOZy34ChAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8H1QGzGRd25kFXby/MbzT65rJrqOkxLv4j3lJaJ6FkqtGWi+BicdKJogzrmHIs2F
         6whSfFhd0YHSt2FJPU5LSX0664waxpwPAoPSehhyAxSDLB62Ld0uebSy97uJ6BPGsT
         76uatpJge5ylizx7yRvdplFK7As6PVOXBXoQFtV0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/43] perf cs-etm: Introducing function cs_etm_decoder__init_dparams()
Date:   Thu, 14 Feb 2019 21:45:22 -0300
Message-Id: <20190215004539.23571-27-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Introducing function cs_etm_decoder__init_dparams() to avoid repeating
code at two different places.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-5-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
 tools/perf/util/cs-etm.c                      | 41 +++++++++++++------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 7e6a8850be4a..663309486784 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -105,9 +105,10 @@ enum {
 	CS_ETM_PROTO_PTM,
 };
 
-enum {
+enum cs_etm_decoder_operation {
 	CS_ETM_OPERATION_PRINT = 1,
 	CS_ETM_OPERATION_DECODE,
+	CS_ETM_OPERATION_MAX,
 };
 
 int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f396fee9bb95..3011c6cae531 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,6 +136,28 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
+static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
+				       struct cs_etm_queue *etmq,
+				       enum cs_etm_decoder_operation mode)
+{
+	int ret = -EINVAL;
+
+	if (!(mode < CS_ETM_OPERATION_MAX))
+		goto out;
+
+	d_params->packet_printer = cs_etm__packet_dump;
+	d_params->operation = mode;
+	d_params->data = etmq;
+	d_params->formatted = true;
+	d_params->fsyncs = false;
+	d_params->hsyncs = false;
+	d_params->frame_aligned = true;
+
+	ret = 0;
+out:
+	return ret;
+}
+
 static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_buffer *buffer)
 {
@@ -182,12 +204,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-	d_params.packet_printer = cs_etm__packet_dump;
-	d_params.operation = CS_ETM_OPERATION_PRINT;
-	d_params.formatted = true;
-	d_params.fsyncs = false;
-	d_params.hsyncs = false;
-	d_params.frame_aligned = true;
+	if (cs_etm__init_decoder_params(&d_params, NULL,
+					CS_ETM_OPERATION_PRINT))
+		return;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
@@ -436,13 +455,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-	d_params.packet_printer = cs_etm__packet_dump;
-	d_params.operation = CS_ETM_OPERATION_DECODE;
-	d_params.formatted = true;
-	d_params.fsyncs = false;
-	d_params.hsyncs = false;
-	d_params.frame_aligned = true;
-	d_params.data = etmq;
+	if (cs_etm__init_decoder_params(&d_params, etmq,
+					CS_ETM_OPERATION_DECODE))
+		goto out_free;
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-- 
2.19.1

