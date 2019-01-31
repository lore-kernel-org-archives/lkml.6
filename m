Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00AC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EB320B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfAaAhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:37:18 -0500
Received: from ozlabs.org ([203.11.71.1]:59785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfAaAhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:37:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qhBt41SKz9sDB;
        Thu, 31 Jan 2019 11:37:10 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mm: Prevent mapping slab pages to userspace
In-Reply-To: <20190125173827.2658-1-willy@infradead.org>
References: <20190125173827.2658-1-willy@infradead.org>
Date:   Thu, 31 Jan 2019 11:37:10 +1100
Message-ID: <87bm3xpsqx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

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
>  	spinlock_t *ptl;
>  
>  	retval = -EINVAL;
> -	if (PageAnon(page))
> +	if (PageAnon(page) || PageSlab(page))
>  		goto out;
>  	retval = -ENOMEM;
>  	flush_dcache_page(page);


Thanks for turning this into an actual patch.

cheers
