Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E59C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00B720652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkTYU9pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00B720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeIGM0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:26:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeIGM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IrCg6O00xZRMFaVwDmDS6t28bHlDyx1+bPOmmLA2wEQ=; b=UkTYU9pq6D3tYcNU1JPANxfmw
        8BGqo5HN0TOLbKq0qIXKkoIa7mohaADXtRJrXr80zw2chhl/ouYx/Efsphp6tMdPxaMqZUnT4gsGu
        Ec2HBDkVNlevi84GcG/Ce05ExJaGwwx2QkIhF3FZSND2kVbfwXs4WKeV+/V6+PJFMcZI6PijSikXP
        Z/gTElwjAEgf4toGfJYk4LeilVLPfjKybFwDSa1WX1OG0m6mgi1P+Y7iW6cRrW4W/BBUomCvlwoRU
        7Cf13TIZt31oO2UWrH6cG6ot52cXYVn2cutpLhfSB9/0VkBFZWBFd8jtNRttJZBqz6K92aaHviM3d
        uZc22//Bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyBTX-0007og-BO; Fri, 07 Sep 2018 07:46:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 566C820210310; Fri,  7 Sep 2018 09:46:42 +0200 (CEST)
Date:   Fri, 7 Sep 2018 09:46:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
Message-ID: <20180907074642.GN24106@hirez.programming.kicks-ass.net>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180905214303.GA30178@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905214303.GA30178@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 05:43:03PM -0400, Johannes Weiner wrote:
> On Tue, Aug 28, 2018 at 01:22:49PM -0400, Johannes Weiner wrote:
> > This version 4 of the PSI series incorporates feedback from Peter and
> > fixes two races in the lockless aggregator that Suren found in his
> > testing and which caused the sample calculation to sometimes underflow
> > and record bogusly large samples; details at the bottom of this email.
> 
> Peter, do the changes from v3 look sane to you?

I'll go have a look.
