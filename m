Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A2ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD49020673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD49020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeITXKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:10:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50388 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731448AbeITXKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:10:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 099871596;
        Thu, 20 Sep 2018 10:25:33 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.Emea.Arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A994F3F557;
        Thu, 20 Sep 2018 10:25:31 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:25:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chintan Pandya <cpandya@codeaurora.org>
Cc:     will.deacon@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        toshi.kani@hpe.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 3/3] arm64: Implement page table free interfaces
Message-ID: <20180920172527.GB18934@arrakis.emea.arm.com>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chintan,

On Wed, Jun 06, 2018 at 12:31:21PM +0530, Chintan Pandya wrote:
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8ae5d7a..65f8627 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -45,6 +45,7 @@
>  #include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
> +#include <asm/tlbflush.h>
>  
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
> @@ -977,12 +978,51 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  {
> -	return pud_none(*pud);
> +	pte_t *table;
> +	pmd_t pmd;
> +
> +	pmd = READ_ONCE(*pmdp);
> +
> +	/* No-op for empty entry and WARN_ON for valid entry */
> +	if (!pmd_present(pmd) || !pmd_table(pmd)) {
> +		VM_WARN_ON(!pmd_table(pmd));
> +		return 1;
> +	}

What's this VM_WARN_ON supposed to do here? If the pmd is 0, we trigger
it all the time. Did you actually mean something like:

		VM_WARN_ON(!pmd_none(pmd));

or pmd_present(pmd)?

Since the comment mentions empty entry, I'd rather make it explicit:

	if (pmd_none(pmd) || !pmd_table(pmd))
		VM_WARN_ON(!pmd_none(pmd));
		return 1;
	}

Similarly for the pud_free_pmd_page():

----------8<--------------------------

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 65f86271f02b..2662937ef879 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -986,8 +986,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 	pmd = READ_ONCE(*pmdp);
 
 	/* No-op for empty entry and WARN_ON for valid entry */
-	if (!pmd_present(pmd) || !pmd_table(pmd)) {
-		VM_WARN_ON(!pmd_table(pmd));
+	if (pmd_none(pmd) || !pmd_table(pmd)) {
+		VM_WARN_ON(!pmd_none(pmd));
 		return 1;
 	}
 
@@ -1008,8 +1008,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	pud = READ_ONCE(*pudp);
 
 	/* No-op for empty entry and WARN_ON for valid entry */
-	if (!pud_present(pud) || !pud_table(pud)) {
-		VM_WARN_ON(!pud_table(pud));
+	if (pud_none(pud) || !pud_table(pud)) {
+		VM_WARN_ON(!pud_none(pud));
 		return 1;
 	}
 
