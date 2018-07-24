Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7428B20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="016/aONR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7428B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeGXKYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:24:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388161AbeGXKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pyJadZXF+w+4qI8kTAzRG47E6LthDngS84oiOPQiIkg=; b=016/aONR60JXRJRk4dL5zDiPZ
        xIG2e2dpSkW2hi0WvrlopZcBNZU80211+/EGNwxdt5aDFSJFW0rm+1kG4i8+PCMQO/DEvh1L+amfm
        hUfadw1Er8oiqPQoeHKPwUBWT/+f4562lY/nR755ryhA/Flf4Nr8/IbNNI/6kjWbKjfm2okk+/cJf
        Q/o8ZSSNmqHyBxKj3wK5OTEyjP3L8V07M7W9rIyDIlycSknMWoXEWXnPrZKGriSYgoRIJc5AMhL21
        8PuThsIfZ9fjkuGyarBLHuNVNiFo3l6URlvu1YGWMbZPZAmbptVOpEzVsMqlsyNG57d+lo3xc1Bh0
        1fLc/nR+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhtSe-0007DD-MB; Tue, 24 Jul 2018 09:18:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 014FA20268330; Tue, 24 Jul 2018 11:18:24 +0200 (CEST)
Date:   Tue, 24 Jul 2018 11:18:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] perf/core: fix a possible deadlock scenario
Message-ID: <20180724091824.GM2494@hirez.programming.kicks-ass.net>
References: <20180719132834.GF18667@krava>
 <20180719191253.3843-1-xiyou.wangcong@gmail.com>
 <20180720115217.GQ2494@hirez.programming.kicks-ass.net>
 <CAM_iQpWVhLZKo9j6COGkvryGrxJq6sEXzh2S-ikza2H3=pAyqw@mail.gmail.com>
 <CAM_iQpV33dj-_bwYp3QJdPKihR8HyPzKMOpi1Lrqm7VtN3bZ8w@mail.gmail.com>
 <CAM_iQpXUsVW7a0+_Z_R-k8xGEQBSKd5Oz7j5+z=G1kQHoDfCqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXUsVW7a0+_Z_R-k8xGEQBSKd5Oz7j5+z=G1kQHoDfCqQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 06:44:43PM -0700, Cong Wang wrote:
> On Mon, Jul 23, 2018 at 6:35 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > Hi, Peter, Andi
> >
> > While reviewing the deadlock, I find out it looks like we could have the
> > following infinite recursion too:
> >
> > perf_event_account_interrupt()
> > __perf_event_account_interrupt()
> > perf_adjust_period()
> > event->pmu->stop
> > x86_pmu_stop()
> > x86_pmu.disable()
> 
> Hmm, x86_pmu_stop() calls __test_and_clear_bit(), so
> we should not call x86_pmu.disable() twice here.

Right, but since we set HES_UPTODATE after calling
x86_perf_event_update() that can in fact recurse.

Now, I don't think that'll be fatal, but it might be good to test that.

If you pick these patches:

  https://lkml.kernel.org/r/20170928121823.430053219@infradead.org

use force_early_printk (and actually configure a serial early_printk)
and put a printk() in x86_pmu_stop() and then run the perf_fuzzer or
something to try and reproduce.

But paranoia suggets moving that HES_UPTODATE thing one line up.

> > intel_pmu_disable_event()
> > intel_pmu_pebs_disable()
> > intel_pmu_drain_pebs_buffer()
> > intel_pmu_drain_pebs_nhm()
> > <repeat....>
> >
> > This time is pure hardware events, attr.freq must be non-zero.
> >
> > And, we could enter this infinite recursion in NMI handler too:
> >
> > intel_pmu_handle_irq()
> > perf_event_overflow()
> > __perf_event_overflow()
> > __perf_event_account_interrupt()
> > ....
> >
> > Or this is impossible too?

I'm not sure I see this second one.. can you be a little more specific?
