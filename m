Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A61206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GvTu2EvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A61206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeGTMkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:40:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55648 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeGTMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OhwZMbh3gtfvdEsTwO4aH7CsfYi4+4DNW2aGjJ+np9g=; b=GvTu2EvYS6Zl13rmIvbn0R59n
        h9kDY8DeKA8S8PuTPBwxfEsF6Tk6bla6iSdoOaIwKxZrcO8CyvOsH5pFZdHzXVQB+gu3nnd/LltZr
        QtNS+Euouz3TXXiWzRVYMvyeYTX0JuctrYGng5TsYVDZz4gYtAhT9X+L8C5mxdwCHNG9l1E7j3Woh
        wKQ+zFIyc7o2mmvCIlS/zxc4PZaf//7bTML1OXleho1cKM05+Pht96mY24W7kktLXSdfvcfZWE3N9
        ZmoctWMtzmkil2A6Qm3fzG9NmT32jZa2rzx5D31VD6yBK/HbfKGXabDgBJRS8Qo2w5GC0Uu7QAGH5
        /PWdt8/mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgTxK-00029b-Ad; Fri, 20 Jul 2018 11:52:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D02220275F38; Fri, 20 Jul 2018 13:52:17 +0200 (CEST)
Date:   Fri, 20 Jul 2018 13:52:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: fix a possible deadlock scenario
Message-ID: <20180720115217.GQ2494@hirez.programming.kicks-ass.net>
References: <20180719132834.GF18667@krava>
 <20180719191253.3843-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719191253.3843-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:12:53PM -0700, Cong Wang wrote:
> hrtimer_cancel() busy-waits for the hrtimer callback to stop,
> pretty much like del_timer_sync(). This creates a possible deadlock
> scenario where we hold a spinlock before calling hrtimer_cancel()
> while in trying to acquire the same spinlock in the callback.

Has this actually been observed?

> cpu_clock_event_init():
>   perf_swevent_init_hrtimer():
>     hwc->hrtimer.function = perf_swevent_hrtimer;
> 
> perf_swevent_hrtimer():
>   __perf_event_overflow():
>     __perf_event_account_interrupt():
>       perf_adjust_period():
>         pmu->stop():
>         cpu_clock_event_stop():
>           perf_swevent_cancel():
>             hrtimer_cancel()

Please explain how a hrtimer event ever gets to perf_adjust_period().
Last I checked perf_swevent_init_hrtimer() results in attr.freq=0.

> Getting stuck in an hrtimer is a disaster:

You'll get NMI watchdog splats. Getting stuck in NMI context is far more
'interesting :-)

> +#define PERF_EF_NO_WAIT	0x08		/* do not wait when stopping, for
> +					 * example, waiting for a timer
> +					 */

That's a broken comment style.
