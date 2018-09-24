Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC5FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C112098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C112098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbeIYAmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:42:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbeIYAmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:42:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1BFB5FA3;
        Mon, 24 Sep 2018 18:39:13 +0000 (UTC)
Date:   Mon, 24 Sep 2018 20:39:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg Hackmann <ghackmann@android.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Omer Tripp <trippo@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs: fix possible Spectre V1 indexing in __close_fd()
Message-ID: <20180924183911.GB9122@kroah.com>
References: <20180924181500.125257-1-ghackmann@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924181500.125257-1-ghackmann@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:15:00AM -0700, Greg Hackmann wrote:
> __close_fd() is reachable via the close() syscall with a
> userspace-controlled fd.  Ensure that it can't be used to speculatively
> access past the end of current->fdt.
> 
> Reported-by: Omer Tripp <trippo@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> ---
>  fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 7ffd6e9d103d..a80cf82be96b 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -18,6 +18,7 @@
>  #include <linux/bitops.h>
>  #include <linux/spinlock.h>
>  #include <linux/rcupdate.h>
> +#include <linux/nospec.h>
>  
>  unsigned int sysctl_nr_open __read_mostly = 1024*1024;
>  unsigned int sysctl_nr_open_min = BITS_PER_LONG;
> @@ -626,6 +627,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
>  	fdt = files_fdtable(files);
>  	if (fd >= fdt->max_fds)
>  		goto out_unlock;
> +	fd = array_index_nospec(fd, fdt->max_fds);
>  	file = fdt->fd[fd];

Don't you need 2 "halfs" of a gadget in order to make it work?  This is
one half, where is the second half?

Or am I reading this code wrong here somehow?

We don't want to play whack-a-mole with only 1/2 spectre gadgets,
otherwise the 700+ patches that Red Hat added to their kernel would have
been merged already.

Which reminds me, did the Red Hat tooling catch this one as well?  If
not, someone need to go fix it :)

thanks,

greg k-h
