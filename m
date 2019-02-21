Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7505C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C9E2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sKTb2zMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfBUNhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:37:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUNhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NpcwRPiUBsDTC6WNdOOEbdvIamRDbsI3Cs5FT6037R8=; b=sKTb2zMH+dfxctWPPWpR688XG
        mqopdVXZ9O38IK/NurCTVcomtPrLltsxwM2s0Fovr/Ma4AxUi9BiufcItxFOh+IAzCmTJ4e9BD5MT
        i/9lTb/y9pltS6JU7kirEYzWlIFlicaBi8F49ifSSR9mgfnpHt5hT9IgiE4BUTGa4gTmaQLfFmCBh
        esWCHGuM/g81Y4yMwBLzINqQ+5iOL2eD/91svq7i8ICFUtd93V6xqVIcAsWdSeWP1sAlYBm7JwEL7
        2ReQbGlADfasbSi1gRZ4WAsoBCpV9EJjMILQR5syTAJbvQ9KlFNwP0rvGrnowcSGa1AVJxwonIf+I
        UhaHhHZEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwoXr-00015i-Cm; Thu, 21 Feb 2019 13:37:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CADF92030EE5E; Thu, 21 Feb 2019 14:37:45 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:37:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: Parse comma separated list passed in clearcpuid
Message-ID: <20190221133745.GP32494@hirez.programming.kicks-ass.net>
References: <20190221131225.22063-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221131225.22063-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 08:12:25AM -0500, Prarit Bhargava wrote:
> Users cannot disable multiple CPU features with the kernel parameter
> clearcpuid=.  For example, "clearcpuid=154 clearcpuid=227" only disables
> CPUID bit 154.
> 
> Previous to commit 0c2a3913d6f5 ("x86/fpu: Parse clearcpuid= as early XSAVE
> argument") it was possible to pass multiple clearcpuid options as kernel
> parameters using individual entries.  With the new code it isn't easy to
> replicate exactly that behaviour but a comma separated list can be easily
> implemented, eg) "clearcpuid=154,227"
> 
> Make the clearcpuid parse a comma-separated list of values instead of only
> a single value.

So I think the feature is broken as is; because it doesn't clear the
CPUID bits for userspace.

something along the lines of:

https://lkml.kernel.org/r/20190212164833.GK32494@hirez.programming.kicks-ass.net

would be required to make it so.

