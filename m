Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D4EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0390520854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eSTn1Zy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0390520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeGKJNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:13:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeGKJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=axBSON5cvs4xwlba/fqyRyd7rPG8BRp78PXGOPrsffs=; b=eSTn1Zy5c/Aun+4usiHSDLp+M
        wgUUGJcLaFMiOOg2URSQvlxCY5ynPBHcRD1sSnmB9b7tRvnhXPsrDGtqggLQjBwqHBhOtE+qpa78Z
        D3xMoaMW6WtqxFPk84rnDXcFhehpXAmMxFg5RxtGXcYnB17IDfrQjbX7AayPZ0/GyReFR5oOtmYwj
        bYESxGDxIMMU8efDlu9egWY48SH5/olLkjJNdA0B0DlQOeQrmLLYNZIlfZ8r7TZvtEqFU/15fmJZP
        6UUlbqu0g5FUG3Db+CSM5KTe8gEPTeR29TRI5/X4MeEB34OWmmLpBBLgz4RW6uB1gmSifmtT6k2QV
        mNAIfkiPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdB8h-0004nw-Q0; Wed, 11 Jul 2018 09:10:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4727320291063; Wed, 11 Jul 2018 11:10:22 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:10:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 14/27] mm: Handle THP/HugeTLB shadow stack page
 fault
Message-ID: <20180711091022.GT2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-15-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710222639.8241-15-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:26:26PM -0700, Yu-cheng Yu wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index a2695dbc0418..f7c46d61eaea 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4108,7 +4108,13 @@ static int __handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  			if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
>  				return do_huge_pmd_numa_page(&vmf, orig_pmd);
>  
> -			if (dirty && !pmd_write(orig_pmd)) {
> +			/*
> +			 * Shadow stack trans huge PMDs are copy-on-access,
> +			 * so wp_huge_pmd() on them no mater if we have a
> +			 * write fault or not.
> +			 */
> +			if (is_shstk_mapping(vma->vm_flags) ||
> +			    (dirty && !pmd_write(orig_pmd))) {
>  				ret = wp_huge_pmd(&vmf, orig_pmd);
>  				if (!(ret & VM_FAULT_FALLBACK))
>  					return ret;

Can't we do this (and the do_wp_page thing) by setting FAULT_FLAG_WRITE
in the arch fault handler on shadow stack faults?
