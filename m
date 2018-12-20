Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28740C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0342E218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeLTSP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:15:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbeLTSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:15:55 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIFj8B3682950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:15:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIFj3U3682947;
        Thu, 20 Dec 2018 10:15:45 -0800
Date:   Thu, 20 Dec 2018 10:15:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-02e7e2509e939b50f4f1b14c08b97f60256df3ea@git.kernel.org>
Cc:     hpa@zytor.com, namhyung@kernel.org, mike.leach@linaro.org,
        leo.yan@linaro.org, mathieu.poirier@linaro.org, acme@redhat.com,
        jolsa@redhat.com, robert.walker@arm.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          namhyung@kernel.org, leo.yan@linaro.org,
          mathieu.poirier@linaro.org, mike.leach@linaro.org,
          acme@redhat.com, robert.walker@arm.com, jolsa@redhat.com,
          hpa@zytor.com
In-Reply-To: <1544513908-16805-8-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-8-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Treat EO_TRACE element as trace
 discontinuity
Git-Commit-ID: 02e7e2509e939b50f4f1b14c08b97f60256df3ea
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

Commit-ID:  02e7e2509e939b50f4f1b14c08b97f60256df3ea
Gitweb:     https://git.kernel.org/tip/02e7e2509e939b50f4f1b14c08b97f60256df3ea
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 11 Dec 2018 15:38:27 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:59 -0300

perf cs-etm: Treat EO_TRACE element as trace discontinuity

If the decoder outputs an EO_TRACE element, it means the end of the
trace buffer; this is a discontinuity and in this case the end of trace
data needs to be saved.

This patch generates a CS_ETM_DISCONTINUITY packet for the EO_TRACE
element hereby flushing the end of trace data in cs-etm.c.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-8-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index bee026e76a4c..cda6f074bd03 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -409,6 +409,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	switch (elem->elem_type) {
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
+	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_discontinuity(decoder,
@@ -425,7 +426,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		decoder->packet_buffer[decoder->tail].exc_ret = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
-	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
