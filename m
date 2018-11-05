Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2343C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D972085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj2iuTPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D972085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbeKFFxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeKFFxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:53:24 -0500
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F90A2084F;
        Mon,  5 Nov 2018 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541449918;
        bh=4xFvlmFBHgCfMrYR5aRlk7Y8/9tKsocPZOssIRMuhrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mj2iuTPahOEoln1UEEeOo/eEYGoRDQLLhuwp42MBi9gCRZEYkCGZe3OxJRCAe//uJ
         lYACQS2+kkjggZ9Cv/2LGOGr443FepQ4rx/2wHbBiomgcTjNpeZDjQQKy6CRa1AVen
         SpgJYa0LYSNJWyTqupweunkdInvYm37rbumoZEEg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 54C54142D18; Mon,  5 Nov 2018 17:31:56 -0300 (-03)
Date:   Mon, 5 Nov 2018 17:31:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
 cpumode is insufficient
Message-ID: <20181105203156.GI7077@kernel.org>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-2-adrian.hunter@intel.com>
 <20181105172946.GH11147@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C313381@IRSMSX106.ger.corp.intel.com>
 <20181105193615.GG7077@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C3133B4@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C3133B4@IRSMSX106.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 05, 2018 at 07:53:17PM +0000, Hunter, Adrian escreveu:
> > -----Original Message-----
> > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > Sent: Monday, November 5, 2018 9:36 PM
> > To: Hunter, Adrian <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>; Andi Kleen <ak@linux.intel.com>; linux-
> > kernel@vger.kernel.org; leo.yan@linaro.org; David Miller
> > <davem@davemloft.net>; Mathieu Poirier <mathieu.poirier@linaro.org>
> > Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
> > cpumode is insufficient
> > 
> > Em Mon, Nov 05, 2018 at 07:21:44PM +0000, Hunter, Adrian escreveu:
> > > > In Monday, November 5, 2018 7:30 PM, Arnaldo Carvalho de Melo wrote
> > > > Also have you considered making this fallback to be performed only
> > > > from code that is that arch specific?

> > > > I.e. the code that supports branch samples/stacks is x86_86 specific
> > > > at this point and thus only in that case we would call the routines
> > > > that perform the fallback, which, in turn, wouldn't need to check for
> > "sparc"?
> > 
> > > I will look at it, but theoretically someone could be processing x86
> > > data but doing it on a machine of a different architecture.
> > 
> > Right, that should be supported, yes. What I meant was that when
> > processing perf.data file with samples where the cpumode can't be inferred,
> > we should use the fallback routines.
> > 
> > It is super unfortunate that we have addresses without a accompanying
> > cpumode :-\ Don't you think those coulde be fixed somehow? If this comes
> > from things synthesized from Intel PT traces, then we can use the address
> > ranges for kernel/userspace to derive that before hitting the core code, that
> > would be fed with addr/cpumode pairs, just like we have hdr.misc &
> > USER/KERNEL and the PERF_CONTEXT_ markers in callchains.
> 
> Yes we will probably need to look at that, but at the moment I would like a fix for stable.

Ok, with that check for archs like sparc, fair enough, and its great
that you consider doing the better fix on top of it, later, thanks!

- Arnaldo
