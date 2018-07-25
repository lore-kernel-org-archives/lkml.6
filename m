Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9768C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6471F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOQHQPUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6471F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeGYRCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbeGYRCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:02:40 -0400
Received: from [192.168.0.101] (unknown [180.111.133.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E6D204EC;
        Wed, 25 Jul 2018 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532533825;
        bh=iYQ0w9NLp0AD9xCRlE/K8Th1RwgC9mD1Whmr6fGJyXE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=bOQHQPUN5hIsXjBtLtrHKxOnMvKrR6fH5pIvamyOiDTDl/GFc7Sv6+6dNX4rtDyhj
         ntiNK9MOz0wXO4xm/3YZ3Z4sY8aPd+mxkFW90OuEmzWY9oWhc0pp0dWuBIaPKy43Qy
         7mnBIyuVS29ajIj0+dFrEEtbf8kY7P/HIpHNOGuA=
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180725032228.63492-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <76daeb43-ee9d-3747-7b35-8de0c8228edc@kernel.org>
Date:   Wed, 25 Jul 2018 23:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725032228.63492-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/25 11:22, Jaegeuk Kim wrote:
> The f2fs_gc() called by f2fs_balance_fs() requires to be called outside of
> fi->i_gc_rwsem[WRITE], since f2fs_gc() can try to grab it in a loop.

It seems there are other paths having the same issue, how about fixing all of
them in this patch?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c    | 2 ++
>  fs/f2fs/segment.c | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 84293423f830..3a5c35fa0603 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1754,6 +1754,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>  	if (ret)
>  		return ret;
>  
> +	f2fs_balance_fs(F2FS_I_SB(inode), true);
> +
>  	inode_lock(inode);
>  
>  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d28fa03a115f..17354089b4ab 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -445,7 +445,6 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	int err;
>  
> -	f2fs_balance_fs(sbi, true);
>  	f2fs_lock_op(sbi);
>  
>  	set_inode_flag(inode, FI_ATOMIC_COMMIT);
> 
