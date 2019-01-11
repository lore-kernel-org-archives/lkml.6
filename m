Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFDA20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PqD6c78Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfAKKAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:00:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbfAKKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PhzhGSxYRHlvLmwZZMdaPmenRxAnGWYTex3Y7sjMuDs=; b=PqD6c78YdS8xbHUO03GaibpGt
        DGbe0D6TsvehJM/RpkEtG1+D+BTc8TVwVCsZE5a5dQuRG/80bUOQW/RlhA19+UafTf23ilH2dHCPt
        TQ3uqyfeL8hOQhwMkUfudNHri0QZWTfJGhUAL+z6s1HJGBgdr90J4tFWFCV6h9H/9GJmWSpMRh1VT
        fl6KzlOp2mBrawVy3LIdA/BPihEHkwPIqLssG2A/QcmLkTghJENnUs/fxfM20R7LUkKmXZbbN1Ocw
        jB0492irhDqIprqYNz+T+L/m7/1ECXsVoL3cB3ghO1sE0oAyi6gUn9u3HvCE/wo8zOcDePNCiIGmv
        hJ5bxwVXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghtbB-0008AV-Ox; Fri, 11 Jan 2019 09:59:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 883D7201267E1; Fri, 11 Jan 2019 10:59:32 +0100 (CET)
Date:   Fri, 11 Jan 2019 10:59:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com,
        tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, liran.alon@oracle.com,
        keescook@google.com, konrad.wilk@oracle.com,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH v7 00/16] Add support for eXclusive Page Frame
 Ownership
Message-ID: <20190111095932.GN30894@hirez.programming.kicks-ass.net>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <31fe7522-0a59-94c8-663e-049e9ad2bff6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31fe7522-0a59-94c8-663e-049e9ad2bff6@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:40:04PM -0800, Dave Hansen wrote:
> Anything else you do will have *some* reduced mitigation value, which
> isn't a deal-breaker (to me at least).  Some ideas:
> 
> Take a look at the SWITCH_TO_KERNEL_CR3 in head_64.S.  Every time that
> gets called, we've (potentially) just done a user->kernel transition and
> might benefit from flushing the TLB.  We're always doing a CR3 write (on
> Meltdown-vulnerable hardware) and it can do a full TLB flush based on if
> X86_CR3_PCID_NOFLUSH_BIT is set.  So, when you need a TLB flush, you
> would set a bit that ADJUST_KERNEL_CR3 would see on the next
> user->kernel transition on *each* CPU.  Potentially, multiple TLB
> flushes could be coalesced this way.  The downside of this is that
> you're exposed to the old TLB entries if a flush is needed while you are
> already *in* the kernel.

I would really prefer not to depend on the PTI crud for new stuff. We
really want to get rid of that code on unaffected CPUs.
