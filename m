Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794A8C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E03C21723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZfoF7i0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E03C21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbeHGOQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:16:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34905 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeHGOQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:16:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so27981987oic.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ni1bMlS+6A1NsNB5hX3yt8UGYYP8XwAMdSDc0Hh0ZW8=;
        b=ZfoF7i0VBrNGt0Vj2WoQBvOw38iY7dSpZfQG+VyNDh4Lf8TvtVn/QFG1ylLyl4EJeP
         epacFOapJsfaW2TtBiUcd1Q9wfFNdr5zBz5uzi4gvrEhdWHG8/igkoskt+NHfNViCoeB
         ERtLdkDkzR+A4Do07YsfU6TIU7NMpqF5if7IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ni1bMlS+6A1NsNB5hX3yt8UGYYP8XwAMdSDc0Hh0ZW8=;
        b=iyur4mG6RpskuBYSv2LWLBkHD8njAsIul6CJNWKVzimACqRy08UbbhHGezat2Zb2FE
         xZdCIFh9lU7fh3VaLYznXzLEDzt0HQ3OeFxCHIQ43RuhFPXNZErDG4eUAZJjks9+BRfL
         Jz4RKW9WsTm/kP1uAphxzhmXbn0ZzUJwc7DbJrVQludh4aW4KvHhvF5tcAWKotVVOfla
         IDyvhiNg41tJ1BLf+j9SUgfcwz24P3nD1mE4Abrh4GPbpNe4FGJ2K3Iy+0inrXBk8+bo
         JqlS121AhBBVWbg/34o7ZPIBm2LqruJHL0Jdno45v9mYI1aUOw5e7TWDZmWGAv/orOjn
         cNlQ==
X-Gm-Message-State: AOUpUlFu32ObYPaNTR+qP76H5fbvHIy1IdGQ5krnMjTccVgVvuF6/JPZ
        sO5WLu4E+naFhffythB+yJRS+Q8goizsYsrC23qVeEH1
X-Google-Smtp-Source: AAOMgpcbOmqCoIB5vETHzDlX/NFLTvTeIPJCMhe/5lF6RycA0umEjQyOFvibly23wnxNsw22QNMwpvxRblXRdvzYvro=
X-Received: by 2002:aca:3c45:: with SMTP id j66-v6mr17517346oia.118.1533643356124;
 Tue, 07 Aug 2018 05:02:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 05:02:35 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180629125341.30466-1-ndevos@redhat.com>
References: <20180629121630.GS2345@ndevos-x270> <20180629125341.30466-1-ndevos@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Aug 2018 14:02:35 +0200
Message-ID: <CAJfpegstirk9AymSO3GHixNWCd_wNwvXRKj0zyVNDX3ftMqkHQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: add support for copy_file_range()
To:     Niels de Vos <ndevos@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcin Sulikowski <marcin.k.sulikowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 2:53 PM, Niels de Vos <ndevos@redhat.com> wrote:
> There are several FUSE filesystems that can implement server-side copy
> or other efficient copy/duplication/clone methods. The copy_file_range()
> syscall is the standard interface that users have access to while not
> depending on external libraries that bypass FUSE.
>
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
>         return err;
>  }
>
> +static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> +                                   struct file *file_out, loff_t pos_out,
> +                                   size_t len, unsigned int flags)
> +{
> +       struct fuse_file *ff_in = file_in->private_data;
> +       struct fuse_file *ff_out = file_out->private_data;
> +       struct inode *inode_out = file_inode(file_out);
> +       struct fuse_inode *fi_out = get_fuse_inode(inode_out);
> +       struct fuse_conn *fc = ff_in->fc;
> +       FUSE_ARGS(args);
> +       struct fuse_copy_file_range_in inarg = {
> +               .fh_in = ff_in->fh,
> +               .off_in = pos_in,
> +               .nodeid_out = ff_out->nodeid,
> +               .fh_out = ff_out->fh,
> +               .off_out = pos_out,
> +               .len = len,
> +               .flags = flags
> +       };
> +       struct fuse_copy_file_range_out outarg;
> +       ssize_t err;
> +
> +       if (fc->no_copy_file_range)
> +               return -EOPNOTSUPP;
> +
> +       inode_lock(inode_out);
> +       set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);

