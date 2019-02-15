Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE2CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E309B222DB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191710;
	bh=6LdzrCVx8YqnpmPcRdemWeu0Aj6Lfc4MEov3VXtbxS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iewsAJjV27uZ0zknuwwXnpORMvKfTm8kThMjaFosfTN5ud4MBzJXbw5kD6katS+9t
	 oTEmGdEVe1WtB9iange/sBfTZNVcqBMGJrdrePRK4UEOIxmpjfzoxaeaMYN13FDO7Q
	 Rl/bcIfW6Hz+CTrR2YICgwTTszlh9IDhs3sER5bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbfBOAs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389617AbfBOAsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:24 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8511A222A1;
        Fri, 15 Feb 2019 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191704;
        bh=6LdzrCVx8YqnpmPcRdemWeu0Aj6Lfc4MEov3VXtbxS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xwhLmUcpYFD23RrowCfeVr66BAmigTql/10xm+6AD7Rlx3E6d1mVK/YeawQok3boj
         t273uf9QOKK/WSVN8POqfY3zGjBbZ0V4LzsK7GOnzQ6FfaywWj5XeKYvEjNpKY+d3l
         tV7FUVmi7LbcxGHNtYUSzIfSrXcwxe6ICFJQioFI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/43] perf cs-etm: Modularize auxtrace_buffer fetch function
Date:   Thu, 14 Feb 2019 21:45:31 -0300
Message-Id: <20190215004539.23571-36-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Making the auxtrace_buffer fetch function modular so that it can be
called from different decoding context (timeless vs. non-timeless),
avoiding to repeat code.

No change in functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-14-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f607bc58bd03..110804936fc3 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1152,6 +1152,32 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 
 	return 0;
 }
+/*
+ * cs_etm__get_data_block: Fetch a block from the auxtrace_buffer queue
+ *			   if need be.
+ * Returns:	< 0	if error
+ *		= 0	if no more auxtrace_buffer to read
+ *		> 0	if the current buffer isn't empty yet
+ */
+static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
+{
+	int ret;
+
+	if (!etmq->buf_len) {
+		ret = cs_etm__get_trace(etmq);
+		if (ret <= 0)
+			return ret;
+		/*
+		 * We cannot assume consecutive blocks in the data file
+		 * are contiguous, reset the decoder to force re-sync.
+		 */
+		ret = cs_etm_decoder__reset(etmq->decoder);
+		if (ret)
+			return ret;
+	}
+
+	return etmq->buf_len;
+}
 
 static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 				 struct cs_etm_packet *packet,
@@ -1591,18 +1617,9 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
-		if (!etmq->buf_len) {
-			err = cs_etm__get_trace(etmq);
-			if (err <= 0)
-				return err;
-			/*
-			 * We cannot assume consecutive blocks in the data file
-			 * are contiguous, reset the decoder to force re-sync.
-			 */
-			err = cs_etm_decoder__reset(etmq->decoder);
-			if (err != 0)
-				return err;
-		}
+		err = cs_etm__get_data_block(etmq);
+		if (err <= 0)
+			return err;
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
-- 
2.19.1

