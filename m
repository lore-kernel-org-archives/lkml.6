Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDDDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB6A2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB6A2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeGJAOE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:14:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932812AbeGJAN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:13:58 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B85F3D91;
        Tue, 10 Jul 2018 00:13:57 +0000 (UTC)
Date:   Mon, 9 Jul 2018 17:13:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel-team <kernel-team@fb.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: mm,tlb: revert 4647706ebeee?
Message-Id: <20180709171356.87d834e125f06e0cdaa72f85@linux-foundation.org>
In-Reply-To: <20180708012538.51b2c672@roar.ozlabs.ibm.com>
References: <1530896635.5350.25.camel@surriel.com>
        <20180708012538.51b2c672@roar.ozlabs.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2018 01:25:38 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> On Fri, 06 Jul 2018 13:03:55 -0400
> Rik van Riel <riel@surriel.com> wrote:
> 
> > Hello,
> > 
> > It looks like last summer, there were 2 sets of patches
> > in flight to fix the issue of simultaneous mprotect/madvise
> > calls unmapping PTEs, and some pages not being flushed from
> > the TLB before returning to userspace.
> > 
> > Minchan posted these patches:
> > 56236a59556c ("mm: refactor TLB gathering API")
> > 99baac21e458 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem")
> > 
> > Around the same time, Mel posted:
> > 4647706ebeee ("mm: always flush VMA ranges affected by zap_page_range")
> > 
> > They both appear to solve the same bug.
> > 
> > Only one of the two solutions is needed.
> > 
> > However, 4647706ebeee appears to introduce extra TLB
> > flushes - one per VMA, instead of one over the entire
> > range unmapped, and also extra flushes when there are
> > no simultaneous unmappers of the same mm.
> > 
> > For that reason, it seems like we should revert
> > 4647706ebeee and keep only Minchan's solution in
> > the kernel.
> > 
> > Am I overlooking any reason why we should not revert
> > 4647706ebeee?
> 
> Yes I think so. Discussed here recently:
> 
> https://marc.info/?l=linux-mm&m=152878780528037&w=2

Unclear if that was an ack ;)

> Actually we realized that powerpc does not implement the mmu
> gather flushing quite right so it needs a fix before this
> revert. But I propose the revert for next merge window.

Yes, I have Rik's patch for 4.19-rc1.  I added yourself, Aneesh and
Nadav to cc so you'll see it fly past.  If poss, please do get this all
tested before the time comes and let me know?


