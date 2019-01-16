Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91356C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E9B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CAGg6l/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbfAPGZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:25:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38786 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfAPGZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:25:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so712616wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vpk4JTSxD8QxfkykpPDAxFXdzKPiVBJKdTp/GmGy4gc=;
        b=CAGg6l/IBlMN2x87/TlX5GVgLEwU4paoVQhjQdX7L+hC8M/7Kkq+zuMzytrhKL6Uxp
         o4QmjEcr5LGzjcC5bnk2ItfAeH7eXI+Tj6bX1qViLcj+jfnW1ysXXu0SnpgemtpPgfHm
         aXK6QTt5UnMY4VCfOnNR5wc/Arvs+JxMWRy1CqQ0zTsmMsdDUC9JdfuvuDP9Rwxs7+ID
         N30vTtm4cbdjm3uqC/XdajJNPHuvzP5MrV2OZLFbn6fYhQeVloeccOw3JJthLhgpsqQE
         DKKjSSgkwCLwpXmrKzScHufszTcFgLnnI1om3B6Ruszb2P0EMwMVvVFZsXnU7qBVuuXw
         vLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vpk4JTSxD8QxfkykpPDAxFXdzKPiVBJKdTp/GmGy4gc=;
        b=m6dmNAe4dNrvHuTEYPzW8WaC9R3VB/0djiKgthiSXTbusm3kCQfEmsHsNWneBLPh0e
         hqF14RHPGEZbsBfFyVKMx8DvBV4ZAP/gZwkPnqEum2p6405Zr1Ervbc9upmCCrnu4Z9t
         NrorafSBYFlvjf83EPRKjxvJ0t7RdXoXIue6tbrTNnqeT0WyoDETbgK7PhGxKEOSwFyd
         n3v0RbAZOoRvTl093gGIvxBEeocHJj2ZKAIHbVd2tskQXFZcPaq6f7fjQUttj3p7ljKk
         dldWFDNNtlNIhAfppuqFvy7hhaUxkbqlpyK0H2arbLGsP1zHwVoDGcV3guC4unNPxmSO
         XEVQ==
X-Gm-Message-State: AJcUukdZ87X+pT9Gf2XE3AVRLMOBEndh6NaIsDBcNmhYYcd2Is4WC83w
        Jwj4K+VZi12U2SZR5PDKZmhX2A==
X-Google-Smtp-Source: ALg8bN45G9bE42pMBqEGKEbhOwgzIpaja4Y+Pn4393DLWh5xrM71vcU35Lk+r3pKnXav5GkTsbIAfQ==
X-Received: by 2002:a1c:8b09:: with SMTP id n9mr6065378wmd.38.1547619953412;
        Tue, 15 Jan 2019 22:25:53 -0800 (PST)
Received: from brauner.io ([154.119.33.254])
        by smtp.gmail.com with ESMTPSA id o16sm94680731wrn.11.2019.01.15.22.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 22:25:52 -0800 (PST)
Date:   Wed, 16 Jan 2019 07:25:47 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] binderfs: fix error return code in
 binderfs_fill_super()
Message-ID: <20190116062546.ufoeresnwz3wyxiu@brauner.io>
References: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:01:04AM +0000, Wei Yongjun wrote:
> Fix to return a negative error code -ENOMEM from the new_inode() and
> d_make_root() error handling cases instead of 0, as done elsewhere in
> this function.
> 
> Fixes: 3ad20fe393b3 ("binder: implement binderfs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/android/binderfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 9518e2e..2bf4b2b 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -519,8 +519,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_fs_info = info;
>  
>  	inode = new_inode(sb);
> -	if (!inode)
> +	if (!inode) {
> +		ret = -ENOMEM;

Hey, thanks for the patch. Just a nit:
can you please just do?

	ret = -ENOMEM;
        inode = new_inode(sb);

This is more consistent with how we do it everywhere else and let's us
avoid shoving ret = -ENOMEM into two places.

Thanks!
Christian

>  		goto err_without_dentry;
> +	}
>  
>  	inode->i_ino = FIRST_INODE;
>  	inode->i_fop = &simple_dir_operations;
> @@ -530,8 +532,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  	set_nlink(inode, 2);
>  
>  	sb->s_root = d_make_root(inode);
> -	if (!sb->s_root)
> +	if (!sb->s_root) {
> +		ret = -ENOMEM;
>  		goto err_without_dentry;
> +	}
>  
>  	ret = binderfs_binder_ctl_create(sb);
>  	if (ret)
> 
> 
> 