This one is only needed in the non-writeback-cache case and only if
the operations is size extending.

Here's how the writeback-cache is supposed to work: the kernel buffers
writes, just like a normal filesystem, as well as buffering related
metadata updates (size & [cm]time), again, just like a normal
filesystem.  This means we just don't care about i_size being updated
in userspace, any such change will be overwritten when the metadata is
flushed out.

In writeback-cache mode, when we do any other data modification, we
need to first flush out the cache so that the order of writes is not
mixed up.  See fallocate() for example.  We could be selective and
only flush the range covered by [pos, pos+len], but just flushing
everything is okay.

I could add these, but you already have a test for this set up, so, I
wouldn't mind if you post a new version.

> +
> +       args.in.h.opcode = FUSE_COPY_FILE_RANGE;
> +       args.in.h.nodeid = ff_in->nodeid;
> +       args.in.numargs = 1;
> +       args.in.args[0].size = sizeof(inarg);
> +       args.in.args[0].value = &inarg;
> +       args.out.numargs = 1;
> +       args.out.args[0].size = sizeof(outarg);
> +       args.out.args[0].value = &outarg;
> +       err = fuse_simple_request(fc, &args);
> +       if (err == -ENOSYS) {
> +               fc->no_copy_file_range = 1;
> +               err = -EOPNOTSUPP;
> +       }
> +       if (err)
> +               goto out;
> +
> +       /* we might have extended the file */
> +       if (outarg.size > 0) {
> +               /* Size of inode_out may not have changed in case of
> +                * overwrites, oh well. */
> +               bool changed = fuse_write_update_size(inode_out,
> +                                                     pos_out + outarg.size);
> +
> +               if (changed && fc->writeback_cache)
> +                       file_update_time(file_out);
> +       }
> +
> +       fuse_invalidate_attr(inode_out);
> +
> +       err = outarg.size;
> +out:
> +       clear_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
> +       inode_unlock(inode_out);
> +
> +       return err;
> +}
> +
>  static const struct file_operations fuse_file_operations = {
>         .llseek         = fuse_file_llseek,
>         .read_iter      = fuse_file_read_iter,
> @@ -3025,6 +3090,7 @@ static const struct file_operations fuse_file_operations = {
>         .compat_ioctl   = fuse_file_compat_ioctl,
>         .poll           = fuse_file_poll,
>         .fallocate      = fuse_file_fallocate,
> +       .copy_file_range = fuse_copy_file_range,
>  };
>
>  static const struct file_operations fuse_direct_io_file_operations = {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 5256ad333b05..ea848bb7d9e2 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -637,6 +637,9 @@ struct fuse_conn {
>         /** Allow other than the mounter user to access the filesystem ? */
>         unsigned allow_other:1;
>
> +       /** Does the filesystem support copy_file_range? */
> +       unsigned no_copy_file_range:1;
> +
>         /** The number of requests waiting for completion */
>         atomic_t num_waiting;
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
> -       FUSE_LOOKUP        = 1,
> -       FUSE_FORGET        = 2,  /* no reply */
> -       FUSE_GETATTR       = 3,
> -       FUSE_SETATTR       = 4,
> -       FUSE_READLINK      = 5,
> -       FUSE_SYMLINK       = 6,
> -       FUSE_MKNOD         = 8,
> -       FUSE_MKDIR         = 9,
> -       FUSE_UNLINK        = 10,
> -       FUSE_RMDIR         = 11,
> -       FUSE_RENAME        = 12,
> -       FUSE_LINK          = 13,
> -       FUSE_OPEN          = 14,
> -       FUSE_READ          = 15,
> -       FUSE_WRITE         = 16,
> -       FUSE_STATFS        = 17,
> -       FUSE_RELEASE       = 18,
> -       FUSE_FSYNC         = 20,
> -       FUSE_SETXATTR      = 21,
> -       FUSE_GETXATTR      = 22,
> -       FUSE_LISTXATTR     = 23,
> -       FUSE_REMOVEXATTR   = 24,
> -       FUSE_FLUSH         = 25,
> -       FUSE_INIT          = 26,
> -       FUSE_OPENDIR       = 27,
> -       FUSE_READDIR       = 28,
> -       FUSE_RELEASEDIR    = 29,
> -       FUSE_FSYNCDIR      = 30,
> -       FUSE_GETLK         = 31,
> -       FUSE_SETLK         = 32,
> -       FUSE_SETLKW        = 33,
> -       FUSE_ACCESS        = 34,
> -       FUSE_CREATE        = 35,
> -       FUSE_INTERRUPT     = 36,
> -       FUSE_BMAP          = 37,
> -       FUSE_DESTROY       = 38,
> -       FUSE_IOCTL         = 39,
> -       FUSE_POLL          = 40,
> -       FUSE_NOTIFY_REPLY  = 41,
> -       FUSE_BATCH_FORGET  = 42,
> -       FUSE_FALLOCATE     = 43,
> -       FUSE_READDIRPLUS   = 44,
> -       FUSE_RENAME2       = 45,
> -       FUSE_LSEEK         = 46,
> +       FUSE_LOOKUP          = 1,
> +       FUSE_FORGET          = 2,  /* no reply */
> +       FUSE_GETATTR         = 3,
> +       FUSE_SETATTR         = 4,
> +       FUSE_READLINK        = 5,
> +       FUSE_SYMLINK         = 6,
> +       FUSE_MKNOD           = 8,
> +       FUSE_MKDIR           = 9,
> +       FUSE_UNLINK          = 10,
> +       FUSE_RMDIR           = 11,
> +       FUSE_RENAME          = 12,
> +       FUSE_LINK            = 13,
> +       FUSE_OPEN            = 14,
> +       FUSE_READ            = 15,
> +       FUSE_WRITE           = 16,
> +       FUSE_STATFS          = 17,
> +       FUSE_RELEASE         = 18,
> +       FUSE_FSYNC           = 20,
> +       FUSE_SETXATTR        = 21,
> +       FUSE_GETXATTR        = 22,
> +       FUSE_LISTXATTR       = 23,
> +       FUSE_REMOVEXATTR     = 24,
> +       FUSE_FLUSH           = 25,
> +       FUSE_INIT            = 26,
> +       FUSE_OPENDIR         = 27,
> +       FUSE_READDIR         = 28,
> +       FUSE_RELEASEDIR      = 29,
> +       FUSE_FSYNCDIR        = 30,
> +       FUSE_GETLK           = 31,
> +       FUSE_SETLK           = 32,
> +       FUSE_SETLKW          = 33,
> +       FUSE_ACCESS          = 34,
> +       FUSE_CREATE          = 35,
> +       FUSE_INTERRUPT       = 36,
> +       FUSE_BMAP            = 37,
> +       FUSE_DESTROY         = 38,
> +       FUSE_IOCTL           = 39,
> +       FUSE_POLL            = 40,
> +       FUSE_NOTIFY_REPLY    = 41,
> +       FUSE_BATCH_FORGET    = 42,
> +       FUSE_FALLOCATE       = 43,
> +       FUSE_READDIRPLUS     = 44,
> +       FUSE_RENAME2         = 45,
> +       FUSE_LSEEK           = 46,
> +       FUSE_COPY_FILE_RANGE = 47,

Nit: please do tabulation with tabs instead of spaces.

>
>         /* CUSE specific operations */
>         CUSE_INIT          = 4096,
> @@ -792,4 +796,19 @@ struct fuse_lseek_out {
>         uint64_t        offset;
>  };
>
> +struct fuse_copy_file_range_in {
> +       uint64_t        fh_in;
> +       uint64_t        off_in;
> +       uint64_t        nodeid_out;
> +       uint64_t        fh_out;
> +       uint64_t        off_out;
> +       uint64_t        len;
> +       uint32_t        flags;

Why not uint64_t for flags?

> +};
> +
> +struct fuse_copy_file_range_out {
> +       uint32_t        size;
> +       uint32_t        padding;
> +};

Could reuse "struct fuse_write_out" for this.   Helps with the
userspace interface as well, since the same fuse_reply_write()
function can be used.

Thanks,
Miklos
