Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF31C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057D2240F1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057D2240F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeGEKXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:23:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51495 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753317AbeGEKXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:23:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41Lv7r3Lptz9ttS1;
        Thu,  5 Jul 2018 12:23:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id btNar2wGZxeY; Thu,  5 Jul 2018 12:23:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41Lv7r2cDfz9ttBx;
        Thu,  5 Jul 2018 12:23:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF59E8B897;
        Thu,  5 Jul 2018 12:23:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R6m_1W6ppBel; Thu,  5 Jul 2018 12:23:05 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DC1A8B88B;
        Thu,  5 Jul 2018 12:23:05 +0200 (CEST)
Subject: Re: [PATCH v3 02/11] hugetlb: Introduce generic version of
 hugetlb_free_pgd_range
To:     Alexandre Ghiti <alex@ghiti.fr>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20180705051640.790-1-alex@ghiti.fr>
 <20180705051640.790-3-alex@ghiti.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <005bf713-fb51-bf29-5f86-6f244cd49f35@c-s.fr>
Date:   Thu, 5 Jul 2018 10:22:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180705051640.790-3-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2018 05:16 AM, Alexandre Ghiti wrote:
> arm, arm64, mips, parisc, sh, x86 architectures use the
> same version of hugetlb_free_pgd_range, so move this generic
> implementation into asm-generic/hugetlb.h.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Build failure on mpc885_ads_defconfig

   CC      arch/powerpc/kernel/setup-common.o
In file included from arch/powerpc/kernel/setup-common.c:37:
./include/linux/hugetlb.h:191:65: error: expected identifier or '(' 
before '{' token
  #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) 
({BUG(); 0; })
                                                                  ^
./include/asm-generic/hugetlb.h:44:20: note: in expansion of macro 
'hugetlb_free_pgd_range'
  static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
                     ^~~~~~~~~~~~~~~~~~~~~~

see below

> ---
>   arch/arm/include/asm/hugetlb.h     | 12 ++----------
>   arch/arm64/include/asm/hugetlb.h   | 10 ----------
>   arch/ia64/include/asm/hugetlb.h    |  5 +++--
>   arch/mips/include/asm/hugetlb.h    | 13 ++-----------
>   arch/parisc/include/asm/hugetlb.h  | 12 ++----------
>   arch/powerpc/include/asm/hugetlb.h |  4 +++-
>   arch/sh/include/asm/hugetlb.h      | 12 ++----------
>   arch/sparc/include/asm/hugetlb.h   |  4 +++-
>   arch/x86/include/asm/hugetlb.h     | 11 ++---------
>   include/asm-generic/hugetlb.h      | 11 +++++++++++
>   10 files changed, 30 insertions(+), 64 deletions(-)
> 

[snip]

> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 3225eb6402cc..de46ee16b615 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -4,7 +4,6 @@
>   
>   #ifdef CONFIG_HUGETLB_PAGE
>   #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
>   
>   extern struct kmem_cache *hugepte_cache;
>   
> @@ -113,6 +112,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
>   void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>   #endif
>   
> +#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
>   void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>   			    unsigned long end, unsigned long floor,
>   			    unsigned long ceiling);
> @@ -193,4 +193,6 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
>   }
>   #endif /* CONFIG_HUGETLB_PAGE */
>   
> +#include <asm-generic/hugetlb.h>
> +

That include was previously inside #ifdef CONFIG_HUGETLB_PAGE.
Why put it outside ?

Christophe

