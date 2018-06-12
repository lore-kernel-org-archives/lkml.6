Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3502C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5543D2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RUORSsvi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="liOmfUQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5543D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934731AbeFLXUF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:20:05 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35342 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934354AbeFLXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:20:03 -0400
Received: by mail-yb0-f193.google.com with SMTP id f79-v6so253034ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ehjovfCjQ3dvAvE5gVfrCWsH2VPV49x/uBS5rO+cQWk=;
        b=RUORSsviT2HKPQvsJjuLWeTIn7WCRjOD/v2e5MlhmwlnkTSMYNM+7nca0xb0DEnZWk
         HapiYtmaSAMHarjSa3BaXpAsb6nB5VoLxWKDpqPPFd/+Tlo3uSyvVrJN3XzVNmpUQl5S
         4PxN6e+cRI82bvlVh/7C45DP6RYIe3fKKyJlzxX/WbgwL8C7+sUlKcHxSI3afoSWmVOt
         eAFvYfmxUQTnKsihLOH9VQj2JvjZmuNb8BQZ/14sYMS3TsUrdBKTdH6xfNUUDIGRF0ax
         i5h5Ep899cVw8ORTtGG40d5jhhvYJDSPjW0pA7+v++kzbaEhRXxTw7iacZ0D1UYq+R2O
         mF9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ehjovfCjQ3dvAvE5gVfrCWsH2VPV49x/uBS5rO+cQWk=;
        b=liOmfUQLIcjlpKig1vV0cXiPZYQ3FpEGshcnNBVMsEeciSmN8L/h9AmZZ7xLtp2Pte
         quCqurrJd58CNGmfmj36iLqUUcM2acUPk6uG1Fg1SHgaSXh1s6+dbpVZ8TovZpaBZzSB
         zQ8quKoBHkacxplfWKV0yyZUj7O7KkdhTWwkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ehjovfCjQ3dvAvE5gVfrCWsH2VPV49x/uBS5rO+cQWk=;
        b=rSwVMjrr2VVvsC9YY+rzZVWh58IQaMIDU4C3dITgNsA35dhne4CkM3MJs1LRUXDq5M
         6uwvl+Wk/neLQASEa/pljksO3qm0gyRezwP12hhKOd68a/3rZXX85TVuzdeQwg8Mx+pL
         vnCuZUQLWC90UvAhYeANG4QCzo6Zof5pL6egesGWswEyrWyUDrshUkK/wpK0SeetC8E7
         ALSu6bTnwaxBnxjAO8sVFXCyKomBizBP0HsLfgx8uthNtIlHdlRo5jSIz3uy4QUlgCa7
         d24TNrKxujzLjvjv/perkjxGWpx41fcudJC6crIjWX0GS9P8u4jkfL2VRwRGQygWgsUo
         utiA==
X-Gm-Message-State: APt69E2YVJ0Y8OYUN4D4quFbkydbOrHlRrrbI5WIvvJVPFBaWNOVcUuO
        Rl2AsLWvD+GOG0gVJY83ARaH9wiNWM7/Q7MPl5DkYA==
X-Google-Smtp-Source: ADUXVKIgTLmFnFf1TozyAh99h6js4SuOyMUcDOVDiWCcW8a1180wOqwkdXEtUKHIk9NOthxP6tNoDSR8Yysq+gAp5ow=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr1274103ybi.193.1528845602849;
 Tue, 12 Jun 2018 16:20:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 16:20:02
 -0700 (PDT)
In-Reply-To: <20180612120432.xqffkv7q74wnip5n@kili.mountain>
References: <20180612120432.xqffkv7q74wnip5n@kili.mountain>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Jun 2018 16:20:02 -0700
X-Google-Sender-Auth: fjVdD92xLU8Njce7stmHWK019pY
Message-ID: <CAGXu5j+B4=fNbb4yGkFZZfQgPsxTz6C7dO88Pm-VbJBfQEz3Vw@mail.gmail.com>
Subject: Re: [PATCH] test_overflow: fix an IS_ERR() vs NULL bug
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:04 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> root_device_register() returns error pointers, it never returns NULL.
>
> Fixes: ca90800a91ba ("test_overflow: Add memory allocation overflow tests")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ah! Thanks. I'll pull this into my overflow tree for Linus.

-Kees

>
> diff --git a/lib/test_overflow.c b/lib/test_overflow.c
> index aecbbb217305..2278fe05a1b0 100644
> --- a/lib/test_overflow.c
> +++ b/lib/test_overflow.c
> @@ -367,7 +367,7 @@ static int __init test_overflow_allocation(void)
>
>         /* Create dummy device for devm_kmalloc()-family tests. */
>         dev = root_device_register(device_name);
> -       if (!dev) {
> +       if (IS_ERR(dev)) {
>                 pr_warn("Cannot register test device\n");
>                 return 1;
>         }



-- 
Kees Cook
Pixel Security
