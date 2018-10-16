Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C96C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F63621470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="unvCz86/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F63621470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJQCCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:02:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34962 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJQCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8OUUaLS5INAkW9peW/lnB520svb/cSOG0gE2dRdwHSI=; b=unvCz86/T3jWamR8BrQYcO8nL
        PKnUcNFbo6xN9TQ4Us1b/vNknhUKTXP8XuoTsbDU5NOeqTHQayrGabDCDCVC7jgklUO+WWxZNB1FV
        /PjGKyxAaceaJqOM40Vzlnwo/mxLu7hAtbjJKyQ7Fajyf8xqdxusOAh3o2lrjcBTSHfr8TWI5qB45
        F70frwWUm/cLLFduSngQDbwKhaDvOXrdEWT2BJju39Gngoh5VR19Sq1UbjyKyc/IWaejfwHmSShPR
        aJb2gAcJSCE6EyNToPShNOVA0WwTmAqTeRhSnVCROPIVG2+KGvUUCZtLjbvptmkhAR+XRTh2cyaL8
        m0UpHO7WQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCTnN-0004NF-7e; Tue, 16 Oct 2018 18:10:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88ED82029900B; Tue, 16 Oct 2018 20:10:15 +0200 (CEST)
Date:   Tue, 16 Oct 2018 20:10:15 +0200
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
Message-ID: <20181016181015.GD3121@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
 <70079805-1CAE-4CAA-813A-F8DDB929F22B@fb.com>
 <20181012095001.GG9867@hirez.programming.kicks-ass.net>
 <E4F81A5E-C371-429D-AFEC-6F4B32971F09@fb.com>
 <20181016095056.GE4030@hirez.programming.kicks-ass.net>
 <9865C981-0E8C-4419-AE8C-638DCD40D74E@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9865C981-0E8C-4419-AE8C-638DCD40D74E@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:34:05PM +0000, Song Liu wrote:
> >> 3. perf_event_pmu_context owns RB tree of events. Since we don't 
> >>   need rotation across multiple hardware PMUs, the rotation is 
> >>   within same perf_event_pmu_context.  
> > 
> > By keeping the RB trees in perf_event_context, we get bigger trees,
> > which is more efficient (log(n+m) < log(n) + log(m))
> > 
> > Also, specifically, it means we only need a single merge sort /
> > iteration to schedule in a full context, instead of (again) doing 'n' of
> > them.
> > 
> > Also, given a context and a pmu, it is cheaper for finding the relevant
> > events; this is needed for big.little for instance. Something the
> > proposed patch doesn't fully flesh out.
> 
> Would it be faster if we add a perf_event_pmu_context pointer to the 
> perf_event? 

+       pmu_ctx = find_get_pmu_context(pmu, ctx, event);
+       if (IS_ERR(pmu_ctx)) {
+               err = PTR_ERR(pmu_ctx);
+               goto err_locked;
+       }
+       event->pmu_ctx = pmu_ctx;

Like that?
