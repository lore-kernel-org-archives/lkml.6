Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477DAC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2DB2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDnpSABe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2DB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeLACdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:33:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeLACdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a9hWsvR5UQDfnlobG1KzpAgarUgIlawfyd9drsnruQo=; b=HDnpSABeFQDQWzqY7MR7P0rfD
        Dz9R3cW6w3mPPFNMAKk3S2fYBeoZrz9PpruGxC0mzM5ZfgG7gMG27ZvfqvWFWmYHaN92g4QYj9Z+R
        TfZBYHKsbVGAYBInme2IORM8tcxIHTVu8UI/F+Bk7VhteveW3LyokpVEENjqQfeXQKbDfw9YJGwPz
        ZRl5+XaA+vdfaqoGRIvwp1VLcOHF3w6i9mbSmZ7zOlugTpcwhivNuV+dQUMVGyem7PGw7bZ+Igp5E
        dM6INkgTLHP+OkwqUkcLmhv/Exqbk0aWwXYK/JnNXbI14lY9Yicj7K/yowEIbEn6+AMAl9EqCpVA9
        47/fk9Wfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSkdy-0004Te-E0; Fri, 30 Nov 2018 15:23:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D780E2029F873; Fri, 30 Nov 2018 16:23:47 +0100 (CET)
Date:   Fri, 30 Nov 2018 16:23:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "StDenis, Tom" <Tom.StDenis@amd.com>
Cc:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Message-ID: <20181130152347.GB11614@hirez.programming.kicks-ass.net>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:14:30PM +0000, StDenis, Tom wrote:
> On 2018-11-30 10:09 a.m., Peter Zijlstra wrote:
> > On Fri, Nov 30, 2018 at 02:52:26PM +0000, StDenis, Tom wrote:
> >> Hi Peter,
> >>
> >> Unfortunately I can't apply this on top of our drm-next the first patch
> >> fails.
> > 
> > Against what tree would you like the patches? rebasing should not be
> > hard I think.
> > 
> 
> Actually I just tried applying against the tip of master and got the 
> same errors...
> 
> [root@carrizo linux]# git apply \[PATCH\ 1_4\]\ x86_mm_cpa\:\ Add\ 
> __cpa_addr\(\)\ helper\ -\ Peter\ Zijlstra\ \<peterz@infradead.org\>\ -\ 
> 2018-11-30\ 0844.eml
> error: patch failed: arch/x86/mm/pageattr.c:228
> error: arch/x86/mm/pageattr.c: patch does not apply
> 
> 
> Any ideas?

Hurm.. no. They apply cleanly to Linus' tree here.

linux-2.6$ git describe
v4.20-rc4-156-g94f371cb7394
linux-2.6$ quilt push 4
Applying patch patches/peterz-cpa-addr.patch
patching file arch/x86/mm/pageattr.c
Applying patch patches/peterz-cpa-fix-flush_array.patch
patching file arch/x86/mm/mm_internal.h
patching file arch/x86/mm/pageattr.c
patching file arch/x86/mm/tlb.c
Applying patch patches/peterz-cpa-fold-cpa_flush.patch
patching file arch/x86/mm/pageattr.c
Applying patch patches/peterz-cpa-clflush_opt.patch
patching file arch/x86/mm/pageattr.c
Now at patch patches/peterz-cpa-clflush_opt.patch

Weird.
