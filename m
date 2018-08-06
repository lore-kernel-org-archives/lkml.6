Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44953C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0059421A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0059421A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeHFMzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:55:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727978AbeHFMzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:55:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76F457C6A9;
        Mon,  6 Aug 2018 10:46:43 +0000 (UTC)
Received: from localhost (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBFC92026D68;
        Mon,  6 Aug 2018 10:46:42 +0000 (UTC)
Date:   Mon, 6 Aug 2018 12:46:40 +0200
From:   Niels de Vos <ndevos@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Marcin Sulikowski <marcin.k.sulikowski@gmail.com>
Subject: Re: [PATCH v3] fuse: add support for copy_file_range()
Message-ID: <20180806104640.GF14004@ndevos-x270>
References: <20180629121630.GS2345@ndevos-x270>
 <20180629125341.30466-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629125341.30466-1-ndevos@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 10:46:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 10:46:43 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ndevos@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

On Fri, Jun 29, 2018 at 02:53:41PM +0200, Niels de Vos wrote:
> There are several FUSE filesystems that can implement server-side copy
> or other efficient copy/duplication/clone methods. The copy_file_range()
> syscall is the standard interface that users have access to while not
> depending on external libraries that bypass FUSE.

Could you have a look at this patch? A review would be most welcome.
This has been tested with libfuse, and the pull-request for that is
available at https://github.com/libfuse/libfuse/pull/259

Marcin had a look already too, with his feedback we landed at V3 of this
change.

Thanks,
Niels


> Signed-off-by: Niels de Vos <ndevos@redhat.com>
> 
> ---
> v2: return ssize_t instead of long
> v3: add nodeid_out to fuse_copy_file_range_in for libfuse expectations
> ---
>  fs/fuse/file.c            |  66 +++++++++++++++++++++++
>  fs/fuse/fuse_i.h          |   3 ++
>  include/uapi/linux/fuse.h | 107 ++++++++++++++++++++++----------------
>  3 files changed, 132 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 67648ccbdd43..864939a1215d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3009,6 +3009,71 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  	return err;
>  }
>  
> +static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> +				    struct file *file_out, loff_t pos_out,
> +				    size_t len, unsigned int flags)
> +{
> +	struct fuse_file *ff_in = file_in->private_data;
> +	struct fuse_file *ff_out = file_out->private_data;
> +	struct inode *inode_out = file_inode(file_out);
> +	struct fuse_inode *fi_out = get_fuse_inode(inode_out);
> +	struct fuse_conn *fc = ff_in->fc;
> +	FUSE_ARGS(args);
> +	struct fuse_copy_file_range_in inarg = {
> +		.fh_in = ff_in->fh,
> +		.off_in = pos_in,
> +		.nodeid_out = ff_out->nodeid,
> +		.fh_out = ff_out->fh,
> +		.off_out = pos_out,
> +		.len = len,
> +		.flags = flags
> +	};
> +	struct fuse_copy_file_range_out outarg;
> +	ssize_t err;
> +
> +	if (fc->no_copy_file_range)
> +		return -EOPNOTSUPP;
> +
> +	inode_lock(inode_out);
> +	set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> +
> +	args.in.h.opcode = FUSE_COPY_FILE_RANGE;
> +	args.in.h.nodeid = ff_in->nodeid;
> +	args.in.numargs = 1;
> +	args.in.args[0].size = sizeof(inarg);
> +	args.in.args[0].value = &inarg;
> +	args.out.numargs = 1;
> +	args.out.args[0].size = sizeof(outarg);
> +	args.out.args[0].value = &outarg;
> +	err = fuse_simple_request(fc, &args);
> +	if (err == -ENOSYS) {
> +		fc->no_copy_file_range = 1;
> +		err = -EOPNOTSUPP;
> +	}
> +	if (err)
> +		goto out;
> +
> +	/* we might have extended the file */
> +	if (outarg.size > 0) {
> +		/* Size of inode_out may not have changed in case of
> +		 * overwrites, oh well. */
> +		bool changed = fuse_write_update_size(inode_out,
> +						      pos_out + outarg.size);
> +
> +		if (changed && fc->writeback_cache)
> +			file_update_time(file_out);
> +	}
> +
> +	fuse_invalidate_attr(inode_out);
> +
> +	err = outarg.size;
> +out:
> +	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> +	inode_unlock(inode_out);
> +
> +	return err;
> +}
> +
>  static const struct file_operations fuse_file_operations = {
>  	.llseek		= fuse_file_llseek,
>  	.read_iter	= fuse_file_read_iter,
> @@ -3025,6 +3090,7 @@ static const struct file_operations fuse_file_operations = {
>  	.compat_ioctl	= fuse_file_compat_ioctl,
>  	.poll		= fuse_file_poll,
>  	.fallocate	= fuse_file_fallocate,
> +	.copy_file_range = fuse_copy_file_range,
>  };
>  
>  static const struct file_operations fuse_direct_io_file_operations = {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 5256ad333b05..ea848bb7d9e2 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -637,6 +637,9 @@ struct fuse_conn {
>  	/** Allow other than the mounter user to access the filesystem ? */
>  	unsigned allow_other:1;
>  
> +	/** Does the filesystem support copy_file_range? */
> +	unsigned no_copy_file_range:1;
> +
>  	/** The number of requests waiting for completion */
>  	atomic_t num_waiting;
>  
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 92fa24c24c92..84aa810e04c8 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -116,6 +116,9 @@
>   *
>   *  7.27
>   *  - add FUSE_ABORT_ERROR
> + *
> + *  7.28
> + *  - add FUSE_COPY_FILE_RANGE
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -337,50 +340,51 @@ struct fuse_file_lock {
>  #define FUSE_POLL_SCHEDULE_NOTIFY (1 << 0)
>  
>  enum fuse_opcode {
> -	FUSE_LOOKUP	   = 1,
> -	FUSE_FORGET	   = 2,  /* no reply */
> -	FUSE_GETATTR	   = 3,
> -	FUSE_SETATTR	   = 4,
> -	FUSE_READLINK	   = 5,
> -	FUSE_SYMLINK	   = 6,
> -	FUSE_MKNOD	   = 8,
> -	FUSE_MKDIR	   = 9,
> -	FUSE_UNLINK	   = 10,
> -	FUSE_RMDIR	   = 11,
> -	FUSE_RENAME	   = 12,
> -	FUSE_LINK	   = 13,
> -	FUSE_OPEN	   = 14,
> -	FUSE_READ	   = 15,
> -	FUSE_WRITE	   = 16,
> -	FUSE_STATFS	   = 17,
> -	FUSE_RELEASE       = 18,
> -	FUSE_FSYNC         = 20,
> -	FUSE_SETXATTR      = 21,
> -	FUSE_GETXATTR      = 22,
> -	FUSE_LISTXATTR     = 23,
> -	FUSE_REMOVEXATTR   = 24,
> -	FUSE_FLUSH         = 25,
> -	FUSE_INIT          = 26,
> -	FUSE_OPENDIR       = 27,
> -	FUSE_READDIR       = 28,
> -	FUSE_RELEASEDIR    = 29,
> -	FUSE_FSYNCDIR      = 30,
> -	FUSE_GETLK         = 31,
> -	FUSE_SETLK         = 32,
> -	FUSE_SETLKW        = 33,
> -	FUSE_ACCESS        = 34,
> -	FUSE_CREATE        = 35,
> -	FUSE_INTERRUPT     = 36,
> -	FUSE_BMAP          = 37,
> -	FUSE_DESTROY       = 38,
> -	FUSE_IOCTL         = 39,
> -	FUSE_POLL          = 40,
> -	FUSE_NOTIFY_REPLY  = 41,
> -	FUSE_BATCH_FORGET  = 42,
> -	FUSE_FALLOCATE     = 43,
> -	FUSE_READDIRPLUS   = 44,
> -	FUSE_RENAME2       = 45,
> -	FUSE_LSEEK         = 46,
> +	FUSE_LOOKUP	     = 1,
> +	FUSE_FORGET	     = 2,  /* no reply */
> +	FUSE_GETATTR	     = 3,
> +	FUSE_SETATTR	     = 4,
> +	FUSE_READLINK	     = 5,
> +	FUSE_SYMLINK	     = 6,
> +	FUSE_MKNOD	     = 8,
> +	FUSE_MKDIR	     = 9,
> +	FUSE_UNLINK	     = 10,
> +	FUSE_RMDIR	     = 11,
> +	FUSE_RENAME	     = 12,
> +	FUSE_LINK	     = 13,
> +	FUSE_OPEN	     = 14,
> +	FUSE_READ	     = 15,
> +	FUSE_WRITE	     = 16,
> +	FUSE_STATFS	     = 17,
> +	FUSE_RELEASE         = 18,
> +	FUSE_FSYNC           = 20,
> +	FUSE_SETXATTR        = 21,
> +	FUSE_GETXATTR        = 22,
> +	FUSE_LISTXATTR       = 23,
> +	FUSE_REMOVEXATTR     = 24,
> +	FUSE_FLUSH           = 25,
> +	FUSE_INIT            = 26,
> +	FUSE_OPENDIR         = 27,
> +	FUSE_READDIR         = 28,
> +	FUSE_RELEASEDIR      = 29,
> +	FUSE_FSYNCDIR        = 30,
> +	FUSE_GETLK           = 31,
> +	FUSE_SETLK           = 32,
> +	FUSE_SETLKW          = 33,
> +	FUSE_ACCESS          = 34,
> +	FUSE_CREATE          = 35,
> +	FUSE_INTERRUPT       = 36,
> +	FUSE_BMAP            = 37,
> +	FUSE_DESTROY         = 38,
> +	FUSE_IOCTL           = 39,
> +	FUSE_POLL            = 40,
> +	FUSE_NOTIFY_REPLY    = 41,
> +	FUSE_BATCH_FORGET    = 42,
> +	FUSE_FALLOCATE       = 43,
> +	FUSE_READDIRPLUS     = 44,
> +	FUSE_RENAME2         = 45,
> +	FUSE_LSEEK           = 46,
> +	FUSE_COPY_FILE_RANGE = 47,
>  
>  	/* CUSE specific operations */
>  	CUSE_INIT          = 4096,
> @@ -792,4 +796,19 @@ struct fuse_lseek_out {
>  	uint64_t	offset;
>  };
>  
> +struct fuse_copy_file_range_in {
> +	uint64_t	fh_in;
> +	uint64_t	off_in;
> +	uint64_t	nodeid_out;
> +	uint64_t	fh_out;
> +	uint64_t	off_out;
> +	uint64_t	len;
> +	uint32_t	flags;
> +};
> +
> +struct fuse_copy_file_range_out {
> +	uint32_t	size;
> +	uint32_t	padding;
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> -- 
> 2.17.1
> 
