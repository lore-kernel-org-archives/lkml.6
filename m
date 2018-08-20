Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41103C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDD320C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OJDzNcV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDD320C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeHTM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:29:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeHTM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qw39LjWTQ5WgPhgBBowHU8hABG3RkYwGF0YkftPxRig=; b=OJDzNcV8lbNw1Fv1sWUSBRvCL
        YlfC/uehCfpG3m4oAa9FJ4fZgeeYw0oMH7bQ1/UjHSpydy7de1wnn0USvUlhtlYS5VPutzUDZHCZF
        cm1gjWdDPsO/d4AIKQQ27AdvlPpTJ6IO587NHyglFt25HINpgWpUfH4niIpDbcOrOcEJHxe+6p8Tx
        iRLzUFJu1IwzI6Y3Da+0D62ufej6vIHQjU4DAbycmoifw31LCsRp+xmKL+7idzDFkCZrlT0Ue+HSP
        RXw64+CGJhv4aVtxalhno5bjlNcMddgy/8qplEmAZxh5uslHPlWsO+Z8D7sJdsiYKlC+raDJC2Zsb
        rPOpVbMSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frgGf-0000AZ-6x; Mon, 20 Aug 2018 09:14:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03D7920267B13; Mon, 20 Aug 2018 11:14:30 +0200 (CEST)
Date:   Mon, 20 Aug 2018 11:14:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Message-ID: <20180820091430.GV2494@hirez.programming.kicks-ass.net>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
 <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan>
 <20180817141252.GA12426@lerouge>
 <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 11:57:00PM +0200, Rafael J. Wysocki wrote:
> So I have given more consideration to this and my conclusion is that
> restarting the tick between cpuidle_select() and call_cpuidle() is a
> bad idea.

Ack, we should only restart the tick once we leave the idle loop.

> First off, if need_resched() is "false", the primary reason for
> running the tick on the given CPU is not there, so it only might be
> useful as a "backup" timer to wake up the CPU from an inadequate idle
> state.

this..

<snip>

> The second
> reason is when the governor predicts a wakeup which is not by a timer
> in this time frame and it is quite arguable what the governor should
> do then.  IMO it at least is not unreasonable to throw the prediction
> away and still go for the closest timer event in that case (which is
> the current approach).

Yes, I think I can agree with that, predictions at that scale are just
not that useful. The primary point of the governor is to stay shallow
when we can, but once we're deep and have disabled the tick and lost
caches, there's really no point anymore. Waking up is going to hurt.

> There's more, though.  Restarting the tick between cpuidle_select()
> and call_cpuidle() might introduce quite a bit of latency into that
> point and that would mess up with the idle state selection (e.g.
> selecting a very shallow idle state might not make a lot of sense if
> that latency was high enough, because the expected wakeup might very
> well take place when the tick was being restarted), so it should
> rather be avoided IMO.

Absolutely, mucking with the tick just because of a hunch is the wrong
thing.

So,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

for this one.
