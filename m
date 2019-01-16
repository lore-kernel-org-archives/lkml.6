Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A48C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA48D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="d1aVn+yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfAPIlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:41:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51009 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbfAPIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:41:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so1048532wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 00:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b2LuXdXxQcuKvwCS+44bPlMgNx8NsNIh48/lWI4p120=;
        b=d1aVn+yxVUY4XUkMpjFyB7K0U4rnONpHYd3Kz11h9reic7cfIXhGfPm83tmdrR6f0I
         mEtXNeg4juCdqyVZbucs9Wd27bKknDmf9rEDaRQtqiEsY1T+7Tsoml+u6NSRCABY3kV0
         ET889DX5mkbExtqSfG3+bnisJuOhtOUaECN3aQU9PeaM36QwDRQbrlsEkkW3cW5KRZ/c
         TfOPwt0+eqhonVvvTPavsj9hb553oShrIdijIGKHWwNtTsCG7Rdo1U++fe3WPRGILzU0
         oVvOx7O1f4kqozwkCoXgH2qHebkm0DrChuCZehV/TL80rqpOzh4lMms1jNQaUVs0131e
         r7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b2LuXdXxQcuKvwCS+44bPlMgNx8NsNIh48/lWI4p120=;
        b=hon9tanBb009GGEEX+l0Kv/JSUz3e+VTzNk/V5tcvK5ms24dDgSzSKfx1ksJ+vCkrR
         ODoOPGOS/0eOXQutYIyeN/nkHmbMBvZLm6H1G2BcrdFuJukVpFnDRuq3mTIXzCwlHy1W
         UCQLCLHiy9lGm7DwCvvQWyrsnfCEhW0SPjhnaCQFKWtFNwMsnl4MWUXnrQI//s/RkZX3
         swHNswGBO49BqXGDNDx9kAjAsw3LSzOUbhlj2wO5hTHnHagQA3ildRweafCUDHxsVbCI
         3buhPcYzNWZ8Yjd3hR3YWRGsrf46TNuxBhwyfqvXoWRo1DeT7POhXdgvSh0p7EPhWyim
         x5PA==
X-Gm-Message-State: AJcUukeytuKpGAGpsTutbbV0Bdoew4yq9TbkrNx2XCZFSi9sHoH/+KbO
        6SnMjjpo4HNL+JmPAF5py0nPoQ==
X-Google-Smtp-Source: ALg8bN674HNiJJ/2BEtoj/Q5L93tvMuOpcPZrBe/5Pk+E7S4h7RShVjwxVZ7wXe4zDkZWhw+1wYSyA==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr6145358wmf.17.1547628077974;
        Wed, 16 Jan 2019 00:41:17 -0800 (PST)
Received: from brauner.io ([154.119.33.254])
        by smtp.gmail.com with ESMTPSA id p10sm22873323wrt.25.2019.01.16.00.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 00:41:17 -0800 (PST)
Date:   Wed, 16 Jan 2019 09:41:10 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next v2] binderfs: fix error return code in
 binderfs_fill_super()
Message-ID: <20190116084108.lubcpqaflkzmwfvp@brauner.io>
References: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
 <1547627642-96450-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547627642-96450-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:34:02AM +0000, Wei Yongjun wrote:
> Fix to return a negative error code -ENOMEM from the new_inode() and
> d_make_root() error handling cases instead of 0, as done elsewhere in
> this function.
> 
> Fixes: 3ad20fe393b3 ("binder: implement binderfs")

This should be:

Fixes: 849d540ddfcd ("binderfs: implement "max" mount option")

If you have added that feel free to also add my Reviewed-by.

Thanks!
Christian

> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: move 'ret = -ENOMEM' out of if
> ---
>  drivers/android/binderfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 9518e2e..e4ff4c3 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -518,6 +518,7 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	sb->s_fs_info = info;
>  
> +	ret = -ENOMEM;
>  	inode = new_inode(sb);
>  	if (!inode)
>  		goto err_without_dentry;
> 
> 
> 
