Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B5C10F04
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DE2222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191703;
	bh=uluH9qSfxO6EQEq/VO78WgaeQTFAb4ZY5Ks+LwjnaMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YBQynPKEaAKpkbIf83XzXStxn75DxE8Rs/BjJYlG9KTUJ6SiDQQ7L3LH/Mb7BqMbW
	 OFEQDAEtD4Us36m3v9iAD6KMlou7dr2+yLZQVg2pOCncts+a16F9AhExDTEX+i1JKB
	 L/OkznnL3CaPnbe0kiHv/pxjbb9YOFDttWJo7bu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbfBOAsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbfBOAsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:20 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BEDC21B68;
        Fri, 15 Feb 2019 00:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191699;
        bh=uluH9qSfxO6EQEq/VO78WgaeQTFAb4ZY5Ks+LwjnaMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDWsvz9feKOzTn+FMPbyrODlbK8NOBPudaX396ldiJbDkBmE5QBGdHb4joUgl6YV7
         1U6Ayk2cglka4/1CMgFR9I0m723lXzR5TQYEvxJrXWYsYPyrMhJE2vtHdvOuhRj+dr
         pmRMnWXYiTA0Lz4gmjs70maH0eC7NofU319p+t3I=
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
Subject: [PATCH 34/43] perf cs-etm: Modularize main packet processing loop
Date:   Thu, 14 Feb 2019 21:45:30 -0300
Message-Id: <20190215004539.23571-35-acme@kernel.org>
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

Making the main packet processing loop modular so that it can be called
from different decoding context (timeless vs. non-timless), avoiding to
repeat code.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-13-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 129 ++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index cfa686fe223e..f607bc58bd03 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1519,6 +1519,72 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	return ret;
 }
 
+static int cs_etm__process_decoder_queue(struct cs_etm_queue *etmq)
+{
+	int ret;
+
+		/* Process each packet in this chunk */
+		while (1) {
+			ret = cs_etm_decoder__get_packet(etmq->decoder,
+							 etmq->packet);
+			if (ret <= 0)
+				/*
+				 * Stop processing this chunk on
+				 * end of data or error
+				 */
+				break;
+
+			/*
+			 * Since packet addresses are swapped in packet
+			 * handling within below switch() statements,
+			 * thus setting sample flags must be called
+			 * prior to switch() statement to use address
+			 * information before packets swapping.
+			 */
+			ret = cs_etm__set_sample_flags(etmq);
+			if (ret < 0)
+				break;
+
+			switch (etmq->packet->sample_type) {
+			case CS_ETM_RANGE:
+				/*
+				 * If the packet contains an instruction
+				 * range, generate instruction sequence
+				 * events.
+				 */
+				cs_etm__sample(etmq);
+				break;
+			case CS_ETM_EXCEPTION:
+			case CS_ETM_EXCEPTION_RET:
+				/*
+				 * If the exception packet is coming,
+				 * make sure the previous instruction
+				 * range packet to be handled properly.
+				 */
+				cs_etm__exception(etmq);
+				break;
+			case CS_ETM_DISCONTINUITY:
+				/*
+				 * Discontinuity in trace, flush
+				 * previous branch stack
+				 */
+				cs_etm__flush(etmq);
+				break;
+			case CS_ETM_EMPTY:
+				/*
+				 * Should not receive empty packet,
+				 * report error.
+				 */
+				pr_err("CS ETM Trace: empty packet\n");
+				return -EINVAL;
+			default:
+				break;
+			}
+		}
+
+	return ret;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	int err = 0;
@@ -1544,64 +1610,13 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			if (err)
 				return err;
 
-			/* Process each packet in this chunk */
-			while (1) {
-				err = cs_etm_decoder__get_packet(etmq->decoder,
-								 etmq->packet);
-				if (err <= 0)
-					/*
-					 * Stop processing this chunk on
-					 * end of data or error
-					 */
-					break;
+			/*
+			 * Process each packet in this chunk, nothing to do if
+			 * an error occurs other than hoping the next one will
+			 * be better.
+			 */
+			err = cs_etm__process_decoder_queue(etmq);
 
-				/*
-				 * Since packet addresses are swapped in packet
-				 * handling within below switch() statements,
-				 * thus setting sample flags must be called
-				 * prior to switch() statement to use address
-				 * information before packets swapping.
-				 */
-				err = cs_etm__set_sample_flags(etmq);
-				if (err < 0)
-					break;
-
-				switch (etmq->packet->sample_type) {
-				case CS_ETM_RANGE:
-					/*
-					 * If the packet contains an instruction
-					 * range, generate instruction sequence
-					 * events.
-					 */
-					cs_etm__sample(etmq);
-					break;
-				case CS_ETM_EXCEPTION:
-				case CS_ETM_EXCEPTION_RET:
-					/*
-					 * If the exception packet is coming,
-					 * make sure the previous instruction
-					 * range packet to be handled properly.
-					 */
-					cs_etm__exception(etmq);
-					break;
-				case CS_ETM_DISCONTINUITY:
-					/*
-					 * Discontinuity in trace, flush
-					 * previous branch stack
-					 */
-					cs_etm__flush(etmq);
-					break;
-				case CS_ETM_EMPTY:
-					/*
-					 * Should not receive empty packet,
-					 * report error.
-					 */
-					pr_err("CS ETM Trace: empty packet\n");
-					return -EINVAL;
-				default:
-					break;
-				}
-			}
 		} while (etmq->buf_len);
 
 		if (err == 0)
-- 
2.19.1

