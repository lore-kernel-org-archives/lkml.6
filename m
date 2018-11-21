Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA08C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6591721479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HcVN5T3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6591721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeKUSsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:48:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZJewmOd27OA7wEvszIakppkkEWlgf5r/zdAFQHC65UE=; b=HcVN5T3lK/0weBYz8SOebscqe
        SCzBj+kzl+83p21XUVmAZGGU/ry60zIcXWmqfCbMXVz8oWtGD+fgq7SwgsjKDFc1X+XsLs84mx6vS
        TDaMJ5Q8KZkC7e5ZCn0NvXG1mCRfsi6/RmBNHSqBlDK7+pu+XMCqE1FMqAOJqmWk7TqVvqMny6vor
        dDEqU6+gqhGNeW68XPULAZonqVFJYbsFqsqfch8DRmJg9LBT0YOMz+CJNyI778oRKnIoFDK5LGEjd
        M44/n9JWh3M2R7rJVCtt5LvNRqCkfoNUI4az8OSn5xZQ02RXGas6dwtEgLs0ZzPfuCVE5GAIo2JVR
        3/CMPV5EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPNeR-0002rZ-6j; Wed, 21 Nov 2018 08:14:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CDC02029FD58; Wed, 21 Nov 2018 09:14:20 +0100 (CET)
Date:   Wed, 21 Nov 2018 09:14:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kyle Huey <me@kylehuey.com>, Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Robert O'Callahan <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
Message-ID: <20181121081420.GF2131@hirez.programming.kicks-ass.net>
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com>
 <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com>
 <20181120221642.GE2131@hirez.programming.kicks-ass.net>
 <20181120222549.GA2149@hirez.programming.kicks-ass.net>
 <20181120223854.GH13936@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120223854.GH13936@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:38:54PM -0800, Andi Kleen wrote:
> > In fact, I'll argue FREEZE_ON_OVERFLOW is unfixably broken for
> > independent counters, because while one counter overflows, we'll stall
> > counting on all others until we've handled the PMI.
> > 
> > Even though the PMI might not be for them and they very much want/need
> > to continue counting.
> 
> We stop all counters in any case for the PMI. With freeze-on-PMI it just
> happens slightly earlier.

Hiding the PMI is fine and good. The PMI is not the workload. Stopping
it earlier is _NOT_ good, it hides your actual workload.

