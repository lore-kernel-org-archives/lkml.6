Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DFCC6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6F727D69
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6F727D69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935904AbeF3BfF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:35:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935556AbeF3BfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:35:04 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4FEBDCA1;
        Sat, 30 Jun 2018 01:35:03 +0000 (UTC)
Date:   Fri, 29 Jun 2018 18:35:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-Id: <20180629183501.9e30c26135f11853245c56c7@linux-foundation.org>
In-Reply-To: <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
        <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018 06:39:44 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:


And...

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 87dcf83..d61e08b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2763,6 +2763,128 @@ static int munmap_lookup_vma(struct mm_struct *mm, struct vm_area_struct **vma,
>  	return 1;
>  }
>  
> +/* Consider PUD size or 1GB mapping as large mapping */
> +#ifdef HPAGE_PUD_SIZE
> +#define LARGE_MAP_THRESH	HPAGE_PUD_SIZE
> +#else
> +#define LARGE_MAP_THRESH	(1 * 1024 * 1024 * 1024)
> +#endif

So this assumes that 32-bit machines cannot have 1GB mappings (fair
enough) and this is the sole means by which we avoid falling into the
"len >= LARGE_MAP_THRESH" codepath, which will behave very badly, at
least because for such machines, VM_DEAD is zero.

This is rather ugly and fragile.  And, I guess, explains why we can't
give all mappings this treatment: 32-bit machines can't do it.  And
we're adding a bunch of code to 32-bit kernels which will never be
executed.

I'm thinking it would be better to be much more explicit with "#ifdef
CONFIG_64BIT" in this code, rather than relying upon the above magic.

But I tend to think that the fact that we haven't solved anything on
locked vmas or on uprobed mappings is a shostopper for the whole
approach :(


