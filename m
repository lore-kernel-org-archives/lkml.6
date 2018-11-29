Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B135C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41492082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBTUN4tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41492082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeK3ClU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:41:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeK3ClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e/44OweujBTvsgHnwuyRm5zM9pAVKO0ArllTpHzSSnY=; b=WBTUN4tr+UwG/Uu1TdcA6EXtB
        1SexAHzTOo6IHXwRoNpktwGRotJJPQ+nktW7ZZ3ZlWlPU2CxGgWFw0jglyB69v8MKeKGbZAUIWDr7
        B9Ltg1JwIKAgXQjTXfifR6nPTKOiK91cktOzbNfhnEMpbdzMBac2cek8fe170kkhcceRi0IKJzrhV
        4uJHWJ5WWeDjLBQX/MuthriwtUSClk/mewyYK3shH02aWAgLRCc6TCKJR/fmFppzTw0wSwzGadjak
        2cZo6fB3VhH0CicQct4Yq2rq0CiDzkPBzHYWIjgPDmwrGsmclkupBkKncdjRaZ9zWa/6aXSzfWeDv
        R3c5ykUPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOLf-0000Cf-PZ; Thu, 29 Nov 2018 15:35:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CE7F2029FD58; Thu, 29 Nov 2018 16:35:26 +0100 (CET)
Date:   Thu, 29 Nov 2018 16:35:26 +0100
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
Message-ID: <20181129153526.GR2131@hirez.programming.kicks-ass.net>
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com>
 <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com>
 <20181120221642.GE2131@hirez.programming.kicks-ass.net>
 <20181120222549.GA2149@hirez.programming.kicks-ass.net>
 <20181120223854.GH13936@tassilo.jf.intel.com>
 <20181121081420.GF2131@hirez.programming.kicks-ass.net>
 <CAP045AqRs4+F5rNKXLYHeuvLCvzd9U=eZY0X0NnHXxz3qk9TUw@mail.gmail.com>
 <20181127233615.GY13936@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127233615.GY13936@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 03:36:15PM -0800, Andi Kleen wrote:
> > It does seem that FREEZE_PERFMON_ON_PMI (misnamed as it is) is of
> > rather limited use (or even negative, in our case) to a counter that's
> > already restricted to ring 3.
> 
> It's much faster. The PMI cost goes down dramatically.

faster doesn't mean much when its broken.
