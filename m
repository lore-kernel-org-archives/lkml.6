Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E9ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46682214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46682214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeIQNZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:25:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727073AbeIQNZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:25:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8H7wf8g133277
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 03:59:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mj7rhsevf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 03:59:14 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 17 Sep 2018 08:59:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Sep 2018 08:59:05 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8H7x4YF45023294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Sep 2018 07:59:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B4C04203F;
        Mon, 17 Sep 2018 10:58:53 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54F4442041;
        Mon, 17 Sep 2018 10:58:50 +0100 (BST)
Received: from skywalker (unknown [9.124.31.179])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 17 Sep 2018 10:58:50 +0100 (BST)
Received: (nullmailer pid 15762 invoked by uid 1000);
        Mon, 17 Sep 2018 07:59:01 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 11/24] powerpc/mm: don't use _PAGE_EXEC for calling hash_preload()
In-Reply-To: <4792a83ab79c6709d010ed4fec3b40242f46df33.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr> <4792a83ab79c6709d010ed4fec3b40242f46df33.1536692743.git.christophe.leroy@c-s.fr>
Date:   Mon, 17 Sep 2018 13:29:00 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18091707-0008-0000-0000-0000027233EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091707-0009-0000-0000-000021DA8221
Message-Id: <87workh7wb.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809170085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The 'access' parameter of hash_preload() is either 0 or _PAGE_EXEC.
> Among the two versions of hash_preload(), only the PPC64 one is
> doing something with this 'access' parameter.
>
> In order to remove the use of _PAGE_EXEC outside platform code,
> 'access' parameter is replaced by 'is_exec' which will be either
> true of false, and the PPC64 version of hash_preload() creates
> the access flag based on 'is_exec'.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 3 ++-
>  arch/powerpc/mm/mem.c           | 9 +++++----
>  arch/powerpc/mm/mmu_decl.h      | 2 +-
>  arch/powerpc/mm/pgtable_32.c    | 2 +-
>  arch/powerpc/mm/ppc_mmu_32.c    | 2 +-
>  5 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index f23a89d8e4ce..b8ce0e8cc608 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1482,7 +1482,7 @@ static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
>  #endif
>  
>  void hash_preload(struct mm_struct *mm, unsigned long ea,
> -		  unsigned long access, unsigned long trap)
> +		  bool is_exec, unsigned long trap)
>  {
>  	int hugepage_shift;
>  	unsigned long vsid;
> @@ -1490,6 +1490,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>  	pte_t *ptep;
>  	unsigned long flags;
>  	int rc, ssize, update_flags = 0;
> +	unsigned long access = _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PAGE_EXEC : 0);
>  
>  	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
>  
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 31bd9b53c358..0ba0cdb3f759 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -507,7 +507,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  	 * We don't need to worry about _PAGE_PRESENT here because we are
>  	 * called with either mm->page_table_lock held or ptl lock held
>  	 */
> -	unsigned long access, trap;
> +	unsigned long trap;
> +	bool is_exec;
>  
>  	if (radix_enabled()) {
>  		prefetch((void *)address);
> @@ -529,16 +530,16 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  	trap = current->thread.regs ? TRAP(current->thread.regs) : 0UL;
>  	switch (trap) {
>  	case 0x300:
> -		access = 0UL;
> +		is_exec = false;
>  		break;
>  	case 0x400:
> -		access = _PAGE_EXEC;
> +		is_exec = true;
>  		break;
>  	default:
>  		return;
>  	}
>  
> -	hash_preload(vma->vm_mm, address, access, trap);
> +	hash_preload(vma->vm_mm, address, is_exec, trap);
>  #endif /* CONFIG_PPC_STD_MMU */
>  #if (defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_FSL_BOOK3E)) \
>  	&& defined(CONFIG_HUGETLB_PAGE)
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index e5d779eed181..dd7f9b951d25 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -82,7 +82,7 @@ static inline void _tlbivax_bcast(unsigned long address, unsigned int pid,
>  #else /* CONFIG_PPC_MMU_NOHASH */
>  
>  extern void hash_preload(struct mm_struct *mm, unsigned long ea,
> -			 unsigned long access, unsigned long trap);
> +			 bool is_exec, unsigned long trap);
>  
>  
>  extern void _tlbie(unsigned long address);
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 0bbc7b7d8a05..01f348938328 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -261,7 +261,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
>  		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
>  #ifdef CONFIG_PPC_STD_MMU_32
>  		if (ktext)
> -			hash_preload(&init_mm, v, 0, 0x300);
> +			hash_preload(&init_mm, v, false, 0x300);
>  #endif
>  		v += PAGE_SIZE;
>  		p += PAGE_SIZE;
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index bea6c544e38f..38a793bfca37 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -163,7 +163,7 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
>   * Preload a translation in the hash table
>   */
>  void hash_preload(struct mm_struct *mm, unsigned long ea,
> -		  unsigned long access, unsigned long trap)
> +		  bool is_exec, unsigned long trap)
>  {
>  	pmd_t *pmd;
>  
> -- 
> 2.13.3

