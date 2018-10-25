Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7E9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14502075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14502075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJYTxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:53:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:40264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbeJYTxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:53:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 071B9AEE1;
        Thu, 25 Oct 2018 11:20:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8BD5C1E06C6; Thu, 25 Oct 2018 13:20:44 +0200 (CEST)
Date:   Thu, 25 Oct 2018 13:20:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
Message-ID: <20181025112044.GA7711@quack2.suse.cz>
References: <20181023201953.GA15687@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023201953.GA15687@pathfinder>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-10-18 21:19:53, Phillip Potter wrote:
> Many file systems use a copy&paste implementation
> of dirent to on-disk file type conversions.
> 
> Create a common implementation to be used by file systems
> with some useful conversion helpers to reduce open coded
> file type conversions in file system code.

Thanks for the patch. I like the cleanup. Some comments inline...

> diff --git a/include/linux/file_type.h b/include/linux/file_type.h
> new file mode 100644
> index 000000000000..f015c41ca90c
> --- /dev/null
> +++ b/include/linux/file_type.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_FILE_TYPE_H
> +#define _LINUX_FILE_TYPE_H
> +
> +/*
> + * This is a common implementation of dirent to fs on-disk
> + * file type conversion.  Although the fs on-disk bits are
> + * specific to every file system, in practice, many file systems
> + * use the exact same on-disk format to describe the lower 3
> + * file type bits that represent the 7 POSIX file types.
> + * All those file systems can use this generic code for the
> + * conversions:
> + *  i_mode -> fs on-disk file type (ftype)
> + *  fs on-disk file type (ftype) -> dirent file type (dtype)
> + *  i_mode -> dirent file type (dtype)

I don't think these three lines above are really useful. If you want to
make it easier for fs developers, add Docbook coments at function
implementations.

> + */
> +
> +/*
> + * struct dirent file types
> + * exposed to user via getdents(2), readdir(3)
> + *
> + * These match bits 12..15 of stat.st_mode
> + * (ie "(i_mode >> 12) & 15").
> + */
> +#define S_DT_SHIFT	12
> +#define S_DT(mode)	(((mode) & S_IFMT) >> S_DT_SHIFT)
> +#define S_DT_MASK	(S_IFMT >> S_DT_SHIFT)
> +
> +#define DT_UNKNOWN	0
> +#define DT_FIFO		S_DT(S_IFIFO) /* 1 */
> +#define DT_CHR		S_DT(S_IFCHR) /* 2 */
> +#define DT_DIR		S_DT(S_IFDIR) /* 4 */
> +#define DT_BLK		S_DT(S_IFBLK) /* 6 */
> +#define DT_REG		S_DT(S_IFREG) /* 8 */
> +#define DT_LNK		S_DT(S_IFLNK) /* 10 */
> +#define DT_SOCK		S_DT(S_IFSOCK) /* 12 */

Why not keep the original definition by absolute number. After all these
must match glibc...

> +#define DT_WHT		14
> +
> +#define DT_MAX		(S_DT_MASK + 1) /* 16 */
> +
> +/*
> + * fs on-disk file types.
> + * Only the low 3 bits are used for the POSIX file types.
> + * Other bits are reserved for fs private use.
> + *
> + * Note that no fs currently stores the whiteout type on-disk,
> + * so whiteout dirents are exposed to user as DT_CHR.
> + */
> +#define FT_UNKNOWN	0
> +#define FT_REG_FILE	1
> +#define FT_DIR		2
> +#define FT_CHRDEV	3
> +#define FT_BLKDEV	4
> +#define FT_FIFO		5
> +#define FT_SOCK		6
> +#define FT_SYMLINK	7
> +
> +#define FT_MAX		8
> +
> +/*
> + * fs on-disk file type to dirent file type conversion
> + */
> +static unsigned char fs_dtype_by_ftype[FT_MAX] = {
> +	[FT_UNKNOWN]	= DT_UNKNOWN,
> +	[FT_REG_FILE]	= DT_REG,
> +	[FT_DIR]	= DT_DIR,
> +	[FT_CHRDEV]	= DT_CHR,
> +	[FT_BLKDEV]	= DT_BLK,
> +	[FT_FIFO]	= DT_FIFO,
> +	[FT_SOCK]	= DT_SOCK,
> +	[FT_SYMLINK]	= DT_LNK
> +};

So you define static variable in a header file. That will make it appear in
each and every object that includes this header (when not used it will get
optimized away but still...). IMO that is not good and I don't think
anything here is so performance super-crittical, that the cost of
additional function call would matter (correct me if I'm wrong here). So
I'd rather see these tables and associated functions in some C file.

> +static inline unsigned char fs_dtype(int filetype)

This function name is not very descriptive and consistent with the other
two. It should be like fs_ftype_to_dtype(), right?

> +{
> +	if (filetype >= FT_MAX)
> +		return DT_UNKNOWN;
> +
> +	return fs_dtype_by_ftype[filetype];
> +}

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
