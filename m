Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4D6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6221020664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hKicoZ6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6221020664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeKZU1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:27:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeKZU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pLw6hUKAJnT1gRtFKi4wW88hGZ4q6/ak8OYu5BO7J3c=; b=hKicoZ6PnhZwqqlDRAhAvNSMz
        KGJsLz/u4kxCqbUmHPAiha0kvuEHt+VWKJNGCJZfB4PMPASSDJjYZa4x7PNIbpnsRStCNdlJ43QRs
        YXv2mpZgMrj7g4pastL4t+j5P/vSKBmwJt87vY+mH5Ukw/7hIqkssHQkhtNkINPvAm4zLfU8DDo8j
        gBR44D9dvc1dMBwnjuLatKeQsrpD0sycgw0RmHkz0Drsks2DBZUWdBl5cRhQepjAtLvMiuB3/R/ZJ
        YkWdfCIxR+1bjLgDlskKqKpPTm92oRQMWA/mTrz9SD00jax8oTzVIq8yLqIkIghkVmQF1lo5UTfxz
        j9LpAHYFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRDH4-0006eX-De; Mon, 26 Nov 2018 09:33:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD1F02029F87F; Mon, 26 Nov 2018 10:33:47 +0100 (CET)
Date:   Mon, 26 Nov 2018 10:33:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/atomics: build atomic headers as required
Message-ID: <20181126093347.GM2113@hirez.programming.kicks-ass.net>
References: <20181123153321.8561-1-mark.rutland@arm.com>
 <20181126084621.GL2113@hirez.programming.kicks-ass.net>
 <20181126090448.5onnooknto67tzoa@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126090448.5onnooknto67tzoa@salmiak>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:04:48AM +0000, Mark Rutland wrote:
> On Mon, Nov 26, 2018 at 09:46:21AM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 23, 2018 at 03:33:21PM +0000, Mark Rutland wrote:
> > > Andrew and Ingo report that the check-atomics.sh script is simply too
> > > slow to run for every kernel build, and it's impractical to make it
> > > faster without rewriting it in something other than shell.
> > > 
> > > Rather than committing the generated headers, let's regenerate these
> > > as-required for a pristine tree.
> > 
> > Thing is, I '_never_' have a pristine tree. Now, I would also be in a
> > position to know if something with the atomics changed, but that can't help
> > other people that never use pristine trees.
> 
> Just to be clear, regardless of whether the tree is pristine, the headers will
> be rebuilt iff their dependencies have changed. It's just that they
> *definitely* have to be built for a pristine tree.
> 
> So perhaps I just need to clarify the commit message? Or do you envisage a
> problem with that?
> 
> I've realised I missed the fallbacks and library script from the dependency
> list, so I can also fix that for v2.

Ah, ok. Yeah, maybe call that out explicitly. But that will certainly
work for me.

Thanks!
