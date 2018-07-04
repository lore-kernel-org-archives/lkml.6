Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E911C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95D223D71
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95D223D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeGDRkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:40:55 -0400
Received: from foss.arm.com ([217.140.101.70]:41318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbeGDRky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:40:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4947E7A9;
        Wed,  4 Jul 2018 10:40:54 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 197973F5A0;
        Wed,  4 Jul 2018 10:40:54 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 17E0C1AE180C; Wed,  4 Jul 2018 18:41:34 +0100 (BST)
Date:   Wed, 4 Jul 2018 18:41:34 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCHv2 11/11] arm64: use instrumented atomics
Message-ID: <20180704174133.GD9668@arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-12-mark.rutland@arm.com>
 <20180704152422.GK4828@arm.com>
 <20180704163721.lxuynjd4dflcyucm@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704163721.lxuynjd4dflcyucm@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 05:37:23PM +0100, Mark Rutland wrote:
> On Wed, Jul 04, 2018 at 04:24:22PM +0100, Will Deacon wrote:
> > This is mostly straightforward, but the cmpxchg/cmpxchg_double cases grow
> > an 'arch' prefix which suggests that they're part of the API with the core
> > atomics and also makes them horribly ugly.
> 
> I agree this isn't nice.
> 
> > This just looks to be an artifact of __LL_SC_CALL pasting that in. Can
> > you drop that auto pasting of 'arch', and instead change the
> > non-cmpxchg-case callers of the macro to include the arch prefix
> > instead, please?
> 
> That leads to having an arch___llsc_ prefix in some cases, which is
> equally hideous.

Yuck, how does that come about?

> How about I remove the prefix mangling entirely, and always give
> functions an __llsc_ or __lse_ prefix. Then, unify the two in our
> atomic.h with:
> 
> #ifdef CONFIG_ARM64_LSE
> #define ATOMIC_PFX	__lse_
> #else
> #define ATOMIC_PFX	__ll_sc_
> #endif
> 
> #define arch_atomic_foo		ATOMIC_PFX##atomic_foo
> #define arch_atomic_bar		ATOMIC_PFX##atomic_bar
> 
> ... which clearly delineates the implementation from core API.
> 
> Does that sound ok to you?

Why do we need two prefixes? The only reason we throw out __ll_sc_ at the
moment is so the out-of-line atomics have a different name from the inlined
ones. What I'd like is:

	atomic_foo
	-> arch_atomic_foo
	   -> optionally calls __ll_sc_arch_atomic_foo

which I think is very similar to what we already do (i.e. the inlined macro
is always called arch_atomic_foo, regardless of lse or ll/sc).

Will
