Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59617C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A0E2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="G3bymVEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBTRkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:40:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:58755 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTRkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:40:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444Pxp6Wvqz9txwN;
        Wed, 20 Feb 2019 18:39:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=G3bymVEj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QStU0W-kmL6O; Wed, 20 Feb 2019 18:39:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444Pxp5HRkz9txwM;
        Wed, 20 Feb 2019 18:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550684398; bh=9mRs0YCY5VwvK6zuu98KPe9M3xynokILGcsK+mOkqZw=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=G3bymVEjdnrauFCmW63hvS/c97w+GQ3zErfc5VLzgGwf0yzl97JDmMjtCNo+gYz5p
         mM+/X1kWcovEg1CG1ylRN2buh+PzYNuCCPFQl24BAVf5YV0jCWYUsVeCSsSLRSYM4P
         2S5WtrxyvFBQ3Gi1uxVnu5IJFcdgubPtklsAR2sk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 65F368B84F;
        Wed, 20 Feb 2019 18:40:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ifBXLgN0UUAU; Wed, 20 Feb 2019 18:40:00 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 37CBF8B84A;
        Wed, 20 Feb 2019 18:40:00 +0100 (CET)
Subject: Re: [PATCH 02/10] powerpc/603: Store PGDIR physical address in a SPRG
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        joakim.tjernlund@infinera.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
 <a805b78bc4c7c24ee061d1578e7ff7bb2746e54a.1548419273.git.christophe.leroy@c-s.fr>
Message-ID: <06894fe5-bc42-96b1-ecc3-7871422ef4e3@c-s.fr>
Date:   Wed, 20 Feb 2019 18:39:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a805b78bc4c7c24ee061d1578e7ff7bb2746e54a.1548419273.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/01/2019 à 13:34, Christophe Leroy a écrit :
> Use SPRN_SPRG5 to store the current thread PGDIR and
> avoid reading thread_struct->pgdir at every TLB miss.

I'll send out v2 with an additional patch getting rid of SPRN_SPRG_RTAS 
hence freeing SPRN_SPRG2 which I will use here instead of SPRN_SPRG5 so 
that all 6xx will benefit.

Christophe

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/reg.h      |  1 +
>   arch/powerpc/kernel/cpu_setup_6xx.S |  4 ++++
>   arch/powerpc/kernel/head_32.S       | 28 ++++++++++++++++------------
>   3 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 1c98ef1f2d5b..ba0ab1a1431b 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1169,6 +1169,7 @@
>   #define SPRN_SPRG_SCRATCH1	SPRN_SPRG1
>   #define SPRN_SPRG_RTAS		SPRN_SPRG2
>   #define SPRN_SPRG_603_LRU	SPRN_SPRG4
> +#define SPRN_SPRG_603_PGDIR	SPRN_SPRG5
>   #endif
>   
>   #ifdef CONFIG_40x
> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
> index 8c069e96c478..4c91d1f640fe 100644
> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> @@ -24,6 +24,10 @@ BEGIN_MMU_FTR_SECTION
>   	li	r10,0
>   	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
>   END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
> +	lis	r10, (swapper_pg_dir - PAGE_OFFSET)@h
> +	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
> +	mtspr	SPRN_SPRG_603_PGDIR, r10
> +
>   BEGIN_FTR_SECTION
>   	bl	__init_fpu_registers
>   END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index c2f564690778..dbd15e03952a 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -502,16 +502,15 @@ InstructionTLBMiss:
>   	mfspr	r3,SPRN_IMISS
>   	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
>   	cmplw	0,r1,r3
> -	mfspr	r2,SPRN_SPRG_THREAD
> +	mfspr	r2, SPRN_SPRG_603_PGDIR
>   	li	r1,_PAGE_USER|_PAGE_PRESENT|_PAGE_EXEC /* low addresses tested as user */
> -	lwz	r2,PGDIR(r2)
>   	bge-	112f
>   	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
>   	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
>   	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
>   	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
> -112:	tophys(r2,r2)
> -	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
> +	tophys(r2,r2)
> +112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
>   	lwz	r2,0(r2)		/* get pmd entry */
>   	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
>   	beq-	InstructionAddressInvalid	/* return if no mapping */
> @@ -576,16 +575,15 @@ DataLoadTLBMiss:
>   	mfspr	r3,SPRN_DMISS
>   	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
>   	cmplw	0,r1,r3
> -	mfspr	r2,SPRN_SPRG_THREAD
> +	mfspr	r2, SPRN_SPRG_603_PGDIR
>   	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
> -	lwz	r2,PGDIR(r2)
>   	bge-	112f
>   	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
>   	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
>   	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
>   	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
> -112:	tophys(r2,r2)
> -	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
> +	tophys(r2,r2)
> +112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
>   	lwz	r2,0(r2)		/* get pmd entry */
>   	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
>   	beq-	DataAddressInvalid	/* return if no mapping */
> @@ -660,16 +658,15 @@ DataStoreTLBMiss:
>   	mfspr	r3,SPRN_DMISS
>   	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
>   	cmplw	0,r1,r3
> -	mfspr	r2,SPRN_SPRG_THREAD
> +	mfspr	r2, SPRN_SPRG_603_PGDIR
>   	li	r1,_PAGE_RW|_PAGE_USER|_PAGE_PRESENT /* access flags */
> -	lwz	r2,PGDIR(r2)
>   	bge-	112f
>   	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
>   	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
>   	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
>   	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
> -112:	tophys(r2,r2)
> -	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
> +	tophys(r2,r2)
> +112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
>   	lwz	r2,0(r2)		/* get pmd entry */
>   	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
>   	beq-	DataAddressInvalid	/* return if no mapping */
> @@ -1030,6 +1027,13 @@ _ENTRY(switch_mmu_context)
>   	lis	r5, abatron_pteptrs@ha
>   	stw	r4, abatron_pteptrs@l + 0x4(r5)
>   #endif
> +BEGIN_MMU_FTR_SECTION
> +#ifndef CONFIG_BDI_SWITCH
> +	lwz	r4, MM_PGD(r4)
> +#endif
> +	tophys(r4, r4)
> +	mtspr	SPRN_SPRG_603_PGDIR, r4
> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_HPTE_TABLE)
>   	li	r4,0
>   	isync
>   3:
> 
