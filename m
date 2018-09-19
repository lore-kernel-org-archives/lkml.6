Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A637ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70532150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70532150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeISSCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:02:02 -0400
Received: from foss.arm.com ([217.140.101.70]:58400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeISSCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:02:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD6FD7A9;
        Wed, 19 Sep 2018 05:24:20 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F7403F5BD;
        Wed, 19 Sep 2018 05:24:20 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CDDD61AE3029; Wed, 19 Sep 2018 13:24:39 +0100 (BST)
Date:   Wed, 19 Sep 2018 13:24:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 07/11] arm/tlb: Convert to generic mmu_gather
Message-ID: <20180919122439.GC22723@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.247989787@infradead.org>
 <20180918141034.GF16498@arm.com>
 <20180919112829.GA24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919112829.GA24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:28:29PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 18, 2018 at 03:10:34PM +0100, Will Deacon wrote:
> 
> > So whilst I was reviewing this, I realised that I think we should be
> > selecting HAVE_RCU_TABLE_INVALIDATE for arch/arm/ if HAVE_RCU_TABLE_FREE.
> 
> Yes very much so. Let me invert that option, you normally want that,
> except if you don't natively use the linux page-tables.

Yeah, inverting this to be opt-out is definitely the safe thing to do.
Patch below looks good:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> ---
> Subject: asm-generic/tlb: Invert HAVE_RCU_TABLE_INVALIDATE
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Sep 19 13:24:41 CEST 2018
> 
> Make issuing a TLB invalidate for page-table pages the normal case.
> 
> The reason is twofold:
> 
>  - too many invalidates is safer than too few,
>  - most architectures use the linux page-tables natively
>    and would this require this.
> 
> Make it an opt-out, instead of an opt-in.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
