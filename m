Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B4F218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OWTKgxsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfAYSoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:44:55 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45367 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAYSoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:44:55 -0500
Received: by mail-vk1-f195.google.com with SMTP id n126so2339264vke.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgiQ1AS1vbH52Fdhlzx0yBS0Qcj/v4CjMVy9B7SV8gQ=;
        b=OWTKgxsRROMExtBfkf0bxxcq0zQINpUefyMVFPVXOD7Ow1GJhPS1F3XVpEUazOyoPC
         B1fPtJERXRLxCQX5VG1AlmKhbDkZtlL80flYdMYT2hZpyHyHT7FezvASf1PdBvcpGS0k
         V8rIWejSfPUpU8eHglkabuMuE/Imstz6FB3QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgiQ1AS1vbH52Fdhlzx0yBS0Qcj/v4CjMVy9B7SV8gQ=;
        b=If7+/Bjm3uxGaAenXQaaAi1iyuheE8MxwuAbPaTUIt44GLMYBu94cYB2zWs4zwKYJl
         Bcrf5TYlS7Ppda94hgdy5VlTSKKKxBwuFuQF6uoOtAKk8B8LhqWtfagi43mB3yNnr3Qs
         VUMK5oq/E4NdqrSXDYGp2e5h/k0goewjBdTq2VIhmbgxjUits9ny8eDckN0qekNDwr4t
         Rax+quwB81jTstT7wIgMFtAgZmqrw9Jk+4Mh792RA/2ZhFJWRy3WGOQGT8zqTr9m2Joz
         DlNabteXWLG6hXuh8GNFVLpKXv2/9JbgWTZ+gDRX+2dajNcmwRFH57H2ZvkMPan6e7SK
         54MQ==
X-Gm-Message-State: AJcUukdw4HEzqQdzTkaPyGtZ2hGXXd6htvv+6xQcxJEZ6z19oUbsN04R
        RAdlHgIKhjnfnKaQGrTio1irAd3uH5k=
X-Google-Smtp-Source: ALg8bN7zxSn6rqojKjLK2hJiBDsb37c66UioGTJp9IxOvU1LfnipIt7nEMMvH5DVfZluG7KUs0d9PQ==
X-Received: by 2002:a1f:ccc4:: with SMTP id c187mr4922418vkg.90.1548441893847;
        Fri, 25 Jan 2019 10:44:53 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id p8sm76651526vke.27.2019.01.25.10.44.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:44:52 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id u19so3587817uae.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:44:52 -0800 (PST)
X-Received: by 2002:ab0:645:: with SMTP id f63mr4915124uaf.106.1548441892334;
 Fri, 25 Jan 2019 10:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20190125173827.2658-1-willy@infradead.org>
In-Reply-To: <20190125173827.2658-1-willy@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 26 Jan 2019 07:44:40 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJ=yHXC_S_o6V4QQ+DCV4w2T-tw_BiUXDAW2a8rZDhZJg@mail.gmail.com>
Message-ID: <CAGXu5jJ=yHXC_S_o6V4QQ+DCV4w2T-tw_BiUXDAW2a8rZDhZJg@mail.gmail.com>
Subject: Re: [PATCH] mm: Prevent mapping slab pages to userspace
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 6:38 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> It's never appropriate to map a page allocated by SLAB into userspace.
> A buggy device driver might try this, or an attacker might be able to
> find a way to make it happen.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index e11ca9dd823f..ce8c90b752be 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1451,7 +1451,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>         spinlock_t *ptl;
>
>         retval = -EINVAL;
> -       if (PageAnon(page))
> +       if (PageAnon(page) || PageSlab(page))

Are there other types that should not get mapped? (Or better yet, is
there a whitelist of those that are okay to be mapped?)

Either way, this sounds good. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>                 goto out;
>         retval = -ENOMEM;
>         flush_dcache_page(page);
> --
> 2.20.1
>


-- 
Kees Cook
