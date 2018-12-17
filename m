Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5BEC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D5B2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbeLQLis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:38:48 -0500
Received: from ozlabs.org ([203.11.71.1]:51617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbeLQLis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:38:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JK10123Yz9s2P;
        Mon, 17 Dec 2018 22:38:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 3/9] powerpc/vdso: don't clear PG_reserved
In-Reply-To: <20181214111014.15672-4-david@redhat.com>
References: <20181214111014.15672-1-david@redhat.com> <20181214111014.15672-4-david@redhat.com>
Date:   Mon, 17 Dec 2018 22:38:39 +1100
Message-ID: <87pnu0tmbk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> The VDSO is part of the kernel image and therefore the struct pages are
> marked as reserved during boot.
>
> As we install a special mapping, the actual struct pages will never be
> exposed to MM via the page tables. We can therefore leave the pages
> marked as reserved.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/kernel/vdso.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index 65b3bdb99f0b..d59dc2e9a695 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -795,7 +795,6 @@ static int __init vdso_init(void)
>  	BUG_ON(vdso32_pagelist == NULL);
>  	for (i = 0; i < vdso32_pages; i++) {
>  		struct page *pg = virt_to_page(vdso32_kbase + i*PAGE_SIZE);
> -		ClearPageReserved(pg);
>  		get_page(pg);
>  		vdso32_pagelist[i] = pg;
>  	}
> @@ -809,7 +808,6 @@ static int __init vdso_init(void)
>  	BUG_ON(vdso64_pagelist == NULL);
>  	for (i = 0; i < vdso64_pages; i++) {
>  		struct page *pg = virt_to_page(vdso64_kbase + i*PAGE_SIZE);
> -		ClearPageReserved(pg);
>  		get_page(pg);
>  		vdso64_pagelist[i] = pg;
>  	}
> -- 
> 2.17.2
