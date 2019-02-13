Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6739C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D562190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391681AbfBMLOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:14:14 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:37401 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbfBMLON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:14:13 -0500
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 1F80A1C1E0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:14:11 +0000 (GMT)
Received: (qmail 10497 invoked from network); 13 Feb 2019 11:14:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2019 11:14:10 -0000
Date:   Wed, 13 Feb 2019 11:14:09 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213111409.GN9565@techsingularity.net>
References: <20190213082134.GA21834@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190213082134.GA21834@yury-thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> Hi Mel, all,
> 
> My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> Backtrace is not too verbose:
> (gdb) i threads
>   Id   Target Id         Frame
> * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
>     at arch/arm64/lib/delay.c:49
>   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
>   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
>   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> (gdb) bt
> #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
> Reverting the patch
> 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> fragmentation event occurs") together with following patch
> 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> helps me to boot normally. 
> 

Well, that's a bad start to any day. Thanks for tracking it down. Does
the following patch help? I can't test it properly as I didn't recreate
your boot image or initrd but this appears to get past the initial boot
phase at least.

---8<---
mm, page_alloc: Fix a division by zero error when boosting watermarks

Yury Norov reported that an arm64 KVM instance could not boot since after
v5.0-rc1 and could addressed by reverting the patches

1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")

The problem is that a division by zero error is possible if boosting occurs
either very early in boot or if the high watermark is very small. This
patch checks for the conditions and avoids boosting in those cases.

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
Reported-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..ae7e4ba5b9f5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2170,6 +2170,11 @@ static inline void boost_watermark(struct zone *zone)
 
 	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
 			watermark_boost_factor, 10000);
+
+	/* high watermark be be uninitialised or very small */
+	if (!max_boost)
+		return;
+
 	max_boost = max(pageblock_nr_pages, max_boost);
 
 	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,


