Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA38C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17D020878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk3nA1Vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17D020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJCHSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeJCHSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:18:55 -0400
Received: from localhost (unknown [104.132.0.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB7E206B2;
        Wed,  3 Oct 2018 00:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538526776;
        bh=4KR/sfQTrX29ixd/WCBtlr2+p4y3QeyVC2kE6asDg74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qk3nA1Vn9OtDFAdOJXQXnbZo7Gt34NKaRpn2X1RTTftqpFnhE33/6QWJBRsZwkO9a
         NxQMf+y3LXN1b1ibzJepoBINDNDXO0gFX1VnnzddohsWZEdzJyAn6+t1Pd9ZZguqZG
         HXpDeq0yCnmrNHnFDKHQ/R/r+iYkCi3OvOiHLmLk=
Date:   Tue, 2 Oct 2018 17:32:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to recover cold bit of inode block during POR
Message-ID: <20181003003255.GA33266@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181002031324.12517-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002031324.12517-1-chao@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Testcase to reproduce this bug:
> 1. mkfs.f2fs /dev/sdd
> 2. mount -t f2fs /dev/sdd /mnt/f2fs
> 3. touch /mnt/f2fs/file
> 4. sync
> 5. chattr +A /mnt/f2fs/file
> 6. xfs_io -f /mnt/f2fs/file -c "fsync"
> 7. godown /mnt/f2fs
> 8. umount /mnt/f2fs
> 9. mount -t f2fs /dev/sdd /mnt/f2fs
> 10. chattr -A /mnt/f2fs/file
> 11. xfs_io -f /mnt/f2fs/file -c "fsync"
> 12. umount /mnt/f2fs
> 13. mount -t f2fs /dev/sdd /mnt/f2fs
> 14. lsattr /mnt/f2fs/file
> 
> -----------------N- /mnt/f2fs/file
> 
> But actually, we expect the corrct result is:
> 
> -------A---------N- /mnt/f2fs/file
> 
> The reason is in step 9) we missed to recover cold bit flag in inode
> block, so later, in fsync, we will skip write inode block due to below
> condition check, result in lossing data in another SPOR.
> 
> f2fs_fsync_node_pages()
> 	if (!IS_DNODE(page) || !is_cold_node(page))
> 		continue;
> 
> Note that, I guess that some non-dir inode has already lost cold bit
> during POR, so in order to reenable recovery for those inode, let's
> try to recover cold bit in f2fs_iget() to save more fsynced data.

Please check that this breaks inode checksum when mounting the fresh partition.

> 
> Fixes: c56675750d7c ("f2fs: remove unneeded set_cold_node()")
> Cc: <stable@vger.kernel.org> 4.17+
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 4 ++++
>  fs/f2fs/node.c  | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 3c278e63d1a3..4ce4d6b298f9 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -365,6 +365,10 @@ static int do_read_inode(struct inode *inode)
>  	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
>  		__recover_inline_status(inode, node_page);
>  
> +	/* try to recover cold bit for non-dir inode */
> +	if (!S_ISDIR(inode->i_mode) && !is_cold_node(node_page))
> +		set_cold_node(node_page, false);
> +
>  	/* get rdev by using inline_info */
>  	__get_inode_rdev(inode, ri);
>  
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index b3cf18eb12f0..b1edc7525597 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2549,7 +2549,7 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
>  	if (!PageUptodate(ipage))
>  		SetPageUptodate(ipage);
>  	fill_node_footer(ipage, ino, ino, 0, true);
> -	set_cold_node(page, false);
> +	set_cold_node(ipage, false);
>  
>  	src = F2FS_INODE(page);
>  	dst = F2FS_INODE(ipage);
> -- 
> 2.18.0
