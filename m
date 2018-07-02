Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95990C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CED224617
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CED224617
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeGBVGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:06:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeGBVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:06:40 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38895DA7;
        Mon,  2 Jul 2018 21:06:39 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:06:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCHi v2] mm: do not drop unused pages when userfaultd is
 running
Message-Id: <20180702140638.eb3edfaa611ba9fa018f92eb@linux-foundation.org>
In-Reply-To: <20180702075049.9157-1-borntraeger@de.ibm.com>
References: <20180702075049.9157-1-borntraeger@de.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Jul 2018 09:50:49 +0200 Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> KVM guests on s390 can notify the host of unused pages. This can result
> in pte_unused callbacks to be true for KVM guest memory.
> 
> If a page is unused (checked with pte_unused) we might drop this page
> instead of paging it. This can have side-effects on userfaultd, when the
> page in question was already migrated:
> 
> The next access of that page will trigger a fault and a user fault
> instead of faulting in a new and empty zero page. As QEMU does not
> expect a userfault on an already migrated page this migration will fail.
> 
> The most straightforward solution is to ignore the pte_unused hint if a
> userfault context is active for this VMA.
> 
> ...
>
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -64,6 +64,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/page_idle.h>
>  #include <linux/memremap.h>
> +#include <linux/userfaultfd_k.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -1481,7 +1482,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  			}
>  
> -		} else if (pte_unused(pteval)) {
> +		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
>  			/*
>  			 * The guest indicated that the page content is of no
>  			 * interest anymore. Simply discard the pte, vmscan

A reader of this code will wonder why we're checking
userfaultfd_armed().  So the writer of this code should add a comment
which explains this to them ;)  Please.

