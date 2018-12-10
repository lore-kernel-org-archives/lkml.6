Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C93C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2012082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ed5+2KRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2012082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeLJRqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:46:52 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44474 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeLJRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:46:51 -0500
Received: by mail-yb1-f194.google.com with SMTP id d2so854589ybs.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2BEvgAB5tLKe2Jkh8uFQEGm89nJIznxDfmpwN13nSQ=;
        b=Ed5+2KRTSVSDtL10OQqbAy7tkXxqY+L+ejJmN9mLWx99XXLQ1BENnexZZOpiaWYYak
         1J8gj6XA1Z5St57yHr8femJnLeCVsFL2RCbH5035SGZ4H1LotPMWXbh+4xwCcVI8PPEl
         UWeJFOaaX1Ngp6+RlavDa9V6ERhRNyMOjTTlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2BEvgAB5tLKe2Jkh8uFQEGm89nJIznxDfmpwN13nSQ=;
        b=CWF8oPi8TomR8qIEtLdU6v33W350Vw5DmqTScULdD+rlu6SoIKbv3HajaxhI5u2Dk3
         jQIiJTsdVFqbhHb2BalBJFvF8VDJWe3vJmHjsm/sOsIwddNS28GaVoHK2sBvE+Nzsya7
         kPBwuizcF2/lFKjhvVoflbHOsxsYOnFZTMSyaKk28PHuFLYe5zbB4igrCLOusxz4Wa4w
         kQfp+qu8fh/8+80nudozoi/0LNrey3wOTr52o+bhPfL+O1AlYsuCc+xoTd98x26UGZoe
         3TyKepQhQvtht6W+xHzLhym80W7ww0CijzSugZNvP5WvPmnHZWsuFpfKhI5JyJ2mZo4/
         H5xg==
X-Gm-Message-State: AA+aEWaT0kTRsQfUqzd+9Yh5jK550l04eyn+YOo/PCWTfJmXNEXA/UgY
        v/YOVHjLsRNcBase5x4mKOIzltFpcak=
X-Google-Smtp-Source: AFSGD/VHyHKNf1QPI3hfrvAzy4aLZILhUC5/XA3Wu1rFeuyrntJ+8ofi4LfXjXbW8NdYw+DDcd5v5Q==
X-Received: by 2002:a25:2d63:: with SMTP id s35mr12928332ybe.349.1544464010367;
        Mon, 10 Dec 2018 09:46:50 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id w1sm3553073ywd.49.2018.12.10.09.46.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:46:49 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id d2so854544ybs.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:46:49 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr12922476ybj.137.1544464008816;
 Mon, 10 Dec 2018 09:46:48 -0800 (PST)
MIME-Version: 1.0
References: <40d63adb6058b1fbb4082ca6f15225cb6e76bd62.1544429175.git.christophe.leroy@c-s.fr>
In-Reply-To: <40d63adb6058b1fbb4082ca6f15225cb6e76bd62.1544429175.git.christophe.leroy@c-s.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Dec 2018 09:46:37 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLfNf8NDyZS3jQB=XU9ihs_xg-UBZzFAB7fZaMSaMSPXQ@mail.gmail.com>
Message-ID: <CAGXu5jLfNf8NDyZS3jQB=XU9ihs_xg-UBZzFAB7fZaMSaMSPXQ@mail.gmail.com>
Subject: Re: [PATCH] lib: fix build failure in CONFIG_DEBUG_VIRTUAL test
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 12:08 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> On several arches, virt_to_phys() is in io.h
>
> Build fails without it:
>
>   CC      lib/test_debug_virtual.o
> lib/test_debug_virtual.c: In function 'test_debug_virtual_init':
> lib/test_debug_virtual.c:26:7: error: implicit declaration of function 'virt_to_phys' [-Werror=implicit-function-declaration]
>   pa = virt_to_phys(va);
>        ^
>
> Fixes: e4dace361552 ("lib: add test module for CONFIG_DEBUG_VIRTUAL")
> CC: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/test_debug_virtual.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/test_debug_virtual.c b/lib/test_debug_virtual.c
> index d5a06addeb27..bf864c73e462 100644
> --- a/lib/test_debug_virtual.c
> +++ b/lib/test_debug_virtual.c
> @@ -5,6 +5,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/slab.h>
>  #include <linux/sizes.h>
> +#include <linux/io.h>
>
>  #include <asm/page.h>
>  #ifdef CONFIG_MIPS
> --
> 2.13.3
>


-- 
Kees Cook
