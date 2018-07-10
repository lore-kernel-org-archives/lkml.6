Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94383C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E6420870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E6420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeGJBIu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:08:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeGJBIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:08:43 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9475D16;
        Tue, 10 Jul 2018 01:08:42 +0000 (UTC)
Date:   Mon, 9 Jul 2018 18:08:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, vmacache: hash addresses based on pmd
Message-Id: <20180709180841.ebfb6cf70bd8dc08b269c0d9@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1807091749150.114630@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1807091749150.114630@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 17:50:03 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> When perf profiling a wide variety of different workloads, it was found
> that vmacache_find() had higher than expected cost: up to 0.08% of cpu
> utilization in some cases.  This was found to rival other core VM
> functions such as alloc_pages_vma() with thp enabled and default
> mempolicy, and the conditionals in __get_vma_policy().
> 
> VMACACHE_HASH() determines which of the four per-task_struct slots a vma
> is cached for a particular address.  This currently depends on the pfn,
> so pfn 5212 occupies a different vmacache slot than its neighboring
> pfn 5213.
> 
> vmacache_find() iterates through all four of current's vmacache slots
> when looking up an address.  Hashing based on pfn, an address has
> ~1/VMACACHE_SIZE chance of being cached in the first vmacache slot, or
> about 25%, *if* the vma is cached.
> 
> This patch hashes an address by its pmd instead of pte to optimize for
> workloads with good spatial locality.  This results in a higher
> probability of vmas being cached in the first slot that is checked:
> normally ~70% on the same workloads instead of 25%.

Was the improvement quantifiable?

Surprised.  That little array will all be in CPU cache and that loop
should execute pretty quickly?  If it's *that* sensitive then let's zap
the no-longer-needed WARN_ON.  And we could hide all the event counting
behind some developer-only ifdef.

Did you consider LRU-sorting the array instead?
