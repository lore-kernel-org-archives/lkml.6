Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B17C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACBC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACBC20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbeGXXpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:45:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbeGXXpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:45:16 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC205DA0;
        Tue, 24 Jul 2018 22:36:22 +0000 (UTC)
Date:   Tue, 24 Jul 2018 15:36:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, viro@zeniv.linux.org.uk, hughd@google.com,
        mhocko@suse.com, ross.zwisler@linux.intel.com,
        zi.yan@cs.rutgers.edu, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, riel@redhat.com, pasha.tatashin@oracle.com,
        jschoenh@amazon.de, kstewart@linuxfoundation.org,
        rientjes@google.com, tglx@linutronix.de, peterz@infradead.org,
        mgorman@suse.de, yang.s@alibaba-inc.com, minchan@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Change return type int to vm_fault_t for fault
 handlers
Message-Id: <20180724153621.e7eed7faa1d265eee73a7031@linux-foundation.org>
In-Reply-To: <20180604171727.GA20279@jordon-HP-15-Notebook-PC>
References: <20180604171727.GA20279@jordon-HP-15-Notebook-PC>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018 22:47:27 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> The aim is to change the return type of finish_fault()
> and handle_mm_fault() to vm_fault_t type. As part of
> that clean up return type of all other recursively called
> functions have been changed to vm_fault_t type.
> 
> The places from where handle_mm_fault() is getting invoked
> will be change to vm_fault_t type but in a separate patch.
> 
> vmf_error() is the newly introduce inline function
> in 4.17-rc6.

Looks OK.

For some reason the shmem.c changes are already present.

One incidental fixup:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-change-return-type-int-to-vm_fault_t-for-fault-handlers-fix

don't shadow outer local `ret' in __do_huge_pmd_anonymous_page()

--- a/mm/huge_memory.c~mm-change-return-type-int-to-vm_fault_t-for-fault-handlers-fix
+++ a/mm/huge_memory.c
@@ -584,15 +584,15 @@ static vm_fault_t __do_huge_pmd_anonymou
 
 		/* Deliver the page fault to userland */
 		if (userfaultfd_missing(vma)) {
-			vm_fault_t ret;
+			vm_fault_t ret2;
 
 			spin_unlock(vmf->ptl);
 			mem_cgroup_cancel_charge(page, memcg, true);
 			put_page(page);
 			pte_free(vma->vm_mm, pgtable);
-			ret = handle_userfault(vmf, VM_UFFD_MISSING);
-			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
-			return ret;
+			ret2 = handle_userfault(vmf, VM_UFFD_MISSING);
+			VM_BUG_ON(ret2 & VM_FAULT_FALLBACK);
+			return ret2;
 		}
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);

