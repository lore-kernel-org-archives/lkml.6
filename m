Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F50CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCC72087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCC72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeILO2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:28:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:52068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727153AbeILO2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:28:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBD70AF69;
        Wed, 12 Sep 2018 09:24:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 13CE21E3613; Wed, 12 Sep 2018 11:24:22 +0200 (CEST)
Date:   Wed, 12 Sep 2018 11:24:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     jack@suse.cz, dan.j.williams@intel.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Message-ID: <20180912092422.GA7782@quack2.suse.cz>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
 <20180911154246.6844-2-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911154246.6844-2-toshi.kani@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-09-18 09:42:45, Toshi Kani wrote:
> Ext4 mount path calls ext4_iget() to obtain the journal inode.  This
> inode does not support DAX, and 'ext4_da_aops' needs to be set.  It
> currently works for the DAX mount case because ext4_iget() always set
> 'ext4_da_aops' to any regular files.
> 
>   ext4_fill_super
>     ext4_load_journal
>       ext4_get_journal_inode
>         ext4_iget
> 
> In preparation to fix ext4_iget() to set 'ext4_dax_aops' for DAX files,
> update ext4_should_use_dax() to return false for the journal inode.
> 
> Fixes: 5f0663bb4a64f588f0a2dd6d1be68d40f9af0086
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>

The journal inode is similar to any other 'system' inode we have in ext4.
We don't really expect any of the address space operations to be called for
it because we don't use page cache with these inodes. Very similar
situation is with e.g. quota files. So to me it seems this patch is not
really necessary. Or did you observe any bad effects without this patch?

That being said I agree that it would be a good cleanup to define something
like ext4_is_system_inode() and disable DAX for these inodes just because
they are special. But I don't see a need for this as a part of your fix.

								Honza

> ---
>  fs/ext4/ext4_jbd2.h |    8 ++++++++
>  fs/ext4/inode.c     |    2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 15b6dd733780..9847dc980a0d 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -437,6 +437,14 @@ static inline int ext4_should_writeback_data(struct inode *inode)
>  	return ext4_inode_journal_mode(inode) & EXT4_INODE_WRITEBACK_DATA_MODE;
>  }
>  
> +static inline int ext4_is_journal_inode(struct inode *inode)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	unsigned int journal_inum = le32_to_cpu(sbi->s_es->s_journal_inum);
> +
> +	return journal_inum && (journal_inum == inode->i_ino);
> +}
> +
>  /*
>   * This function controls whether or not we should try to go down the
>   * dioread_nolock code paths, which makes it safe to avoid taking
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d0dd585add6a..775cd9b4af55 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4686,6 +4686,8 @@ static bool ext4_should_use_dax(struct inode *inode)
>  		return false;
>  	if (ext4_should_journal_data(inode))
>  		return false;
> +	if (ext4_is_journal_inode(inode))
> +		return false;
>  	if (ext4_has_inline_data(inode))
>  		return false;
>  	if (ext4_encrypted_inode(inode))
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
