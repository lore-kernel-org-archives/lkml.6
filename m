Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeCZRcE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:32:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbeCZRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:32:03 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>
Subject: [RFC 0/1] New IDA API
Date: Mon, 26 Mar 2018 10:30:36 -0700
Message-Id: <20180326173037.11824-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

I have a tree locally with no more calls to ida_pre_get(),
ida_get_new_above(), ida_get_new() or ida_remove(), leaving us with only
calls to ida_simple_get() and ida_simple_remove().  With no 'complex'
versions, naming the functions ida_simple_* seems pointless.  I also
don't think that 'get' and 'remove' are antonyms.

The percpu_ida has the right names, in my opinion, 'alloc' and 'free'.
We're used to alloc and free from kmalloc/kfree and many other examples.
Looking through the existing users, ida_simple_get() is a little too
flexible for some users, so I included helper wrappers which allow
*most* users to just call ida_alloc(), while those that want a bounded
end can call ida_alloc_min() or ida_alloc_max().  ida_alloc_range() is
available for those who want to specify both ends of the range.

The most controversial thing is how to specify the upper bound on the
ID to allocate.  The current ida_simple_get() specifies an exclusive
bound (ie one higher than the maximum ID to return), while
ida_alloc_max() / ida_alloc_range() specify an inclusive bound (the
maximum ID to return).  Both styles of bound specification have their
adherents within the kernel, and current users seem about equally split
whether they would prefer 'end' or 'max':

drivers/block/virtio_blk.c:     err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
drivers/dax/super.c:    minor = ida_simple_get(&dax_minor_ida, 0, MINORMASK+1, GFP_KERNEL);

Some have been confused by the current convention:

drivers/fsi/fsi-core.c: master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
(pretty sure they'd be OK with returning INT_MAX)

One aspect I particularly like about specifying an inclusive rather than
exclusive bound is that this is not an uncommon pattern:
	id = ida_simple_get(&rtc_ida, of_id, of_id + 1, GFP_KERNEL);

and transforming that to
	id = ida_alloc_range(&rtc_ida, of_id, of_id, GFP_KERNEL);
makes more sense.  Also, there is a bug in the current implementation
of ida_simple_get where the above call would not just fail to allocate
an ID but actually BUG() if of_id happened to be INT_MAX.

I'm still musing whether the API should be expressed in terms of int,
or whether 64-bit systems might appreciate having the extra space of
'long'.  The underlying data structure supports 'unsigned long', but an
API that uses that is much harder to use and in the absence of any users,
I'm not going to add it.  Converting from int to long would hardly
change the interface, but it would lead to a situation where you could
allocate IDs on 64-bit systems that could never be allocated on 32-bit
systems.

Matthew Wilcox (1):
  ida: Add new API

 include/linux/idr.h | 59 +++++++++++++++++++++++++++++++++++++++++---
 lib/idr.c           | 70 ++++++++++++++++++++++++-----------------------------
 2 files changed, 87 insertions(+), 42 deletions(-)

-- 
2.16.2
