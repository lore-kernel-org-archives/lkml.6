Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F343C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289D9243E8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aeub3hYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289D9243E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeFVOqN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:46:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeFVOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aCu3YLrBQEG8gVJ26ShhjCpYlzfv0ByV0orY+NSZLAs=; b=aeub3hYuhqpECFKfNJ6KswCY/
        Z2Rt4R5BqfUae1L9bkzXh3rZTwTVARiXWXs2KwLwWpvgNXLPS0KODUUkXfhCoFRBx9Mf8NOTRmHEc
        ReHC9TY5QzMJHJmU+sYDNXMd4sJjX9SGhGxQG7U87Pif47Bwemim0l4CAH7XsWDRCK0x/wfpwbIQy
        REJQ10Fo5Iux3DehFTQPEXnJ8ZX79ZqPGEYjgk4gGKOaEpuG9WmdVitJ9A98Nn6k+XFWfaRyXYil6
        RLKIRUw7IS1na4y6P7/BiF9kyuu/EGxSpheJKpnAe0B5XpkODNgjyOikfOtpCYOba0Wz+aHQEqyOS
        nrZNeNI3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWNK9-0008JP-NG; Fri, 22 Jun 2018 14:46:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C55572029FA0E; Fri, 22 Jun 2018 16:46:03 +0200 (CEST)
Date:   Fri, 22 Jun 2018 16:46:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622144603.GR2476@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
 <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
 <20180622132624.GL2494@hirez.programming.kicks-ass.net>
 <CAKfTPtA+QwUL5c0kqacEYtqONem6_PedMcmq0PAb0RQbi_bRjQ@mail.gmail.com>
 <CAKfTPtC-4HyMZ82oDdVamN3FVtP4VgShPO6JSei3GZHWv8EqNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC-4HyMZ82oDdVamN3FVtP4VgShPO6JSei3GZHWv8EqNQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:57:24PM +0200, Vincent Guittot wrote:
> On Fri, 22 Jun 2018 at 15:54, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> > On Fri, 22 Jun 2018 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:

> > > And that is my objection to that straight sum thing; there the dl util
> > > distorts the computed dl bandwidth thing even if there is no cfs
> > > utilization.
> >
> > hmm,
> 
> forgot to finish this sentence
> 
> hmm, dl util_avg is only used to detect is there is idle time so if
> cfs util is nul we will not distort the  dl bw (for a use case where
> there is no rt task running)

Hurm.. let me apply those patches and read the result, because I think I
missed something.

