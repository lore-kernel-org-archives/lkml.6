Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41156C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20AA21775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rPbgCg6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20AA21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHCRWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:22:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43386 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbeHCRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5CckWVZ19mDRE+nb+m1P6u23lkBWNktRwYY1E7pcs1k=; b=rPbgCg6UoHdI3KtsCw+v6XDGy
        kuqWNuerOEG33hAdSf/obPdAXTkqNK8k6NismfnZMpPeTLlc32uJ00EOAUE1H612y6ceJXTbcl0cF
        c+ySACnS1HsCTYwcnMPfodJpcr//zeyyG8VjwIAMDWpD0qpHlH1TqXESZBk3h0nuyrMIFKdOc+osY
        UmeUMSiODZm5f5Spso8EbwNNbl13T+9dRCxqXTDuI8tLtBKLm6NztibINXJ6YObAmbw7XIfrwuT+m
        vUQDK8fmoEDKTYHXdlQzCUyHnVonuPuZ+lo0rcM8COK6ThzOmZmJRCmYhn8p1wvWaQG3GopmA3A7O
        1oOOatKuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flbxF-0006yt-0L; Fri, 03 Aug 2018 15:25:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A19AC20268265; Fri,  3 Aug 2018 17:25:23 +0200 (CEST)
Date:   Fri, 3 Aug 2018 17:25:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180803152523.GY2476@hirez.programming.kicks-ass.net>
References: <20180802161823.GJ2458@hirez.programming.kicks-ass.net>
 <f990df31-ab75-974e-b142-47af07a33a08@intel.com>
 <20180802173727.GP2494@hirez.programming.kicks-ass.net>
 <653e874f-5e77-a9b5-996a-ed9daa3c6d43@intel.com>
 <20180802195410.GR2494@hirez.programming.kicks-ass.net>
 <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
 <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 08:18:09AM -0700, Reinette Chatre wrote:
> You state that you understand what we are trying to do and I hope that I
> convinced you that we are not able to accomplish the same by following
> your guidance.

No, I said I understood your pmc reserve patch and its implications.

I have no clue what you're trying to do with resctl, nor why you think
this is not feasible with perf. And if it really is not feasible, you'll
have to live without it.
