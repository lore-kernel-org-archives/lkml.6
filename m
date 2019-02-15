Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BCE222FE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405111AbfBOJli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:41:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388771AbfBOJli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:41:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9fMRd1118490
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:41:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9fLON1118487;
        Fri, 15 Feb 2019 01:41:21 -0800
Date:   Fri, 15 Feb 2019 01:41:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-65963e5b4dfa9b9ba4bdf7ef8dc7d4424cfd2097@git.kernel.org>
Cc:     suzuki.poulose@arm.com, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        leo.yan@linaro.org, peterz@infradead.org, acme@redhat.com,
        mathieu.poirier@linaro.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
          suzuki.poulose@arm.com, mingo@kernel.org,
          mathieu.poirier@linaro.org, peterz@infradead.org,
          acme@redhat.com, tglx@linutronix.de, leo.yan@linaro.org
In-Reply-To: <20190212171618.25355-5-mathieu.poirier@linaro.org>
References: <20190212171618.25355-5-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Introducing function
 cs_etm_decoder__init_dparams()
Git-Commit-ID: 65963e5b4dfa9b9ba4bdf7ef8dc7d4424cfd2097
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

Commit-ID:  65963e5b4dfa9b9ba4bdf7ef8dc7d4424cfd2097
Gitweb:     https://git.kernel.org/tip/65963e5b4dfa9b9ba4bdf7ef8dc7d4424cfd2097
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:09 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:06 -0300

perf cs-etm: Introducing function cs_etm_decoder__init_dparams()

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
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
 tools/perf/util/cs-etm.c                        | 41 +++++++++++++++++--------
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
 
