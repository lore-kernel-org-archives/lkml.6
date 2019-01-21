Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4ABC37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C97620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfAUUQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:16:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:55516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727856AbfAUUPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B48BAFF3;
        Mon, 21 Jan 2019 20:15:12 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 00/13] epoll: support pollable epoll from userspace
Date:   Mon, 21 Jan 2019 21:14:43 +0100
Message-Id: <20190121201456.28338-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is RFC v2 which introduces pollable epoll from userspace.

v2:
 - No reallocations, the max number of items (thus size of the user ring)
   is specified by the caller.

 - Interface is simplified: -ENOSPC is returned on attempt to add a new
   epoll item if number is reached the max, nothing more.

 - Alloced pages are accounted using user->locked_vm and limited to
   RLIMIT_MEMLOCK value.

 - EPOLLONESHOT is handled.

This series introduces pollable epoll from userspace, i.e. user creates
epfd with a new EPOLL_USERPOLL flag, mmaps epoll descriptor, gets header
and ring pointers and then consumes ready events from a ring, avoiding
epoll_wait() call.  When ring is empty, user has to call epoll_wait()
in order to wait for new events.  epoll_wait() returns -ESTALE if user
ring has events in the ring (kind of indication, that user has to consume
events from the user ring first, I could not invent anything better than
returning -ESTALE).

For user header and user ring allocation I used vmalloc_user().  I found
that it is much easy to reuse remap_vmalloc_range_partial() instead of
dealing with page cache (like aio.c does).  What is also nice is that
virtual address is properly aligned on SHMLBA, thus there should not be
any d-cache aliasing problems on archs with vivt or vipt caches.

** Limitations
    
1. Expect always EPOLLET flag for new epoll items (Edge Triggered behavior)
     obviously we can't call vfs_epoll() from userpace to have level
     triggered behaviour.
    
2. No support for EPOLLWAKEUP
     events are consumed from userspace, thus no way to call __pm_relax()
    
3. No support for EPOLLEXCLUSIVE
     If device does not pass pollflags to wake_up() there is no way to
     call poll() from the context under spinlock, thus special work is
     scheduled to offload polling.  In this specific case we can't
     support exclusive wakeups, because we do not know actual result
     of scheduled work and have to wake up every waiter.

** Principle of operation

* Basic structures shared with userspace:

In order to consume events from userspace all inserted items should be
stored in items array, which has original epoll_event field and u32
field for keeping ready events, i.e. each item has the following struct:

 struct epoll_uitem {
    __poll_t ready_events;
    struct epoll_event event;
 };
 BUILD_BUG_ON(sizeof(struct epoll_uitem) != 16);

And the following is a header, which is seen by userspace:

 struct epoll_uheader {
    u32 magic;          /* epoll user header magic */
    u32 header_length;  /* length of the header + items */
    u32 index_length;   /* length of the index ring, always pow2 */
    u32 max_items_nr;   /* max num of items */
    u32 head;           /* updated by userland */
    u32 int tail;       /* updated by kernel */

	struct epoll_uitem items[] __aligned(128);
 };

 /* Header is 128 bytes, thus items are aligned on CPU cache */
 BUILD_BUG_ON(sizeof(struct epoll_uheader) != 128);

In order to poll epfd from userspace application has to call:

   epoll_create2(EPOLL_USERPOLL, max_items_nr);

Ready events are kept in a ring buffer, which is simply an index table,
where each element points to an item in a header:

 unsinged int *user_index;

* How is new event accounted on kernel side?  Hot it is consumed from
* userspace?

When new event comes for some epoll item kernel does the following:

 struct epoll_uitem *uitem;

 /* Each item has a bit (index in user items array), discussed later */
 uitem = user_header->items[epi->bit];

 if (!atomic_fetch_or(uitem->ready_events, pollflags)) {
     i = atomic_add(&ep->user_header->tail, 1);

     item_idx = &user_index[i & index_mask];

     /* Signal with a bit, user spins on index expecting value > 0 */
     *item_idx = idx + 1;

    /*
     * Want index update be flushed from CPU write buffer and
     * immediately visible on userspace side to avoid long busy
     * loops.
     */
     smp_wmb();
 }

Important thing here is that ring can't infinitely grow and corrupt other
elements, because kernel always checks that item was marked as ready, so
userspace has to clear ready_events field.

On userside events the following code should be used in order to consume
events:

 tail = READ_ONCE(header->tail);
 for (i = 0; header->head != tail; header->head++) {
     item_idx_ptr = &index[idx & indeces_mask];

     /*
      * Spin here till we see valid index
      */
     while (!(idx = __atomic_load_n(item_idx_ptr, __ATOMIC_ACQUIRE)))
         ;

     item = &header->items[idx - 1];

     /*
      * Mark index as invalid, that is for userspace only, kernel does not care
      * and will refill this pointer only when observes that event is cleared,
      * which happens below.
      */
     *item_idx_ptr = 0;

     /*
      * Fetch data first, if event is cleared by the kernel we drop the data
      * returning false.
      */
     event->data = item->event.data;
     event->events = __atomic_exchange_n(&item->ready_events, 0,
                         __ATOMIC_RELEASE);

 }

* How new epoll item gets its index inside user items array?

Kernel has a bitmap for that and gets free bit on attempt to insert a new
epoll item.  When bitmap is full -ENOSPC is returned.

* Is there any testing app available?

There is a small app [1] which starts many threads with many event fds and
produces many events, while single consumer fetches them from userspace
and goes to kernel from time to time in order to wait.

[1] https://github.com/rouming/test-tools/blob/master/userpolled-epoll.c

Roman Penyaev (13):
  epoll: move private helpers from a header to the source
  epoll: introduce user structures for polling from userspace
  epoll: allocate user header and user events ring for polling from
    userspace
  epoll: some sanity flags checks for epoll syscalls for polling from
    userspace
  epoll: offload polling to a work in case of epfd polled from userspace
  epoll: introduce helpers for adding/removing events to uring
  epoll: call ep_add_event_to_uring() from ep_poll_callback()
  epoll: support polling from userspace for ep_insert()
  epoll: support polling from userspace for ep_remove()
  epoll: support polling from userspace for ep_modify()
  epoll: support polling from userspace for ep_poll()
  epoll: support mapping for epfd when polled from userspace
  epoll: implement epoll_create2() syscall

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/eventpoll.c                         | 711 ++++++++++++++++++++++---
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/eventpoll.h         |  37 +-
 kernel/sys_ni.c                        |   1 +
 7 files changed, 657 insertions(+), 99 deletions(-)

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
-- 
2.19.1

