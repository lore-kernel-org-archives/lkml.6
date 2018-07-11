Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB1C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD96320C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD96320C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbeGKXRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:17:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbeGKXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:17:07 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 343E5DB6;
        Wed, 11 Jul 2018 23:10:31 +0000 (UTC)
Date:   Wed, 11 Jul 2018 16:10:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, vmacache: hash addresses based on pmd
Message-Id: <20180711161030.b5ae2f5b1210150c13b1a832@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1807091822460.130281@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1807091749150.114630@chino.kir.corp.google.com>
        <20180709180841.ebfb6cf70bd8dc08b269c0d9@linux-foundation.org>
        <alpine.DEB.2.21.1807091822460.130281@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 18:37:37 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> > Did you consider LRU-sorting the array instead?
> > 
> 
> It adds 40 bytes to struct task_struct,

What does?  LRU sort?  It's a 4-entry array, just do it in place, like
bh_lru_install(). Confused.

> but I'm not sure the least 
> recently used is the first preferred check.  If I do 
> madvise(MADV_DONTNEED) from a malloc implementation where I don't control 
> what is free()'d and I'm constantly freeing back to the same hugepages, 
> for example, I may always get first slot cache hits with this patch as 
> opposed to the 25% chance that the current implementation has (and perhaps 
> an lru would as well).
> 
> I'm sure that I could construct a workload where LRU would be better and 
> could show that the added footprint were worthwhile, but I could also 
> construct a workload where the current implementation based on pfn would 
> outperform all of these.  It simply turns out that on the user-controlled 
> workloads that I was profiling that hashing based on pmd was the win.

That leaves us nowhere to go.  Zapping the WARN_ON seems a no-brainer
though?
