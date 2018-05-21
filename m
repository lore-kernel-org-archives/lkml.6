Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeEUTOM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:14:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeEUTOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:14:00 -0400
Date: Mon, 21 May 2018 12:13:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Roman Kagan <rkagan@virtuozzo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-Id: <20180521121358.0d0c64a5ca9f34efab086fe8@linux-foundation.org>
In-Reply-To: <20180519141445.GA9526@bombadil.infradead.org>
References: <20180518175025.GD6361@bombadil.infradead.org>
        <20180518153138.459c78a83c6bada41b4b187d@linux-foundation.org>
        <20180519062635.GA6352@rkaganip.lan>
        <20180519141445.GA9526@bombadil.infradead.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2018 07:14:45 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, May 19, 2018 at 09:26:36AM +0300, Roman Kagan wrote:
> > On Fri, May 18, 2018 at 03:31:38PM -0700, Andrew Morton wrote:
> > > On Fri, 18 May 2018 10:50:25 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > > 
> > > > If the radix tree underlying the IDR happens to be full and we attempt
> > > > to remove an id which is larger than any id in the IDR, we will call
> > > > __radix_tree_delete() with an uninitialised 'slot' pointer, at which
> > > > point anything could happen.  This was easiest to hit with a single entry
> > > > at id 0 and attempting to remove a non-0 id, but it could have happened
> > > > with 64 entries and attempting to remove an id >= 64.
> > > > 
> > > > Fixes: 0a835c4f090a ("Reimplement IDR and IDA using the radix tree")
> > > > Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> > > > Debugged-by: Roman Kagan <rkagan@virtuozzo.com>
> > > > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > > 
> > > Neither of the changelogs I'm seeing attempt to describe the end-user
> > > impact of the bug.  People like to know that so they can decide which
> > > kernel version(s) need patching, so please always remember it.
> > 
> > That's my fault, Matthew may not have seen the original discussion among
> > the KVM folks.
> > 
> > > Looknig at the sysbot report, the impact is at least "privileged user
> > > can trigger a WARN", but I assume there could be worse,
> > 
> > Unfortunately it is worse: the syzcaller test boils down to opening
> > /dev/kvm, creating an eventfd, and calling a couple of KVM ioctls.  None
> > of this requires superuser.  And the result is dereferencing an
> > uninitialized pointer which is likely a crash.
> > 
> > > as-yet-undiscovered impacts.  So I'm thinking a cc:stable is needed,
> > > yes?
> > 
> > Well the specific path caught by syzbot is via KVM_HYPERV_EVENTD ioctl
> > which is new in 4.17.  But I guess there are other user-triggerable
> > paths, so cc:stable is probably justified.
> 
> We have around 250 calls to idr_remove() in the kernel today.  Many of
> them pass an ID which is embedded in the object they're removing, so
> they're safe.  Picking a few likely candidates:
> 
> drivers/firewire/core-cdev.c looks unsafe; the ID comes from an ioctl.
> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c is similar
> drivers/atm/nicstar.c could be taken down by a handcrafted packet

OK, thanks, I sprinkled some of the above words into the changelog ad
added cc:stable.


From: Matthew Wilcox <mawilcox@microsoft.com>
Subject: idr: fix invalid ptr dereference on item delete

If the radix tree underlying the IDR happens to be full and we attempt to
remove an id which is larger than any id in the IDR, we will call
__radix_tree_delete() with an uninitialised 'slot' pointer, at which point
anything could happen.  This was easiest to hit with a single entry at id
0 and attempting to remove a non-0 id, but it could have happened with 64
entries and attempting to remove an id >= 64.

Roman said:

  The syzcaller test boils down to opening /dev/kvm, creating an
  eventfd, and calling a couple of KVM ioctls.  None of this requires
  superuser.  And the result is dereferencing an uninitialized pointer
  which is likely a crash.  The specific path caught by syzbot is via
  KVM_HYPERV_EVENTD ioctl which is new in 4.17.  But I guess there are
  other user-triggerable paths, so cc:stable is probably justified.

Matthew added:

  We have around 250 calls to idr_remove() in the kernel today.  Many
  of them pass an ID which is embedded in the object they're removing,
  so they're safe.  Picking a few likely candidates:

  drivers/firewire/core-cdev.c looks unsafe; the ID comes from an ioctl.
  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c is similar
  drivers/atm/nicstar.c could be taken down by a handcrafted packet

Link: http://lkml.kernel.org/r/20180518175025.GD6361@bombadil.infradead.org
Fixes: 0a835c4f090a ("Reimplement IDR and IDA using the radix tree")
Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
Debugged-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/radix-tree.c                    |    4 +++-
 tools/testing/radix-tree/idr-test.c |    7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff -puN lib/radix-tree.c~idr-fix-invalid-ptr-dereference-on-item-delete lib/radix-tree.c
--- a/lib/radix-tree.c~idr-fix-invalid-ptr-dereference-on-item-delete
+++ a/lib/radix-tree.c
@@ -2034,10 +2034,12 @@ void *radix_tree_delete_item(struct radi
 			     unsigned long index, void *item)
 {
 	struct radix_tree_node *node = NULL;
-	void __rcu **slot;
+	void __rcu **slot = NULL;
 	void *entry;
 
 	entry = __radix_tree_lookup(root, index, &node, &slot);
+	if (!slot)
+		return NULL;
 	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
 						get_slot_offset(node, slot))))
 		return NULL;
diff -puN tools/testing/radix-tree/idr-test.c~idr-fix-invalid-ptr-dereference-on-item-delete tools/testing/radix-tree/idr-test.c
--- a/tools/testing/radix-tree/idr-test.c~idr-fix-invalid-ptr-dereference-on-item-delete
+++ a/tools/testing/radix-tree/idr-test.c
@@ -252,6 +252,13 @@ void idr_checks(void)
 	idr_remove(&idr, 3);
 	idr_remove(&idr, 0);
 
+	assert(idr_alloc(&idr, DUMMY_PTR, 0, 0, GFP_KERNEL) == 0);
+	idr_remove(&idr, 1);
+	for (i = 1; i < RADIX_TREE_MAP_SIZE; i++)
+		assert(idr_alloc(&idr, DUMMY_PTR, 0, 0, GFP_KERNEL) == i);
+	idr_remove(&idr, 1 << 30);
+	idr_destroy(&idr);
+
 	for (i = INT_MAX - 3UL; i < INT_MAX + 1UL; i++) {
 		struct item *item = item_create(i, 0);
 		assert(idr_alloc(&idr, item, i, i + 10, GFP_KERNEL) == i);
_
