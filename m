Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA1EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA35E20666
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPmOmm42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA35E20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeI0ORn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:17:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeI0ORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cj7KRNh9atNQpphncGWvDaQuTW0KZ7UuVq+Its9Pn7U=; b=WPmOmm42FH75ThdZM3aatjrnF
        KpkdCWUHNNUkXmiF0c3bltZsmYxLXqjRqsTh7RrjHnC4kSNlrM+hYBt3m2asK/pvGYD8QxxOk1lsa
        Z6/LBRXrhkVGmj9JYElc4Wsa4yDOgA/IgTHEj9dP0rnNnCRw7dYwDYG2kPvvdsqnwM9nmzVjqoUHU
        YWdag+BNF9VWggnjjxtC5dPUOhT/AgMEYSXjDXsr1MRejIMBIGxRh60u6m2zV3Pnbre/buOzhNc4T
        Us9zsuDD4mBBN46V1zTiS673HE8lE4EWcR6QWj70yQMdJ26jQPo+eafmr19bg6301CzZdu9zWgmcC
        HatALsaPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5RDf-0007W7-4H; Thu, 27 Sep 2018 08:00:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 449E2205FF760; Thu, 27 Sep 2018 09:59:35 +0200 (CEST)
Date:   Thu, 27 Sep 2018 09:59:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20180927075935.GA4889@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20180926205208.GA4864@andrea>
 <20180927071747.GD5254@hirez.programming.kicks-ass.net>
 <20180927074748.GA7939@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927074748.GA7939@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:47:48AM +0200, Andrea Parri wrote:
> > LKMM in particular does _NOT_ deal with mixed sized atomics _at_all_.
> 
> True, but it is nothing conceptually new to deal with: there're Cat
> models that handle mixed-size accesses, just give it time.

Sure, but until that time I must not rely on (and thus not use) LKMM for
qspinlock things.

So while your argument about coherence might be true -- I'll have to
think about it; litmus tests are out the window.
