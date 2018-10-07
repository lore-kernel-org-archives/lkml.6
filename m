Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE81C65C24
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05532084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05532084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeJHCIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:08:04 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60241 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJHCID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:08:03 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 671E5C0008;
        Sun,  7 Oct 2018 18:59:45 +0000 (UTC)
Subject: Re: [PATCH] hugetlb: fix ARM 3level page tables
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Luiz Capitulino <lcapitulino@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181005161722.904274-1-arnd@arndb.de>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <65728e32-d527-5f38-a93c-5a8d9cfbd492@ghiti.fr>
Date:   Sun, 7 Oct 2018 18:59:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181005161722.904274-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnd, this change intervened in v5, that seemed straightforward 
enough...Sorry about that, and thanks for your fix.

Alex


On 10/05/2018 04:16 PM, Arnd Bergmann wrote:
> The check for __HAVE_ARCH_HUGE_PTEP_GET comes before the definition,
> leading to an extraneous definition of huge_ptep_get:
>
> In file included from arch/arm/include/asm/hugetlb.h:28,
>                   from include/linux/hugetlb.h:456,
>                   from arch/arm/kvm/../../../virt/kvm/arm/mmu.c:22:
> arch/arm/include/asm/hugetlb-3level.h:33:21: error: redefinition of 'huge_ptep_get'
>   static inline pte_t huge_ptep_get(pte_t *ptep)
>
> Change the header file inclusions to be in the correct order for
> this to work.
>
> Fixes: bb1d18ffc7ae ("hugetlb: introduce generic version of huge_ptep_get")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/include/asm/hugetlb.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
> index 3fcef21ff2c2..b67256c22b08 100644
> --- a/arch/arm/include/asm/hugetlb.h
> +++ b/arch/arm/include/asm/hugetlb.h
> @@ -23,9 +23,8 @@
>   #define _ASM_ARM_HUGETLB_H
>   
>   #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
> -
>   #include <asm/hugetlb-3level.h>
> +#include <asm-generic/hugetlb.h>
>   
>   static inline int is_hugepage_only_range(struct mm_struct *mm,
>   					 unsigned long addr, unsigned long len)

