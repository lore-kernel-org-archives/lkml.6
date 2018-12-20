Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EFEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B65218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbeLTSP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:15:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50637 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbeLTSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:15:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIFBGJ3682905
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:15:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIFAQl3682902;
        Thu, 20 Dec 2018 10:15:10 -0800
Date:   Thu, 20 Dec 2018 10:15:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-37bb37168dc1b1f5e3ac791aeecd14ef980764fd@git.kernel.org>
Cc:     namhyung@kernel.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        mike.leach@linaro.org, jolsa@redhat.com, hpa@zytor.com,
        leo.yan@linaro.org, acme@redhat.com, tglx@linutronix.de,
        robert.walker@arm.com
Reply-To: mike.leach@linaro.org, jolsa@redhat.com, namhyung@kernel.org,
          mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
          coresight@lists.linaro.org, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, leo.yan@linaro.org, robert.walker@arm.com,
          acme@redhat.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Git-Commit-ID: 37bb37168dc1b1f5e3ac791aeecd14ef980764fd
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

Commit-ID:  37bb37168dc1b1f5e3ac791aeecd14ef980764fd
Gitweb:     https://git.kernel.org/tip/37bb37168dc1b1f5e3ac791aeecd14ef980764fd
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 11 Dec 2018 15:38:26 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:59 -0300

perf cs-etm: Treat NO_SYNC element as trace discontinuity

The CoreSight tracer driver might insert barrier packets between
different buffers, thus the decoder can spot the boundaries based on the
barrier packet; it is possible for the decoder to hit a barrier packet
and emit a NO_SYNC element, then the decoder will find a periodic
synchronisation point inside that next trace block that starts the trace
again but does not have the TRACE_ON element as indicator - usually
because this trace block has wrapped the buffer so we have lost the
original point when the trace was enabled.

In the first case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
in the middle of the tracing stream, but as we were not handling the
NO_SYNC element properly this ends up making users miss the
discontinuity indications.

Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
output from the decoder, both indicate that the trace data is
discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as a trace
discontinuity and generates a CS_ETM_DISCONTINUITY packet for it, so
cs-etm can handle the discontinuity for this case, finally it saves the
last trace data for the previous trace block and restart samples for the
new block.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-7-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 1039f364f4cc..bee026e76a4c 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_discontinuity(decoder,
 							    trace_chan_id);
