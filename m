Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CCFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FC420578
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500856;
	bh=rHhuQRG+CPfH9o7bUDFs6weW/e2Z5xXMrhOOXqB/GJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1suAV6nOwt9iZy4fRsl7+XHO6YsZm6NwrWnCDnnLAqGPdsWHZXEnDPhIn/4l9nyw0
	 nTmRQGLCFeHJLWUbn0cgLgAXJXVL9N02OyRmy5toZnqG5Mwea5vMNcVqemDSJsCVqh
	 151PqxbXMnaDBsUXhTetffMsaSivdP6jc/QhZEx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391663AbeLVRrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:47:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbeLVRrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9684C219FE;
        Sat, 22 Dec 2018 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545477915;
        bh=rHhuQRG+CPfH9o7bUDFs6weW/e2Z5xXMrhOOXqB/GJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryFveUidm95Mm1Ivmbt8jCZFwECvE+4RQxCjQMyY2mzlVoKtNZHZsmpbGUK17/NH7
         BCXcrkZxp6U8OpzEwnEOi1UrpirwKJw7y4wGgS3vb7PcddRp20jOWuwkcWuSq3k+66
         BLnIuTnvpsT3gCZHbMGpEMZ3C2Io4gVjs21tAU2U=
Date:   Sat, 22 Dec 2018 12:25:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: remove inc_nlink in debugfs_create_automount
Message-ID: <20181222112512.GA27683@kroah.com>
References: <20181222084536.21305-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222084536.21305-1-yangerkun@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 04:45:36PM +0800, yangerkun wrote:
> Remove inc_nlink in debugfs_create_automount, or this inode will never
> be free.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/debugfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 13b01351dd1c..9294238e364f 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -551,12 +551,11 @@ struct dentry *debugfs_create_automount(const char *name,
>  	if (unlikely(!inode))
>  		return failed_creating(dentry);
>  
> +	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	make_empty_dir_inode(inode);
>  	inode->i_flags |= S_AUTOMOUNT;
>  	inode->i_private = data;
>  	dentry->d_fsdata = (void *)f;
> -	/* directory inodes start off with i_nlink == 2 (for "." entry) */
> -	inc_nlink(inode);

Again, have you tested this and how?  How did you find this issue?

thanks,

greg k-h
