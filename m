Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB1CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6E920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6E920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeFTOmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:42:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:60175 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754011AbeFTOmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:42:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16766AE2A;
        Wed, 20 Jun 2018 14:41:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 930E51E04AE; Wed, 20 Jun 2018 16:41:58 +0200 (CEST)
Date:   Wed, 20 Jun 2018 16:41:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jan Kara <jack@suse.com>, y2038@lists.linaro.org,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: use ktime_get_real_seconds for timestamps
Message-ID: <20180620144158.4xddk5fgomlhnnme@quack2.suse.cz>
References: <20180620143203.42225-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620143203.42225-1-arnd@arndb.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-06-18 16:31:40, Arnd Bergmann wrote:
> get_seconds() is deprecated because of the y2038 overflow, so users
> should migrate to 64-bit timestamps using ktime_get_real_seconds().
> In ext2, the timestamps in the superblock and in the inode are all
> limited to 32-bit, and this won't get fixed, so let's just stop
> using the deprecated interface and keep truncating.
> 
> All users of ext2 should migrate to ext4 before 2038 to prevent this
> from causing problems.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks. The patch looks good modulo one line-wrap in fs/ext2/super.c but
I'll take care of that when taking the patch to my tree.

								Honza

> ---
>  fs/ext2/inode.c | 2 +-
>  fs/ext2/super.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 71635909df3b..7f7ee18fe179 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -86,7 +86,7 @@ void ext2_evict_inode(struct inode * inode)
>  	if (want_delete) {
>  		sb_start_intwrite(inode->i_sb);
>  		/* set dtime */
> -		EXT2_I(inode)->i_dtime	= get_seconds();
> +		EXT2_I(inode)->i_dtime	= ktime_get_real_seconds();
>  		mark_inode_dirty(inode);
>  		__ext2_write_inode(inode, inode_needs_sync(inode));
>  		/* truncate to 0 */
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 25ab1274090f..25e31afe961d 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -679,7 +679,7 @@ static int ext2_setup_super (struct super_block * sb,
>  			"running e2fsck is recommended");
>  	else if (le32_to_cpu(es->s_checkinterval) &&
>  		(le32_to_cpu(es->s_lastcheck) +
> -			le32_to_cpu(es->s_checkinterval) <= get_seconds()))
> +			le32_to_cpu(es->s_checkinterval) <= ktime_get_real_seconds()))
>  		ext2_msg(sb, KERN_WARNING,
>  			"warning: checktime reached, "
>  			"running e2fsck is recommended");
> @@ -1245,7 +1245,7 @@ void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es,
>  	spin_lock(&EXT2_SB(sb)->s_lock);
>  	es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
>  	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
> -	es->s_wtime = cpu_to_le32(get_seconds());
> +	es->s_wtime = cpu_to_le32(ktime_get_real_seconds());
>  	/* unlock before we do IO */
>  	spin_unlock(&EXT2_SB(sb)->s_lock);
>  	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
> @@ -1360,7 +1360,7 @@ static int ext2_remount (struct super_block * sb, int * flags, char * data)
>  		 * the rdonly flag and then mark the partition as valid again.
>  		 */
>  		es->s_state = cpu_to_le16(sbi->s_mount_state);
> -		es->s_mtime = cpu_to_le32(get_seconds());
> +		es->s_mtime = cpu_to_le32(ktime_get_real_seconds());
>  		spin_unlock(&sbi->s_lock);
>  
>  		err = dquot_suspend(sb, -1);
> -- 
> 2.9.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
