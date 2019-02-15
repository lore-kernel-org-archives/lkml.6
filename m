Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE775C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5A1222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191698;
	bh=WFKhBGivstHsu/Fs+BfZ/htyrxFjYHkApYCCiKiHFX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ocJ3U8gj2PxMjBDVKI3R5ZcP2etY3NTZBxzeYU2WF1XuhvEa0wSTkBsQPoaHZxEyQ
	 IAzWzVAPlZRDXRi/socVRU8LYGJ8Eaq1otw0burOiCG9LwcRPAOu093ksdqz0EI2Eg
	 ehSvh4Eprgr/pMxerAbRfNa0AqR1shKK81WTRRbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfBOAsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389370AbfBOAsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:16 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D470222C9;
        Fri, 15 Feb 2019 00:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191695;
        bh=WFKhBGivstHsu/Fs+BfZ/htyrxFjYHkApYCCiKiHFX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+kbDdZ8vnowMRYyDFsySlyuP4BTytgPEFwEzygpMOMgFhGMg/T2N6+bkwgMuElLg
         nTrhax+BqDCi5KcMrlQe9+SiTx2PWq0hSNTS0s/h4GiYlVACdFZqqbcSXNINJSUgfF
         FZGwZDE63wVn13Ka4S8Wrr4et7Kkwn8hbXARcCrg=
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
Subject: [PATCH 33/43] perf cs-etm: Modularize main decoder function
Date:   Thu, 14 Feb 2019 21:45:29 -0300
Message-Id: <20190215004539.23571-34-acme@kernel.org>
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
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
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
-- 
2.19.1

