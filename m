Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF02C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ACA218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t9HAEXn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfAWRb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:31:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47348 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:31:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NHSb0A087718;
        Wed, 23 Jan 2019 17:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=5NZpbGt9tGthD9CDDy0CZNcq7WVuy+ghR2I4NRadhKY=;
 b=t9HAEXn3T7/DOG6U41IvV4tHyDUbZVm5UAxCKK/CjzJKikVnxd1By2h311WlAuWIaVLE
 GqmrmZwAnM5xxg/GQSYF88bveCRDS25W1xQCW8q2Fqn2FivxQbc+kcUff2ZYRmDqfvFx
 xQeBhFrI7Wt0SAxu4vQTgLAvpJip6W15aoGBRf414rJ/jWg+KOq/0LiVQ150UjsCgsCk
 c8lC/MlOKu0viyR1Dw4MgNO7fCceu5TAIngRtid9ufO1qnL8erjm3RlO/JPTzOLPGrP8
 i5Okr42iX8tKHXVA+3xH+tFL3dYvC5U6tCuepmENahGMdYkk/OLEAObPVZLXaNhX0OJK Sw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2q3uauubu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:31:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHVqUK025248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:31:52 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NHVqv2012793;
        Wed, 23 Jan 2019 17:31:52 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 09:31:52 -0800
Date:   Wed, 23 Jan 2019 12:31:29 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        Filippo Sironi <sironi@amazon.de>
Subject: Re: [PATCH v5 03/13] X86/KVM: Handle PFNs outside of kernel reach
 when touching GPTEs
Message-ID: <20190123173051.GH19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-4-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-4-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:03AM +0100, KarimAllah Ahmed wrote:
> From: Filippo Sironi <sironi@amazon.de>
> 
> cmpxchg_gpte() calls get_user_pages_fast() to retrieve the number of
> pages and the respective struct page to map in the kernel virtual
> address space.
> This doesn't work if get_user_pages_fast() is invoked with a userspace
> virtual address that's backed by PFNs outside of kernel reach (e.g., when
> limiting the kernel memory with mem= in the command line and using
> /dev/mem to map memory).
> 
> If get_user_pages_fast() fails, look up the VMA that back the userspace
> virtual address, compute the PFN and the physical address, and map it in
> the kernel virtual address space with memremap().
> 
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

I personally would have used some crafty goto statements to jump to
'err' label which would have
	up_read(&current->mm->mmap_sem);
	return -EFAULT;

which would be after
 154         return (ret != orig_pte);                                               

But that is bike-shedding so feel free to ignore it.

Either way:

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>


> ---
>  arch/x86/kvm/paging_tmpl.h | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> index 6bdca39..c40af67 100644
> --- a/arch/x86/kvm/paging_tmpl.h
> +++ b/arch/x86/kvm/paging_tmpl.h
> @@ -141,15 +141,35 @@ static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>  	struct page *page;
>  
>  	npages = get_user_pages_fast((unsigned long)ptep_user, 1, 1, &page);
> -	/* Check if the user is doing something meaningless. */
> -	if (unlikely(npages != 1))
> -		return -EFAULT;
> -
> -	table = kmap_atomic(page);
> -	ret = CMPXCHG(&table[index], orig_pte, new_pte);
> -	kunmap_atomic(table);
> -
> -	kvm_release_page_dirty(page);
> +	if (likely(npages == 1)) {
> +		table = kmap_atomic(page);
> +		ret = CMPXCHG(&table[index], orig_pte, new_pte);
> +		kunmap_atomic(table);
> +
> +		kvm_release_page_dirty(page);
> +	} else {
> +		struct vm_area_struct *vma;
> +		unsigned long vaddr = (unsigned long)ptep_user & PAGE_MASK;
> +		unsigned long pfn;
> +		unsigned long paddr;
> +
> +		down_read(&current->mm->mmap_sem);
> +		vma = find_vma_intersection(current->mm, vaddr, vaddr + PAGE_SIZE);
> +		if (!vma || !(vma->vm_flags & VM_PFNMAP)) {
> +			up_read(&current->mm->mmap_sem);
> +			return -EFAULT;
> +		}
> +		pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> +		paddr = pfn << PAGE_SHIFT;
> +		table = memremap(paddr, PAGE_SIZE, MEMREMAP_WB);
> +		if (!table) {
> +			up_read(&current->mm->mmap_sem);
> +			return -EFAULT;
> +		}
> +		ret = CMPXCHG(&table[index], orig_pte, new_pte);
> +		memunmap(table);
> +		up_read(&current->mm->mmap_sem);
> +	}
>  
>  	return (ret != orig_pte);
>  }
> -- 
> 2.7.4
> 
