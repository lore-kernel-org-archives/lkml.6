Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657A6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0BA20675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405306AbfBOJr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:47:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404420AbfBOJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:47:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9lDDi1121042
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:47:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9lCXY1121039;
        Fri, 15 Feb 2019 01:47:12 -0800
Date:   Fri, 15 Feb 2019 01:47:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-8224531cf5a1246bbe1d43c5db26e5348aeb77c5@git.kernel.org>
Cc:     suzuki.poulose@arm.com, hpa@zytor.com, acme@redhat.com,
        mathieu.poirier@linaro.org, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, leo.yan@linaro.org,
          tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
          hpa@zytor.com, acme@redhat.com, suzuki.poulose@arm.com,
          mathieu.poirier@linaro.org, peterz@infradead.org
In-Reply-To: <20190212171618.25355-14-mathieu.poirier@linaro.org>
References: <20190212171618.25355-14-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Modularize auxtrace_buffer fetch
 function
Git-Commit-ID: 8224531cf5a1246bbe1d43c5db26e5348aeb77c5
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

Commit-ID:  8224531cf5a1246bbe1d43c5db26e5348aeb77c5
Gitweb:     https://git.kernel.org/tip/8224531cf5a1246bbe1d43c5db26e5348aeb77c5
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:18 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:08 -0300

perf cs-etm: Modularize auxtrace_buffer fetch function

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
 tools/perf/util/cs-etm.c | 41 +++++++++++++++++++++++++++++------------
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
