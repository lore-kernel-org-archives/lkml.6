Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62925C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C562150D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxDyPmPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C562150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbeIRXuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbeIRXuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:50:55 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8DC821508;
        Tue, 18 Sep 2018 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537294626;
        bh=682dXEpM/q3x3gNqKy/514PR08wKnh1HayK+OGTIyDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxDyPmPeW/IVAkFpMoXD6XT9FtGJGscFdm4XvdG2QdZD4hW45xoY41+9h+RE6vL44
         UBPhz547JRkj+/NogkxnBYxlKD/T7L2PSCmoHdOg6ogZWfwMmRKQqF2DFDD1LhDx+L
         YRTvU9W7Vu3Il/3audmQ9K8tbJuZiD28Sam1iLCU=
Date:   Tue, 18 Sep 2018 11:17:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yunlong Song <yunlong.song@huawei.com>
Cc:     chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com,
        miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file corrupted
Message-ID: <20180918181705.GG91945@jaegeuk-macbookpro.roam.corp.google.com>
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18, Yunlong Song wrote:
> The encrypted file may be corrupted by GC in following case:
> 
> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
> segment 2,
> 
> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |

            segment 2 blkaddr = B?

> 
> Before page 1 is written back and if segment 2 become a victim, then
> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,

                                                         C of ?

> during the GC process of Time 2, f2fs should wait for page 1 written back
> before reading it, or move_data_block will read a garbage block from
> blkaddr B since page is not written back to blkaddr B yet.

move_data_block() checks PageUptodate() so it won't get garbage, yes?
So, does ra_data_block need to check PageUptodate?

> 
> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
> ra_data_block to read encrypted block, but it forgets to add
> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/gc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a4c1a41..c55fb62 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -641,6 +641,14 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>  	fio.page = page;
>  	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
>  
> +	/*
> +	 * don't cache encrypted data into meta inode until previous dirty
> +	 * data were writebacked to avoid racing between GC and flush.
> +	 */
> +	f2fs_wait_on_page_writeback(page, DATA, true);
> +
> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
> +
>  	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
>  					dn.data_blkaddr,
>  					FGP_LOCK | FGP_CREAT, GFP_NOFS);
> @@ -723,6 +731,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>  	 */
>  	f2fs_wait_on_page_writeback(page, DATA, true);
>  
> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
> +
>  	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
>  	if (err)
>  		goto put_out;
> -- 
> 1.8.5.2
