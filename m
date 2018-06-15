Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 13172C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE47208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B7a/Y849"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE47208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756035AbeFOIRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:17:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755847AbeFOIRM (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pv6C0oexGS7w9Sc6SpYeYAOyQn+821H77ADzNCTiFpI=; b=B7a/Y849j+NBtKsXvUsJEXRPm
        2454s26kelEdput/IjE5KDYq2wiKscipGYfXhdNcXCdfPQXlmImh5R7gQjNPTeHb7PtNMf1NT6l1G
        T7NyGq2AfwtfVk3xdi4cDx88f0vLvfdp8GfQ6fO1oRjxs75j8gvoS5TyGV00mK8dFequAE8rg1Sbp
        vBXSX1lcm8uv44d7OUwFYs6Gypy8AQQgpj50qQhRsmbNZtSOEvrZv1EyPu8YLOjeU0UG5PuY958EP
        V2jF6fsHqj2fNfRl0hYjWqLI2eNe3mSizOLM+Fp39Ff0Ng0fMPDu/HPzURKUn6LmPtkiczWhPy9PN
        btAM4+MXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTjuk-0003oS-DT; Fri, 15 Jun 2018 08:16:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17B892029FA0D; Fri, 15 Jun 2018 10:16:56 +0200 (CEST)
Date:   Fri, 15 Jun 2018 10:16:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     yao.jin@linux.intel.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        me@kylehuey.com, LKML <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
Message-ID: <20180615081656.GC2458@hirez.programming.kicks-ass.net>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <CABPqkBTyEZX7DebLR-nbzXs0ZYGT1xWNmOmvKgRsvr4mxWJg=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTyEZX7DebLR-nbzXs0ZYGT1xWNmOmvKgRsvr4mxWJg=w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:02:53PM -0700, Stephane Eranian wrote:
> On Thu, Jun 14, 2018 at 7:10 PM Jin Yao <yao.jin@linux.intel.com> wrote:
> > +       /*
> > +        * Due to interrupt latency (AKA "skid"), we may enter the
> > +        * kernel before taking an overflow, even if the PMU is only
> > +        * counting user events.
> > +        * To avoid leaking information to userspace, we must always
> > +        * reject kernel samples when exclude_kernel is set.
> > +        */
> > +       if (event->attr.exclude_kernel && !user_mode(regs))
> > +               return false;
> > +
> And how does that filter PEBS or LBR records?

I suspect the user_mode() thing actually covers PEBS, but yes LBR might
need additional filtering.
