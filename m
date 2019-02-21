Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AEB2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IuIVjhxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfBUNs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:48:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfBUNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2rPPAY8WwyxwJOXAkSPfsMtHotY7LD6OL0J+ly1aVDQ=; b=IuIVjhxZHynyB8/RHU30bh9+0
        tbxA0JHKv/qeUoq2F0WkfWR8K8UvfsU4pKUlpefkH1nAk93TD3Ndo0sAgY8BVonLXiHFfAIySTsn4
        15LmroOAtuveHRssgRsawm1Nmu+/q0WQTR5hlayOGpgaNipdw0aQ0p4/BkCPXP1D97Gv/5eN6QGDq
        wGQg+6Md5W9B9INh+UFnKQzBiViEmcnYRy5Ze26EWQWYKMEANFvehpA39z0iEPhZxHDIihEQzphgK
        XlPqRuYCLdazJedYIThbfLlr+NkeZHW9Kl8WhFHKVghun50nYt7BHNdt4TS3ciPtrmuMqX1ubbiRN
        bUZ6VpZTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwoiX-0001Er-Eb; Thu, 21 Feb 2019 13:48:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F033522BBEAF7; Thu, 21 Feb 2019 14:48:47 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:48:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: Parse comma separated list passed in clearcpuid
Message-ID: <20190221134847.GQ32494@hirez.programming.kicks-ass.net>
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

Can we also please kill the value thing entirely and only accept
strings. Having to reverse engineer the numbers is madness.

Also, wth would you want to disable XSAVE and EPB ?
