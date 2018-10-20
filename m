Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B4CC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 04:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604E02098A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 04:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604E02098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJTNFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 09:05:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46010 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeJTNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 09:05:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDjJ2-0006Ix-PP; Sat, 20 Oct 2018 04:56:08 +0000
Date:   Sat, 20 Oct 2018 05:56:08 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/24] iov_iter: Separate type from direction and use
 accessor functions
Message-ID: <20181020045608.GH32577@ZenIV.linux.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
 <153999784492.866.12128875514532051040.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153999784492.866.12128875514532051040.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 02:10:44AM +0100, David Howells wrote:

One general comment: I would strongly recommend splitting the iov_iter
initializers change into a separate patch.

> index 8d41ca7bfcf1..dcdbcb6f09f8 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2990,7 +2990,7 @@ cifs_readdata_to_iov(struct cifs_readdata *rdata, struct iov_iter *iter)
>  		size_t copy = min_t(size_t, remaining, PAGE_SIZE);
>  		size_t written;
>  
> -		if (unlikely(iter->type & ITER_PIPE)) {
> +		if (unlikely(iov_iter_is_pipe(iter))) {
>  			void *addr = kmap_atomic(page);
>  
>  			written = copy_to_iter(addr, copy, iter);

FWIW, I wonder if that one is actually a missing primitive getting open-coded...

> @@ -786,7 +786,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
>  	struct page **pages = NULL;
>  	struct bio_vec *bv = NULL;
>  
> -	if (iter->type & ITER_KVEC) {
> +	if (iov_iter_is_kvec(iter)) {
>  		memcpy(&ctx->iter, iter, sizeof(struct iov_iter));
>  		ctx->len = count;
>  		iov_iter_advance(iter, count);

... and so, to much greater extent, is this.

> @@ -2054,14 +2054,22 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)

> +	switch (iov_iter_type(&msg->msg_iter)) {
> +	case ITER_KVEC:
>  		buf = msg->msg_iter.kvec->iov_base;
>  		to_read = msg->msg_iter.kvec->iov_len;
>  		rc = smbd_recv_buf(info, buf, to_read);
>  		break;
>  
> -	case READ | ITER_BVEC:
> +	case ITER_BVEC:
>  		page = msg->msg_iter.bvec->bv_page;
>  		page_offset = msg->msg_iter.bvec->bv_offset;
>  		to_read = msg->msg_iter.bvec->bv_len;

Incidentally, this is bollocks - looks like a fallout of RDMA patches of some
sort, but AFAICS there's no reason have separate bvec and kvec
paths there - smbd_recv_buf() can bloody well use copy_to_iter(),
eliminating the need for kmap_atomic, sleep avoidance, etc.
As well as this branching on iterator flavour...  Anyway,
not your headache.

> @@ -1313,7 +1313,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	spin_lock_init(&dio->bio_lock);
>  	dio->refcount = 1;
>  
> -	dio->should_dirty = (iter->type == ITER_IOVEC);
> +	dio->should_dirty = iter_is_iovec(iter);

Nope.  This path *can* get both read and write iov_iter.  Not an equivalent
change.

> @@ -1795,7 +1795,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		if (pos >= dio->i_size)
>  			goto out_free_dio;
>  
> -		if (iter->type == ITER_IOVEC)
> +		if (iter_is_iovec(iter))
>  			dio->flags |= IOMAP_DIO_DIRTY;

Ditto.

> @@ -417,28 +417,35 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
>  	int err;
>  	struct iovec v;
>  
> -	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
> +	switch (iov_iter_type(i)) {
> +	case ITER_IOVEC:
> +	case ITER_PIPE:
>  		iterate_iovec(i, bytes, v, iov, skip, ({
>  			err = fault_in_pages_readable(v.iov_base, v.iov_len);
>  			if (unlikely(err))
>  			return err;
>  		0;}))
> +		break;
> +	case ITER_KVEC:
> +	case ITER_BVEC:
> +		break;
>  	}
>  	return 0;
>  }
>  EXPORT_SYMBOL(iov_iter_fault_in_readable);

Huh?  That makes no sense whatsoever - ITER_PIPE ones are write-only in the first place,
so they won't be passed to that one, but feeding ITER_PIPE to iterate_iovec() is
insane.  And even if they copy-from ITER_PIPES would appear, why the devil would we
want to fault-in anything?

> @@ -987,7 +1003,7 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
>  		return;
>  	i->count += unroll;
> -	if (unlikely(i->type & ITER_PIPE)) {
> +	if (unlikely(iov_iter_is_pipe(i))) {
>  		struct pipe_inode_info *pipe = i->pipe;
...
> +	case ITER_PIPE:
> +		BUG();
> +	}
>  }
>  EXPORT_SYMBOL(iov_iter_revert);

Wha...?
