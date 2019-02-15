Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA594C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10BA21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbfBOQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:48:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:35658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbfBOQsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:48:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF894B03F;
        Fri, 15 Feb 2019 16:48:53 +0000 (UTC)
Subject: Re: [PATCH v3] hugetlb: allow to free gigantic pages regardless of
 the configuration
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190214193100.3529-1-alex@ghiti.fr>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <363365a7-f1ac-5bde-ff7f-bdb137c20628@suse.cz>
Date:   Fri, 15 Feb 2019 17:48:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214193100.3529-1-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 8:31 PM, Alexandre Ghiti wrote:
> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
> that support gigantic pages, boottime reserved gigantic pages can not be
> freed at all. This patch simply enables the possibility to hand back
> those pages to memory allocator.
> 
> This patch also renames:
> 
> - the triplet CMA or (MEMORY_ISOLATION && COMPACTION) into CONTIG_ALLOC,
> and gets rid of all use of it in architecture specific code (and then
> removes ARCH_HAS_GIGANTIC_PAGE config).
> - gigantic_page_supported to make it more accurate: this value being false
> does not mean that the system cannot use gigantic pages, it just means that
> runtime allocation of gigantic pages is not supported, one can still
> allocate boottime gigantic pages if the architecture supports it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

...

> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -252,12 +252,17 @@ config MIGRATION
>  	  pages as migration can relocate pages to satisfy a huge page
>  	  allocation instead of reclaiming.
>  
> +

Stray newline? No need to resend, Andrew can fix up.
Ah, he wasn't in To:, adding.

>  config ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	bool
>  
>  config ARCH_ENABLE_THP_MIGRATION
>  	bool
>  
> +config CONTIG_ALLOC
> +	def_bool y
> +	depends on (MEMORY_ISOLATION && COMPACTION) || CMA
> +
>  config PHYS_ADDR_T_64BIT
>  	def_bool 64BIT
>  
