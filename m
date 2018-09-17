Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646F0ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2581E2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2581E2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbeIQWFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:05:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbeIQWFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:05:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DE6FACB7;
        Mon, 17 Sep 2018 16:37:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A32FF1E091E; Mon, 17 Sep 2018 18:37:09 +0200 (CEST)
Date:   Mon, 17 Sep 2018 18:37:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     jack@suse.cz, dan.j.williams@intel.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ext2, dax: set ext2_dax_aops for dax files
Message-ID: <20180917163709.GA10257@quack2.suse.cz>
References: <20180914145114.11122-1-toshi.kani@hpe.com>
 <20180914145114.11122-4-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914145114.11122-4-toshi.kani@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-09-18 08:51:14, Toshi Kani wrote:
> Sync syscall to DAX file needs to flush processor cache, but it
> currently does not flush to existing DAX files.  This is because
> 'ext2_da_aops' is set to address_space_operations of existing DAX
> files, instead of 'ext2_dax_aops', since S_DAX flag is set after
> ext2_set_aops() in the open path.
> 
> Similar to ext4, change ext2_iget() to initialize i_flags before
> ext2_set_aops().
> 
> Fixes: fb094c90748f ("ext2, dax: introduce ext2_dax_aops")
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: <stable@vger.kernel.org>

Thanks. I'll take the patch through my tree.

								Honza

> ---
>  fs/ext2/inode.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 7f7ee18fe179..e4bb9386c045 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1448,6 +1448,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
>  	}
>  	inode->i_blocks = le32_to_cpu(raw_inode->i_blocks);
>  	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
> +	ext2_set_inode_flags(inode);
>  	ei->i_faddr = le32_to_cpu(raw_inode->i_faddr);
>  	ei->i_frag_no = raw_inode->i_frag;
>  	ei->i_frag_size = raw_inode->i_fsize;
> @@ -1517,7 +1518,6 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
>  			   new_decode_dev(le32_to_cpu(raw_inode->i_block[1])));
>  	}
>  	brelse (bh);
> -	ext2_set_inode_flags(inode);
>  	unlock_new_inode(inode);
>  	return inode;
>  	
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
