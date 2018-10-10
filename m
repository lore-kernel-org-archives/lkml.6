Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A9DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5CF2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yZDGwYla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5CF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeJKE6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJKE6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:58:05 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBDF520870;
        Wed, 10 Oct 2018 21:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539207243;
        bh=kQQCi5nAaIhCZgQMSB2Zn6aGqYbxZPhvMn8HARPhKbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yZDGwYlajnt7jalYQs3eZblj+5Vsnpud8/x1ZJzoyh7qgk//9dQso04RD8lrzU/f6
         dzCCIu3M+6mq5HKNO2roH0a9l1llWmuJqsnU9lBaWHWFXgo9NI0xJ0QekxoBbKJ66k
         oqngBFH0VjJXFQZoH+4GU8GEeVP5csmjs3TNODTg=
Date:   Wed, 10 Oct 2018 14:34:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix data corruption issue with hardware encryption
Message-ID: <20181010213402.GA52406@jaegeuk-macbookpro.roam.corp.google.com>
References: <1539149182-12729-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539149182-12729-1-git-send-email-stummala@codeaurora.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10, Sahitya Tummala wrote:
> Direct IO can be used in case of hardware encryption. The following
> scenario results into data corruption issue in this path -
> 
> Thread A -                          Thread B-
> -> write file#1 in direct IO
>                                     -> GC gets kicked in
>                                     -> GC submitted bio on meta mapping
> 				       for file#1, but pending completion
> -> write file#1 again with new data
>    in direct IO
>                                     -> GC bio gets completed now
>                                     -> GC writes old data to the new
>                                        location and thus file#1 is
> 				       corrupted.
> 
> Fix this by submitting and waiting for pending io on meta mapping
> for direct IO case in f2fs_map_blocks().
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/data.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9ef6f1f..7b2fef0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1028,6 +1028,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  		map->m_pblk = ei.blk + pgofs - ei.fofs;
>  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
>  		map->m_flags = F2FS_MAP_MAPPED;
> +		/* for HW encryption, but to avoid potential issue in future */
> +		if (flag == F2FS_GET_BLOCK_DIO) {
> +			blkaddr = map->m_pblk;
> +			for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
> +				f2fs_wait_on_block_writeback(sbi, blkaddr);

Do we need this? IIRC, DIO would give create=1.

> +		}
>  		if (map->m_next_extent)
>  			*map->m_next_extent = pgofs + map->m_len;
>  		goto out;
> @@ -1188,6 +1194,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	goto next_dnode;
>  
>  sync_out:
> +	/* for hardware encryption, but to avoid potential issue in future */
> +	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED) {
> +		blkaddr = map->m_pblk;
> +		for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
> +			f2fs_wait_on_block_writeback(sbi, blkaddr);
> +	}
>  	if (flag == F2FS_GET_BLOCK_PRECACHE) {
>  		if (map->m_flags & F2FS_MAP_MAPPED) {
>  			unsigned int ofs = start_pgofs - map->m_lblk;
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
