Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E17ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1599205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WJKPQP7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1599205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJSTpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:45:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37232 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeJSTpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eA6QITRghzqA59wlagXhUriGbJdvtkuWgn7JL2XOxUE=; b=WJKPQP7ztppitf237SqKhk/49
        B/78PTKXGgGDZstbtIJtNbWF/NC3duKdt+Z7Wt7uSh6/hLqgsb+mDAgHcAfYh5G54z0EqQUTNKcQj
        SYiOgBAro6cKhatxhP+zw+P88ZV1ViwJ+EuWS9NRm8dMymeloJOJ+GDq4sriFusjlCvxhabFTN97t
        XPQd9R+sH83dT/ZiRkEiQqCBQy4yx5L1JpdalFZBFqHO+drJWKtaR5yhJm+GE/XYlWMub0C+PD5wc
        nt/OPGUWu9FuoqRiP0ozRLT5/52G0OMJnVzhpSMh5tzwMt7L0Bm/b6w/YxET/RmyYETdhbhZe9SJq
        meLtjJdNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDT84-0004Xo-O9; Fri, 19 Oct 2018 11:39:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57D3E2029856B; Fri, 19 Oct 2018 13:39:42 +0200 (CEST)
Date:   Fri, 19 Oct 2018 13:39:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181019113942.GH3121@hirez.programming.kicks-ass.net>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018130811.61337932@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 01:08:11PM +0200, luca abeni wrote:
> Ok, I see the issue now: the problem is that the "while (dl_se->runtime
> <= 0)" loop is executed at replenishment time, but the deadline should
> be postponed at enforcement time.
> 
> I mean: in update_curr_dl() we do:
> 	dl_se->runtime -= scaled_delta_exec;
> 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> 		...
> 		enqueue replenishment timer at dl_next_period(dl_se)
> But dl_next_period() is based on a "wrong" deadline!
> 
> 
> I think that inserting a
>         while (dl_se->runtime <= -pi_se->dl_runtime) {
>                 dl_se->deadline += pi_se->dl_period;
>                 dl_se->runtime += pi_se->dl_runtime;
>         }
> immediately after "dl_se->runtime -= scaled_delta_exec;" would fix the
> problem, no?

That certainly makes sense to me. The only remaining issue would then be
placing a limit on the amount of times we can take that loop; which, as
you propose in a later email; can be done separately as a limit on
runtime.
