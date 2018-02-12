Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeBLUcn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:32:43 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35709 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbeBLUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:32:41 -0500
X-Google-Smtp-Source: AH8x2241nLrc9lQmKIg5mqw8Q/NbpbnAGV81PMlqpAnrf1vJaTWqN4mQpat3NbiObUEWm6khAytUcA==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf tools: Freeing allocated memory
Date: Mon, 12 Feb 2018 13:32:35 -0700
Message-Id: <1518467557-18505-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch frees all the memory allocated in function
cs_etm__alloc_queue().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b9f0a53dfa65..f2c98774e665 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -174,6 +174,12 @@ static void cs_etm__free_queue(void *priv)
 {
 	struct cs_etm_queue *etmq = priv;
 
+	if (!etmq)
+		return;
+
+	thread__zput(etmq->thread);
+	cs_etm_decoder__free(etmq->decoder);
+	zfree(&etmq->event_buf);
 	free(etmq);
 }
 
-- 
2.7.4
