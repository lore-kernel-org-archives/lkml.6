Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB340C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6372E214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6372E214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJJE55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:57:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJE55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:57:57 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 602068E2;
        Tue,  9 Oct 2018 21:39:00 +0000 (UTC)
Date:   Tue, 9 Oct 2018 14:38:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-Id: <20181009143859.8b9a700b1caf4e8d1e33a723@linux-foundation.org>
In-Reply-To: <20181009201400.168705-1-joel@joelfernandes.org>
References: <20181009201400.168705-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Oct 2018 13:14:00 -0700 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Android needs to mremap large regions of memory during memory management
> related operations. The mremap system call can be really slow if THP is
> not enabled. The bottleneck is move_page_tables, which is copying each
> pte at a time, and can be really slow across a large map. Turning on THP
> may not be a viable option, and is not for us. This patch speeds up the
> performance for non-THP system by copying at the PMD level when possible.
> 
> The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> completion times drops from 160-250 millesconds to 380-400 microseconds.
> 
> Before:
> Total mremap time for 1GB data: 242321014 nanoseconds.
> Total mremap time for 1GB data: 196842467 nanoseconds.
> Total mremap time for 1GB data: 167051162 nanoseconds.
> 
> After:
> Total mremap time for 1GB data: 385781 nanoseconds.
> Total mremap time for 1GB data: 388959 nanoseconds.
> Total mremap time for 1GB data: 402813 nanoseconds.
> 
> Incase THP is enabled, the optimization is skipped. I also flush the
> tlb every time we do this optimization since I couldn't find a way to
> determine if the low-level PTEs are dirty. It is seen that the cost of
> doing so is not much compared the improvement, on both x86-64 and arm64.

Looks tasty.

> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>  		drop_rmap_locks(vma);
>  }
>  
> +bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,

I'll park this for now, shall plan to add a `static' in there then
merge it up after 4.20-rc1.



