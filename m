Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD744C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905252064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905252064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeJVVTR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:19:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbeJVVTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:19:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9FE2CD185;
        Mon, 22 Oct 2018 13:00:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4A575C22D;
        Mon, 22 Oct 2018 13:00:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181020045608.GH32577@ZenIV.linux.org.uk>
References: <20181020045608.GH32577@ZenIV.linux.org.uk> <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk> <153999784492.866.12128875514532051040.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/24] iov_iter: Separate type from direction and use accessor functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10855.1540213245.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 22 Oct 2018 14:00:45 +0100
Message-ID: <10856.1540213245@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Oct 2018 13:00:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> One general comment: I would strongly recommend splitting the iov_iter
> initializers change into a separate patch.

Done.

> >  			void *addr = kmap_atomic(page);
> >  
> >  			written = copy_to_iter(addr, copy, iter);
> 
> FWIW, I wonder if that one is actually a missing primitive getting open-coded...

Ummm...  You mean the combination of kmap_atomic() and copy_to_iter()?  Can I
leave these for another time?

> >  		memcpy(&ctx->iter, iter, sizeof(struct iov_iter));
> >  		ctx->len = count;
> >  		iov_iter_advance(iter, count);
> 
> ... and so, to much greater extent, is this.

And combining memcpy() and iov_iter_advance()?

> > -	dio->should_dirty = (iter->type == ITER_IOVEC);
> > +	dio->should_dirty = iter_is_iovec(iter);
> 
> Nope.  This path *can* get both read and write iov_iter.  Not an equivalent
> change.

This should really have been (iter->type == (ITER_IOVEC | READ)).

Fixed to:

	dio->should_dirty = iter_is_iovec(iter) && iov_iter_rw(iter) == READ;

> > -		if (iter->type == ITER_IOVEC)
> > +		if (iter_is_iovec(iter))
> >  			dio->flags |= IOMAP_DIO_DIRTY;
> 
> Ditto.

This also should've had "| READ" in there.

Fixed to:

		if (iter_is_iovec(iter) && iov_iter_rw(iter) == READ)
 			dio->flags |= IOMAP_DIO_DIRTY;

> > @@ -417,28 +417,35 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
> >  	int err;
> >  	struct iovec v;
> >  
> > -	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
> > +	switch (iov_iter_type(i)) {
> > +	case ITER_IOVEC:
> > +	case ITER_PIPE:
> >  		iterate_iovec(i, bytes, v, iov, skip, ({
> >  			err = fault_in_pages_readable(v.iov_base, v.iov_len);
> >  			if (unlikely(err))
> >  			return err;
> >  		0;}))
> > +		break;
> > +	case ITER_KVEC:
> > +	case ITER_BVEC:
> > +		break;
> >  	}
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(iov_iter_fault_in_readable);
> 
> Huh?  That makes no sense whatsoever - ITER_PIPE ones are write-only in the
> first place, so they won't be passed to that one, but feeding ITER_PIPE to
> iterate_iovec() is insane.  And even if they copy-from ITER_PIPES would
> appear, why the devil would we want to fault-in anything?

Note that the condition "!(i->type & (ITER_BVEC|ITER_KVEC))" is true if type
is ITER_PIPE or ITER_IOVEC.

That said, I can make it BUG if it encounters a pipe iterator.

> > @@ -987,7 +1003,7 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
> >  		return;
> >  	i->count += unroll;
> > -	if (unlikely(i->type & ITER_PIPE)) {
> > +	if (unlikely(iov_iter_is_pipe(i))) {
> >  		struct pipe_inode_info *pipe = i->pipe;
> ...
> > +	case ITER_PIPE:
> > +		BUG();
> > +	}
> >  }
> >  EXPORT_SYMBOL(iov_iter_revert);
> 
> Wha...?

It should never get to the BUG() because of the earlier if-statement.
However, the compiler gets picky sometimes, but isn't necessarily good enough
to see that this particular case should never occur, so to avoid getting a
warning about missing cases I put in a BUG.  I can stick a comment on it and
make it just break.

David
