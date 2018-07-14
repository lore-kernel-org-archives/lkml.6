Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1004ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8514A208CE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ASPFh83A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8514A208CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeGNJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 05:06:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeGNJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 05:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D4UH+YSxBBsFpoWpsdR49sCjczDPjsDoe/b3ykeEbSg=; b=ASPFh83A6P0wyfA5ZSABHOd5G
        2zO4hvGtG0o3nSAY27X5ZIox46ynM+x6Y3pldiRdjZCLLro7MMJmfzHKQugKFbv37WAeLKsZ23Z1K
        e8SfE7irA4q7yc1J2Ajzk79Clk2CmzVVDHZKLampmKjJMZIA+zvSbITA0msbnDC/AlbDsyFhWPi1c
        WYiCDTJy44T1g33FlvxoN3WEGVFGu6NWbtiJiIvKY6sec8eWVH83Uziw4mOvcJIL2KG58RuLWdO55
        8DUU32v6vz6v9qiRq1HCy2ZInxRZImTrbFcV1rBxvhBHllD31pdPvpIvuzRx6wAUdx2jKm8s97yMy
        uEPYG3Y2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1feGDl-0007ff-EK; Sat, 14 Jul 2018 08:48:05 +0000
Received: by worktop (Postfix, from userid 1000)
        id 8101A6E093E; Sat, 14 Jul 2018 10:48:01 +0200 (CEST)
Date:   Sat, 14 Jul 2018 10:48:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180714084801.GB4920@worktop.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180713092153.GU2494@hirez.programming.kicks-ass.net>
 <20180713161756.GA21168@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713161756.GA21168@cmpxchg.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Johannes,

A few quick comments on first reading; I'll do a second and more
thorough reading on Monday.

On Fri, Jul 13, 2018 at 12:17:56PM -0400, Johannes Weiner wrote:
> First off, what I want to do can indeed be done without a strong link
> of a sleeping task to a CPU. We don't rely on it, and it's something I
> only figured out in v2. The important thing is not, as I previously
> thought, that CPUs are tracked independently from each other, but that
> we use potential execution threads as the baseline for potential that
> could be wasted by resource delays. Tracking CPUs independently just
> happens to do that implicitly, but it's not a requirement.

I don't follow, but I don't think I agree.

Consider the case of 2 CPUs and 2 blocked tasks. If they both blocked on
the same CPU, then only that CPU has lost potential. Whereas the only
thing that matters is the number of blocked tasks and the number of idle
CPUs.

Those two tasks can fill the two idle CPUs. Tracking per CPU just
utterly confuses the matter.
