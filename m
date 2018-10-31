Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE078C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A494A20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A494A20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeJaO0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:26:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38800 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeJaO0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:26:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DBCD214399C23;
        Tue, 30 Oct 2018 22:30:03 -0700 (PDT)
Date:   Tue, 30 Oct 2018 22:30:03 -0700 (PDT)
Message-Id: <20181030.223003.2242527041807905962.davem@davemloft.net>
To:     acme@kernel.org
CC:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC] perf: Start 'top' display thread earlier.
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Oct 2018 22:30:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If events are coming in at a rate such that the event processing
thread can barely keep up, our initial run of the event ring will
almost never terminate and this delays the starting of the display
thread.

The screen basically stays black until the event thread can get out of
it's endless loop.

Therefore, start the display thread before we start processing the
ring buffer.

This also make sure that we always have the user requested real time
setting engaged when processing the ring.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d875..e7a78ce 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1134,11 +1125,6 @@ static int __cmd_top(struct perf_top *top)
         if (!target__none(&opts->target))
                 perf_evlist__enable(top->evlist);
 
-	/* Wait for a minimal set of events before starting the snapshot */
-	perf_evlist__poll(top->evlist, 100);
-
-	perf_top__mmap_read(top);
-
 	ret = -1;
 	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
 							    display_thread), top)) {
@@ -1156,6 +1142,11 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
+	/* Wait for a minimal set of events before starting the snapshot */
+	perf_evlist__poll(top->evlist, 100);
+
+	perf_top__mmap_read(top);
+
 	while (!done) {
 		u64 hits = top->samples;
 
