Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424E9C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E833F20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E833F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbeGXVLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:11:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbeGXVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:11:14 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7EE63D27;
        Tue, 24 Jul 2018 20:03:09 +0000 (UTC)
Date:   Tue, 24 Jul 2018 13:03:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/3] mm: Introduce vma_init()
Message-Id: <20180724130308.bbd46afc3703af4c5e1d6868@linux-foundation.org>
In-Reply-To: <20180724121139.62570-2-kirill.shutemov@linux.intel.com>
References: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
        <20180724121139.62570-2-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 15:11:37 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> Not all VMAs allocated with vm_area_alloc(). Some of them allocated on
> stack or in data segment.
> 
> The new helper can be use to initialize VMA properly regardless where
> it was allocated.
> 
> ...
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -452,6 +452,12 @@ struct vm_operations_struct {
>  					  unsigned long addr);
>  };
>  
> +static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
> +{
> +	vma->vm_mm = mm;
> +	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +}
> +
>  struct mmu_gather;
>  struct inode;
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index a191c05e757d..1b27babc4c78 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -312,10 +312,8 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);

I'd sleep better if this became a kmem_cache_alloc() and the memset
was moved into vma_init().  A bunch of the vma_init() callers are
already doing the memset and the others risk leaving uninitialized
stack fields in the vma.

>  
> -	if (vma) {
> -		vma->vm_mm = mm;
> -		INIT_LIST_HEAD(&vma->anon_vma_chain);
> -	}
> +	if (vma)
> +		vma_init(vma, mm);
>  	return vma;
>  }

