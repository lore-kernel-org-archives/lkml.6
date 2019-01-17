Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA822054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547724623;
	bh=iFbIxsRB6Q5t6nI5hY4xpuaHGQRh5WmdKYA9LgjpUSo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0ZH4SUjR/hlUO6zCry0W4/cN/fr2lFN5UvjEU95YrZdOGTdh/nmTlRy2uVN1wdFvz
	 73XFQQzuEg+g6KtlvvgaQ1ovIXaLYkxIal/laRMI8K7UB1n3Lbxh9XUZGIqqlGJ5bO
	 zAJXziyVIL9AJ7+QkDG2rsYgybJSNbgPbOt9sZyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfAQLaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:30:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfAQLaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:30:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 597FE8831A;
        Thu, 17 Jan 2019 11:30:20 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97288600C9;
        Thu, 17 Jan 2019 11:30:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH perf/urgent] perf tools: Fix crash in ordered_events__free
Date:   Thu, 17 Jan 2019 12:30:17 +0100
Message-Id: <20190117113017.12977-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 17 Jan 2019 11:30:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu reported crash in perf record:

> #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
> #1  0x0000000000500196 in ordered_events.reinit ()
> #2  0x00000000004fe413 in perf_session.process_events ()
> #3  0x0000000000440431 in cmd_record ()
> #4  0x00000000004a439f in run_builtin ()
> #5  0x000000000042b3e5 in main ()"

This can happen when we get out of the buffers during
event processing. The subsequent ordered_events__free
assumes the oe->buffer != NULL and crashes. Adding
the check to prevent that.

Cc: Stephane Eranian <eranian@google.com>
Fixes: d5ceb62b3654 ("perf ordered_events: Add 'struct ordered_events_buffer' layer")
Reported-by: Song Liu <liu.song.a23@gmail.com>
Link: http://lkml.kernel.org/n/tip-914bml5kabz2m9mbywd7el9l@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/ordered-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 897589507d97..ea523d3b248f 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -391,8 +391,10 @@ void ordered_events__free(struct ordered_events *oe)
 	 * Current buffer might not have all the events allocated
 	 * yet, we need to free only allocated ones ...
 	 */
-	list_del(&oe->buffer->list);
-	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	if (oe->buffer) {
+		list_del(&oe->buffer->list);
+		ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	}
 
 	/* ... and continue with the rest */
 	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
-- 
2.17.2

