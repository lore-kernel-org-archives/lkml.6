Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DD5ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0950E21524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0tOEBorI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0950E21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeISUEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732215AbeISUEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:12 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48C521525;
        Wed, 19 Sep 2018 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367162;
        bh=Hy5vRY2Vnum70J9Vql4ZUg/3mcGlnzE1TunL0JHB0Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0tOEBorIEYPfDea8IT6hu5ZjNu1HBcIxqoQFYBeUYA8lMkoNr0ZyUgehgaS02H+xk
         jjGGtMxAmywlvysEP+5Sh9GyGl06OTIh+3Z6rC+GiV77XodH4LsT1tve8vTnwZdL6z
         ArwfOV5VT2ypeb5bgzGrZlMkfYYHYR+VMpFVmPVM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/13] perf ordered_events: Prevent crossing max_alloc_size
Date:   Wed, 19 Sep 2018 11:25:28 -0300
Message-Id: <20180919142537.29985-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Stephane reported a possible issue in the ordered events code, which
could lead to allocating more memory than guarded by max_alloc_size.

He also suggested the fix to properly check that the new size is below
the max_alloc_size limit.

Reported-by: Stephane Eranian <eranian@google.com>
Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180907102455.7030-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 84ce25272c13..1904e7f6ec84 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -101,6 +101,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 	struct list_head *cache = &oe->cache;
 	struct ordered_event *new = NULL;
 	union perf_event *new_event;
+	size_t size;
 
 	new_event = dup_event(oe, event);
 	if (!new_event)
@@ -133,6 +134,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 	 * Removal of ordered event object moves it from events to
 	 * the cache list.
 	 */
+	size = sizeof(*oe->buffer) + MAX_SAMPLE_BUFFER * sizeof(*new);
+
 	if (!list_empty(cache)) {
 		new = list_entry(cache->next, struct ordered_event, list);
 		list_del(&new->list);
@@ -140,10 +143,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 		new = &oe->buffer->event[oe->buffer_idx];
 		if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
 			oe->buffer = NULL;
-	} else if (oe->cur_alloc_size < oe->max_alloc_size) {
-		size_t size = sizeof(*oe->buffer) +
-			      MAX_SAMPLE_BUFFER * sizeof(*new);
-
+	} else if ((oe->cur_alloc_size + size) < oe->max_alloc_size) {
 		oe->buffer = malloc(size);
 		if (!oe->buffer) {
 			free_dup_event(oe, new_event);
-- 
2.14.4

