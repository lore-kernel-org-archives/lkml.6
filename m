Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30DAECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722E421534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x6hEWCmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722E421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbeIUD1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeIUD1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:27:03 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3000821533;
        Thu, 20 Sep 2018 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537479691;
        bh=+4YA2C/T4xEfDl/sz3Q8hrU3+hCMTguhz7rjn5wYsgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x6hEWCmUWmYElBXHySMvlDmYJom2JdQLn4rRnk7tPEJNpGWotL3uO1LECpt17XlB0
         76M/tZ/zv8c4gJpLu72MCYOye6ON3HCG23eWaMQR2/EAsuNH9xnPaiqva5z3Oq/VzG
         Lc7aUQ294CnhohjWfcy3d9Z8Oh/aNISMIQrp8qvE=
Date:   Thu, 20 Sep 2018 14:41:30 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to recover inode's uid/gid during POR
Message-ID: <20180920214130.GC35918@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180920094130.124622-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920094130.124622-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20, Chao Yu wrote:
> Step to reproduce this bug:
> 1. logon as root
> 2. mount -t f2fs /dev/sdd /mnt;
> 3. touch /mnt/file;
> 4. chown system /mnt/file; chgrp system /mnt/file;
> 5. xfs_io -f /mnt/file -c "fsync";
> 6. godown /mnt;
> 7. umount /mnt;
> 8. mount -t f2fs /dev/sdd /mnt;
> 
> After step 8) we will expect file's uid/gid are all system, but during
> recovery, these two fields were not been recovered, fix it.

Hmm, I tried this before, but wasn't enough to fix everything. :(

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/recovery.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index ba678efe7cad..da9f59b9044e 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -209,6 +209,8 @@ static void recover_inode(struct inode *inode, struct page *page)
>  	char *name;
>  
>  	inode->i_mode = le16_to_cpu(raw->i_mode);
> +	i_uid_write(inode, le32_to_cpu(raw->i_uid));
> +	i_gid_write(inode, le32_to_cpu(raw->i_gid));
>  	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
>  	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
>  	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
> -- 
> 2.18.0.rc1
