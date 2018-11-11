Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8CCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E710120818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E710120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbeKLFsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50592 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730488AbeKLFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsi-0000lG-Lw; Sun, 11 Nov 2018 19:58:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001qU-Qw; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Rientjes" <rientjes@google.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Douglas Anderson" <dianders@chromium.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Mike Snitzer" <snitzer@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.361460579@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 328/366] dm bufio: avoid sleeping while holding the
 dm_bufio lock
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

commit 9ea61cac0b1ad0c09022f39fd97e9b99a2cfc2dc upstream.

We've seen in-field reports showing _lots_ (18 in one case, 41 in
another) of tasks all sitting there blocked on:

  mutex_lock+0x4c/0x68
  dm_bufio_shrink_count+0x38/0x78
  shrink_slab.part.54.constprop.65+0x100/0x464
  shrink_zone+0xa8/0x198

In the two cases analyzed, we see one task that looks like this:

  Workqueue: kverityd verity_prefetch_io

  __switch_to+0x9c/0xa8
  __schedule+0x440/0x6d8
  schedule+0x94/0xb4
  schedule_timeout+0x204/0x27c
  schedule_timeout_uninterruptible+0x44/0x50
  wait_iff_congested+0x9c/0x1f0
  shrink_inactive_list+0x3a0/0x4cc
  shrink_lruvec+0x418/0x5cc
  shrink_zone+0x88/0x198
  try_to_free_pages+0x51c/0x588
  __alloc_pages_nodemask+0x648/0xa88
  __get_free_pages+0x34/0x7c
  alloc_buffer+0xa4/0x144
  __bufio_new+0x84/0x278
  dm_bufio_prefetch+0x9c/0x154
  verity_prefetch_io+0xe8/0x10c
  process_one_work+0x240/0x424
  worker_thread+0x2fc/0x424
  kthread+0x10c/0x114

...and that looks to be the one holding the mutex.

The problem has been reproduced on fairly easily:
0. Be running Chrome OS w/ verity enabled on the root filesystem
1. Pick test patch: http://crosreview.com/412360
2. Install launchBalloons.sh and balloon.arm from
     http://crbug.com/468342
   ...that's just a memory stress test app.
3. On a 4GB rk3399 machine, run
     nice ./launchBalloons.sh 4 900 100000
   ...that tries to eat 4 * 900 MB of memory and keep accessing.
4. Login to the Chrome web browser and restore many tabs

With that, I've seen printouts like:
  DOUG: long bufio 90758 ms
...and stack trace always show's we're in dm_bufio_prefetch().

The problem is that we try to allocate memory with GFP_NOIO while
we're holding the dm_bufio lock.  Instead we should be using
GFP_NOWAIT.  Using GFP_NOIO can cause us to sleep while holding the
lock and that causes the above problems.

The current behavior explained by David Rientjes:

  It will still try reclaim initially because __GFP_WAIT (or
  __GFP_KSWAPD_RECLAIM) is set by GFP_NOIO.  This is the cause of
  contention on dm_bufio_lock() that the thread holds.  You want to
  pass GFP_NOWAIT instead of GFP_NOIO to alloc_buffer() when holding a
  mutex that can be contended by a concurrent slab shrinker (if
  count_objects didn't use a trylock, this pattern would trivially
  deadlock).

This change significantly increases responsiveness of the system while
in this state.  It makes a real difference because it unblocks kswapd.
In the bug report analyzed, kswapd was hung:

   kswapd0         D ffffffc000204fd8     0    72      2 0x00000000
   Call trace:
   [<ffffffc000204fd8>] __switch_to+0x9c/0xa8
   [<ffffffc00090b794>] __schedule+0x440/0x6d8
   [<ffffffc00090bac0>] schedule+0x94/0xb4
   [<ffffffc00090be44>] schedule_preempt_disabled+0x28/0x44
   [<ffffffc00090d900>] __mutex_lock_slowpath+0x120/0x1ac
   [<ffffffc00090d9d8>] mutex_lock+0x4c/0x68
   [<ffffffc000708e7c>] dm_bufio_shrink_count+0x38/0x78
   [<ffffffc00030b268>] shrink_slab.part.54.constprop.65+0x100/0x464
   [<ffffffc00030dbd8>] shrink_zone+0xa8/0x198
   [<ffffffc00030e578>] balance_pgdat+0x328/0x508
   [<ffffffc00030eb7c>] kswapd+0x424/0x51c
   [<ffffffc00023f06c>] kthread+0x10c/0x114
   [<ffffffc000203dd0>] ret_from_fork+0x10/0x40

By unblocking kswapd memory pressure should be reduced.

Suggested-by: David Rientjes <rientjes@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-bufio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -778,7 +778,8 @@ static struct dm_buffer *__alloc_buffer_
 	 * dm-bufio is resistant to allocation failures (it just keeps
 	 * one buffer reserved in cases all the allocations fail).
 	 * So set flags to not try too hard:
-	 *	GFP_NOIO: don't recurse into the I/O layer
+	 *	GFP_NOWAIT: don't wait; if we need to sleep we'll release our
+	 *		    mutex and wait ourselves.
 	 *	__GFP_NORETRY: don't retry and rather return failure
 	 *	__GFP_NOMEMALLOC: don't use emergency reserves
 	 *	__GFP_NOWARN: don't print a warning in case of failure
@@ -788,7 +789,7 @@ static struct dm_buffer *__alloc_buffer_
 	 */
 	while (1) {
 		if (dm_bufio_cache_size_latch != 1) {
-			b = alloc_buffer(c, GFP_NOIO | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
+			b = alloc_buffer(c, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			if (b)
 				return b;
 		}

