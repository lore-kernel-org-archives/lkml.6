Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B77620675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393387AbfBOJqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:46:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390166AbfBOJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:46:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9jt5b1120947
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:45:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9jts21120944;
        Fri, 15 Feb 2019 01:45:55 -0800
Date:   Fri, 15 Feb 2019 01:45:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-f74f349c211e3e62bc7fe35a132918c7f2c0fafb@git.kernel.org>
Cc:     acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
        jolsa@redhat.com, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mathieu.poirier@linaro.org, jolsa@redhat.com, leo.yan@linaro.org,
          peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          suzuki.poulose@arm.com
In-Reply-To: <20190212171618.25355-12-mathieu.poirier@linaro.org>
References: <20190212171618.25355-12-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Modularize main decoder function
Git-Commit-ID: f74f349c211e3e62bc7fe35a132918c7f2c0fafb
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

Commit-ID:  f74f349c211e3e62bc7fe35a132918c7f2c0fafb
Gitweb:     https://git.kernel.org/tip/f74f349c211e3e62bc7fe35a132918c7f2c0fafb
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:16 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:07 -0300

perf cs-etm: Modularize main decoder function

Making the main decoder block modular so that it can be called from
different decoding context (timeless vs. non-timeless), avoiding
to repeat code.

No change in functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-12-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d2c90b369e7c..cfa686fe223e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1491,9 +1491,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
+{
+	int ret = 0;
+	size_t processed = 0;
+
+	/*
+	 * Packets are decoded and added to the decoder's packet queue
+	 * until the decoder packet processing callback has requested that
+	 * processing stops or there is nothing left in the buffer.  Normal
+	 * operations that stop processing are a timestamp packet or a full
+	 * decoder buffer queue.
+	 */
+	ret = cs_etm_decoder__process_data_block(etmq->decoder,
+						 etmq->offset,
+						 &etmq->buf[etmq->buf_used],
+						 etmq->buf_len,
+						 &processed);
+	if (ret)
+		goto out;
+
+	etmq->offset += processed;
+	etmq->buf_used += processed;
+	etmq->buf_len -= processed;
+
+out:
+	return ret;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	size_t processed;
 	int err = 0;
 
 	/* Go through each buffer in the queue and decode them one by one */
@@ -1513,20 +1540,10 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
-			processed = 0;
-			err = cs_etm_decoder__process_data_block(
-				etmq->decoder,
-				etmq->offset,
-				&etmq->buf[etmq->buf_used],
-				etmq->buf_len,
-				&processed);
+			err = cs_etm__decode_data_block(etmq);
 			if (err)
 				return err;
 
-			etmq->offset += processed;
-			etmq->buf_used += processed;
-			etmq->buf_len -= processed;
-
 			/* Process each packet in this chunk */
 			while (1) {
 				err = cs_etm_decoder__get_packet(etmq->decoder,
