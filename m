Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299B620675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405238AbfBOJqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:46:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404420AbfBOJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:46:51 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9kZgm1121003
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:46:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9kYn71121000;
        Fri, 15 Feb 2019 01:46:34 -0800
Date:   Fri, 15 Feb 2019 01:46:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-3fa0e83e29488547b39f321fd5a239f08f129c72@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, jolsa@redhat.com,
        peterz@infradead.org, hpa@zytor.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com
Reply-To: acme@redhat.com, mingo@kernel.org, peterz@infradead.org,
          jolsa@redhat.com, hpa@zytor.com, leo.yan@linaro.org,
          mathieu.poirier@linaro.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, suzuki.poulose@arm.com
In-Reply-To: <20190212171618.25355-13-mathieu.poirier@linaro.org>
References: <20190212171618.25355-13-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Modularize main packet processing loop
Git-Commit-ID: 3fa0e83e29488547b39f321fd5a239f08f129c72
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3fa0e83e29488547b39f321fd5a239f08f129c72
Gitweb:     https://git.kernel.org/tip/3fa0e83e29488547b39f321fd5a239f08f129c72
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:17 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:07 -0300

perf cs-etm: Modularize main packet processing loop

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
 tools/perf/util/cs-etm.c | 129 ++++++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index cfa686fe223e..f607bc58bd03 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1519,6 +1519,72 @@ out:
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
