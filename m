Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCDEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A224121721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="08ftx0rA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfBGUC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:02:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45884 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N4kppCYUcUOnlVR0x/xZGUmpasOnSvYhF6T1O8btqEk=; b=08ftx0rAKEGoamzTHb1LM8m2D
        cC5592p9NtKw5oJGo2vb8llaHnpio+ghLsi7OMbTQaFy17Ts92xZmBD0S1UsT7BW/v21QGGQYkrKA
        B7CDAmg0fG95YqSdnqmGRXoIm/qiuR9Wb/nw7QRzc+MI7OH8tOsmoAFk4nhQE659vGIFD0GsNYyDg
        SrIg6+by3Kqt5e5/E4DaS4x0O4yW08jkKN7PoRIu3kDV8qI6x/2FZzUDL44r0umfjbzaXK5fijXTE
        PHV+0awC7jwoSuzgVTll7U98/34PET0qPvI9pw66ihF0ai6GXHhdMvxDqYlcqI8kfttWNiq0jgbDW
        Yv6iUwthw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grpsC-0007Al-Ta; Thu, 07 Feb 2019 20:02:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 845142029E062; Thu,  7 Feb 2019 21:02:11 +0100 (CET)
Date:   Thu, 7 Feb 2019 21:02:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf, bpf: Retain kernel executable code in memory
 to aid Intel PT tracing
Message-ID: <20190207200211.GG32477@hirez.programming.kicks-ass.net>
References: <20190207111901.2399-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207111901.2399-1-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 01:19:01PM +0200, Adrian Hunter wrote:
> Subject to memory pressure and other limits, retain executable code, such
> as JIT-compiled bpf, in memory instead of freeing it immediately it is no
> longer needed for execution.
> 
> While perf is primarily aimed at statistical analysis, tools like Intel
> PT can aim to provide a trace of exactly what happened. As such, corner
> cases that can be overlooked statistically need to be addressed. For
> example, there is a gap where JIT-compiled bpf can be freed from memory
> before a tracer has a chance to read it out through the bpf syscall.
> While that can be ignored statistically, it contributes to a death by
> 1000 cuts for tracers attempting to assemble exactly what happened. This is
> a bit gratuitous given that retaining the executable code is relatively
> simple, and the amount of memory involved relatively small. The retained
> executable code is then available in memory images such as /proc/kcore.
> 
> This facility could perhaps be extended also to init sections.
> 
> Note that this patch is compile tested only and, at present, is missing
> the ability to retain symbols.

You don't need the symbols; you already have them through
PERF_RECORD_KSYMBOL.

Also; afaict this patch guarantees exactly nothing. It registers a
shrinker which will (given enough memory pressure) happily free your
text before we get around to copying it out.

Did you read this proposal?

  https://lkml.kernel.org/r/20190109101808.GG1900@hirez.programming.kicks-ass.net

(also: s/KCORE_QC/KCORE_QS/ for quiescent state)

That would create an RCU like interface to /proc/kcore and give you the
guarantees you need, while also allowing the memory to get freed once
you've obtained a copy.
