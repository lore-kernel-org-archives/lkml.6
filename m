Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DF5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426EF2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLGf+gAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426EF2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbeG0LaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730577AbeG0LaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:30:11 -0400
Received: from localhost (unknown [119.197.233.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3EA52089C;
        Fri, 27 Jul 2018 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532686139;
        bh=9gYiFDA74JlbtDCYiXmcL7ffhlnbOIeCdjPh/zA0uKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLGf+gABsOOqTahAvmqscVkoBt7sVhwD6A+nQqG8owU9sZsThaU3ylQqD0oMyXFWe
         GKhed4OzNSa1NeViKmHCKd1frHLv1Yc9QhfW7dx4m6hxN57pwWE1ig3Ac3HH4+tV7F
         4qCqduRu5Y5rn7WBN//OM1s6eO0TpLAoxSYNliyE=
Date:   Fri, 27 Jul 2018 19:08:55 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to restrict mount condition when without
 CONFIG_QUOTA
Message-ID: <20180727100855.GF16155@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180724165546.12924-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724165546.12924-1-chao@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Like quota_ino feature, we need to reject mounting RDWR with image
> which enables project_quota feature when there is no CONFIG_QUOTA
> be set in kernel.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index dbc1cb53581f..bb40f08d2861 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
>  			 "without CONFIG_QUOTA");
>  		return -EINVAL;
>  	}
> +	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
> +		ext4_msg(sb, KERN_ERR,

What is this?

> +			"Filesystem with project quota feature cannot be "
> +			"mounted RDWR without CONFIG_QUOTA");
> +		return -EINVAL;
> +	}
>  #endif
>  
>  	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
> -- 
> 2.16.2.17.g38e79b1fd
