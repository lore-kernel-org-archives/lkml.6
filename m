Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D01C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612582086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612582086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbeK0UXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:23:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:45648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728512AbeK0UXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:23:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09EC2AF8D;
        Tue, 27 Nov 2018 09:25:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 028551E07ED; Tue, 27 Nov 2018 10:25:51 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:25:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] namei: free new_dentry late
Message-ID: <20181127092551.GC16301@quack2.suse.cz>
References: <1543104923-81192-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543104923-81192-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 25-11-18 08:15:23, Pan Bian wrote:
> After calling dput(new_dentry), new_dentry is passed to fsnotify_move.
> This may result in a use-after-free bug. This patch moves the put
> operation late.
> 
> Fixes: da1ce0670c14("vfs: add cross-rename")
> Signed-off-by: Pan Bian <bianpan2016@163.com>

The code is actually fine AFAICT. One new_dentry reference is passed into
vfs_rename() and another one is acquired directly inside vfs_rename(). That
is the one dropped early but there's still the original reference passed in
protecting new_dentry from freeing. Am I missing something?

								Honza

> ---
> V2: correct the fixes commit information
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 0cab649..8b104d9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4498,7 +4498,6 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		unlock_two_nondirectories(source, target);
>  	else if (target)
>  		inode_unlock(target);
> -	dput(new_dentry);
>  	if (!error) {
>  		fsnotify_move(old_dir, new_dir, old_name.name, is_dir,
>  			      !(flags & RENAME_EXCHANGE) ? target : NULL, old_dentry);
> @@ -4507,6 +4506,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  				      new_is_dir, NULL, new_dentry);
>  		}
>  	}
> +	dput(new_dentry);
>  	release_dentry_name_snapshot(&old_name);
>  
>  	return error;
> -- 
> 2.7.4
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
