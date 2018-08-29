Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C6FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4507420850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4507420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeH2RPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:15:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2RPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:15:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF164AF87;
        Wed, 29 Aug 2018 13:18:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 410281E11C0; Wed, 29 Aug 2018 15:18:15 +0200 (CEST)
Date:   Wed, 29 Aug 2018 15:18:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 1/5] ext2: cache NULL when both default_acl and acl are
 NULL
Message-ID: <20180829131815.GC7369@quack2.suse.cz>
References: <20180814141634.5471-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814141634.5471-1-cgxu519@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-08-18 22:16:30, Chengguang Xu wrote:
> default_acl and acl of newly created inode will be initiated
> as ACL_NOT_CACHED in vfs function inode_init_always() and later
> will be updated by calling xxx_init_acl() in specific filesystems.
> Howerver, when default_acl and acl are NULL then they keep the value
> of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
> in this case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  fs/ext2/acl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
> index 224c04abb2e5..74411e8ea507 100644
> --- a/fs/ext2/acl.c
> +++ b/fs/ext2/acl.c
> @@ -262,5 +262,8 @@ ext2_init_acl(struct inode *inode, struct inode *dir)
>  			error = __ext2_set_acl(inode, acl, ACL_TYPE_ACCESS);
>  		posix_acl_release(acl);
>  	}
> +	if (!default_acl && !acl)
> +		cache_no_acl(inode);
> +

Thanks for the patch. I'd somewhat prefer something equivalent to:

	if (!acl)
		inode->i_acl = NULL;
	if (!default_acl)
		inode->i_default_acl = NULL;

given the code in ext2_init_acl(). It would be most natural like:

	if (default_acl) {
		do foo
	} else {
		inode->i_default_acl = NULL;
	}

And similarly for 'acl'.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
