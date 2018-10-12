Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BE6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8F02087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uJdlmoKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8F02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeJLT0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:26:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJLT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9GbQBQh97a2ERQ2mi/oMoQYqXMC6ygxsYstHUdaTbus=; b=uJdlmoKeyCXrhxUWuL333djHr
        cFoF1UzE6DUNPlvgkUkUHKN0I8eN/Yur5fUBHU3EKWF/JveEsKcToR3Sox1Aa5DihwLgMilkYhUpg
        WAQuYyxHu8fQJ9lwT58tdvpGAeGxHDCfWo5IvA96AFoKgT4Bxuy3nDkt2Q6MTToZhae2ro+vdYO1v
        5fXNpI5nn2lt5qayKxre+kVy/BHIgaVgwLJW1nd6jTzhS/NpKmqZC82qECq/Fda/MBcFq+4wKwSnD
        mrf4ZcRwPuFxafPrSoIPBN1vJRlFbUwkZEgLKRVrVcno6I3Ykh43GK9SAIimzymrg0hprPmDBkk3K
        fUIb1KS2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAw1P-0000nV-8F; Fri, 12 Oct 2018 11:54:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B1C520292D10; Fri, 12 Oct 2018 13:54:20 +0200 (CEST)
Date:   Fri, 12 Oct 2018 13:54:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Song Liu <songliubraving@fb.com>, Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "eranian@google.com" <eranian@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181012115420.GH9867@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
 <162cce00-745c-6e30-f859-497d9307059d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162cce00-745c-6e30-f859-497d9307059d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:04:36AM +0300, Alexey Budankov wrote:
> On 11.10.2018 12:29, Peter Zijlstra wrote:
> > On Thu, Oct 11, 2018 at 07:50:23AM +0000, Song Liu wrote:
> >> Or step back a little... I see two big changes:
> >>
> >> 1. struct perf_ctx_context is now per cpu (instead of per pmu per cpu);
> >> 2. one perf_event_ctxp per task_struct (instead of 2).  
> > 
> > Correct, we reduce to 1 cpu context and 1 task context at all times.
> > This in fact simplifies quite a bit of things.
> 
> And what is currently missing is 
> some markup of the per cpu event list into per pmu sublists and 
> capability to rotate or not rotate the sublists independently, 
> right?

Yes, that is what the new perf_event_pmu_context is. That tracks the per
pmu sublist state.
