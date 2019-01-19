Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5036CC61CE6
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE93217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMYRDZcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfASBoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:44:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43365 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbfASBo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:44:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so6856583pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7CGHnFgA52zKXZDyd8sb3sbv9trI6e0tJf8G4Od6mhA=;
        b=WMYRDZcJWZlYjwF1keRnofNHQ/JvhjLXBuV4YJrQeX715ddKNk2tbcOviRlR15l1dQ
         0+17juqn231qo7yLpvMLBrExKoWNYpeEb+zrt0VbeW9PuU4S/eHptD0y7nX8eABIPC45
         psLPGy9eTt3CpLPyJvCL8/L63pAy9i7YkA3hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7CGHnFgA52zKXZDyd8sb3sbv9trI6e0tJf8G4Od6mhA=;
        b=RjyO8gWSSHxkTlnI0629SdOEjnG5C/akURsFPIv9yBkmcIaoYO8yGXDVrfgNLv0Ahs
         LhyxdnOD44Z3jS+9mTLfuz8Mv0alzPlrCO0HnSlolgUycwYovbY8ZcK/Ra+MlqlIPDCy
         TmLEaxmf7+snKMrdz0+FVjINT2DFVcPTETsLXLpf0gQtIwJOZttOuhKMh8T8KjzZ8dzG
         xj8SpDFTYRQ7t8y1ew1gpZIuxoU6OJJ4IkDQVdKucAk9L4wYH6JjDW+86oSE6ENVLaly
         vsoWJWD1rptAGPbCG0+pqXGXe00XU2HxAaZf91A6d/Plq/P4Qp8FhOWXah4shytCVnWL
         PJIg==
X-Gm-Message-State: AJcUukdlHMyU9qNu5UqsmRxdvyu/WLzOBO+/6mDI8aKtNffU2Y8Td5Hj
        6BwNMcwTkLdkF9hb86V/+Fdwow==
X-Google-Smtp-Source: ALg8bN6aeSja8/pBhh7EHnw/iobz5oZCKsSD4txnsxNXCWWU5kMDwVSxqnAVn4KyM2HGgGQmsakLjw==
X-Received: by 2002:a65:4646:: with SMTP id k6mr15151021pgr.153.1547862267613;
        Fri, 18 Jan 2019 17:44:27 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com. [50.116.3.24])
        by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:44:27 -0800 (PST)
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
Subject: [PATCH v6 6/8] perf cs-etm: Add traceID in packet
Date:   Sat, 19 Jan 2019 09:43:45 +0800
Message-Id: <20190119014347.27441-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add traceID in packet, thus we can use traceID to retrieve metadata
pointer from traceID-metadata tuple.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
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

