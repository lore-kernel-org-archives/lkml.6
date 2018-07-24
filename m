Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D3BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1AE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sb12mDPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1AE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbeGXKR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:17:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeGXKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wOiRh1ff9YmaShJ9T6oN+CB7lWmVIT2sjH0+Bfp891c=; b=Sb12mDPk+bXT77yhfp2Xfh8Ou
        +V3xrAnl/LfAXnIe2w/9BNdKsEB/t0UIcB74qQWGxISUbGKqH0ktPnYgUi8sqp2ZIIn7uZc9VoZis
        loRQ5cbkpiJvVx9cvGvzDZ6+LHziqfGXGTcyT2A65Ye8aELd2O9LiqjqhFny0vduUsn3C4smKw9CJ
        GbI2h/jFUVgQE2a4Z2IX3kk2SpuNG5J3qWuP1T+yEwOTXVQ61+vWdb5hdwbMpbD7ed3yDDJoHfdgQ
        4eGaS/PEf0A5IOKbD4F80Hb2s4hwZFaVyAks/H/KOjYVulBUKkdg60sA0uOYx99Cwx/YmFN4NECo+
        XOm5tQUKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhtMp-0007pv-3h; Tue, 24 Jul 2018 09:12:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9735720268330; Tue, 24 Jul 2018 11:12:25 +0200 (CEST)
Date:   Tue, 24 Jul 2018 11:12:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] perf/core: fix a possible deadlock scenario
Message-ID: <20180724091225.GL2494@hirez.programming.kicks-ass.net>
References: <20180719132834.GF18667@krava>
 <20180719191253.3843-1-xiyou.wangcong@gmail.com>
 <20180720115217.GQ2494@hirez.programming.kicks-ass.net>
 <CAM_iQpWVhLZKo9j6COGkvryGrxJq6sEXzh2S-ikza2H3=pAyqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpWVhLZKo9j6COGkvryGrxJq6sEXzh2S-ikza2H3=pAyqw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:16:23PM -0700, Cong Wang wrote:

> > > +#define PERF_EF_NO_WAIT      0x08            /* do not wait when stopping, for
> > > +                                      * example, waiting for a timer
> > > +                                      */
> >
> > That's a broken comment style.
> 
> It is picked by checkpatch.pl, not me, I chose a different one and got
> a complain. :)

Ignore checkpatch when it's wrong ;-)
