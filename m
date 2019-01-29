Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A44C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4972175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfA2APM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:15:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA2APL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:15:11 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CA9DD254A;
        Tue, 29 Jan 2019 00:15:10 +0000 (UTC)
Date:   Mon, 28 Jan 2019 16:15:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sandeep Patil <sspatil@android.com>
Cc:     vbabka@suse.cz, adobriyan@gmail.com, avagin@openvz.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@android.com, dancol@google.com
Subject: Re: [PATCH] mm: proc: smaps_rollup: Fix pss_locked calculation
Message-Id: <20190128161509.5085cacf939463f1c22e0550@linux-foundation.org>
In-Reply-To: <20190121011049.160505-1-sspatil@android.com>
References: <20190121011049.160505-1-sspatil@android.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2019 17:10:49 -0800 Sandeep Patil <sspatil@android.com> wrote:

> The 'pss_locked' field of smaps_rollup was being calculated incorrectly
> as it accumulated the current pss everytime a locked VMA was found.
> 
> Fix that by making sure we record the current pss value before each VMA
> is walked. So, we can only add the delta if the VMA was found to be
> VM_LOCKED.
> 
> ...
>
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -709,6 +709,7 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>  #endif
>  		.mm = vma->vm_mm,
>  	};
> +	unsigned long pss;
>  
>  	smaps_walk.private = mss;
>  
> @@ -737,11 +738,12 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>  		}
>  	}
>  #endif
> -
> +	/* record current pss so we can calculate the delta after page walk */
> +	pss = mss->pss;
>  	/* mmap_sem is held in m_start */
>  	walk_page_vma(vma, &smaps_walk);
>  	if (vma->vm_flags & VM_LOCKED)
> -		mss->pss_locked += mss->pss;
> +		mss->pss_locked += mss->pss - pss;
>  }

This seems to be a rather obscure way of accumulating
mem_size_stats.pss_locked.  Wouldn't it make more sense to do this in
smaps_account(), wherever we increment mem_size_stats.pss?

It would be a tiny bit less efficient but I think that the code cleanup
justifies such a cost?
