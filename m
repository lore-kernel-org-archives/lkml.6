Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166EEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE392083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GB5R82Ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE392083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeIGSA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:00:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeIGSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GxTXDdh4Z1b9dHQDGjcK3yyWb/9Z6FnzzVWV6JuvFIs=; b=GB5R82IiZgkjuTYcgaiWdArMn
        8eo2vYnUChc1OUPkhXneB7px7pbCUiCygQL17dZmsjscfrhUomrZ79fxKXL7C5bZ8STTPKpmN8bxt
        YEW2fVjqfMM/Ilyg5NmtXiZA0+BF8ZETPOo/VN738Y+zhSVNPd+yDZQ03cqHXiBR/08PCiuVt8gZ2
        EjqLSXMCx6YOli6dJ60wrKbJNkv1jpa2cLoeTlcBiqLgI315J4sLzm5MgrgoZ4QM1lyeN/nYrFwa6
        LE3wIW+czUm1HnBAggL66Pm0Hs9roYKq84t3+nh9Ymhkyc4+XJAez2PUJxQHBAEEaMr4wXU0W1TaJ
        FlT8Hrqbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyGfU-000176-NP; Fri, 07 Sep 2018 13:19:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D18220210310; Fri,  7 Sep 2018 15:19:23 +0200 (CEST)
Date:   Fri, 7 Sep 2018 15:19:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Jirka Hladky <jhladky@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jakub Ra??ek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
Message-ID: <20180907131923.GB24106@hirez.programming.kicks-ass.net>
References: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
 <20180907125649.GA3995@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907125649.GA3995@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 06:26:49PM +0530, Srikar Dronamraju wrote:

> Can you please pick
> 
> 
> 1. 69bb3230297e881c797bbc4b3dbf73514078bc9d sched/numa: Stop multiple tasks
> from moving to the cpu at the same time
> 2. dc62cfdac5e5b7a61cd8a2bd4190e80b9bb408fc sched/numa: Avoid task migration
> for small numa improvement
> 3. 76e18a67cdd9e3609716c8a074c03168734736f9 sched/numa: Pass destination cpu as
> a parameter to migrate_task_rq
> 4.  489c19b440ebdbabffe530b9a41389d0a8b315d9 sched/numa: Reset scan rate
> whenever task moves across nodes
> 5.  b7e9ae1ae3825f35cd0f38f1f0c8e91ea145bc30 sched/numa: Limit the
> conditions where scan period is reset
> 
> from https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/kernel/sched

That is not a stable tree; the whole thing is re-generated from my quilt
set every time I feel like it.

It is likely those commit ids will no longer exist in a few hours.
