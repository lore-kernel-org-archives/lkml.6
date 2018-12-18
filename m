Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C895C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5A0217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLROUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:20:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeLROUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:20:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEJufk2855447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:19:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEJuxN2855444;
        Tue, 18 Dec 2018 06:19:56 -0800
Date:   Tue, 18 Dec 2018 06:19:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-15a5cd19627a3046e7b66626abdeed3f92daafd2@git.kernel.org>
Cc:     jolsa@redhat.com, mathieu.poirier@linaro.org, namhyung@kernel.org,
        hpa@zytor.com, acme@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: alexander.shishkin@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
          mathieu.poirier@linaro.org, acme@redhat.com, hpa@zytor.com
In-Reply-To: <1543955944-10042-4-git-send-email-mathieu.poirier@linaro.org>
References: <1543955944-10042-4-git-send-email-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Add support for PTMv1.1 decoding
Git-Commit-ID: 15a5cd19627a3046e7b66626abdeed3f92daafd2
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

Commit-ID:  15a5cd19627a3046e7b66626abdeed3f92daafd2
Gitweb:     https://git.kernel.org/tip/15a5cd19627a3046e7b66626abdeed3f92daafd2
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 4 Dec 2018 13:39:04 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:01 -0300

perf cs-etm: Add support for PTMv1.1 decoding

This patch is re-using the mechanic set forth by ETMv3 to add support
for PTM decoding.  Configuration for both encoding protocol is similar
but the generated stream itself is very different, hence requiring
special handling.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1543955944-10042-4-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 23 +++++++++++++++++++++--
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 952d1f43f3fa..0b4c8629f578 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -256,8 +256,11 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
 
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
+	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+							OCSD_BUILTIN_DCD_ETMV3 :
+							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
@@ -453,8 +456,11 @@ static int cs_etm_decoder__create_etm_packet_decoder(
 
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
+	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+							OCSD_BUILTIN_DCD_ETMV3 :
+							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 6b5525410a43..b295dd2b8292 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -96,6 +96,7 @@ enum {
 	CS_ETM_PROTO_ETMV3 = 1,
 	CS_ETM_PROTO_ETMV4i,
 	CS_ETM_PROTO_ETMV4d,
+	CS_ETM_PROTO_PTM,
 };
 
 enum {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 76e509c32a28..23159c33db2a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -83,6 +83,19 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid, u64 time_);
 
+/* PTMs ETMIDR [11:8] set to b0011 */
+#define ETMIDR_PTM_VERSION 0x00000300
+
+static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
+{
+	etmidr &= ETMIDR_PTM_VERSION;
+
+	if (etmidr == ETMIDR_PTM_VERSION)
+		return CS_ETM_PROTO_PTM;
+
+	return CS_ETM_PROTO_ETMV3;
+}
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -115,7 +128,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+
+			t_params[i].protocol =
+					cs_etm__get_v7_protocol_version(etmidr);
 			t_params[i].etmv3.reg_ctrl =
 					etm->metadata[i][CS_ETM_ETMCR];
 			t_params[i].etmv3.reg_trc_id =
@@ -366,7 +382,10 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+
+			t_params[i].protocol =
+					cs_etm__get_v7_protocol_version(etmidr);
 			t_params[i].etmv3.reg_ctrl =
 					etm->metadata[i][CS_ETM_ETMCR];
 			t_params[i].etmv3.reg_trc_id =
