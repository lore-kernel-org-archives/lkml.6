Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967829AbeCALmJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:42:09 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:39689 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967775AbeCALmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:42:06 -0500
X-Google-Smtp-Source: AG47ELvRJsdLRcpxCnjkXF7nyvgLfHyuSgnVj1rua+RsdzX2no78fa/AxkLc+bL4py7AW9MNK65hvA==
Date: Thu, 1 Mar 2018 03:42:04 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch] mm, compaction: drain pcps for zone when kcompactd fails
Message-ID: <alpine.DEB.2.20.1803010340100.88270@chino.kir.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for buddy pages to become stranded on pcps that, if drained,
could be merged with other buddy pages on the zone's free area to form
large order pages, including up to MAX_ORDER.

Consider a verbose example using the tools/vm/page-types tool at the
beginning of a ZONE_NORMAL, where 'B' indicates a buddy page and 'S'
indicates a slab page, which the migration scanner is attempting to
defragment (and doing it well, absent coalescing up to cc.order):

109954  1       _______S________________________________________________________
109955  2       __________B_____________________________________________________
109957  1       ________________________________________________________________
109958  1       __________B_____________________________________________________
109959  7       ________________________________________________________________
109960  1       __________B_____________________________________________________
109961  9       ________________________________________________________________
10996a  1       __________B_____________________________________________________
10996b  3       ________________________________________________________________
10996e  1       __________B_____________________________________________________
10996f  1       ________________________________________________________________
109970  1       __________B_____________________________________________________
109971  f       ________________________________________________________________
...
109f88  1       __________B_____________________________________________________
109f89  3       ________________________________________________________________
109f8c  1       __________B_____________________________________________________
109f8d  2       ________________________________________________________________
109f8f  2       __________B_____________________________________________________
109f91  f       ________________________________________________________________
109fa0  1       __________B_____________________________________________________
109fa1  7       ________________________________________________________________
109fa8  1       __________B_____________________________________________________
109fa9  1       ________________________________________________________________
109faa  1       __________B_____________________________________________________
109fab  1       _______S________________________________________________________

These buddy pages, spanning 1,621 pages, could be coalesced and allow for
three transparent hugepages to be dynamically allocated.  Totaling all
hugepage length spans that could be coalesced, this could yield over 400
hugepages on the zone's free area when at the time this /proc/kpageflags
was collected, there was _no_ order-9 or order-10 pages available for
allocation even after triggering compaction through procfs.

When kcompactd fails to defragment memory such that a cc.order page can
be allocated, drain all pcps for the zone back to the buddy allocator so
this stranding cannot occur.  Compaction for that order will subsequently
be deferred, which acts as a ratelimit on this drain.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/compaction.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1987,6 +1987,14 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (status == COMPACT_SUCCESS) {
 			compaction_defer_reset(zone, cc.order, false);
 		} else if (status == COMPACT_PARTIAL_SKIPPED || status == COMPACT_COMPLETE) {
+			/*
+			 * Buddy pages may become stranded on pcps that could
+			 * otherwise coalesce on the zone's free area for
+			 * order >= cc.order.  This is ratelimited by the
+			 * upcoming deferral.
+			 */
+			drain_all_pages(zone);
+
 			/*
 			 * We use sync migration mode here, so we defer like
 			 * sync direct compaction does.
