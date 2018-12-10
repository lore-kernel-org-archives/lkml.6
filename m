Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D76C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5382082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P83Jx93Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5382082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLJIxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:53:43 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:46040 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeLJIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:53:42 -0500
Received: by mail-wr1-f47.google.com with SMTP id b14so9527587wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vUyooLcyJUYiK6jffhRtzW6QvVrGY41s8t/va8y//+E=;
        b=P83Jx93Qf7l7qBaSRaK1K3yR6IZ6RtW2bu5lW7VjGrBx2KuWrCUeSsAe+V50Mc8w95
         fhfDgA24iPzUWSoJgyngux5eN41dgd+rs2+8ZriiBvbRa/m7z8eYzxa0QirGPZ5i2EHg
         rKZ4jbQe2VFiiOxqjde3BE6J4nMBy+j6pXJ4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vUyooLcyJUYiK6jffhRtzW6QvVrGY41s8t/va8y//+E=;
        b=odwhZ60NNh5+m4X6avvbBwhs4RCoGSgjj8s766FsQIYIb/FkzHWUe/ewKESoqyQ81z
         H2tiaUAmARmRyXgQqZWtpo8dmM+2BcdJKirokRb3NbL8QKRwA6uq0J5/e6cXqEVHI3qM
         AXymu5VTLPyKqqDUNGlAyeUNOB/6acTJJEstZYIGrLtIygk5X5x1EAmkk0SOZRMWYOec
         DwkuCj/cyfzMQo0gHO7xsyFVkqe5AEyoCrL4v+acmLTSCnw8yPxGfQlgDN7Kucd1Ax5/
         i86xtmO9fi9+3ZKwMlE2SIgCJA/x9VCVzGpvcuhxkjjr0jt1jShFXJXXS62i6gKPF8wC
         rdJg==
X-Gm-Message-State: AA+aEWbQTgn9ej19Zhv/QJxWMWT5OA0tIUoVmHu96yIDiqBsS1Smbg/T
        mw6zD0RjPgOvCguxcLGsfi4SGQ==
X-Google-Smtp-Source: AFSGD/Ut3JQ0s/myU2ZSrcpxk9vzKTFREh4QW++BB6w4HOnQlYlHHdg3rubPwVtlvMXm1OXVegATzg==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr9543064wrn.27.1544432020389;
        Mon, 10 Dec 2018 00:53:40 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 00:53:39 -0800 (PST)
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
Subject: [PATCH v2 5/6] perf cs-etm: Treat EO_TRACE element as trace discontinuity
Date:   Mon, 10 Dec 2018 16:53:00 +0800
Message-Id: <1544431981-24144-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If decoder outputs EO_TRACE element, it means the end of the trace
buffer; this is a discontinuity and in this case the end of trace data
needs to be saved.

This patch generates CS_ETM_DISCONTINUITY packet for EO_TRACE element
hereby flushing the end of trace data in cs-etm.c.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 46b67f1..bcb5c98 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -411,6 +411,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
+	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 		resp = cs_etm_decoder__buffer_discontinuity(decoder,
 							    trace_chan_id);
 		decoder->trace_on = false;
@@ -431,7 +432,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		decoder->packet_buffer[decoder->tail].exc_ret = true;
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
-	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
-- 
2.7.4

