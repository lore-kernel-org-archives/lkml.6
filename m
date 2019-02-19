Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72C0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="AtQ4AQBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfBSDrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:47:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33598 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfBSDrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:47:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so9726907plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=tUz5JABWfgefOez+HboEAqWRpASZBI5PTo6PVfPcxkM=;
        b=AtQ4AQBZ2Rs72iQg21eVLhPCUlHDD2nd52ok0ZoaZuwrzF6SLa2Z3rjN3Adj0IEHx/
         kLwciEPdrRzkQM512RIV6QIh32UOnQnq4MNhzjJGJkdP4tmCPTVsrpf+L7xPpGT4/m7p
         CjvZtu15kGGCXRv9ZHBNWKFBBcvl/DjrLtZWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tUz5JABWfgefOez+HboEAqWRpASZBI5PTo6PVfPcxkM=;
        b=h+ZxOgXmkqMGYT7bJc9o5DBMog8KUNd6pxnZVVfYoETcb33zamALDVl3a0sH/U0Aa9
         8Ohp5fRYzBfZGMUdi271OwpXMc3EBQmhdTjVJky2lEdw3zSdTy9yTB2GHmgzJbZbiuKO
         ST19e2ZJvsUGNLl6mC0i8bVeZUz9SfA6OMfVNM+qt+I991c3rjNjLkN+Y6ipSSrlQ8iI
         7LfFsMcHNj5mIaVn//1FJnykenOy93zjI3pUU6iUwVIBYEM15aWSfGD49hQpkWFCqZEX
         k4d+wVB+uEvza/qia76+oKkW+IDvFaSQupsfJLMp7EoSzhHIUIOlPn9ytjvYZI00cDcy
         bVNQ==
X-Gm-Message-State: AHQUAua8CmGZJupDR8Bijo5J99gb9oE8Vx+VaAXVrJXScjphbpSlrWLe
        lPbsKikbOfM6o4ipUjk3OOpa2H/CDEc=
X-Google-Smtp-Source: AHgI3IazyC9x9/pPkfrXHrIGgcQZGn+Wj3upFeyiZPMMewsB4KKyc1LnVK7RYGbaB3hy66K9mFJJEQ==
X-Received: by 2002:a17:902:6686:: with SMTP id e6mr28695726plk.208.1550548028446;
        Mon, 18 Feb 2019 19:47:08 -0800 (PST)
Received: from localhost (ppp121-45-196-25.bras1.cbr1.internode.on.net. [121.45.196.25])
        by smtp.gmail.com with ESMTPSA id z127sm24578596pfb.80.2019.02.18.19.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 19:47:07 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     YueHaibing <yuehaibing@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] powerpc/pseries: Drop pointless static qualifier in vpa_debugfs_init()
In-Reply-To: <20190218125644.87448-1-yuehaibing@huawei.com>
References: <20190218125644.87448-1-yuehaibing@huawei.com>
Date:   Tue, 19 Feb 2019 14:47:02 +1100
Message-ID: <87ftska18p.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing, <yuehaibing@huawei.com> writes:

> There is no need to have the 'struct dentry *vpa_dir' variable static
> since new value always be assigned before use it.
>

Much to my surprise this seems to be a correct change. I don't know why
the struct was ever static but it seems to have been this way since the
commit went in in October 2018. And yes, it is set every time when the
function is called (which is exactly once, it's an initcall). I wonder
if once upon a time in an earlier spin of the patch there was a method
to tear the debugfs down, so it was global, and in the revisions that
went away but the static qualifier remained.

Anyway, I think your commit message should have:

Fixes: c6c26fb55e8e ("powerpc/pseries: Export raw per-CPU VPA data via debugfs")

as this is the commit that introduced the issue.

With that change:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/platforms/pseries/lpar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index f2a9f0adc2d3..f649c1b652eb 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -1263,7 +1263,7 @@ static int __init vpa_debugfs_init(void)
>  {
>  	char name[16];
>  	long i;
> -	static struct dentry *vpa_dir;
> +	struct dentry *vpa_dir;
>  
>  	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
>  		return 0;
