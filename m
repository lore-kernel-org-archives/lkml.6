Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6551DC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5F20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiIUh07K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF5F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeLJIxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:53:39 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38722 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeLJIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:53:38 -0500
Received: by mail-wm1-f42.google.com with SMTP id m22so10301936wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 00:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WgMRTLtOLhYT8FlarRUnYgdidlPs5flIzaegKvjmyYI=;
        b=EiIUh07KJ15nJAm0JkYmA6j0bfQk4wTHlH9S3w0vtyejd92gNNVA5+lB0Eg1QJSXxS
         znaz8c/sHTTuS60A565mN+yxnk5kPhiU58zhjcfDiArb+dsolwlfdQ/COw1ppFfum8nb
         FiwC5dTXlXR6XSd/DmNcLcKosB7fM4xj0KPIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WgMRTLtOLhYT8FlarRUnYgdidlPs5flIzaegKvjmyYI=;
        b=agXg9P1Qop5wu2iZL0odOM7ubneZz/rpRRNOf4axTTNdeoR2EUxKLT+oGgJ1cBCCDk
         2ONAjqj7FgvHwWcDDK5J/Hd+GqcYeul2sLx8Fh0UtX8J+NqHwds9cK4fxN0iP9jmGhE7
         t/fvJL43+DrNJFtxBYb5mCkY8h5Tq3SHHS47ijPB5e8gWrqXz7mGRL9bIY1wnQxXyX7w
         JJlRTmayKspznzWk+SDtlkus+nXDm2dF8Ca5j1CAfijqQRBFO98dWGfo8wWITnwKqYkA
         Pc1MHleRQA+kc8LQPtPYw3MdRueGvESTwqM0EYnifKlG6GQPvwzYdd/f9cFhcWfj/ugR
         giIg==
X-Gm-Message-State: AA+aEWbl2lh2D/U73Lt5TY8k42+J3BlOKdG2PLaRyahTFOhw+eCpvK21
        Q6xdruqlGAEalRmtnYenNJOCfg==
X-Google-Smtp-Source: AFSGD/WSXfc8yKKG9ujEQqfUTAEU+FQc1AK54t1aAmHlrcluJAloPpPjcl35cY6wEhgiunaE3kAnsA==
X-Received: by 2002:a1c:a485:: with SMTP id n127mr10064898wme.15.1544432016030;
        Mon, 10 Dec 2018 00:53:36 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 00:53:35 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: [PATCH v2 4/6] perf cs-etm: Treat NO_SYNC element as trace discontinuity
Date:   Mon, 10 Dec 2018 16:52:59 +0800
Message-Id: <1544431981-24144-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight tracer driver might insert barrier packet between different
buffers, thus the decoder can spot the boundaries based on the barrier
packet; the decoder is possible to hit a barrier packet and emit a
NO_SYNC element, then the decoder will find a periodic synchronisation
point inside that next trace block that starts trace again but does not
have the TRACE_ON element as indicator - usually because this block of
trace has wrapped the buffer so we have lost the original point that
trace was enabled.

In upper case, it results in the trace stream only inserts the
OCSD_GEN_TRC_ELEM_NO_SYNC element in the middle of tracing stream, but
we don't handle NO_SYNC element properly and at the end users miss to
see the info for trace discontinuity.

Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
output from the decoder, but both of them indicate the trace data is
discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
cs-etm can handle discontinuity for this case, finally it saves the last
trace data for previous trace block and restart samples for new block.

Credit to Mike Leach and Robert Walker who made me clear for underlying
mechanism for NO_SYNC element, Mike also shared with me for detailed
explanation for why we can treat NO_SYNC and TRACE_ON elements as the
same, so this commit log reused most of his explanation.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index a3994f1..46b67f1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -411,6 +411,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
+		resp = cs_etm_decoder__buffer_discontinuity(decoder,
+							    trace_chan_id);
 		decoder->trace_on = false;
 		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-- 
2.7.4

