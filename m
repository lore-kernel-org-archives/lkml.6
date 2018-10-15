Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2C6C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E372098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdJ+EV5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E372098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJPErv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeJPEru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:47:50 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688BA208B3;
        Mon, 15 Oct 2018 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539637253;
        bh=vmeL0U9OoGUmES3DW8R2mZTaNQUWMsUULVcHuPssY2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdJ+EV5nBZUyiUKp25mq7BEiUyqClAveEs4ECte5vDVs2Rr1hXKsE+jJa9FeSPQcW
         8icZMf0xGIEh3M3XQvopyVA6KELiDSkkYXv7c/l7YPiZYi3o/BXK0Swez/CBkG+nKh
         CvJVVLp4Bx+zgxXBeXg1OlnUuwDTLdkVPOpahJjA=
Date:   Mon, 15 Oct 2018 14:00:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] splice: don't merge into linked buffers
Message-ID: <20181015210051.GA20855@gmail.com>
References: <20181015150420.2096-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015150420.2096-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 05:04:18PM +0200, Jann Horn wrote:
> Before this patch, it was possible for two pipes to affect each other after
> data had been transferred between them with tee():
> 
> ============
> $ cat tee_test.c
> 
> int main(void) {
>   int pipe_a[2];
>   if (pipe(pipe_a)) err(1, "pipe");
>   int pipe_b[2];
>   if (pipe(pipe_b)) err(1, "pipe");
>   if (write(pipe_a[1], "abcd", 4) != 4) err(1, "write");
>   if (tee(pipe_a[0], pipe_b[1], 2, 0) != 2) err(1, "tee");
>   if (write(pipe_b[1], "xx", 2) != 2) err(1, "write");
> 
>   char buf[5];
>   if (read(pipe_a[0], buf, 4) != 4) err(1, "read");
>   buf[4] = 0;
>   printf("got back: '%s'\n", buf);
> }
> $ gcc -o tee_test tee_test.c
> $ ./tee_test
> got back: 'abxx'
> $
> ============
> 
> Fix it by explicitly marking buffers as mergeable and clearing that flag in
> splice_pipe_to_pipe() and link_pipe().
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 7c77f0b3f920 ("splice: implement pipe to pipe splicing")
> Fixes: 70524490ee2e ("[PATCH] splice: add support for sys_tee()")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Cleanup in the next patch, to simplify backporting.
> 
>  fs/pipe.c                 | 5 +++--
>  fs/splice.c               | 6 ++++++
>  include/linux/pipe_fs_i.h | 8 ++++++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index bdc5d3c0977d..4e2eee77f855 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -379,7 +379,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  		struct pipe_buffer *buf = pipe->bufs + lastbuf;
>  		int offset = buf->offset + buf->len;
>  
> -		if (buf->ops->can_merge && offset + chars <= PAGE_SIZE) {
> +		if (buf->ops->can_merge && offset + chars <= PAGE_SIZE &&
> +		    (buf->flags & PIPE_BUF_FLAG_MAYMERGE)) {
>  			ret = pipe_buf_confirm(pipe, buf);
>  			if (ret)
>  				goto out;
> @@ -439,7 +440,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  			buf->ops = &anon_pipe_buf_ops;
>  			buf->offset = 0;
>  			buf->len = copied;
> -			buf->flags = 0;
> +			buf->flags = PIPE_BUF_FLAG_MAYMERGE;
>  			if (is_packetized(filp)) {
>  				buf->ops = &packet_pipe_buf_ops;
>  				buf->flags = PIPE_BUF_FLAG_PACKET;
> diff --git a/fs/splice.c b/fs/splice.c
> index b3daa971f597..111977c80dfd 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1593,6 +1593,9 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
>  			 */
>  			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
>  
> +			/* We can't merge data into a buffer we don't own. */
> +			obuf->flags &= ~PIPE_BUF_FLAG_MAYMERGE;
> +
>  			obuf->len = len;
>  			opipe->nrbufs++;
>  			ibuf->offset += obuf->len;
> @@ -1667,6 +1670,9 @@ static int link_pipe(struct pipe_inode_info *ipipe,
>  		 */
>  		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
>  
> +		/* We can't merge data into a buffer we don't own. */
> +		obuf->flags &= ~PIPE_BUF_FLAG_MAYMERGE;
> +
>  		if (obuf->len > len)
>  			obuf->len = len;
>  
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 5a3bb3b7c9ad..8893711f9171 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -8,6 +8,14 @@
>  #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
>  #define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
>  #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
> +/*
> + * Set this flag if the generic pipe read/write may coalesce data into an
> + * existing buffer. If this is not set, a new pipe page segment is always used
> + * for new data.
> + * When pipe data is copied by reference (as in the tee() syscall), this flag
> + * must be cleared on the copy.
> + */
> +#define PIPE_BUF_FLAG_MAYMERGE	0x10
>  
>  /**
>   *	struct pipe_buffer - a linux kernel pipe buffer
> -- 
> 2.19.0.605.g01d371f741-goog
> 

Deja vu... https://marc.info/?l=linux-fsdevel&m=149003133809192

Thanks for fixing this; I think this is the right fix.
I verified it works for my reproducer too.

Did you check whether fuse_dev_splice_write() needs to clear
PIPE_BUF_FLAG_MAYMERGE?

- Eric
