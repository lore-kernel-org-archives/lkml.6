Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0681AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8F320879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8F320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeLNJ4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:56:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:48734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727693AbeLNJ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:56:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C00F2AC39;
        Fri, 14 Dec 2018 09:56:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0EAF71E13E6; Fri, 14 Dec 2018 10:56:13 +0100 (CET)
Date:   Fri, 14 Dec 2018 10:56:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Javier Barrio <javier.barrio.mart@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] quota: Lock s_umount in exclusive mode for
 Q_XQUOTA{ON,OFF} quotactls.
Message-ID: <20181214095613.GD8896@quack2.suse.cz>
References: <1ad62e88-7784-6de8-c03d-01295375e315@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad62e88-7784-6de8-c03d-01295375e315@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu 13-12-18 01:06:29, Javier Barrio wrote:
> Commit 1fa5efe3622db58cb8c7b9a50665e9eb9a6c7e97 (ext4: Use generic
> helpers for quotaon and quotaoff) made possible to call
> quotactl(Q_XQUOTAON/OFF) on ext4 filesystems with sysfile quota support.
> This leads to calling dquot_enable/disable without s_umount held in excl.
> mode, because quotactl_cmd_onoff checks only for Q_QUOTAON/OFF.
> 
> The following WARN_ON_ONCE triggers (in this case for dquot_enable, ext4,
> latest Linus' tree):
> 
> [  155.036847] WARNING: CPU: 0 PID: 2343 at fs/quota/dquot.c:2469 dquot_enable+0x34/0xb9

...

> This patch locks the superblock ->s_umount sem. in exclusive mode for all Q_XQUOTAON/OFF
> quotactls too in addition to Q_QUOTAON/OFF.

Thanks for the patch! It looks good to me but let me run it past XFS
people. Looking at XFS code they definitely do not *need* s_umount in
exclusive mode for Q_XQUOTAON/OFF (they have their private mutex for
the exclusion). Shared mode they currently get is enough for them. But
exclusive mode is fine for them as well AFAICT and it would be easier if
all quota backends had the same locking rules wrt VFS locks. XFS guys, any
objections to switching Q_XQUOTAON/OFF handlers from having s_umount locked
for read to having it locked exclusive?

								Honza

> AFAICT, other than ext4, only xfs and ocfs2 are affected by this change.
> The VFS will now call in xfs_quota_* functions with s_umount held, which wasn't the case
> before. This looks good to me but I can not say for sure. Ext4 and ocfs2 where already
> beeing called with s_umount exclusive via quota_quotaon/off which is basically the same.
> 
> Signed-off-by: Javier Barrio <javier.barrio.mart@gmail.com>
> ---
> 
> [ I'm not familiar with this code, please excuse me if this is not the right fix ]
> 
>  fs/quota/quota.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index f0cbf58ad4da..fd5dd806f1b9 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -791,7 +791,8 @@ static int quotactl_cmd_write(int cmd)
>  /* Return true if quotactl command is manipulating quota on/off state */
>  static bool quotactl_cmd_onoff(int cmd)
>  {
> -	return (cmd == Q_QUOTAON) || (cmd == Q_QUOTAOFF);
> +	return (cmd == Q_QUOTAON) || (cmd == Q_QUOTAOFF) ||
> +		 (cmd == Q_XQUOTAON) || (cmd == Q_XQUOTAOFF);
>  }
>  
>  /*
> -- 2.17.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
