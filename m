Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C02CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9F1208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9F1208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeGJUtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:49:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeGJUtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:49:46 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A324D4D;
        Tue, 10 Jul 2018 20:48:59 +0000 (UTC)
Date:   Tue, 10 Jul 2018 13:48:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Fix vma_is_anonymous() false-positives
Message-Id: <20180710134858.3506f097104859b533c81bf3@linux-foundation.org>
In-Reply-To: <20180710134821.84709-2-kirill.shutemov@linux.intel.com>
References: <20180710134821.84709-1-kirill.shutemov@linux.intel.com>
        <20180710134821.84709-2-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 16:48:20 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> vma_is_anonymous() relies on ->vm_ops being NULL to detect anonymous
> VMA. This is unreliable as ->mmap may not set ->vm_ops.
> 
> False-positive vma_is_anonymous() may lead to crashes:
> 
> ...
> 
> This can be fixed by assigning anonymous VMAs own vm_ops and not relying
> on it being NULL.
> 
> If ->mmap() failed to set ->vm_ops, mmap_region() will set it to
> dummy_vm_ops. This way we will have non-NULL ->vm_ops for all VMAs.

Is there a smaller, simpler fix which we can use for backporting
purposes and save the larger rework for development kernels?

>
> ...
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -71,6 +71,9 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
>  static bool ignore_rlimit_data;
>  core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
>  
> +const struct vm_operations_struct anon_vm_ops = {};
> +const struct vm_operations_struct dummy_vm_ops = {};

Some nice comments here would be useful.  Especially for dummy_vm_ops. 
Why does it exist, what is its role, etc.

>  static void unmap_region(struct mm_struct *mm,
>  		struct vm_area_struct *vma, struct vm_area_struct *prev,
>  		unsigned long start, unsigned long end);
> @@ -561,6 +564,8 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
>  void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
>  		struct rb_node **rb_link, struct rb_node *rb_parent)
>  {
> +	WARN_ONCE(!vma->vm_ops, "missing vma->vm_ops");
> +
>  	/* Update tracking information for the gap following the new vma. */
>  	if (vma->vm_next)
>  		vma_gap_update(vma->vm_next);
> @@ -1774,12 +1779,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 */
>  		WARN_ON_ONCE(addr != vma->vm_start);
>  
> +		/* All mappings must have ->vm_ops set */
> +		if (!vma->vm_ops)
> +			vma->vm_ops = &dummy_vm_ops;

Can this happen?  Can we make it a rule that file_operations.mmap(vma)
must initialize vma->vm_ops?  Should we have a WARN here to detect when
the fs implementation failed to do that?

>  		addr = vma->vm_start;
>  		vm_flags = vma->vm_flags;
>  	} else if (vm_flags & VM_SHARED) {
>  		error = shmem_zero_setup(vma);
>  		if (error)
>  			goto free_vma;
> +	} else {
> +		/* vma_is_anonymous() relies on this. */
> +		vma->vm_ops = &anon_vm_ops;
>  	}
>  
>  	vma_link(mm, vma, prev, rb_link, rb_parent);
> ...
>
