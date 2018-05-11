Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeEKIcj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:32:39 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:43674 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752389AbeEKIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:32:37 -0400
Date: Fri, 11 May 2018 18:32:33 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>, hare@suse.com
Subject: Re: [PATCH 1/2] bcachefs: On disk data structures
Message-ID: <20180511083233.GX23861@dastard>
References: <20180508221800.2642-1-kent.overstreet@gmail.com>
 <20180508221800.2642-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508221800.2642-2-kent.overstreet@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

I haven't really had time to digest this in any real detail,
but I've noticed a couple of things that worry me...

On Tue, May 08, 2018 at 06:17:59PM -0400, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  fs/bcachefs/bcachefs_format.h | 1448 +++++++++++++++++++++++++++++++++
>  1 file changed, 1448 insertions(+)
>  create mode 100644 fs/bcachefs/bcachefs_format.h
> 
> diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
> new file mode 100644
> index 0000000000..0961585c7e
> --- /dev/null
> +++ b/fs/bcachefs/bcachefs_format.h
> @@ -0,0 +1,1448 @@
> +#ifndef _BCACHEFS_FORMAT_H
> +#define _BCACHEFS_FORMAT_H
.....
> +/* Btree keys - all units are in sectors */
> +
> +struct bpos {
> +	/* Word order matches machine byte order */
> +#if defined(__LITTLE_ENDIAN)
> +	__u32		snapshot;
> +	__u64		offset;
> +	__u64		inode;
> +#elif defined(__BIG_ENDIAN)
> +	__u64		inode;
> +	__u64		offset;		/* Points to end of extent - sectors */
> +	__u32		snapshot;
> +#else

Mostly my concerns are about these endian constructs - is the on
disk structure big endian or little endian, and how do you ensure
that everything you read and write to the on-disk format is in the
correct endian notation? I think your on-disk format is little
endian (from the definitions later in the file) but these don't look
like endian neutral structures....

That's apart from the fact all the endian defines make the code
really hard to read, and probably a pain to maintain, and it doubles
the test matrix because any on-disk change has to be validate on
both little endian and big endian machines....

> +union bch_extent_entry {
> +#if defined(__LITTLE_ENDIAN) ||  __BITS_PER_LONG == 64
> +	unsigned long			type;
> +#elif __BITS_PER_LONG == 32
> +	struct {
> +		unsigned long		pad;
> +		unsigned long		type;
> +	};
> +#else

This is another worry - using "long" in the on disk structure
definition. If this is in-meory structures, then use
le64_to_cpu/cpu_to_le64 to convert the value from the on-disk value
to the in-memory, cpu order value....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
