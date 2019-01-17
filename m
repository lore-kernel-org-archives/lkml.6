Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E2DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC39320859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QTfYXPiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfAQUIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:08:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfAQUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jscXmMYN7AfUsu7lB13fHEmXJtoPvVFTggQ639HBNYk=; b=QTfYXPiqAGc/1d+PwTETkN0DTn
        iyEaeYmwLf6GM6PMaRj7SQLikxeEWeOz+ww9rhx7eyg4ZUCSZ2QrTwBYv0WGTYLgDU+NvFPxxYAPZ
        szmSg3X8/p+N/i1Rx5Xgl7a5LoG1DPpSPUG5vzanpbKHCaqXg2vF7Gi9n8B8vBki1Qmw61vis8BD9
        e4pxfRAHsGUN/hiv+DFZyLgSflhk1t9xsmiNvvG+0pErpk6Bwh/Jd3VZKj8I5nOjDA3nhBK3c+XGM
        Li/2QGQ3ahPHsb1k0w/F0PP+N+gnhlZd9aLV6Y4jnhQXrD4+OgPlbZc9BJptQ27xG6Q+CkNioAmuw
        38aGmi8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkDxZ-0007Ki-DU
        for linux-kernel@vger.kernel.org; Thu, 17 Jan 2019 20:08:17 +0000
Date:   Thu, 17 Jan 2019 12:08:17 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Subject: Design of xa_alloc
Message-ID: <20190117200816.GP6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As part of getting rid of the radix tree, I need to replace idr_alloc()
with xa_alloc().  xa_alloc() takes the internal xa_lock (and has
xa_alloc_irq(), xa_alloc_bh() and __xa_alloc() variations which handle
the lock the way you probably expect them to).

It would, of course, be possible to make the xa_alloc() API identical
to idr_alloc().  idr_alloc() has been a phenomenal success with around
200 callers in the kernel today.  But it could be improved, and this
seems like a good time to make the API changes.

int idr_alloc(struct idr *, void *ptr, int start, int end, gfp_t);

1. It is not possible to allocate an ID above 2^31.  This led to the
   introduction of idr_alloc_u32 (which has its own problems I'll talk
   about later)
2. It's hard to insert a fully-initialised object into an IDR in a
   way that is safe for RCU-based lookups; the object needs to be marked
   as not-fully-initialised, then inserted, then the ID updated, then the
   object marked as fully-initialised.  Many users choose an "invalid" ID
   for this purpose, or make two calls, first allocating a NULL pointer,
   then replacing it with the actual object.
3. Allocating a specific ID is a little awkward, passing 'id, id + 1' as
   start & end.
4, The meaning of the 'end' argument has been misunderstood by some users.
   It's exclusive, not inclusive, so writing 'INT_MAX' means you
   can allocate up to INT_MAX-1.  This probably doesn't cause any bugs,
   but it's not great.
5. Nobody actually uses the ability to allocate an ID between 'a' and
   'a + n' which is the rationale for how idr_alloc interprets negative
   'end'.
6. Using a non-zero 'start' is inefficient.  I made a start on solving
   this with IDR_INIT_BASE(), but this is a good opportunity to solve
   it for the whole kernel.

As for idr_alloc_u32(), it's just too easy to forget to initialise *id
before calling it, and there's no realistic way to get gcc to warn for
that mistake.  It does solve problems 2, 3 and 5, but it's a bad tradeoff.
The current xa_alloc() in the tree is modelled after idr_alloc_u32(), but
I feel it should be fixed.

I've been through a number of variations of this interface, but this is
what I've currently settled on:

/**
 * xa_alloc() - Find somewhere to store this entry in the XArray.
 * @xa: XArray.
 * @id: Pointer to ID.
 * @entry: New entry.
 * @limit: Range of ID to allocate.
 * @gfp: Memory allocation flags.
 *
 * Finds an empty entry in @xa between @limit.min and @limit.max,
 * stores the index into the @id pointer, then stores the entry at
 * that index.  A concurrent lookup will not see an uninitialised @id.
 *
 * Context: Any context.  Takes and releases the xa_lock.  May sleep if
 * the @gfp flags permit.
 * Return: 0 on success, -ENOMEM if memory could not be allocated or
 * -ENOSPC if there are no free entries in @limit.
 */
static inline __must_check int xa_alloc(struct xarray *xa, u32 *id,
                void *entry, struct xa_limit limit, gfp_t gfp)

Problems 1 & 2 are solved by passing a pointer to the ID, but using it
only as an output, avoiding the initialisation problem of idr_alloc_u32().
There are a few users who store the allocated ID in a u16, but this
isn't too hard to work around.

Problem 3 is solved by using xa_insert() instead of xa_alloc().  It does
return a different errno (-EEXIST) instead of -ENOSPC, but most users
convert the errno to something else anyway because -ENOSPC is a horrible
errno to return to userspace.

Problem 4 is solved by interpreting the 'max' element of xa_limit
inclusively.  The xa_limit is a little complicated to explain, but easy
to use.  Most users will use one of two predefined ranges; xa_limit_32b
or xa_limit_31b which correspond to the ranges [0 - UINT_MAX] and [0 -
INT_MAX] respectively.  The remaining users will pass XA_LIMIT(x, y)
as an argument.

Problem 6 is solved by having two ways of declaring an allocating XArray:

#define DEFINE_XARRAY_ALLOC(name) DEFINE_XARRAY_FLAGS(name, XA_FLAGS_ALLOC)
#define DEFINE_XARRAY_ALLOC1(name) DEFINE_XARRAY_FLAGS(name, XA_FLAGS_ALLOC1)

Supporting bases other than 0 and 1 seems like more effort than it's worth.


Here's an example conversion which is fairly typical, drivers/scsi/st.c:

-static DEFINE_SPINLOCK(st_index_lock);
-static DEFINE_IDR(st_index_idr);
+static DEFINE_XARRAY_ALLOC(st_index);

[...]

-       idr_preload(GFP_KERNEL);
-       spin_lock(&st_index_lock);
-       error = idr_alloc(&st_index_idr, tpnt, 0, ST_MAX_TAPES + 1, GFP_NOWAIT);
-       spin_unlock(&st_index_lock);
-       idr_preload_end();
+       error = xa_alloc(&st_index, &tpnt->index, tpnt,
+                       XA_LIMIT(0, ST_MAX_TAPES), GFP_KERNEL);
        if (error < 0) {
                pr_warn("st: idr allocation failed: %d\n", error);
                goto out_put_queue;
        }
-       tpnt->index = error;


Similarly, we also need an xa_alloc_cyclic, which can be found here:
http://git.infradead.org/users/willy/linux-dax.git/commitdiff/9bbcfb45052235ede806b0a84dcaacc27a5c2f66

