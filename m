Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3D1C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192E62073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfACQh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:37:56 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:56538 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729598AbfACQhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:37:55 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id DC75F1C2349
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jan 2019 16:37:51 +0000 (GMT)
Received: (qmail 16531 invoked from network); 3 Jan 2019 16:37:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Jan 2019 16:37:51 -0000
Date:   Thu, 3 Jan 2019 16:37:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        xieyisheng1@huawei.com, zhong jiang <zhongjiang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Qian Cai <cai@lca.pw>
Subject: Re: possible deadlock in __wake_up_common_lock
Message-ID: <20190103163750.GH31517@techsingularity.net>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190102180611.GE31517@techsingularity.net>
 <CACT4Y+YMc0hiU-taTmwvm_6u4hAruBWV0qAz_Bp4f2a6JC-UiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CACT4Y+YMc0hiU-taTmwvm_6u4hAruBWV0qAz_Bp4f2a6JC-UiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 07:29:43PM +0100, Dmitry Vyukov wrote:
> > > This wakeup_kswapd is new due to Mel's 1c30844d2dfe ("mm: reclaim small
> > > amounts of memory when an external fragmentation event occurs") so CC Mel.
> > >
> >
> > New year new bugs :(
> 
> Old too :(
> https://syzkaller.appspot.com/#upstream-open
> 

Well, that can ruin a day! Lets see can we knock one off the list.

> > While I recognise there is no test case available, how often does this
> > trigger in syzbot as it would be nice to have some confirmation any
> > patch is really fixing the problem.
> 
> This info is always available over the "dashboard link" in the report:
> https://syzkaller.appspot.com/bug?extid=93d94a001cfbce9e60e1
> 

Noted for future reference.

> In this case it's 1. I don't know why. Lock inversions are easier to
> trigger in some sense as information accumulates globally. Maybe one
> of these stacks is hard to trigger, or maybe all these stacks are
> rarely triggered on one machine. While the info accumulates globally,
> non of the machines are actually run for any prolonged time: they all
> crash right away on hundreds of known bugs.
> 
> So good that Qian can reproduce this.

I think this might simply be hard to reproduce. I tried for hours on two
separate machines and failed. Nevertheless this should still fix it and
hopefully syzbot picks this up automaticlly when cc'd. If I hear
nothing, I'll send the patch unconditionally (and cc syzbot). Hopefully
Qian can give it a whirl too.

Thanks

--8<--
mm, page_alloc: Do not wake kswapd with zone lock held

syzbot reported the following and it was confirmed by Qian Cai that a
similar bug was visible from a different context.

======================================================
WARNING: possible circular locking dependency detected
4.20.0+ #297 Not tainted
------------------------------------------------------
syz-executor0/8529 is trying to acquire lock:
000000005e7fb829 (&pgdat->kswapd_wait){....}, at:
__wake_up_common_lock+0x19e/0x330 kernel/sched/wait.c:120

but task is already holding lock:
000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: spin_lock
include/linux/spinlock.h:329 [inline]
000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue_bulk
mm/page_alloc.c:2548 [inline]
000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: __rmqueue_pcplist
mm/page_alloc.c:3021 [inline]
000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue_pcplist
mm/page_alloc.c:3050 [inline]
000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue
mm/page_alloc.c:3072 [inline]
000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at:
get_page_from_freelist+0x1bae/0x52a0 mm/page_alloc.c:3491

It appears to be a false positive in that the only way the lock
ordering should be inverted is if kswapd is waking itself and the
wakeup allocates debugging objects which should already be allocated
if it's kswapd doing the waking. Nevertheless, the possibility exists
and so it's best to avoid the problem.

This patch flags a zone as needing a kswapd using the, surprisingly,
unused zone flag field. The flag is read without the lock held to
do the wakeup. It's possible that the flag setting context is not
the same as the flag clearing context or for small races to occur.
However, each race possibility is harmless and there is no visible
degredation in fragmentation treatment.

While zone->flag could have continued to be unused, there is potential
for moving some existing fields into the flags field instead. Particularly
read-mostly ones like zone->initialized and zone->contiguous.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h | 6 ++++++
 mm/page_alloc.c        | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cc4a507d7ca4..842f9189537b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -520,6 +520,12 @@ enum pgdat_flags {
 	PGDAT_RECLAIM_LOCKED,		/* prevents concurrent reclaim */
 };
 
+enum zone_flags {
+	ZONE_BOOSTED_WATERMARK,		/* zone recently boosted watermarks.
+					 * Cleared when kswapd is woken.
+					 */
+};
+
 static inline unsigned long zone_managed_pages(struct zone *zone)
 {
 	return (unsigned long)atomic_long_read(&zone->managed_pages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cde5dac6229a..d295c9bc01a8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2214,7 +2214,7 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	 */
 	boost_watermark(zone);
 	if (alloc_flags & ALLOC_KSWAPD)
-		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
+		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 
 	/* We are not allowed to try stealing from the whole block */
 	if (!whole_block)
@@ -3102,6 +3102,12 @@ struct page *rmqueue(struct zone *preferred_zone,
 	local_irq_restore(flags);
 
 out:
+	/* Separate test+clear to avoid unnecessary atomics */
+	if (test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags)) {
+		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
+		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
+	}
+
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
 	return page;
