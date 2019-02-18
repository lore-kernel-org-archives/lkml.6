Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE002173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJE0dmec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfBRLbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:31:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbfBRLbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oKffzBACjkSj6o9w5aZt7Px1P4l0HPVu2+Xyfumag+E=; b=dJE0dmec0vzaWeeAGiwYX0sX5
        nTF4DE3finLImKyx8Rlxnu7yd/tEDz+Wv8tZxIxlixjmWGgRCzpOMEQJB5Xw/W055+MGcXyPmyfSG
        IhVmVYTUO9XF1yKO/npu5E2EJDOuJawlJLGG3lmEh74A//1DSdhV9zkLXXKHoDwN3E9jF9hzqU8kt
        N6jeDN4rIhzAsPwEX0kBhUdPR4Itcl5eZZpn88O7HU94itGvbIi1SXdA9D1XBzxxKPQwQBIxhNb/v
        JMK9clZRMvsyKeXWSpPqBf0BZ14S2k6Svs2UBj8gMFXeugRLTMPseVXLBH1BjxnZBrx9RBLZChFzu
        Wjs0KXdWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvh96-0001st-Ep; Mon, 18 Feb 2019 11:31:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8BBF23EAF75C; Mon, 18 Feb 2019 12:31:34 +0100 (CET)
Date:   Mon, 18 Feb 2019 12:31:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, kirill@shutemov.name
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190218113134.GU32477@hirez.programming.kicks-ass.net>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215170235.23360-4-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 05:02:24PM +0000, Steven Price wrote:
> From: James Morse <james.morse@arm.com>
> 
> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> we may come across the exotic large mappings that come with large areas
> of contiguous memory (such as the kernel's linear map).
> 
> For architectures that don't provide p?d_large() macros, provided a
> does nothing default.

Kan was going to fix that for all archs I think..

See:

  http://lkml.kernel.org/r/20190204105409.GA17550@hirez.programming.kicks-ass.net

> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/asm-generic/pgtable.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 05e61e6c843f..7630d663cd51 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -1186,4 +1186,14 @@ static inline bool arch_has_pfn_modify_check(void)
>  #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>  #endif
>  
> +#ifndef pgd_large
> +#define pgd_large(x)	0
> +#endif
> +#ifndef pud_large
> +#define pud_large(x)	0
> +#endif
> +#ifndef pmd_large
> +#define pmd_large(x)	0
> +#endif
> +
>  #endif /* _ASM_GENERIC_PGTABLE_H */
> -- 
> 2.20.1
> 
