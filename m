Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC0EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5CE21AA5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5CE21AA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753661AbeGEKtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:49:06 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46367 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbeGEKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:49:04 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9C159E0002;
        Thu,  5 Jul 2018 10:48:53 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 02/11] hugetlb: Introduce generic version of
 hugetlb_free_pgd_range
References: <20180705051640.790-1-alex@ghiti.fr>
 <20180705051640.790-3-alex@ghiti.fr>
 <005bf713-fb51-bf29-5f86-6f244cd49f35@c-s.fr>
Message-ID: <bd8ee99c-a89b-c114-9b0e-8e36601c50c6@ghiti.fr>
Date:   Thu, 5 Jul 2018 10:48:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <005bf713-fb51-bf29-5f86-6f244cd49f35@c-s.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My bad, when I moved the #include <asm-generic/hugeltb.h> at the bottom 
of the file, I did not pay attention to that #ifdef.
I'm going to fix powerpc and check other architectures if I did not make 
the same mistake.
I'll send a v4 as soon as possible.

Thanks for your comment,

Alex

On 07/05/2018 10:22 AM, Christophe Leroy wrote:
>
>
> On 07/05/2018 05:16 AM, Alexandre Ghiti wrote:
>> arm, arm64, mips, parisc, sh, x86 architectures use the
>> same version of hugetlb_free_pgd_range, so move this generic
>> implementation into asm-generic/hugetlb.h.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>
> Build failure on mpc885_ads_defconfig
>
>   CC      arch/powerpc/kernel/setup-common.o
> In file included from arch/powerpc/kernel/setup-common.c:37:
> ./include/linux/hugetlb.h:191:65: error: expected identifier or '(' 
> before '{' token
>  #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) 
> ({BUG(); 0; })
>                                                                  ^
> ./include/asm-generic/hugetlb.h:44:20: note: in expansion of macro 
> 'hugetlb_free_pgd_range'
>  static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>                     ^~~~~~~~~~~~~~~~~~~~~~
>
> see below
>
>> ---
>>   arch/arm/include/asm/hugetlb.h     | 12 ++----------
>>   arch/arm64/include/asm/hugetlb.h   | 10 ----------
>>   arch/ia64/include/asm/hugetlb.h    |  5 +++--
>>   arch/mips/include/asm/hugetlb.h    | 13 ++-----------
>>   arch/parisc/include/asm/hugetlb.h  | 12 ++----------
>>   arch/powerpc/include/asm/hugetlb.h |  4 +++-
>>   arch/sh/include/asm/hugetlb.h      | 12 ++----------
>>   arch/sparc/include/asm/hugetlb.h   |  4 +++-
>>   arch/x86/include/asm/hugetlb.h     | 11 ++---------
>>   include/asm-generic/hugetlb.h      | 11 +++++++++++
>>   10 files changed, 30 insertions(+), 64 deletions(-)
>>
>
> [snip]
>
>> diff --git a/arch/powerpc/include/asm/hugetlb.h 
>> b/arch/powerpc/include/asm/hugetlb.h
>> index 3225eb6402cc..de46ee16b615 100644
>> --- a/arch/powerpc/include/asm/hugetlb.h
>> +++ b/arch/powerpc/include/asm/hugetlb.h
>> @@ -4,7 +4,6 @@
>>     #ifdef CONFIG_HUGETLB_PAGE
>>   #include <asm/page.h>
>> -#include <asm-generic/hugetlb.h>
>>     extern struct kmem_cache *hugepte_cache;
>>   @@ -113,6 +112,7 @@ static inline void flush_hugetlb_page(struct 
>> vm_area_struct *vma,
>>   void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long 
>> vmaddr);
>>   #endif
>>   +#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
>>   void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long 
>> addr,
>>                   unsigned long end, unsigned long floor,
>>                   unsigned long ceiling);
>> @@ -193,4 +193,6 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, 
>> unsigned long addr,
>>   }
>>   #endif /* CONFIG_HUGETLB_PAGE */
>>   +#include <asm-generic/hugetlb.h>
>> +
>
> That include was previously inside #ifdef CONFIG_HUGETLB_PAGE.
> Why put it outside ?
>
> Christophe
>

