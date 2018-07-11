Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A7DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9296F20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M83ermzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9296F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeGKPgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:36:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52296 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbeGKPgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=00wyPXl4xTf1IEolDKvFrSPBu+GzAssGPGCBgzCbyEc=; b=M83ermzmqI0y0Iqh/p3tlRlo9z
        y9UaIXnFJbaJaM/mEnVL6V8cnRV6kDswOXAcd7oslIUuon9kP1D9n7iAZXe11jrVsg+DbKDZPq04y
        rtw11LaOAbMQEd76ZnsPtxQ628hOXz4lIodeqePIo7VGGPuXCNnP8YzrctaQeyL4BNJIYJj13L2Pw
        eFN71bFj7rlRFgTjdE5acNClR0f3X8SZzh4BdbJpFJlwXiBlcgAJQQcBEigbwgiUd6pVlSUcV3mv5
        5OatjyVaV3/4jobJrzvn0HQ+0l9VdMonP4EqLdVhJAUHUmv/6eNpYMIOBjoZSHY1fwLwxnOvd+Nh9
        +H12pALA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdH4p-0003wY-Bi; Wed, 11 Jul 2018 15:30:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF58A20297EAB; Wed, 11 Jul 2018 17:30:44 +0200 (CEST)
Date:   Wed, 11 Jul 2018 17:30:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 18/27] x86/cet/shstk: Introduce WRUSS instruction
Message-ID: <20180711153044.GK2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-19-yu-cheng.yu@intel.com>
 <20180711094448.GZ2476@hirez.programming.kicks-ass.net>
 <1531321615.13297.9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531321615.13297.9.camel@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:06:55AM -0700, Yu-cheng Yu wrote:
> On Wed, 2018-07-11 at 11:44 +0200, Peter Zijlstra wrote:

> > What happened to:
> > 
> >   https://lkml.kernel.org/r/1528729376.4526.0.camel@2b52.sc.intel.com
> 
> Yes, I put that in once and realized we only need to skip the
> instruction and return err.  Do you think we still need a handler for
> that?

I find that other form more readable, but then there's Nadav doing asm
macros to shrink inline asm thingies so maybe he has another suggestion.
