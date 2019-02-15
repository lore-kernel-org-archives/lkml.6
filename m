Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F56C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9FE222FD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393191AbfBOJm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:42:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389363AbfBOJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:42:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9geFC1118829
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:42:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9geY11118826;
        Fri, 15 Feb 2019 01:42:40 -0800
Date:   Fri, 15 Feb 2019 01:42:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-2507a3d982f2968168b53f4d1e67774d68f79b0c@git.kernel.org>
Cc:     leo.yan@linaro.org, mathieu.poirier@linaro.org, mingo@kernel.org,
        suzuki.poulose@arm.com, tglx@linutronix.de, jolsa@redhat.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com
Reply-To: leo.yan@linaro.org, mathieu.poirier@linaro.org, mingo@kernel.org,
          suzuki.poulose@arm.com, tglx@linutronix.de, jolsa@redhat.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190212171618.25355-7-mathieu.poirier@linaro.org>
References: <20190212171618.25355-7-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Introducing function
 cs_etm__init_trace_params()
Git-Commit-ID: 2507a3d982f2968168b53f4d1e67774d68f79b0c
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

Commit-ID:  2507a3d982f2968168b53f4d1e67774d68f79b0c
Gitweb:     https://git.kernel.org/tip/2507a3d982f2968168b53f4d1e67774d68f79b0c
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:11 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:06 -0300

perf cs-etm: Introducing function cs_etm__init_trace_params()

The trace parameter initialisation code is repeated in two different
places, something that bloats the file and can lead to errors.  This
is fixed by introducing a helper function and calling the right
protocol initialisation code when required.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-7-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 112 +++++++++++++++++++++++------------------------
 tools/perf/util/cs-etm.h |   4 +-
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index aac07f950074..f3a6dfaf3026 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,6 +136,57 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
+static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx,
+					  u32 etmidr)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
+	t_params[idx].etmv3.reg_ctrl = metadata[idx][CS_ETM_ETMCR];
+	t_params[idx].etmv3.reg_trc_id = metadata[idx][CS_ETM_ETMTRACEIDR];
+}
+
+static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = CS_ETM_PROTO_ETMV4i;
+	t_params[idx].etmv4.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
+	t_params[idx].etmv4.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
+	t_params[idx].etmv4.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
+	t_params[idx].etmv4.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
+	t_params[idx].etmv4.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
+	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
+}
+
+static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
+				     struct cs_etm_auxtrace *etm)
+{
+	int i;
+	u32 etmidr;
+	u64 architecture;
+
+	for (i = 0; i < etm->num_cpu; i++) {
+		architecture = etm->metadata[i][CS_ETM_MAGIC];
+
+		switch (architecture) {
+		case __perf_cs_etmv3_magic:
+			etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+			cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
+			break;
+		case __perf_cs_etmv4_magic:
+			cs_etm__set_trace_param_etmv4(t_params, etm, i);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 				       struct cs_etm_queue *etmq,
 				       enum cs_etm_decoder_operation mode)
@@ -161,7 +212,7 @@ out:
 static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_buffer *buffer)
 {
-	int i, ret;
+	int ret;
 	const char *color = PERF_COLOR_BLUE;
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params *t_params;
@@ -179,33 +230,8 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		return;
 
-	for (i = 0; i < etm->num_cpu; i++) {
-		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-
-			t_params[i].protocol =
-					cs_etm__get_v7_protocol_version(etmidr);
-			t_params[i].etmv3.reg_ctrl =
-					etm->metadata[i][CS_ETM_ETMCR];
-			t_params[i].etmv3.reg_trc_id =
-					etm->metadata[i][CS_ETM_ETMTRACEIDR];
-		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
-						      __perf_cs_etmv4_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-			t_params[i].etmv4.reg_idr0 =
-					etm->metadata[i][CS_ETMV4_TRCIDR0];
-			t_params[i].etmv4.reg_idr1 =
-					etm->metadata[i][CS_ETMV4_TRCIDR1];
-			t_params[i].etmv4.reg_idr2 =
-					etm->metadata[i][CS_ETMV4_TRCIDR2];
-			t_params[i].etmv4.reg_idr8 =
-					etm->metadata[i][CS_ETMV4_TRCIDR8];
-			t_params[i].etmv4.reg_configr =
-					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-			t_params[i].etmv4.reg_traceidr =
-					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
-		}
-	}
+	if (cs_etm__init_trace_params(t_params, etm))
+		goto out_free;
 
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
@@ -382,7 +408,6 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 						unsigned int queue_nr)
 {
-	int i;
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
@@ -431,33 +456,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		goto out_free;
 
-	for (i = 0; i < etm->num_cpu; i++) {
-		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-
-			t_params[i].protocol =
-					cs_etm__get_v7_protocol_version(etmidr);
-			t_params[i].etmv3.reg_ctrl =
-					etm->metadata[i][CS_ETM_ETMCR];
-			t_params[i].etmv3.reg_trc_id =
-					etm->metadata[i][CS_ETM_ETMTRACEIDR];
-		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
-							__perf_cs_etmv4_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-			t_params[i].etmv4.reg_idr0 =
-					etm->metadata[i][CS_ETMV4_TRCIDR0];
-			t_params[i].etmv4.reg_idr1 =
-					etm->metadata[i][CS_ETMV4_TRCIDR1];
-			t_params[i].etmv4.reg_idr2 =
-					etm->metadata[i][CS_ETMV4_TRCIDR2];
-			t_params[i].etmv4.reg_idr8 =
-					etm->metadata[i][CS_ETMV4_TRCIDR8];
-			t_params[i].etmv4.reg_configr =
-					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-			t_params[i].etmv4.reg_traceidr =
-					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
-		}
-	}
+	if (cs_etm__init_trace_params(t_params, etm))
+		goto out_free;
 
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index d76126e0e3d0..0e97c196147a 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -105,8 +105,8 @@ struct intlist *traceid_list;
 
 #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
 
-static const u64 __perf_cs_etmv3_magic   = 0x3030303030303030ULL;
-static const u64 __perf_cs_etmv4_magic   = 0x4040404040404040ULL;
+#define __perf_cs_etmv3_magic 0x3030303030303030ULL
+#define __perf_cs_etmv4_magic 0x4040404040404040ULL
 #define CS_ETMV3_PRIV_SIZE (CS_ETM_PRIV_MAX * sizeof(u64))
 #define CS_ETMV4_PRIV_SIZE (CS_ETMV4_PRIV_MAX * sizeof(u64))
 
