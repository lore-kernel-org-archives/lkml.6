Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB152082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cp9KUPnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB152082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbeLKHlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:41:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:40:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so12986907wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqaxBZzT/ny60CVvOS0lgH0CrB/BIasRrsWm7IM5vG8=;
        b=Cp9KUPnhAQUAo/JG52hN0Hj6I5CbvZjECAnZPG+Sf1GU+t3GohIfKw+LUziR1KXtx6
         aMLkIqe1sEoANZKEduQIuphsllazBVrJpYfdlxczQEMm2Zsn64UoE/cToRV6x7AwB+6l
         kR96G57ANDDlB/OU0QQWA6ygrvwAkhKtdOrYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HqaxBZzT/ny60CVvOS0lgH0CrB/BIasRrsWm7IM5vG8=;
        b=D3XSF7r8NniSyVbJD3QISaicHtdEj5ROoMPb288vH/CyfE1EAX4teTkO/OKhaGKkN9
         tqFCDxiYVK1QlmwGI/klPgnq4/9zSOVhIr6hSSEBnW6iKnby8TqEv84ZgtIubVf6+xTd
         5FSAgV0jniyrhq/n/KIJD44RktEaLvGFlKJL5bvD9JCtdy5qRKWsRClPXlSZmc9LLoOT
         eRTX+O5LInKK4FJu1J5THWGxZf22Grk9tinzO1CSJqvjW5JsL6WMaeYr2SDZXywPRUdc
         xL6aNzkw34jIrGdm8QpyhPzCq0Hilbf53IIGsb6JoK2S2MOgAmxR3EuqOrulO9zz5DV2
         kefA==
X-Gm-Message-State: AA+aEWYgkTwsfCY5RxLq2zpZzKO5isGt1NoB6if43ArCBrfJhhU8QGG0
        N3ogBADg4RAAniX53UAYaoZcbg==
X-Google-Smtp-Source: AFSGD/V88XEhcCiMiRqFCj7p8GiJO5XjSLLUncVEsWc4jQ5tpKsBPOBawZz1yltxUZU7QR6eQy4PQw==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr12847975wrt.264.1544514056667;
        Mon, 10 Dec 2018 23:40:56 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:40:55 -0800 (PST)
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
Subject: [PATCH v3 7/8] perf cs-etm: Treat EO_TRACE element as trace discontinuity
Date:   Tue, 11 Dec 2018 15:38:27 +0800
Message-Id: <1544513908-16805-8-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If decoder outputs EO_TRACE element, it means the end of the trace
buffer; this is a discontinuity and in this case the end of trace data
needs to be saved.

This patch generates CS_ETM_DISCONTINUITY packet for EO_TRACE element
hereby flushing the end of trace data in cs-etm.c.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index bee026e..cda6f07 100644
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
-- 
2.7.4

