Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C65C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A039F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nWr83pET";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="GEUl5J07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A039F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLKIVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:21:52 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:59861 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbeLKIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:21:52 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 0FD24206B4;
        Tue, 11 Dec 2018 11:21:47 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BWCnWWxZ58-LkUGgOoP;
        Tue, 11 Dec 2018 11:21:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1544516507; bh=DdBL61cK/P+YLJ2wkFY4SMpy1Nlgfc3ORSx3E0oTjjE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=nWr83pETY52H6OcT3yCGF+TdGLPbkdzPCZMzBKetvRXYp8tO9/2Lhz+wHmKYA/KLU
         YsFRsO9SG9Wl2iIDVM4LBzacBYM4FlxkSnGfav0MVfN+6yPgytlK3SGJEuB9CCEoZE
         1ojXbdpPb1uK+EbQMe/20pZI7dAAgODpjsmrZywg=
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:67])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id n4TZlARbny-LkBGki4b;
        Tue, 11 Dec 2018 11:21:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1544516506; bh=DdBL61cK/P+YLJ2wkFY4SMpy1Nlgfc3ORSx3E0oTjjE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=GEUl5J07/Ukd3XFQOuDT57oFZIurf+P8zx+e1FmHVXzBe5FNdSwZD+l/UVtPM83UB
         spV1rQ3tCtHNSgQQJBC12Gq33kJ7QL/VC9XNs3t/3SDeIvsNqVbndJCuaKtSGNlbm1
         US7Zd+LqnF7pF+T09XhWWV8GPsBM4iLStEXDotSY=
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH v2] mm: thp: fix flags for pmd migration when split
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org
References: <20181211051254.16633-1-peterx@redhat.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <1fc103f7-3164-007d-bcfd-7ad7c60bb6ec@yandex-team.ru>
Date:   Tue, 11 Dec 2018 11:21:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211051254.16633-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2018 8:12, Peter Xu wrote:
> When splitting a huge migrating PMD, we'll transfer all the existing
> PMD bits and apply them again onto the small PTEs.  However we are
> fetching the bits unconditionally via pmd_soft_dirty(), pmd_write()
> or pmd_yound() while actually they don't make sense at all when it's
> a migration entry.  Fix them up by make it conditional.
> 
> Note that if my understanding is correct about the problem then if
> without the patch there is chance to lose some of the dirty bits in
> the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> of swap offset instead of bit 2) and it could potentially corrupt the
> memory of an userspace program which depends on the dirty bit.
> 
> CC: Andrea Arcangeli <aarcange@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Michal Hocko <mhocko@suse.com>
> CC: Dave Jiang <dave.jiang@intel.com>
> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> CC: Souptick Joarder <jrdr.linux@gmail.com>
> CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - fix it up for young/write/dirty bits too [Konstantin]
> ---
>   mm/huge_memory.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f2d19e4fe854..b00941b3d342 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2157,11 +2157,16 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   		page = pmd_page(old_pmd);
>   	VM_BUG_ON_PAGE(!page_count(page), page);
>   	page_ref_add(page, HPAGE_PMD_NR - 1);
> -	if (pmd_dirty(old_pmd))
> -		SetPageDirty(page);
> -	write = pmd_write(old_pmd);
> -	young = pmd_young(old_pmd);
> -	soft_dirty = pmd_soft_dirty(old_pmd);
> +	if (unlikely(pmd_migration)) {
> +		soft_dirty = pmd_swp_soft_dirty(old_pmd);
> +		young = write = false;
> +	} else {
> +		if (pmd_dirty(old_pmd))
> +			SetPageDirty(page);
> +		write = pmd_write(old_pmd);
> +		young = pmd_young(old_pmd);
> +		soft_dirty = pmd_soft_dirty(old_pmd);
> +	}

Write/read-only is encoded into migration entry.
I suppose there should be something like this:

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2151,16 +2151,21 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,

                 entry = pmd_to_swp_entry(old_pmd);
                 page = pfn_to_page(swp_offset(entry));
+               write = is_write_migration_entry(entry);
+               young = false;
+               soft_dirty = pmd_swp_soft_dirty(old_pmd);
         } else
  #endif
+       {
                 page = pmd_page(old_pmd);
+               if (pmd_dirty(old_pmd))
+                       SetPageDirty(page);
+               write = pmd_write(old_pmd);
+               young = pmd_young(old_pmd);
+               soft_dirty = pmd_soft_dirty(old_pmd);
+       }
         VM_BUG_ON_PAGE(!page_count(page), page);
         page_ref_add(page, HPAGE_PMD_NR - 1);
-       if (pmd_dirty(old_pmd))
-               SetPageDirty(page);
-       write = pmd_write(old_pmd);
-       young = pmd_young(old_pmd);
-       soft_dirty = pmd_soft_dirty(old_pmd);

         /*
          * Withdraw the table only after we mark the pmd entry invalid.

>   
>   	/*
>   	 * Withdraw the table only after we mark the pmd entry invalid.
> 
