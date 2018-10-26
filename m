Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70207ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A5E2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFySa6Ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A5E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJ0FWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeJ0FWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:22:08 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A3820856;
        Fri, 26 Oct 2018 20:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540586618;
        bh=K+Vyr2qDchLdtP68ib/jVR4oCCmNq+qHcosG4QVgsC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFySa6EeUX+oD/6uZdQtSUi/YXFUjXiKdSPqZt4NGERbZHlVQ6WyZwFm6TZoLTXuw
         W1olShprpQqlPy0TVhC8uyv515kSpshQipiIkXvCa7+IZG3UNrzWSgWrTdSvYX89ra
         VJPoef42kgssQWgRRkwzytCZ97Dp3p1xG9udlJhY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 28B95142C5F; Fri, 26 Oct 2018 17:43:35 -0300 (-03)
Date:   Fri, 26 Oct 2018 17:43:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: A concern about overflow ring buffer mode
Message-ID: <20181026204335.GK3353@kernel.org>
References: <20181026.104513.2239058788450235574.davem@davemloft.net>
 <20181026183805.GD3353@kernel.org>
 <20181026184255.GE3353@kernel.org>
 <20181026190211.GF3353@kernel.org>
 <3b81c999-9039-94e9-7a74-cdbd48fca08b@linux.intel.com>
 <20181026191231.GG3353@kernel.org>
 <65cbd052-15d9-f3fb-4a8f-781c3ce7a297@linux.intel.com>
 <20181026192424.GH3353@kernel.org>
 <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 26, 2018 at 04:11:51PM -0400, Liang, Kan escreveu:
> 
> 
> On 10/26/2018 3:24 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 26, 2018 at 03:16:29PM -0400, Liang, Kan escreveu:
> > > 
> > > 
> > > On 10/26/2018 3:12 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Oct 26, 2018 at 03:07:40PM -0400, Liang, Kan escreveu:
> > > > > On 10/26/2018 3:02 PM, Arnaldo Carvalho de Melo wrote:
> > > > > > So, I'm adding the following to my tree to help in diagnosing problems
> > > > > > with this overwrite mode:
> > > > > Actually, you can use per-event overwrite term to disable overwrite mode for
> > > > > perf top.
> > <SMIP>
> > > > I see, it will disable that opts->overwrite if it finds the no-overwrite
> > > > in the per-event definition, so the equivalent of the option I added
> > > > below:
> > 
> > > >        perf top --no-overwrite
> > 
> > > > is:
> > 
> > > >        perf top -e cycles/no-overwrite/
> > 
> > > > I checked and both have the same result. But I still think there is
> > > > value in having the shorter form, ok?
> > 
> > > Sure.
> > 
> > Ok.
> > 
> > I think that we should default back to --no-overwrite till we get this
> > sorted out, as the effect is easily noticeable, as David reported and I
> > reproduced, when doing kernel builds.
> 
> It is mainly for performance reason to switch to overwrite mode. The impact
> was very small when I did my test. But now the effect is easily noticeable
> in other tests. Yes, I agree. We may change it back to non-overwrite mode
> until the issue is addressed.

ok
 
> > On systems such as Knights Landing/Mill one can use --overwrite, knowing
> > about this current map resolving limitation, i.e. for workloads where
> > there are not that many short lived threads or mmap'ing, that could be
> > possibly tolerable.
 
> Could you please add this in the description of --overwrite?
> It looks like the --overwrite is not default anymore.
> +--overwrite::
> +	This is the default, but for investigating problems with it or any other
> strange
> +	behaviour like lots of unknown samples, we may want to disable this mode
> by using
> +	--no-overwrite.

Ok, when I make that change, then I'll change the documentation for the
option.
 
> > Fixing this properly will probably involve using the ordered_events code
> > and two evlist, one for the PERF_RECORD_!SAMPLE in non-overwrite mode
> > and the other for PERF_RECORD_SAMPLE in overwrite mode, else someone
> > comes up with some better solution :-)
> > 
> 
> Supporting both overwrite and non-overwrite mode?

Not on the same ring buffer, two ring buffers, one overwrite, the
other non-overwrite, get events from both and order, then consume, like
perf_session does now when processing perf.data files.

> I think that needs some changes in kernel. May need to split the ring buffer
> for different mode. I think it should be very complex.
> But I don't have a better solution for now. :)
