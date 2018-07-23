Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CDBECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A2D20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gtoYvMVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A2D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbeGWKVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:21:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388040AbeGWKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ncgi/OGLVHVBIWqBXQGmW5oDTMACs4d8WwhDeqw4bDc=; b=gtoYvMVL3EIMd+IlLVKREYy/a
        0Xg+FgfefIeyBYt2MjPY8B2R066dOlh0vmT/838Yt6z/zUFpqocN5nyYkfumd6BkQzl7fLFpV8L3E
        5pgfVx3z8FmIMDnFD/qsUzuKaUfGMQlWGPXFU4lOvakuJgetsp+mQGIc0uJSJaQfYdGyebdNA/sQr
        ueXbU7p00Fv5OoZ5SlBLna0uFKOkiijefGSRLQlbJ9Zj1w+y+ZOQTp+8S0lfd85ckLzJuS4QfBPvL
        iglI/0W2/CswksYf/aQShJhL0ESGXo/ZDEeBLWQrqSrxqtQw43ZqYPWNAUimZys6RoxEYoWwOrDBT
        U+7ZewGtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhX1r-0000Wx-Vo; Mon, 23 Jul 2018 09:21:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22F4F20275F3E; Mon, 23 Jul 2018 11:21:18 +0200 (CEST)
Date:   Mon, 23 Jul 2018 11:21:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de,
        frederic@kernel.org, lcapitulino@redhat.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tj@kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/cputime: Ensure accurate utime and stime
 ratio in cputime_adjust()
Message-ID: <20180723092118.GZ2494@hirez.programming.kicks-ass.net>
References: <20180709145843.126583-1-xlpang@linux.alibaba.com>
 <tip-8d4c00dc38a8aa30dae8402955e55e7b34e74bc8@git.kernel.org>
 <20180716133751.GC2494@hirez.programming.kicks-ass.net>
 <20180716174119.GA4514@gmail.com>
 <464f4485-0e6b-17a2-1d54-6e2b24c95761@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464f4485-0e6b-17a2-1d54-6e2b24c95761@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:08:36PM +0800, Xunlei Pang wrote:
> The trace data corresponds to the last sample period:
> trace entry 1:
>              cat-20755 [022] d...  1370.106496: cputime_adjust: task
> tick-based utime 362560000000 stime 2551000000, scheduler rtime 333060702626
>              cat-20755 [022] d...  1370.106497: cputime_adjust: result:
> old utime 330729718142 stime 2306983867, new utime 330733635372 stime
> 2327067254
> 
> trace entry 2:
>              cat-20773 [005] d...  1371.109825: cputime_adjust: task
> tick-based utime 362567000000 stime 3547000000, scheduler rtime 334063718912
>              cat-20773 [005] d...  1371.109826: cputime_adjust: result:
> old utime 330733635372 stime 2327067254, new utime 330827229702 stime
> 3236489210
> 
> 1) expected behaviour
> Let's compare the last two trace entries(all the data below is in ns):
> task tick-based utime: 362560000000->362567000000 increased 7000000
> task tick-based stime: 2551000000  ->3547000000   increased 996000000
> scheduler rtime:       333060702626->334063718912 increased 1003016286
> 
> The application actually runs almost 100%sys at the moment, we can
> use the task tick-based utime and stime increased to double check:
> 996000000/(7000000+996000000) > 99%sys
> 
> 2) the current cputime_adjust() inaccurate result
> But for the current cputime_adjust(), we get the following adjusted
> utime and stime increase in this sample period:
> adjusted utime: 330733635372->330827229702 increased 93594330
> adjusted stime: 2327067254  ->3236489210   increased 909421956
> 
> so 909421956/(93594330+909421956)=91%sys as the shell script shows above.
> 
> 3) root cause
> The root cause of the issue is that the current cputime_adjust() always
> passes the whole times to scale_stime() to split the whole utime and
> stime. In this patch, we pass all the increased deltas in 1) within
> user's sample period to scale_stime() instead and accumulate the
> corresponding results to the previous saved adjusted utime and stime,
> so guarantee the accurate usr and sys increase within the user sample
> period.

But why it this a problem?

Since its sample based there's really nothing much you can guarantee.
What if your test program were to run in userspace for 50% of the time
but is so constructed to always be in kernel space when the tick
happens?

Then you would 'expect' it to be 50% user and 50% sys, but you're also
not getting that.

This stuff cannot be perfect, and the current code provides 'sensible'
numbers over the long run for most programs. Why muck with it?
