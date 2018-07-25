Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C75C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0351B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl/8Jg1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0351B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeGYQdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbeGYQdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:33:19 -0400
Received: from [192.168.0.101] (unknown [180.111.133.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A4220891;
        Wed, 25 Jul 2018 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532532072;
        bh=uiFngwDtvj2ADo/5i/TGeT1MkZmAXG9OcJwkSN1xFaE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bl/8Jg1MrZHzCi2O1yq0yx8RExeUQhqHwFoHw+CTYn9J6nUtC+zyZ3tejv2DxbosO
         GCqHEjr2zE3yxegOYSHCNGdRhxgcs8O40IC4+f+mQmXxJDHpdI6e9ebo/fb1ixjhPp
         8ApWmmEv+i5X/Ak24ffo794LFIyWRsIrWLr/mKlg=
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix 32-bit format string warning
To:     Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
References: <20180724093509.1637386-1-arnd@arndb.de>
From:   Chao Yu <chao@kernel.org>
Message-ID: <08f5d7dd-a271-4cef-4cf3-950c4c251c91@kernel.org>
Date:   Wed, 25 Jul 2018 23:21:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724093509.1637386-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/24 17:34, Arnd Bergmann wrote:
> On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
> causes a warning:
> 
> fs/f2fs/inode.c: In function 'sanity_check_inode':
> fs/f2fs/inode.c:247:4: error: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]
> 
> The correct format string is %zu.
> 
> Fixes: ba3a252d3367 ("f2fs: fix to do sanity check with i_extra_isize")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I noticed the issue, thank you for fixing it, but original buggy patch has not
been upstreamed yet, how about merging this fix into origial patch, if you don't
mind?

Thanks,

> ---
>  fs/f2fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 3fe63b0c7325..4fd339fd3ff2 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -245,7 +245,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
>  		f2fs_msg(sbi->sb, KERN_WARNING,
>  			"%s: inode (ino=%lx) has corrupted i_extra_isize: %d, "
> -			"max: %lu",
> +			"max: %zu",
>  			__func__, inode->i_ino, fi->i_extra_isize,
>  			F2FS_TOTAL_EXTRA_ATTR_SIZE);
>  		return false;
> 
