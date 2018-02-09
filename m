Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeBITqw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 14:46:52 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:60361 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeBITqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 14:46:51 -0500
Date: Fri, 9 Feb 2018 11:46:50 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Mi <chrism@mellanox.com>
Subject: Re: [RFC] Rebasing the IDR
Message-ID: <20180209194650.GH16666@bombadil.infradead.org>
References: <20171130173630.GA15948@bombadil.infradead.org>
 <151298969175.4445.1226930193594726551@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151298969175.4445.1226930193594726551@mail.alporthouse.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2017 at 10:54:51AM +0000, Chris Wilson wrote:
> Quoting Matthew Wilcox (2017-11-30 17:36:30)
> > About 40 of the approximately 180 users of the IDR in the kernel are
> > "1-based" instead of "0-based".  That is, they never want to have ID 0
> > allocated; they want to see IDs allocated between 1 and N.  Usually, that's
> > expressed like this:
> > 
> >         /* Get the user-visible handle using idr. */
> >         ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_KERNEL);
> > 
> > The current implementation of this grieves me.  You see, we mark each
> > node of the radix tree according to whether it has any free entries
> > or not, and entry 0 is always free!  If we've already allocated 10,000
> > entries from this IDR, and see this call, we'll walk all the way down
> > the left side of the tree looking for entry 1, get to the bottom,
> > see that entries 1-63 are allocated, then walk up to the next level,
> > see that 64-4095 are allocated, walk up to the next level, see that
> > 8192-12287 has a free entry, and then start walking down again.
> 
> Hmm, missing the baseline to apply this patch. But I did the quick hack
> of allocating index 0 of the idr and that did eradicate the
> idr_get_free_cmn() from being at the top of the profiles for the
> many-object stress tests. This improvement will be much appreciated.

Hi Chris,

The new IDR implementation is now in Linus' tree.  For any IDR that
you want to be 1s based, initialise it using idr_init_base() instead of
idr_init() and it will magically be more efficient.

I did a quick example on the first IDR which matched
$ git grep 'idr_alloc.*, 1,' drivers/gpu

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bd6e9a40f421..c35ea6695fee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -844,7 +844,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	}
 
 	mutex_init(&fpriv->bo_list_lock);
-	idr_init(&fpriv->bo_list_handles);
+	idr_init_base(&fpriv->bo_list_handles, 1);
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
 

Let me know if you run into any problems using it; there are test-cases in
the test-suite, but I may have missed something.
