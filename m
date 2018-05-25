Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030788AbeEYXK6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 19:10:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43532 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030538AbeEYXK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 19:10:57 -0400
X-Google-Smtp-Source: AB8JxZreU1dHJsF+J40ApBlgthQdcLJk00nbMpTI15AyiX4O89MXs2cuFYjF+cCaYljNzZZiJ8Pspg==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Cc: robert.walker@arm.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix indexing for decoder packet queue
Date: Fri, 25 May 2018 17:10:54 -0600
Message-Id: <1527289854-10755-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tail of a queue is supposed to be pointing to the next available slot
in a queue.  In this implementation the tail is incremented before it is
used and as such points to the last used element, something that has the
immense advantage of centralizing tail management at a single location
and eliminating a lot of redundant code.

But this needs to be taken into consideration on the dequeueing side where
the head also needs to be incremented before it is used, or the first
available element of the queue will be skipped.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
-- 
2.7.4
