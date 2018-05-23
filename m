Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933585AbeEWQer (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:34:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:38909 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933513AbeEWQep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:34:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="61095479"
Date: Wed, 23 May 2018 10:34:42 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, tony.luck@intel.com,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hch@lst.de, Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 7/9] dax: report bytes remaining in dax_iomap_actor()
Message-ID: <20180523163442.GB29519@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        tony.luck@intel.com, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hch@lst.de,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152539240242.31796.4162676712193177396.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152539240242.31796.4162676712193177396.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 05:06:42PM -0700, Dan Williams wrote:
> In preparation for protecting the dax read(2) path from media errors
> with copy_to_iter_mcsafe() (via dax_copy_to_iter()), convert the
> implementation to report the bytes successfully transferred.
> 
> Cc: <x86@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/dax.c |   20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index a64afdf7ec0d..34a2d435ae4b 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -991,6 +991,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	struct iov_iter *iter = data;
>  	loff_t end = pos + length, done = 0;
>  	ssize_t ret = 0;
> +	size_t xfer;
>  	int id;
>  
>  	if (iov_iter_rw(iter) == READ) {
> @@ -1054,19 +1055,20 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		 * vfs_write(), depending on which operation we are doing.
>  		 */
>  		if (iov_iter_rw(iter) == WRITE)
> -			map_len = dax_copy_from_iter(dax_dev, pgoff, kaddr,
> +			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
>  					map_len, iter);
>  		else
> -			map_len = dax_copy_to_iter(dax_dev, pgoff, kaddr,
> +			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
>  					map_len, iter);
> -		if (map_len <= 0) {
> -			ret = map_len ? map_len : -EFAULT;
> -			break;
> -		}
>  
> -		pos += map_len;
> -		length -= map_len;
> -		done += map_len;
> +		pos += xfer;
> +		length -= xfer;
> +		done += xfer;
> +
> +		if (xfer == 0)
> +			ret = -EFAULT;
> +		if (xfer < map_len)
> +			break;

I'm confused by this error handling.  So if we hit an error on a given iov and
we don't transfer the expected number of bytes, we have two cases:

1) We transferred *something* on this iov but not everything - return success.
2) We didn't transfer anything on this iov - return -EFAULT.

Both of these are true regardless of data transferred on previous iovs.

Why the distinction?  If a given iov is interrupted, regardless of whether it
transferred 0 bytes or 1, shouldn't the error path be the same?

>  	}
>  	dax_read_unlock(id);
