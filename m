Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeBQLkY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:40:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39549 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeBQLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:40:21 -0500
Date: Sat, 17 Feb 2018 03:28:56 -0800
From: tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-099c1130998fd2234a200b55d69713ec66d88325@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, yao.jin@linux.intel.com, mathieu.poirier@linaro.org,
        namhyung@kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, namhyung@kernel.org, mathieu.poirier@linaro.org,
        yao.jin@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <1518467557-18505-2-git-send-email-mathieu.poirier@linaro.org>
References: <1518467557-18505-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Freeing allocated memory
Git-Commit-ID: 099c1130998fd2234a200b55d69713ec66d88325
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  099c1130998fd2234a200b55d69713ec66d88325
Gitweb:     https://git.kernel.org/tip/099c1130998fd2234a200b55d69713ec66d88325
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Mon, 12 Feb 2018 13:32:35 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:39 -0300

perf cs-etm: Freeing allocated memory

This patch frees all the memory allocated in function
cs_etm__alloc_queue().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1518467557-18505-2-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b9f0a53..f2c9877 100644
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
 
