Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358B92083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHGHp8jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfA2MaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:30:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42256 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbfA2MaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:30:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so9579483pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LDRQG3UQxntyoi7kv39dKKGog1UFkbBd0dWoL+G3ZRM=;
        b=eHGHp8jRAaV2wgbhIwcjRebSMqSMyg5DgX3bonjkii4dOULdoXvKBmMVhWht8D7sm5
         kFHsfDvgvkrWZUb7WHcFWcjsyo89XO3owhDeFlz/exocxsTJdIjmuFp9/Q1/d9G1TGKr
         Ktft7EuXXzo0VnJKyRvEc7MgaPw+sYIeLkHLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LDRQG3UQxntyoi7kv39dKKGog1UFkbBd0dWoL+G3ZRM=;
        b=pSn+aJYRlHj+T8A4K+Ge82cjoREG/26M+nhTlzFr+6I4uWSdavbB+QEilheUEEBl7p
         XpVktydd48ZiHcVcr9FIrAjl4usW94rBfyy9gwT1tqgjzwHa/wc5rD/I2Hi6/QMTL7YX
         vee8dl1T3JYaIEWjwZejUT8JtcWbj8G1OXqY7JUPnZpGRMM/tiHJzIllmdpvA2XQTikX
         mveqRgqw/4MlDKR2glav85Bzs/y9jw51BdAHBCsNbgyiVQPbb8FiUHTMuP9YG7NyyOsi
         cOjLXQqb6zpLDQ1hoiqyHidzS3M9B/CpC9JkMqtxw5BZd2+aum6YR5PFYKSvM+wQN1/q
         nO7A==
X-Gm-Message-State: AJcUukfBPppbCxDLPMAKww7O/DQNVWjmaY5Xwek0enRR7CU4/cWhnuse
        +4j80CZq79E5PxxRAALTFQamzA==
X-Google-Smtp-Source: ALg8bN5M9hEaCXFh08ImUUli+TbqWwAfB21tD78s+oHZkSQ7jMZBUbR9nUnqtuFbeIBnpKljlbP1YQ==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr23992275pgc.25.1548765015042;
        Tue, 29 Jan 2019 04:30:15 -0800 (PST)
Received: from localhost.localdomain (li569-141.members.linode.com. [192.155.82.141])
        by smtp.gmail.com with ESMTPSA id h64sm59552502pfc.142.2019.01.29.04.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:30:14 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 6/8] perf cs-etm: Add traceID in packet
Date:   Tue, 29 Jan 2019 20:28:40 +0800
Message-Id: <20190129122842.32041-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129122842.32041-1-leo.yan@linaro.org>
References: <20190129122842.32041-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add traceID in packet, thus we can use traceID to retrieve metadata
pointer from traceID-metadata tuple.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cdd38ffd10d2..ba4c623cd8de 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -295,6 +295,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].flags = 0;
 		decoder->packet_buffer[i].exception_number = UINT32_MAX;
+		decoder->packet_buffer[i].trace_chan_id = UINT8_MAX;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_cond = 0;
 	decoder->packet_buffer[et].flags = 0;
 	decoder->packet_buffer[et].exception_number = UINT32_MAX;
+	decoder->packet_buffer[et].trace_chan_id = trace_chan_id;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 012b4728a46f..7e6a8850be4a 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -50,6 +50,7 @@ struct cs_etm_packet {
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
+	u8 trace_chan_id;
 	int cpu;
 };
 
-- 
2.17.1

