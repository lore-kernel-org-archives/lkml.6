Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD11C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453D02086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453D02086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbeKGXUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:20:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:36660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727752AbeKGXUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:20:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F0CFB603;
        Wed,  7 Nov 2018 13:50:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C95CE1E099F; Wed,  7 Nov 2018 14:50:16 +0100 (CET)
Date:   Wed, 7 Nov 2018 14:50:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kalpak Shah <kalpak@clusterfs.com>
Subject: Re: [PATCH 6/7] ext4: lost brelse in ext4_xattr_move_to_block()
Message-ID: <20181107135016.GE25758@quack2.suse.cz>
References: <cover.1541011937.git.vvs@virtuozzo.com>
 <76da5ae3-274d-efa4-58bb-6cd280763a37@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76da5ae3-274d-efa4-58bb-6cd280763a37@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-10-18 22:13:00, Vasily Averin wrote:
> Fixes 3f2571c1f91f ("ext4: factor out xattr moving")
> cc: Jan Kara <jack@suse.cz>
> however issue was present in original ext4_expand_extra_isize_ea()
> Fixes 6dd4ee7cab7e ("ext4: Expand extra_inodes space per ...") # 2.6.23
> cc: Kalpak Shah <kalpak@clusterfs.com>
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Good catch. Thanks for the fix. The patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 07b9a335c8eb..5c9bc0d85cc0 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2617,6 +2617,8 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  	kfree(buffer);
>  	if (is)
>  		brelse(is->iloc.bh);
> +	if (bs)
> +		brelse(bs->bh);
>  	kfree(is);
>  	kfree(bs);
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
