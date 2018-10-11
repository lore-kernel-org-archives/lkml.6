Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414FCC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC22087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LXX3o4fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC22087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeJKQzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:55:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FiPNDg8g4hmCcl+wpoJlxuvjEQ56JIfo3dFJ22aIJS4=; b=LXX3o4fxisXQmW3/jCCWqaLNZ
        XPk+D1AlInM/V0xbGk/AddxD1vd1uWWZBpTwMUC4XL7Aur/Z0NvGaN0F6MKR/LOuTItNgok1rPRLA
        nVyIS8AqtEYKTyzHoxFHvuPymLi/xlsu16u+fdCf10qLQiksSNOs43/ZbKvzOA10RvZsQG2OCrKoS
        o8wVXoqx+WphQc9s6e0iI34h3Y1i2x3H2SD80613zii/VOcwEtCq6w49Xy7F8flg03OJMwyUwdYmo
        ZOuQYNWUVStFMRGpyHRqqd8i08G3vXvmddip9Ac22irU+Dqts7oHXe3T6oyPJKVoKHEgSPtv2f8Bm
        sIk+4rxmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAXHP-0007IA-5V; Thu, 11 Oct 2018 09:29:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 467A12029856A; Thu, 11 Oct 2018 11:29:13 +0200 (CEST)
Date:   Thu, 11 Oct 2018 11:29:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "eranian@google.com" <eranian@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181011092913.GA9848@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 07:50:23AM +0000, Song Liu wrote:
> Hi Peter, 
> 
> I am trying to understand this. Pardon me if any question is silly. 
> 
> I am not sure I fully understand the motivation here. I guess we
> see problem when there are two (or more) independent hardware PMUs 
> per cpu? Then on a given cpu, there are two (or more) 
> perf_cpu_context, but only one task context? 

Right.

> If this is correct (I really doubt...), I guess perf_rotate_context()
> is the problem? 

No, everything comes apart. Where would you put the events of the second
PMU?

The thing most often proposed it pretending the second PMU is a
'software' PMU and sticking the events on the software PMU context.

But because software PMUs must never fail to schedule an event, that
results in some quite horrible things -- including that we cannot RR the
events.

Similarly the big.little guys have the problem that the PMUs are not the
same between big and little cores, and they fudge something horrible. By
having clear ordering on PMU, that can be cleaned up too.

> And if this is still correct, this patch may not help,
> as we are doing rotation for each perf_cpu_pmu_context? (or rotation 
> per perf_event_context is the next step?). 

We do indeed to rotation per perf_cpu_pmu_context, however:

 - perf_cpu_pmu_context embeds a cpu scope perf_event_pmu_context,
 - perf_cpu_pmu_context tracks the currently associated task scope
   perf_event_pmu_context.

So it can rotate all current events for a particular PMU.

> Or step back a little... I see two big changes:
> 
> 1. struct perf_ctx_context is now per cpu (instead of per pmu per cpu);
> 2. one perf_event_ctxp per task_struct (instead of 2).  

Correct, we reduce to 1 cpu context and 1 task context at all times.
This in fact simplifies quite a bit of things.

> I think #1 is a bigger change than #2. Is this correct? 

They're the 'same' change. But yes the primary purpose was 2, but having
only a single cpu context is a direct consequence.

> Could you please help me understand it better? 

I hope this helps to understand, please feel free to ask more.
