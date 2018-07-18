Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38001ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51A12084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51A12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeGRIzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:55:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbeGRIzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:55:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01E0340214E2;
        Wed, 18 Jul 2018 08:19:08 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5A5152026D69;
        Wed, 18 Jul 2018 08:19:06 +0000 (UTC)
Date:   Wed, 18 Jul 2018 10:19:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: fix a possible deadlock scenario
Message-ID: <20180718081905.GA13520@krava>
References: <20180716215101.4713-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716215101.4713-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 18 Jul 2018 08:19:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 18 Jul 2018 08:19:08 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 02:51:01PM -0700, Cong Wang wrote:
> hrtimer_cancel() busy-waits for the hrtimer callback to stop,
> pretty much like del_timer_sync(). This creates a possible deadlock
> scenario where we hold a spinlock before calling hrtimer_cancel()
> while in trying to acquire the same spinlock in the callback.
> 
> This kind of deadlock is already known and is catchable by lockdep,
> like for del_timer_sync(), we can add lockdep annotations. However,
> it is still missing for hrtimer_cancel(). (I have a WIP patch to make
> it complete for hrtimer_cancel() but it breaks booting.)
> 
> And there is such a deadlock scenario in kernel/events/core.c too,
> well actually, it is a simpler version: the hrtimer callback waits
> for itself to finish on the same CPU! It sounds stupid but it is
> not obvious at all, it hides very deeply in the perf event code:
> 
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
> 
> Getting stuck in a timer doesn't sound very scary, however, in this

sound scary enough for me ;-) were you able to hit it?

> case, its consequences are a disaster:
> 
> perf_event_overflow() which calls __perf_event_overflow() is called
> in NMI handler too, so it is racy with hrtimer callback as disabling
> IRQ can't possibly disable NMI. This means this hrtimer callback
> once interrupted by an NMI handler could deadlock within NMI!

hum, the swevent pmu does not triger NMI, so that timer
will never be touched in NMI context

jirka
