Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199B4C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE38C222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVIhgAj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfBLRQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33124 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbfBLRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so1622188plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qkiQiMGL+p9I6/iS3vRnEYYc23edBwfSeQJiedeTSRc=;
        b=sVIhgAj1YxApYOZcGkQA8IOcPqUHNNfVOBXsJ3MIFFlT1Hp8bmWs5av4xevdXiVNZW
         FSC1Yo1a8IBZkR46UdZoVR3FzPxk79HkIZCfHoTxlU8GGBKw8v8cOrzeCP54IGWvsR8v
         PzMzDOol6q8ak1JwyqPhqIVjqViUCZIG9JLB5SZUtCUZFE9WQIA8YFOKafHfRMcpwksv
         /KbApTEcZ92QxjNlFM9SVa3rUX1XD/RHSE+zlfpd9Po0e8bq1JYHfK3fA5fMbe3UteYg
         vcupn0WP+VnbtW/3yDgT6jB0RLT7I35yBoSiTePGbd5SNZIGI/BeE40t1UPLDRoc5QhJ
         lluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qkiQiMGL+p9I6/iS3vRnEYYc23edBwfSeQJiedeTSRc=;
        b=oW/Qngxz1+82nvMsGMBnnFsUAWvnbZhptDqcPAOQLb69kaUHfgD4Edvd0JPdFATgGi
         2gB3YcWDnQpTvmxshdytWzORaQnFfbc1z8EQkd4QDruBbzRoJoxmhanvEChx8LFS+cDc
         dlq1bwhAZQne4SEiKeQvr9TnV0lx1iZ6kw5uLot2OOuFaOiOAU43vIBU25YEvLLS475b
         JD7vUIc69rEoqkkpxqcqrYzg28BsggCW3Z5Z4vu4HVkgS4a0XE+zOyJEY5bVto/SCTsx
         dRcIMfSRCFq3y1zbHAMwcBBS7pvjxajBmmU+yfAFv4oKaBpKD/Qy7W9SQV0ubg9BZ9e6
         lkQw==
X-Gm-Message-State: AHQUAuYJmjvKi2TIoTSG1hHs3UCvdrH9t+fG+VlN0XRN+i6sXckZhGeC
        4z+iOvtE2VLq7Rd56lAeQIr9KQ==
X-Google-Smtp-Source: AHgI3IZIH7pBK/F0JpcB5vmS60BvdRnS+wNobaGXypdhiP9CX2irU2g9uwx3QZUi1h1HLU/7h51cZg==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr4904861plb.120.1549991795240;
        Tue, 12 Feb 2019 09:16:35 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:34 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] perf tools: Modularize auxtrace_buffer fetch function
Date:   Tue, 12 Feb 2019 10:16:18 -0700
Message-Id: <20190212171618.25355-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making the auxtrace_buffer fetch function modular so that it can be called
from different decoding context (timeless vs. non-timeless), avoiding to
repeat code.

No change in functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.17.1

