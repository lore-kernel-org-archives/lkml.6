Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F887C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D242B214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yfe/lYWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfA2IJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:47 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43432 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfA2IJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:45 -0500
Received: by mail-vk1-f193.google.com with SMTP id o130so4297836vke.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HskzooTvMqAmijkoLembaa8q/EUEh+gg5JDbqI0lirU=;
        b=Yfe/lYWx+W08Wnk0LT/9pDOe33v6r/YJCX5FHNL8f7PXRPgQ1pULitx5UhzCxQozax
         sUmP0OKPSRBgz5/GAzgXWKinyALuD6Rusi8YhMCk2/sHGw9Yt1IqU4RuXsexPaHqYRN2
         vnrz1YDb7OGnn7mAzynSfkfNPRgP+5JqFpt78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HskzooTvMqAmijkoLembaa8q/EUEh+gg5JDbqI0lirU=;
        b=XQSUTrhdI+sIFGzO+IIbFmnlq/VN+xy3gyhBJuCEvFKHezvMpBHnhEdYVLTWPVhDfd
         GgGRP6/ls2qeG+P9E4gxMm7CaQARO7g/0SWaCHpmUIcz30h2mgHCeAjHtWamd8unzD6Z
         0qaGRfyKVKlkaOsq3eNkk6yPkVNktvC0DWNn04Kd3AG3SCq+RpHOr7GUHPb4VS7ZOBsi
         tbbDr/Dz72PxnVPpwzJyH5XjZlNxrvOTy24WM8Z7ofE3yvWMh7cvQkx6VVG9wR+vo8cc
         PBP3FMhTNu84yqX9rRz2PZDr0tv6ZxontCMh1678Q8cArGtgv3pC5N+bz3GefemKcoc8
         cdWQ==
X-Gm-Message-State: AJcUukdIhYcFmKV42z4BAqHt9ytqxSvcKFU/xfYiSunKW6X4HcIsmaVn
        dyz8wMv7Uc4qBcxd6Z8loe5zuUY3w0Q=
X-Google-Smtp-Source: ALg8bN54y+/gtDSIAt/eUv88cmJNOgC9i7LkSX0tHIJwH6K2VeLR2TiJQAD+Kef1nhkflGiU2kGOtg==
X-Received: by 2002:a1f:7cca:: with SMTP id x193mr10446305vkc.89.1548749383887;
        Tue, 29 Jan 2019 00:09:43 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id w140sm24649478vkw.2.2019.01.29.00.09.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:09:42 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id e16so6522641uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:09:42 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr10723029uac.122.1548749382268;
 Tue, 29 Jan 2019 00:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20190129053830.3749-1-willy@infradead.org>
In-Reply-To: <20190129053830.3749-1-willy@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 29 Jan 2019 21:09:30 +1300
X-Gmail-Original-Message-ID: <CAGXu5jLbC1-T9JbYcDcXjA2G3jv3DLCWSUvJf3KiA8so2XC19g@mail.gmail.com>
Message-ID: <CAGXu5jLbC1-T9JbYcDcXjA2G3jv3DLCWSUvJf3KiA8so2XC19g@mail.gmail.com>
Subject: Re: [PATCH] mm: Prevent mapping typed pages to userspace
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 6:38 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Pages which use page_type must never be mapped to userspace as it would
> destroy their page type.  Add an explicit check for this instead of
> assuming that kernel drivers always get this right.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index ce8c90b752be..db3534bbd652 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1451,7 +1451,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>         spinlock_t *ptl;
>
>         retval = -EINVAL;
> -       if (PageAnon(page) || PageSlab(page))
> +       if (PageAnon(page) || PageSlab(page) || page_has_type(page))
>                 goto out;
>         retval = -ENOMEM;
>         flush_dcache_page(page);
> --
> 2.20.1
>


-- 
Kees Cook
