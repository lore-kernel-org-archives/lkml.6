Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AA6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC0F20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC0F20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbeGJS2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:28:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732800AbeGJS2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:28:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8D9D3EA8;
        Tue, 10 Jul 2018 18:28:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Douglas Anderson <dianders@chromium.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.4 39/47] dm bufio: avoid sleeping while holding the dm_bufio lock
Date:   Tue, 10 Jul 2018 20:25:03 +0200
Message-Id: <20180710182338.807810204@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-bufio.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -818,7 +818,8 @@ static struct dm_buffer *__alloc_buffer_
 	 * dm-bufio is resistant to allocation failures (it just keeps
 	 * one buffer reserved in cases all the allocations fail).
 	 * So set flags to not try too hard:
-	 *	GFP_NOIO: don't recurse into the I/O layer
+	 *	GFP_NOWAIT: don't wait; if we need to sleep we'll release our
+	 *		    mutex and wait ourselves.
 	 *	__GFP_NORETRY: don't retry and rather return failure
 	 *	__GFP_NOMEMALLOC: don't use emergency reserves
 	 *	__GFP_NOWARN: don't print a warning in case of failure
@@ -828,7 +829,7 @@ static struct dm_buffer *__alloc_buffer_
 	 */
 	while (1) {
 		if (dm_bufio_cache_size_latch != 1) {
-			b = alloc_buffer(c, GFP_NOIO | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
+			b = alloc_buffer(c, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			if (b)
 				return b;
 		}


