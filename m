Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB43C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F76208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUfExPYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F76208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lab.ntt.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbeLCJLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:11:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42745 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLCJLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:11:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so1323590plp.9;
        Mon, 03 Dec 2018 01:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:message-id:to:cc:subject:from:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ET+v1lzht47p7Ea8q9aJOOOusSYukUsS1WfvO9DhXZ8=;
        b=CUfExPYxnTrJ8sESNBEWQbpwMuSGPFuEp9UNLK39UC6BJv8islcBUmKcrrQXHz2q7L
         2RrWE7nwhhW0zu7S7+JsOPtPyHXRe4x//JEb9QtUQRuF9KOgaF/bF7jpMRv1yKzJbNy1
         kl1eBnVZDPrOCXRHNcMros+ZpOAcd3kEdbiUzHBNAwW/pzrWjCr+oPB1HHi2Q2qPNYtg
         4jAa0fBixgqIvfL1avwuUb7qw2ZZIHDApX3b8EOEQVD23AHVJ+WMeB0m8P9QErrOOTHw
         Dd3w0tXVp5oY+0PAx1lTFJR+vvwLLBYDmSBSRgtGOJgLwh/+cn48j7/H5ThxfvqqasSZ
         lz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:to:cc:subject:from
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ET+v1lzht47p7Ea8q9aJOOOusSYukUsS1WfvO9DhXZ8=;
        b=Qx2bp7alngNHoDBoBeITcR2a/EcPMQeJrPOnfyY9QddsTkEulgc1mAtG2ZJKvq1kkn
         cHRYD1P0y25ZM5k0W1ZO/anUr/psnYi34Ybsuj4SQW1UipgwkrpLWPzyy21xCmV5PMI3
         1eGeruD9qAg53nsOAQRpWszNAEKbX06Lncl1B3FdUwfQPjFOaQj8ynBqz1KxNca6zm8q
         iJ+F8ZF7ZKFy6dn7yo4EgXJG8PrEolT76qr6OT00nWWNJUjleSdP8AFfRnB93fyadI7Z
         SF6+CgYSniXTQAa3LzgcnPw1W9ekWdmcposfrgQ1jN4NlLJ5ZTLVW6ObL2dNgUDcyI99
         whKQ==
X-Gm-Message-State: AA+aEWbT3igsVpsZ09zlpvTZy3ZcV+APqSeZSUenQcu5P8jFZ6C6Cd5L
        NNDOG8ojnLYr6LQzfDIrCoQ7e46s
X-Google-Smtp-Source: AFSGD/WQVhzLL860I25RbX0y4DS9/IRUwnn0xsC+vzq2GwzPgDjNcLvwwDWT/Ur4fdqcakqoQqm8bw==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr15535922plb.335.1543828256474;
        Mon, 03 Dec 2018 01:10:56 -0800 (PST)
Received: from localhost (77.255.149.210.rev.vmobile.jp. [210.149.255.77])
        by smtp.gmail.com with ESMTPSA id p7sm16489083pfa.22.2018.12.03.01.10.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 01:10:55 -0800 (PST)
Date:   Mon, 03 Dec 2018 18:10:51 +0900 (JST)
Message-Id: <20181203.181051.1348099310050315226.konishi.ryusuke@lab.ntt.co.jp>
To:     Pan Bian <bianpan2016@163.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nilfs2: fix potential use after free
From:   Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
In-Reply-To: <1543201709-53191-1-git-send-email-bianpan2016@163.com>
References: <1543201709-53191-1-git-send-email-bianpan2016@163.com>
X-Mailer: Mew version 6.6 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pan Bian

Thank you for feeding back this patch.
I reviewed this and am thinking this must be sent to upstream.

Did you see any kernel oops on this bug ?

Regards,
Ryusuke Konishi

On Mon, 26 Nov 2018 11:08:29 +0800, Pan Bian <bianpan2016@163.com> wrote:
> brelse(bh) is called to drop the reference count of bh when the call
> to nilfs_dat_translate fails. If the reference count hits 0, bh may be
> freed. However, bh->b_page is unlocked and put after that, which may
> result in a use-after-free bug. This patch moves the release operation
> after unlocking and putting the page.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  fs/nilfs2/gcinode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
> index aa3c328..a24bb29 100644
> --- a/fs/nilfs2/gcinode.c
> +++ b/fs/nilfs2/gcinode.c
> @@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
>  		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
>  
>  		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
> -		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
> -			brelse(bh);
> +		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
>  			goto failed;
> -		}
>  	}
>  
>  	lock_buffer(bh);
> @@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
>   failed:
>  	unlock_page(bh->b_page);
>  	put_page(bh->b_page);
> +	if (unlikely(err))
> +		brelse(bh);
>  	return err;
>  }
>  
> -- 
> 2.7.4
> 
> 
