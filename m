Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BF5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8626E218DA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479096;
	bh=jTmWGdRh4A7qeDyLncOFpw+Bu1NzoIng5ndfrmuJASI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bwiKkqWtiwNmh/7TslvXfE2UaL8nzD497z59ZQyny2EdlfQb1l9MzCPXV5OX42YwM
	 ocxSHbjPmhKcAbbbYFDjondILnFoozA3Hvyrb65nsJ0f8QeNqw3arYjwYSjZNtHb8x
	 8c1M8RBZmcCBmYjveol8xemJfcjnYSkmVHLZ4AH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfBFSve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfBFSvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:31 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61112206DD;
        Wed,  6 Feb 2019 18:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479090;
        bh=jTmWGdRh4A7qeDyLncOFpw+Bu1NzoIng5ndfrmuJASI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esgS4MTdXkKLzBE8CCWDdW04trJLEgPcwRH3IjFy4vrxRuJYEg7EVatzmv7N65nxG
         u/6zGW/g0HmrOQ+of8Lq7OR7JEZcwLxKM4Rxl6kAzVnMt3Y3KsQFaNLjSmg77TNv1p
         H7HXHuTwh4IAxPllHivDJsDF63mdJ1JJrRmMNKNY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        coresight ml <coresight@lists.linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/53] perf cs-etm: Add traceID in packet
Date:   Wed,  6 Feb 2019 15:48:51 -0300
Message-Id: <20190206184903.24054-42-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Add traceID in packet, thus we can use traceID to retrieve metadata
pointer from traceID-metadata tuple.

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
Link: http://lkml.kernel.org/r/20190129122842.32041-7-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

