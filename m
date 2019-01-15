Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98080C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3420868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbfAOQUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:20:18 -0500
Received: from relay.sw.ru ([185.231.240.75]:51534 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfAOQUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:20:18 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gjRRn-0004Bj-21; Tue, 15 Jan 2019 19:20:15 +0300
Subject: Re: [PATCH RFC] fuse: Prevent background write requests increase
 inode size
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <154151286725.17550.12307253489084032792.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5a653d5f-268b-b2ff-2312-00effb30108f@virtuozzo.com>
Date:   Tue, 15 Jan 2019 19:20:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154151286725.17550.12307253489084032792.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miklos,

please take a look into two problems this patch points:

1)we have to set "io->async = false" in fuse_direct_IO(),
  when inode size is changed (we mustn't increase inode
  size in background);
2)we have to increment fi->writectr on all background requests.

Thanks,
Kirill

On 06.11.2018 17:02, Kirill Tkhai wrote:
> Hi, Miklos,
> 
> this is not a well-tested patch, this is a concept,
> showing the places, where it looks we have a problem.
> 
> Commit 7879c4e58b7c made io->async careless about inode size,
> and this is wrong. Asyncronuos background requests may be sent
> to userspace after inode becomes unlocked, when background
> queue is throttled. In this case we execute a write request
> extending inode size without any protection, and this ruines
> everything. Fix that.
> 
> Also, some write background requests do not increment fi->writectr,
> e.g.:
> 	fuse_direct_IO()
> 	  fuse_direct_io()
> 	    fuse_send_write()
> 	      fuse_async_req_send()
> 	        fuse_request_send_background()
> 
> This is a reason fuse_sync_writes() does not work as expected.
> Fix that too.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/file.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index cc2121b37bf5..0b71a3c96168 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -610,6 +610,9 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>  static void fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req)
>  {
>  	struct fuse_io_priv *io = req->io;
> +	struct kiocb *iocb = io->iocb;
> +	struct file *file = iocb->ki_filp;
> +	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
>  	ssize_t pos = -1;
>  
>  	fuse_release_user_pages(req, io->should_dirty);
> @@ -625,6 +628,12 @@ static void fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req)
>  	}
>  
>  	fuse_aio_complete(io, req->out.h.error, pos);
> +
> +	if (io->write) {
> +		spin_lock(&fc->lock);
> +		fi->writectr--;
> +		spin_unlock(&fc->lock);
> +	}
>  }
>  
>  static size_t fuse_async_req_send(struct fuse_conn *fc, struct fuse_req *req,
> @@ -966,6 +975,7 @@ static size_t fuse_send_write(struct fuse_req *req, struct fuse_io_priv *io,
>  {
>  	struct kiocb *iocb = io->iocb;
>  	struct file *file = iocb->ki_filp;
> +	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_conn *fc = ff->fc;
>  	struct fuse_write_in *inarg = &req->misc.write.in;
> @@ -981,8 +991,12 @@ static size_t fuse_send_write(struct fuse_req *req, struct fuse_io_priv *io,
>  		inarg->lock_owner = fuse_lock_owner_id(fc, owner);
>  	}
>  
> -	if (io->async)
> +	if (io->async) {
> +		spin_lock(&fc->lock);
> +		fi->writectr++;
> +		spin_unlock(&fc->lock);
>  		return fuse_async_req_send(fc, req, count, io);
> +	}
>  
>  	fuse_request_send(fc, req);
>  	return req->misc.write.out.size;
> @@ -2904,8 +2918,10 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	 * We cannot asynchronously extend the size of a file.
>  	 * In such case the aio will behave exactly like sync io.
>  	 */
> -	if ((offset + count > i_size) && iov_iter_rw(iter) == WRITE)
> +	if ((offset + count > i_size) && iov_iter_rw(iter) == WRITE) {
>  		io->blocking = true;
> +		io->async = false;
> +	}
>  
>  	if (io->async && io->blocking) {
>  		/*
> 
