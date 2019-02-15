Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96140C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6334C20675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393369AbfBOJpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:45:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393266AbfBOJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:45:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9jGMW1120884
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:45:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9jFTS1120881;
        Fri, 15 Feb 2019 01:45:15 -0800
Date:   Fri, 15 Feb 2019 01:45:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-23cfcd6d75cc0c1a7f95c44658dc91380fb40770@git.kernel.org>
Cc:     leo.yan@linaro.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mingo@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        hpa@zytor.com, acme@redhat.com, jolsa@redhat.com
Reply-To: mathieu.poirier@linaro.org, mingo@kernel.org, leo.yan@linaro.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, acme@redhat.com, jolsa@redhat.com,
          tglx@linutronix.de, suzuki.poulose@arm.com
In-Reply-To: <20190212171618.25355-11-mathieu.poirier@linaro.org>
References: <20190212171618.25355-11-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Make cs_etm__run_decoder() queue
 independent
Git-Commit-ID: 23cfcd6d75cc0c1a7f95c44658dc91380fb40770
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

Commit-ID:  23cfcd6d75cc0c1a7f95c44658dc91380fb40770
Gitweb:     https://git.kernel.org/tip/23cfcd6d75cc0c1a7f95c44658dc91380fb40770
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:15 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:07 -0300

perf cs-etm: Make cs_etm__run_decoder() queue independent

This patch makes decoding of auxtrace buffer centered around a struct
cs_etm_queue.  This eliminates surperflous variables and is a precursor
for work that simplifies the main decoder loop.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-11-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 ----
 tools/perf/util/cs-etm.c                        | 52 ++++++++++++-------------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 663309486784..3ab11dfa92ae 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -15,13 +15,6 @@
 
 struct cs_etm_decoder;
 
-struct cs_etm_buffer {
-	const unsigned char *buf;
-	size_t len;
-	u64 offset;
-	u64 ref_timestamp;
-};
-
 enum cs_etm_sample_type {
 	CS_ETM_EMPTY,
 	CS_ETM_RANGE,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2d2de898ea68..d2c90b369e7c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -76,6 +76,8 @@ struct cs_etm_queue {
 	size_t last_branch_pos;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
+	const unsigned char *buf;
+	size_t buf_len, buf_used;
 };
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
@@ -683,7 +685,7 @@ static int cs_etm__inject_event(union perf_event *event,
 
 
 static int
-cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
+cs_etm__get_trace(struct cs_etm_queue *etmq)
 {
 	struct auxtrace_buffer *aux_buffer = etmq->buffer;
 	struct auxtrace_buffer *old_buffer = aux_buffer;
@@ -697,7 +699,7 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	if (!aux_buffer) {
 		if (old_buffer)
 			auxtrace_buffer__drop_data(old_buffer);
-		buff->len = 0;
+		etmq->buf_len = 0;
 		return 0;
 	}
 
@@ -717,13 +719,11 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	if (old_buffer)
 		auxtrace_buffer__drop_data(old_buffer);
 
-	buff->offset = aux_buffer->offset;
-	buff->len = aux_buffer->size;
-	buff->buf = aux_buffer->data;
+	etmq->buf_used = 0;
+	etmq->buf_len = aux_buffer->size;
+	etmq->buf = aux_buffer->data;
 
-	buff->ref_timestamp = aux_buffer->reference;
-
-	return buff->len;
+	return etmq->buf_len;
 }
 
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
@@ -1493,24 +1493,23 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	struct cs_etm_buffer buffer;
-	size_t buffer_used, processed;
+	size_t processed;
 	int err = 0;
 
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
-		buffer_used = 0;
-		memset(&buffer, 0, sizeof(buffer));
-		err = cs_etm__get_trace(&buffer, etmq);
-		if (err <= 0)
-			return err;
-		/*
-		 * We cannot assume consecutive blocks in the data file are
-		 * contiguous, reset the decoder to force re-sync.
-		 */
-		err = cs_etm_decoder__reset(etmq->decoder);
-		if (err != 0)
-			return err;
+		if (!etmq->buf_len) {
+			err = cs_etm__get_trace(etmq);
+			if (err <= 0)
+				return err;
+			/*
+			 * We cannot assume consecutive blocks in the data file
+			 * are contiguous, reset the decoder to force re-sync.
+			 */
+			err = cs_etm_decoder__reset(etmq->decoder);
+			if (err != 0)
+				return err;
+		}
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
@@ -1518,14 +1517,15 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			err = cs_etm_decoder__process_data_block(
 				etmq->decoder,
 				etmq->offset,
-				&buffer.buf[buffer_used],
-				buffer.len - buffer_used,
+				&etmq->buf[etmq->buf_used],
+				etmq->buf_len,
 				&processed);
 			if (err)
 				return err;
 
 			etmq->offset += processed;
-			buffer_used += processed;
+			etmq->buf_used += processed;
+			etmq->buf_len -= processed;
 
 			/* Process each packet in this chunk */
 			while (1) {
@@ -1585,7 +1585,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					break;
 				}
 			}
-		} while (buffer.len > buffer_used);
+		} while (etmq->buf_len);
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
