Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F693C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F335A21A72
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtA3tLmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F335A21A72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754098AbeGGBNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753713AbeGGBNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:13:49 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A29021A6F;
        Sat,  7 Jul 2018 01:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530926028;
        bh=JOAw5Zw50ApbVd3Zi/m+CyETMBVC+c0QsNmtOcz20Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtA3tLmfd+ayxw5VGcgCFKBKx4adPnVKXS2ba68L02+ZTdDoqjIVhTufbBL1kMifX
         GdoqF4IDxQpkOvlZFLlTMDUpIfNlkLHowqPNuQZ1CGcuQL/T4Iv/Kj7+js7gVbB+dH
         EeKTmQ0iFJnqCrVFeRLP1sJsFYPf9FGY5F8CVPkQ=
Date:   Fri, 6 Jul 2018 18:13:48 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: enable real-time discard by default
Message-ID: <20180707011348.GB3904@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180705062411.3757-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705062411.3757-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05, Chao Yu wrote:
> f2fs is focused on flash based storage, so let's enable real-time
> discard by default, if user don't want to enable it, 'nodiscard'
> mount option should be used on mount.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 848badda50ad..980edeb0b650 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1366,12 +1366,11 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	set_opt(sbi, NOHEAP);
>  	sbi->sb->s_flags |= SB_LAZYTIME;
>  	set_opt(sbi, FLUSH_MERGE);
> -	if (f2fs_sb_has_blkzoned(sbi->sb)) {

I added this.

	if (blk_queue_discard(bdev_get_queue(sbi->sb->s_bdev)))

> +	set_opt(sbi, DISCARD);
> +	if (f2fs_sb_has_blkzoned(sbi->sb))
>  		set_opt_mode(sbi, F2FS_MOUNT_LFS);
> -		set_opt(sbi, DISCARD);
> -	} else {
> +	else
>  		set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
> -	}
>  
>  #ifdef CONFIG_F2FS_FS_XATTR
>  	set_opt(sbi, XATTR_USER);
> -- 
> 2.18.0.rc1
