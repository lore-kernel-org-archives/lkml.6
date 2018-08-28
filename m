Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8204DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D3720671
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D3720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeH1Qkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:40:36 -0400
Received: from foss.arm.com ([217.140.101.70]:37172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1Qkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:40:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 529CE80D;
        Tue, 28 Aug 2018 05:49:05 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B2E43F721;
        Tue, 28 Aug 2018 05:49:05 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 93BC51AE31F5; Tue, 28 Aug 2018 13:49:16 +0100 (BST)
Date:   Tue, 28 Aug 2018 13:49:16 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 03/11] arm64: pgtable: Implement p[mu]d_valid() and
 check in set_p[mu]d()
Message-ID: <20180828124915.GA26727@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-4-git-send-email-will.deacon@arm.com>
 <CA+55aFyAWyGTCzG8YtNwDdmS9TDVYoMCUYvxo0cj3V79w7hQ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyAWyGTCzG8YtNwDdmS9TDVYoMCUYvxo0cj3V79w7hQ4A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Aug 24, 2018 at 09:15:17AM -0700, Linus Torvalds wrote:
> On Fri, Aug 24, 2018 at 8:52 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Now that our walk-cache invalidation routines imply a DSB before the
> > invalidation, we no longer need one when we are clearing an entry during
> > unmap.
> 
> Do you really still need it when *setting* it?
> 
> I'm wondering if you could just remove the thing unconditionally.
> 
> Why would you need a barrier for another CPU for a mapping that is
> just being created? It's ok if they see the old lack of mapping until
> they are told about it, and that eventual "being told about it" must
> involve a data transfer already.
> 
> And I'm assuming arm doesn't cache negative page table entries, so
> there's no issue with any stale tlb.
> 
> And any other kernel thread looking at the page tables will have to
> honor the page table locking, so you don't need it for some direct
> page table lookup either.
> 
> Hmm? It seems like you shouldn't need to order the "set page directory
> entry" with anything.
> 
> But maybe there's some magic arm64 rule I'm not aware of. Maybe even
> the local TLB hardware walker isn't coherent with local stores?

Yup, you got it: it's not related to ordering of accesses by other CPUs, but
actually because the page-table walker is treated as a separate observer by
the architecture and therefore we need the DSB to push out the store to the
page-table so that the walker can see it (practically speaking, the walker
isn't guaranteed to snoop the store buffer).

For PTEs mapping user addresses, we actually don't bother with the DSB
when writing a valid entry because it's extremely unlikely that we'd get
back to userspace with the entry sitting in the store buffer. If that
*did* happen, we'd just take the fault a second time. However, if we played
that same trick for pXds, I think that:

	(a) We'd need to distinguish between user and kernel mappings
	    in set_pXd(), since we can't tolerate spurious faults on
	    kernel addresses.
	(b) We'd need to be careful about allocating page-table pages,
	    so that e.g. the walker sees zeroes for a new pgtable

We could probably achieve (a) with a software bit and (b) is a non-issue
because mm/memory.c uses smp_wmb(), which is always a DMB for us (which
will enforce the eventual ordering but doesn't necessarily publish the
stores immediately).

Will
