Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeBSQAi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:00:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbeBSQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:00:36 -0500
Date: Mon, 19 Feb 2018 08:00:34 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Nikolay Borisov <nborisov@suse.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@fb.com
Subject: Re: [PATCH] fs: Improve comment of inode_dio_begin
Message-ID: <20180219160034.GC24352@bombadil.infradead.org>
References: <1519053629-14114-1-git-send-email-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519053629-14114-1-git-send-email-nborisov@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 05:20:29PM +0200, Nikolay Borisov wrote:
> +++ b/include/linux/fs.h
> @@ -3015,8 +3015,10 @@ void inode_dio_wait(struct inode *inode);
>   * inode_dio_begin - signal start of a direct I/O requests
>   * @inode: inode the direct I/O happens on
>   *
> - * This is called once we've finished processing a direct I/O request,
> - * and is used to wake up callers waiting for direct I/O to be quiesced.
> + * This is called before we begin processing a direct I/O request,
> + * and is used to quiesce callers of inode_dio_wait. It must be
> + * called under a lock that serialising getting a reference to
> + * ->i_dio_count (usually the inode_lock)
>   */
>  static inline void inode_dio_begin(struct inode *inode)
>  {

Thanks for the patch!  It'd be nice if it used the kernel-doc annotations
for Context: to document the locking requirements.  Also, I find the
wording a little confusing.  How does the following look?

 * Mark the inode as having direct I/O in progress.  This causes callers
 * of inode_dio_wait() to block until the I/O has completed.
 *
 * Context: Process context.  Caller should hold a lock that callers of
 * inode_dio_wait() also hold (usually inode_lock, but this depends on
 * the filesystem).
