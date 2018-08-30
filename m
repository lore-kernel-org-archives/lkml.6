Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E35C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB8420834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rj8y1i49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB8420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHaAD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:03:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaAD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g+rQpy8djYi0Iw6RI5TwjdBXdXca8lOddTytVmpYKx8=; b=Rj8y1i49574dk80BKAL+8+TJP
        I3MTT22buHOjJa/cimLape/XlGRnZspKxiq70xq0a3GT02khMAHjEGx3dIVlm0oZq53XHQCiWJtfk
        cwWvHg0FzdJYMz2sgc3dvaEMp4cNyELX5p1BZB0Ii/jhCYHhWG89IDJzSElPAar+zRZyJ5Tg8ABxl
        hDAn6szm0VVlr9dTCrpmUa0hKOlTiUElsKzyP41ss9zcEfJ0K4+IKYnmDINFwZ7VFM+oZc6tEZ5NE
        BjlWN4Ph8hcQhVLNCAGA2hb7Y2m39LvDQnJu0TZjUbkiNZlC6e8bMKeq8AifiKXIk9aFYBRtPnQV+
        tztiUcKkA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvT6B-0002oI-R2; Thu, 30 Aug 2018 19:59:23 +0000
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
 <20180830143904.3168-13-yu-cheng.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9879c17a-24da-d84a-5a7c-30bcbb473914@infradead.org>
Date:   Thu, 30 Aug 2018 12:59:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830143904.3168-13-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 07:38 AM, Yu-cheng Yu wrote:
> When Shadow Stack is enabled, the read-only and PAGE_DIRTY_HW PTE
> setting is reserved only for the Shadow Stack.  To track dirty of
> non-Shadow Stack read-only PTEs, we use PAGE_DIRTY_SW.
> 
> Update ptep_set_wrprotect() and pmdp_set_wrprotect().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/pgtable.h | 42 ++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 4d50de77ea96..556ef258eeff 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1203,7 +1203,28 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> +	pte_t pte;
> +
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> +	pte = *ptep;
> +
> +	/*
> +	 * Some processors can start a write, but ending up seeing

	                                      but end up seeing

> +	 * a read-only PTE by the time they get to the Dirty bit.
> +	 * In this case, they will set the Dirty bit, leaving a
> +	 * read-only, Dirty PTE which looks like a Shadow Stack PTE.
> +	 *
> +	 * However, this behavior has been improved and will not occur
> +	 * on processors supporting Shadow Stacks.  Without this
> +	 * guarantee, a transition to a non-present PTE and flush the
> +	 * TLB would be needed.
> +	 *
> +	 * When change a writable PTE to read-only and if the PTE has

	        changing

> +	 * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW so
> +	 * that the PTE is not a valid Shadow Stack PTE.
> +	 */
> +	pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
> +	set_pte_at(mm, addr, ptep, pte);
>  }
>  
>  #define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
> @@ -1266,7 +1287,28 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pmd_t *pmdp)
>  {
> +	pmd_t pmd;
> +
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
> +	pmd = *pmdp;
> +
> +	/*
> +	 * Some processors can start a write, but ending up seeing

	                                      but end up seeing

> +	 * a read-only PTE by the time they get to the Dirty bit.
> +	 * In this case, they will set the Dirty bit, leaving a
> +	 * read-only, Dirty PTE which looks like a Shadow Stack PTE.
> +	 *
> +	 * However, this behavior has been improved and will not occur
> +	 * on processors supporting Shadow Stacks.  Without this
> +	 * guarantee, a transition to a non-present PTE and flush the
> +	 * TLB would be needed.
> +	 *
> +	 * When change a writable PTE to read-only and if the PTE has

	        changing

> +	 * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW so
> +	 * that the PTE is not a valid Shadow Stack PTE.
> +	 */
> +	pmd = pmd_move_flags(pmd, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
> +	set_pmd_at(mm, addr, pmdp, pmd);
>  }
>  
>  #define pud_write pud_write
> 


-- 
~Randy
