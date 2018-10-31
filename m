Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B5AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3962054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OpJ8Bz2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3962054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJaSId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:08:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34670 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJaSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HFdRiotsZPgF4qiPJpcnOuxOYwo8hghVuCSCnAayKTw=; b=OpJ8Bz2gJW3qCAIynQBZGmexu
        Fcn33YPpIhvE1K5OI5oXO77d6nT9ZQ7/O0xbMY2H30bDFuYK9ijwHJdomKxvDqSg4gJLxi2ryNS90
        nK7fcfjxiVK57QdqeR61VMpBapsMrYpBnyDrwan/bTP0lgn29vUiT9Xb4DGgalwDCt56MgGMOBvMB
        MIDPAO1eyfvFAljBuMXLk9czrEbIJFbUkiPTx4omJxkcFeizNVMXlI1Dt6iR2ZZ5O8K9bh8dYuTXM
        JbBKEFUImT+Hbk+6utvPvtzg4N7lDFeeaa/4YE+IRKy0yWf1CYdPr2MF8ixCnx4tFpyJpH4GAiX+K
        Tw5X/2xnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHmWY-0002Og-Fg; Wed, 31 Oct 2018 09:10:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC84D2029FA14; Wed, 31 Oct 2018 10:10:48 +0100 (CET)
Date:   Wed, 31 Oct 2018 10:10:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] prmem: pratomic-long
Message-ID: <20181031091048.GH744@hirez.programming.kicks-ass.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-17-igor.stoppa@huawei.com>
 <20181025001312.GA3159@worktop.c.hoisthospitality.com>
 <806bfff0-8d62-9918-480d-ec791b93841e@gmail.com>
 <20181030155841.GF8177@hirez.programming.kicks-ass.net>
 <20181030162815.GB20827@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030162815.GB20827@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 04:28:16PM +0000, Will Deacon wrote:
> On Tue, Oct 30, 2018 at 04:58:41PM +0100, Peter Zijlstra wrote:
> > Like mentioned elsewhere; if you do write_enable() + write_disable()
> > thingies, it all becomes:
> > 
> > 	write_enable();
> > 	atomic_foo(&bar);
> > 	write_disable();
> > 
> > No magic gunk infested duplication at all. Of course, ideally you'd then
> > teach objtool about this (or a GCC plugin I suppose) to ensure any
> > enable reached a disable.
> 
> Isn't the issue here that we don't want to change the page tables for the
> mapping of &bar, but instead want to create a temporary writable alias
> at a random virtual address?
> 
> So you'd want:
> 
> 	wbar = write_enable(&bar);
> 	atomic_foo(wbar);
> 	write_disable(wbar);
> 
> which is probably better expressed as a map/unmap API. I suspect this
> would also be the only way to do things for cmpxchg() loops, where you
> want to create the mapping outside of the loop to minimise your time in
> the critical section.

Ah, so I was thikning that the altnerative mm would have stuff in the
same location, just RW instead of RO.

But yes, if we, like Andy suggets, use the userspace address range for
the aliases, then we need to do as you suggest.

