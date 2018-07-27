Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E0AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917F7208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z+X/FXds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917F7208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeG0Luh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbeG0Luh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:50:37 -0400
Received: from localhost (unknown [119.197.233.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D099208A2;
        Fri, 27 Jul 2018 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532687360;
        bh=DmKL19mdN8G3ZC0jr7gLOoaBo890N+xZVOp42yp6iw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+X/FXdsGtVVmzMqlHdn3WjvIlS8izdiNu11kexDyH4hrm554TugBcqawpakEG604
         Un13iyWlhlmuYyxPAJvnZXVxSYU8/AG3HRqnGeq6LLP8xIuAIb/OLPiY4jrrB7wjOR
         Q/+euOlswWw2VlPCSiyRg2kyLEy7XPlNaTfpLBTI=
Date:   Fri, 27 Jul 2018 19:29:16 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: avoid race between zero_range and background GC
Message-ID: <20180727102916.GI16155@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180726104536.114340-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726104536.114340-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26, Chao Yu wrote:
> Thread A				Background GC
> - f2fs_zero_range
>  - truncate_pagecache_range
> 					- gc_data_segment
> 					 - get_read_data_page
> 					  - move_data_page
> 					   - set_page_dirty
> 					   - set_cold_data
>  - f2fs_do_zero_range
>   - dn->data_blkaddr = NEW_ADDR;
>   - f2fs_set_data_blkaddr
> 
> Actually, we don't need to set dirty & checked flag on the page, since
> all valid data in the page should be zeroed by zero_range().

But, it doesn't matter too much, right?

> Use i_gc_rwsem[WRITE] to avoid such race condition.

Hope to avoid abusing i_gc_rwsem[] tho.

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 267ec3794e1e..7bd2412a8c37 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1309,6 +1309,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>  	if (ret)
>  		return ret;
>  
> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>  	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
>  	if (ret)
> @@ -1389,6 +1390,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>  	}
>  out_sem:
>  	up_write(&F2FS_I(inode)->i_mmap_sem);
> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  
>  	return ret;
>  }
> -- 
> 2.18.0.rc1
