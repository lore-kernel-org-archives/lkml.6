Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF7CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13BC20855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBIMyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:54:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:54:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CqrBo2632962
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:52:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CqrX12632959;
        Sat, 9 Feb 2019 04:52:53 -0800
Date:   Sat, 9 Feb 2019 04:52:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-465eaaa89e2b7e450d53f4d3a6845f0c595a5f59@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        coresight@lists.linaro.org, alexander.shishkin@linux.intel.com,
        suzuki.poulose@arm.com, leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, robert.walker@arm.com,
        namhyung@kernel.org, jolsa@redhat.com
Reply-To: robert.walker@arm.com, namhyung@kernel.org, jolsa@redhat.com,
          leo.yan@linaro.org, suzuki.poulose@arm.com,
          mike.leach@linaro.org, mathieu.poirier@linaro.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
          mingo@kernel.org, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190129122842.32041-4-leo.yan@linaro.org>
References: <20190129122842.32041-4-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Set sample flags for trace
 discontinuity
Git-Commit-ID: 465eaaa89e2b7e450d53f4d3a6845f0c595a5f59
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

Commit-ID:  465eaaa89e2b7e450d53f4d3a6845f0c595a5f59
Gitweb:     https://git.kernel.org/tip/465eaaa89e2b7e450d53f4d3a6845f0c595a5f59
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 29 Jan 2019 20:28:37 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf cs-etm: Set sample flags for trace discontinuity

In the middle of trace stream, it might be interrupted thus the trace
data is not continuous, the trace stream firstly is ended for previous
trace block and restarted for next block.

To display related information for showing trace is restarted, this
patch set sample flags for trace discontinuity:

- If one discontinuity packet is coming, append flag
  PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
  has been ended;
- If one instruction packet is following discontinuity packet, this
  instruction packet is the first one packet to restarting trace.  So
  set flag PERF_IP_FLAG_TRACE_START to discontinuity packet, this flag
  will be used to generate sample when connect with the sequential
  instruction packet.

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
Link: http://lkml.kernel.org/r/20190129122842.32041-4-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d05cac5295f1..1aa29633ce77 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1111,6 +1111,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_packet *packet = etmq->packet;
+	struct cs_etm_packet *prev_packet = etmq->prev_packet;
 
 	switch (packet->sample_type) {
 	case CS_ETM_RANGE:
@@ -1170,8 +1171,26 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
 			packet->flags = PERF_IP_FLAG_BRANCH |
 					PERF_IP_FLAG_RETURN;
+
+		/*
+		 * Decoder might insert a discontinuity in the middle of
+		 * instruction packets, fixup prev_packet with flag
+		 * PERF_IP_FLAG_TRACE_BEGIN to indicate restarting trace.
+		 */
+		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_BEGIN;
 		break;
 	case CS_ETM_DISCONTINUITY:
+		/*
+		 * The trace is discontinuous, if the previous packet is
+		 * instruction packet, set flag PERF_IP_FLAG_TRACE_END
+		 * for previous packet.
+		 */
+		if (prev_packet->sample_type == CS_ETM_RANGE)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_END;
+		break;
 	case CS_ETM_EXCEPTION:
 	case CS_ETM_EXCEPTION_RET:
 	case CS_ETM_EMPTY:
