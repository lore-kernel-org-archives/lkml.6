Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E009C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0103218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171054;
	bh=cV+EWGCRKnKm1DJ1KLIkyVctuTBV9Z0WKj287fkcmBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DF+M+elcnQP8mz6fiqjmW8eZzwCumWDPQudTRN+G1u141FWGE+dVh772we6/Wn6ws
	 9KuxXT/2eWYfuYb2jInd6icYpk+kkVQxHw5PCTYkVIgHFqpoyCVYX+kKM2O5470WvI
	 UGeDhSN1L7xUiOw/Ic3JhlmUnwEQTLYRw+pZHdoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeLRWKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeLRWKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:10:51 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC28217D9;
        Tue, 18 Dec 2018 22:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171051;
        bh=cV+EWGCRKnKm1DJ1KLIkyVctuTBV9Z0WKj287fkcmBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdwzuoghBI4wfKX/C0uq8Uekn/FGzX03KX9zup9NgNq1dHXmToQE3cqVs1xuQcNm9
         zuBfYowSkxCc0Ptkpx8JzbDVz+ECwr+HVqOUVDQ8VXBp2RA1ygqFN4y++HrQ6b7VN+
         trDBxxzs+b0FhXO4rwCj0Rx6as938zmKaax0WlmQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight ml <coresight@lists.linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/63] perf cs-etm: Treat NO_SYNC element as trace discontinuity
Date:   Tue, 18 Dec 2018 19:07:01 -0300
Message-Id: <20181218220733.15839-32-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

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
-- 
2.19.2

