Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DC6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6951A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJNxugnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6951A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIERo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:44:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33136 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIERo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QfGZdyH888q3YFw8xRp6IZ/mpBL4QsYP7IYjzuOX8NU=; b=HJNxugnjDNtlm1/rdedqm9mro
        G3jVZjE6wwJCB+VPkRvCWrMMJRqKXadtJgdPW8QoI7nYSJPISrwkHExVYLPHpW1rVHOwfw5rSMkz3
        22IY4c9Is+rm0K11pYlUaSGNmWwQJgR5mXnurVWSA5iyNbMgfZYWKMHosMi8Fu2tqaf+pEwnnIUsY
        csH7arzfyECcZVcR17IxGj8LBegBVnTdyImlwmJtvlERozYzGj/oTCFBqkFKXocE1xWq2P+0jRJkc
        HldYtqon8/9Nw3unXW/mo7m6zvwT1bZzRajaddaFBR/ArjjW/GUwwJGF4jxH4b4zi9S2zB2NxIP0G
        3fTbfkPjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxXdM-0005hH-27; Wed, 05 Sep 2018 13:14:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D84622022BACF; Wed,  5 Sep 2018 15:14:10 +0200 (CEST)
Date:   Wed, 5 Sep 2018 15:14:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: stop_machine() soft lockup
Message-ID: <20180905131410.GY24082@hirez.programming.kicks-ass.net>
References: <20180904190322.GA21835@centauri.lan>
 <20180905084241.GS24082@hirez.programming.kicks-ass.net>
 <20180905114749.GA5345@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905114749.GA5345@centauri.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:47:49PM +0200, Niklas Cassel wrote:
> On Wed, Sep 05, 2018 at 10:42:41AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 04, 2018 at 09:03:22PM +0200, Niklas Cassel wrote:
> > > Hello Peter,
> > >
> > > I'm seeing some lockups when booting linux-next on a db820c arm64 board.
> > > I've tried to analyze, but I'm currently stuck.
> >
> > Please see (should be in your Inbox too):
> >
> >   https://lkml.kernel.org/r/20180905084158.GR24124@hirez.programming.kicks-ass.net
> 
> I'm sorry if I mislead you by replying to your other mail thread,
> both of them have timekeeping_notify() in the call trace,
> but my problem has this call trace:
> 
> [  128.747853]  wait_for_common+0xe0/0x1a0
> [  128.752023]  wait_for_completionx+0x28/0x38
> [  128.755677]  __stop_cpus+0xd4/0xf8
> [  128.759837]  stop_cpus+0x70/0xa8
> [  128.762958]  stop_machine_cpuslocked+0x124/0x130
> [  128.766345]  stop_machine+0x54/0x70
> [  128.771373]  timekeeping_notify+0x44/0x70
> [  128.774158]  __clocksource_select+0xa8/0x1d8
> [  128.778605]  clocksource_done_booting+0x4c/0x64
> [  128.782931]  do_one_initcall+0x94/0x3f8
> [  128.786921]  kernel_init_freeable+0x47c/0x528
> [  128.790742]  kernel_init+0x18/0x110
> [  128.795673]  ret_from_fork+0x10/0x1c
> 
> 
> while your other mail thread has this call trace:
> 
> * stop_machine()
> * timekeeping_notify()
> * __clocksource_select()
> * clocksource_select()
> * clocksource_watchdog_work()
> 
> 
> So my problem is not related to the watchdog, I tried your revert anyway,
> but unfortunately my problem persists.

Oh, right, missed that distinction. And this is new?

I'll try and have a look. Lockdep doesn't suggest anything?
