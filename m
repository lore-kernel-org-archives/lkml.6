Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B26C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0424D208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131829;
	bh=Pp1BSJqGnr8Zlu4LoVIpB9sL2Ft59alVyavz5fTV3dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y582CTZFEL1yrDKeqxWzRrzDntthMW1/G8iyDR3tk7ZumzcLB938Rh7CY+OJJCcUC
	 0cm2IwitFI47Dc8mj1iFx2jgKbnuVFvTRU0epm45E/or4NiYMqDY/Lce7KoYkVQxED
	 +xQxrojM4SkNxogwSxOs5gSHKWSetezq7SuDf3Lw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0424D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeLFVa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeLFVaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:24 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C50D1208E7;
        Thu,  6 Dec 2018 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131823;
        bh=Pp1BSJqGnr8Zlu4LoVIpB9sL2Ft59alVyavz5fTV3dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUKaAUv5n2GHvd3fDyF1AtZ70d0ITdFyp49lne2ILHuAyX+6ysq7+44cCz+yLmPOI
         NTMdfkLIMtIz+EZe+DQTQyBlsZhvrXwpk3IA9HRIwS00icgBgSL2rXSBdUgfIShmEm
         W34bWijZHTI8nWgfDHaKKXFAU6IHgrHX2GUGYl7A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 59/75] perf cs-etm: Add support for PTMv1.1 decoding
Date:   Thu,  6 Dec 2018 18:25:46 -0300
Message-Id: <20181206212602.20474-60-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

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
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++--
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                      | 23 +++++++++++++++++--
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
-- 
2.19.2

