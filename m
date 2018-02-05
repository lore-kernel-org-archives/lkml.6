Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeBEMBI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:01:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:44119 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeBEMBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:01:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,464,1511856000";
   d="scan'208";a="24926821"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: bisected bd4c82c22c367e is the first bad commit (was [Bug 198617] New: zswap causing random applications to crash)
References: <20180130114841.aa2d3bd99526c03c6a5b5810@linux-foundation.org>
        <20180203013455.GA739@jagdpanzerIV>
        <CAC=cRTPyh-JTY=uOQf2dgmyPDyY-4+ryxkedp-iZMcFQZtnaqw@mail.gmail.com>
        <20180205013758.GA648@jagdpanzerIV>
Date: Mon, 05 Feb 2018 20:00:57 +0800
In-Reply-To: <20180205013758.GA648@jagdpanzerIV> (Sergey Senozhatsky's message
        of "Mon, 5 Feb 2018 10:37:58 +0900")
Message-ID: <87d11j4pdy.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> writes:

> Hi,
>
> On (02/04/18 22:21), huang ying wrote:
> [..]
>> >> After disabling zswap no crashes at all.
>> >>
>> >> /etc/systemd/swap.conf
>> >> zswap_enabled=1
>> >> zswap_compressor=lz4      # lzo lz4
>> >> zswap_max_pool_percent=25 # 1-99
>> >> zswap_zpool=zbud          # zbud z3fold
>> >
> [..]
>> Can you give me some detailed steps to reproduce this?  Like the
>> kernel configuration file, swap configuration, etc.  Any kernel
>> WARNING during testing?  Can you reproduce this with a real swap
>> device instead of zswap?
>
> No warnings (at least no warnings with my .config). Tested it only with
> zram based swap (I'm running swap-less x86 systems, so zram is the easiest
> way). It seems it's THP + frontswap that makes things unstable, rather
> than THP + swap.
>
> Kernel zswap boot params:
> zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=10 zswap.zpool=zbud
>
> Then I add a 4G zram swap and run a silly memory hogger. I don't think
> you'll have any problems reproducing it, but just in case I attached my
> .config

I have successfully reproduced the issue and find the problem.  The
following patch fix the issue for me, can you try it?

Best Regards,
Huang, Ying

---------------------------------8<-------------------------------
>From 4c52d531680f91572ebc6f4525a018e32a934ef0 Mon Sep 17 00:00:00 2001
From: Huang Ying <huang.ying.caritas@gmail.com>
Date: Mon, 5 Feb 2018 19:27:43 +0800
Subject: [PATCH] fontswap thp fix

---
 mm/page_io.c |  2 +-
 mm/vmscan.c  | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index b41cf9644585..6dca817ae7a0 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -250,7 +250,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		unlock_page(page);
 		goto out;
 	}
-	if (frontswap_store(page) == 0) {
+	if (!PageTransHuge(page) && frontswap_store(page) == 0) {
 		set_page_writeback(page);
 		unlock_page(page);
 		end_page_writeback(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bee53495a829..d1c1e00b08bb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -55,6 +55,7 @@
 
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
+#include <linux/frontswap.h>
 
 #include "internal.h"
 
@@ -1063,14 +1064,23 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 					/* cannot split THP, skip it */
 					if (!can_split_huge_page(page, NULL))
 						goto activate_locked;
+					/*
+					 * Split THP if frontswap enabled,
+					 * because it cannot process THP
+					 */
+					if (frontswap_enabled()) {
+						if (split_huge_page_to_list(
+							page, page_list))
+							goto activate_locked;
+					}
 					/*
 					 * Split pages without a PMD map right
 					 * away. Chances are some or all of the
 					 * tail pages can be freed without IO.
 					 */
-					if (!compound_mapcount(page) &&
-					    split_huge_page_to_list(page,
-								    page_list))
+					else if (!compound_mapcount(page) &&
+						 split_huge_page_to_list(page,
+							page_list))
 						goto activate_locked;
 				}
 				if (!add_to_swap(page)) {
-- 
2.15.1
