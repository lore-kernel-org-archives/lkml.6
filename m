Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C28C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DA22089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c0bBAjgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DA22089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJBQhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:37:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50534 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJBQhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n2LK6DxCheOvFoUE8OkdbDiS0ZORr4/c7fVOUMGpG9A=; b=c0bBAjgRJf8UkDrRSnJtjj/j+
        Ekq5zyqj8O3zyUaJlEe8F042Hpak7UA+X5GJemrKxqEAOf0Hy0/q1sy3uhIm/DC8XssRTfNSQrvTp
        cFp8tXFQadPm4+F4SAqqOCAXyN1xRJvr8NGadTfmjgHJmTdFEpmxxa6WwX5m0TzPY7a89zE+S617R
        ws66s1KAmRlmMxYPGMz5hnPZeSBDO3OqfjgHCTCLrdBckEq758lkt2VWLbzoNIpNPC+qFf5wKMMI8
        X/SSbjoRy8AlJRQAypEE9KutJcV0Fj2WffKmKUGGxFROR93mn++CRgyDzko08GEN6BGyykmi+RxsN
        +v4gEqoPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7HNu-00045d-Rd; Tue, 02 Oct 2018 09:54:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6015D202B9CBA; Tue,  2 Oct 2018 11:54:29 +0200 (CEST)
Date:   Tue, 2 Oct 2018 11:54:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        tglx@linutronix.de, luto@kernel.org, jannh@google.com,
        x86@kernel.org
Subject: Re: [PATCH 0/8] [v2] x86/mm: page fault handling cleanups
Message-ID: <20181002095429.GW3439@hirez.programming.kicks-ass.net>
References: <20180928160219.3402F0AA@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928160219.3402F0AA@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 09:02:19AM -0700, Dave Hansen wrote:
> Changes from v1:
>  * Take "space_" out of do_kern/user_addr_fault()
>  * Make "bad fault" comment in do_kern_addr_fault() less scary
>  * Add clarifying comment for the conditions under which 
>    do_kern_addr_fault() is called.
>  * Remove mention of hw_error_code in search_exception_tables()
>    comment.
>  * Clarify that the exception tables spell out individual
>    instructions, not larger sections of code.
>  * Use PAGE_MASK in is_vsyscall_vaddr()
>  * Add some additional reasoning behind the code move when
>    moving the vsyscall handling to user address space handler
>  * Remove hard-coded ~0xfff and replace with PAGE_MASK
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
