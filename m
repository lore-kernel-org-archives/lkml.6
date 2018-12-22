Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7D92054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500902;
	bh=VUn4BJAyFZuF6+i0cEMKpogtsh1RirfR3yR6ObvsDlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KRKzc9Gs4WqO8yFZ/qwA96IYBhadD+tODyvRqY3Z7Z3tfiwP2K23/4IlIK4oOP1GD
	 pBzdxwZ0bix2/6G48FBIwDmUQC+s4Mvc2rDQWZhLM85cnNGTmT+TGvrDdFC52BLinY
	 GcIbss1j5KIok5nnWtq94zY1ijy0JTWqmLU5kSL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404609AbeLVRsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390019AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3050221934;
        Sat, 22 Dec 2018 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545463929;
        bh=VUn4BJAyFZuF6+i0cEMKpogtsh1RirfR3yR6ObvsDlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5K8jrMBHETtAx3P7CzaNEg5ZTusaOh2vgX1dvzqZN2nwnJG2PAASUKJwmZUSa6sX
         6z5+gAYl5TJXYb8F87cLJ5taRa/ialQJH27/Bsk8EqMicP4himBztrD9sll/CZiric
         lDuMPpkG8aS41OCDNjaZ1vxDdVrZZpPwDwREztdM=
Date:   Sat, 22 Dec 2018 08:32:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yangerkun <yangerkun@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: remove no need inc_nlink
Message-ID: <20181222073205.GA21053@kroah.com>
References: <20181222034111.15214-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222034111.15214-1-yangerkun@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:41:11AM +0800, yangerkun wrote:
> Remove inc_nlink in debugfs_create_automount, or this inode will never
> be free.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/debugfs/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 13b0135..9e6e225 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -516,8 +516,6 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>  	inode->i_op = &simple_dir_inode_operations;
>  	inode->i_fop = &simple_dir_operations;
>  
> -	/* directory inodes start off with i_nlink == 2 (for "." entry) */
> -	inc_nlink(inode);

Really?  How did you test this and why does removing this line directly
go against what the comment says?

this feels really wrong...

greg k-h
