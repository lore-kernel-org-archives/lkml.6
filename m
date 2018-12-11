Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF57C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70E720849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+dbz6iU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70E720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLKHky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:40:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:40:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so12986694wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6aboUTCwaj4TA/VXlzMLvpQGBMMzsatHH0Kix/jICo=;
        b=J+dbz6iU8ewWu0saYvBbMMYJmMeQuz/VHbn5m1CTalri8JzMCpqLROwpq1G3yGAVEO
         l5kxfqbZMF8o4TnNe04jEiR1zruc+MyFPibD5YXTW22GzWPgSsJJQ7UYp/KOWP8A5MlS
         Oi++7stK9UD7kswvx/7HRXrnxdmGTa6aousv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s6aboUTCwaj4TA/VXlzMLvpQGBMMzsatHH0Kix/jICo=;
        b=LioBf3d470oEWzFcy4JYiWw5erk0AgIpT2YelX/adWRn8wgFWJogTL0/6qiVSFsItc
         9a2fGD7tdtXDgWJNLHY0ufnkI/S+WaFpYzFChuISJ9izLn+bCX/XMqIptnEHAq06JgOt
         kfFNGEUgBCg/Aooae8PImguN6zZSiG5VnAY5RX+xnNOJti/Vr8mgOxcuTudKhfoAHn9z
         G/UFYGE/ZWS1/S5fxdbSu1o5p7e9Q715Kq3Xuk2IrPkPDtJKHIsziE5y7wf9WPlFWy/9
         +W3oyBEkaU1V3lP9CGf8pEkRCmqMaop29j1Mb9gLOu341MddmHK3dlL7GC6jmGa2w6+r
         p+Wg==
X-Gm-Message-State: AA+aEWb6iu8DfdO6/yFOlb5wkI+vFD4s51XXqD8ed+Crg+iadX8r5+IV
        LJFDqfn6WCu0JMQlORPXQUVOKw==
X-Google-Smtp-Source: AFSGD/VRBEwILLZAC4QOSgQ9/7OLPWBsrOEDNOzaXyNMwPmAO8U8CHi4WocLQpfrlGM+2erTp/VfCA==
X-Received: by 2002:adf:f308:: with SMTP id i8mr11822984wro.219.1544514051589;
        Mon, 10 Dec 2018 23:40:51 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:40:50 -0800 (PST)
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
Subject: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace discontinuity
Date:   Tue, 11 Dec 2018 15:38:26 +0800
Message-Id: <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
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

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 1039f364..bee026e 100644
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
2.7.4

