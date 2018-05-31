Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbeEaKo6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:44:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754597AbeEaKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:44:56 -0400
Date: Thu, 31 May 2018 03:44:32 -0700
From: tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-e2ab28521a588785c3e053098ffe607b5ff54634@git.kernel.org>
Cc: jolsa@redhat.com, tglx@linutronix.de, leo.yan@linaro.org,
        mingo@kernel.org, hpa@zytor.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        acme@redhat.com, robert.walker@arm.com, namhyung@kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, namhyung@kernel.org, robert.walker@arm.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com
In-Reply-To: <1527289854-10755-1-git-send-email-mathieu.poirier@linaro.org>
References: <1527289854-10755-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Fix indexing for decoder packet
 queue
Git-Commit-ID: e2ab28521a588785c3e053098ffe607b5ff54634
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

Commit-ID:  e2ab28521a588785c3e053098ffe607b5ff54634
Gitweb:     https://git.kernel.org/tip/e2ab28521a588785c3e053098ffe607b5ff54634
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 25 May 2018 17:10:54 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 30 May 2018 15:38:40 -0300

perf cs-etm: Fix indexing for decoder packet queue

The tail of a queue is supposed to be pointing to the next available
slot in a queue.  In this implementation the tail is incremented before
it is used and as such points to the last used element, something that
has the immense advantage of centralizing tail management at a single
location and eliminating a lot of redundant code.

But this needs to be taken into consideration on the dequeueing side
where the head also needs to be incremented before it is used, or the
first available element of the queue will be skipped.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1527289854-10755-1-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index c8b98fa22997..4d5fc374e730 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -96,11 +96,19 @@ int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
 	/* Nothing to do, might as well just return */
 	if (decoder->packet_count == 0)
 		return 0;
+	/*
+	 * The queueing process in function cs_etm_decoder__buffer_packet()
+	 * increments the tail *before* using it.  This is somewhat counter
+	 * intuitive but it has the advantage of centralizing tail management
+	 * at a single location.  Because of that we need to follow the same
+	 * heuristic with the head, i.e we increment it before using its
+	 * value.  Otherwise the first element of the packet queue is not
+	 * used.
+	 */
+	decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
 
 	*packet = decoder->packet_buffer[decoder->head];
 
-	decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
-
 	decoder->packet_count--;
 
 	return 1;
