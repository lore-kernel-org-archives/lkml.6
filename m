Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1191C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BD620869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BD620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeIGQY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:24:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44496 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeIGQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:24:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so6874961pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 04:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YF1OHIhmAVlWCr6F/ebiZrS2h57vs9fWzePNwoliCyI=;
        b=c32sRYN81oguJCZ+FZ8YAFRiGkEGIj5ZYjVahUogFggZA4p430OeDDbZBPR0xgPza6
         57cbnWhCh47oKFYHdTxQnE6i3cl2BcPh5U5wmV5J03P5lFvj1MFS61rjDTv1sOgzyfWG
         6R0VHK/X+yGAl5N2qaybxeDBU8DqPEbOvv91UXKjTsah4yBWtYTgVMKQVbdyUdSYMLzd
         Z6Hkm3+PfWgSS7UAU3z0Mjf7Wmnfv5T6pWeLYyFPAC0N9J3aq3Eo7DB3gGbP/OStO+UH
         A6GBOIYEV5r77U4PMmi7N0s/eBk4x62zOnscgYLGfy4mJtywWVjxRoXzupwHyneysWZx
         hu0Q==
X-Gm-Message-State: APzg51AiYTSi1r4bd1QHGu62SJ5FHjZhP3Kqk2iFynhO7s9psQ0l2GqH
        2rKhpXM3EnikJYDIPTETczc=
X-Google-Smtp-Source: ANB0VdYfStOeiFdj3bRCZPAICp3nZzztaYZH7VAmsY4H1mN6L6/1ki1ZNEnT2gd21phjt12QxzEOvg==
X-Received: by 2002:a63:d806:: with SMTP id b6-v6mr7661165pgh.347.1536320634376;
        Fri, 07 Sep 2018 04:43:54 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w13-v6sm8628258pgs.89.2018.09.07.04.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 04:43:53 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH] mm, page_alloc: drop should_suppress_show_mem
Date:   Fri,  7 Sep 2018 13:43:34 +0200
Message-Id: <20180907114334.7088-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

should_suppress_show_mem has been introduced to reduce the overhead of
show_mem on large NUMA systems. Things have changed since then though.
Namely c78e93630d15 ("mm: do not walk all of system memory during
show_mem") has reduced the overhead considerably.

Moreover warn_alloc_show_mem clears SHOW_MEM_FILTER_NODES when called
from the IRQ context already so we are not printing per node stats.

Remove should_suppress_show_mem because we are losing potentially
interesting information about allocation failures. We have seen a bug
report where system gets unresponsive under memory pressure and there
is only
kernel: [2032243.696888] qlge 0000:8b:00.1 ql1: Could not get a page chunk, i=8, clean_idx =200 .
kernel: [2032243.710725] swapper/7: page allocation failure: order:1, mode:0x1084120(GFP_ATOMIC|__GFP_COLD|__GFP_COMP)

without an additional information for debugging. It would be great to
see the state of the page allocator at the moment.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89d2a2ab3fe6..025f23dc282e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3366,26 +3366,12 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	return NULL;
 }
 
-/*
- * Large machines with many possible nodes should not always dump per-node
- * meminfo in irq context.
- */
-static inline bool should_suppress_show_mem(void)
-{
-	bool ret = false;
-
-#if NODES_SHIFT > 8
-	ret = in_interrupt();
-#endif
-	return ret;
-}
-
 static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 {
 	unsigned int filter = SHOW_MEM_FILTER_NODES;
 	static DEFINE_RATELIMIT_STATE(show_mem_rs, HZ, 1);
 
-	if (should_suppress_show_mem() || !__ratelimit(&show_mem_rs))
+	if (!__ratelimit(&show_mem_rs))
 		return;
 
 	/*
-- 
2.18.0

