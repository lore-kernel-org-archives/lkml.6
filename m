Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED33DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9959A214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1HUqiXr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9959A214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJQTCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:02:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQTCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2uXTb0Wb29vDfEw3LjOk74sK6S3NB93y4fR3Dz/EytU=; b=1HUqiXr9XFtux2FAzqC/FgyCNZ
        ZQCfkVNE/B1wWWvzxwQDKySj26bLkgqHsuhi+LhRm/opWuYgJD12iq/3AJ8lIsOvYEzWIClOVKI06
        Wzu1PdApf2xC/jg1CKyGSZ+sEhQIB0t4m4esS0MCEhtB0Q14PCoVHt0HBpdF/oMtMbrDxkEoI/Ffd
        NBdMu3T0tpbga3cj7drTwG2FPB1wFtE5LZrOxivJqYx6EONcMRJVV1T8n5p19aenVovhee30NuD7Z
        cnNs6RGViB3/eXbNFRS4mx+6g0RvP0lTkkOcgbScqbQfNjrbZRgtq+cqqXlQjRTxbkFDGKUq83GVS
        GSwDeSyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCjfB-0000p6-Nm; Wed, 17 Oct 2018 11:06:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B73520298568; Wed, 17 Oct 2018 13:06:51 +0200 (CEST)
Date:   Wed, 17 Oct 2018 13:06:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181017110651.GI3121@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
 <AF0FCD08-E014-4D29-B023-EA780056DBB5@fb.com>
 <FE66AE20-9785-4CF7-8D8D-CF2A9C696923@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <FE66AE20-9785-4CF7-8D8D-CF2A9C696923@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:28:10PM +0000, Song Liu wrote:
> > How about this:=20
> >=20
> > 1. Keep multiple perf_cpu_context per CPU, just like before this patch.=
=20
> >=20
> > 2. For perf_event_context, add PMU as an order for the RB tree.=20
> >=20
> > 3. (hw) pmu->perf_cpu_context->ctx only has events for this PMU (and sw=
=20
> >   events moved to this context).
> >=20
> > 4. task->perf_event_ctxp has events for all PMUs.=20
> >=20
> > With this path, we keep the existing perf_cpu_context/perf_event_context
> > logic as-is, which I think is simp=10ler than the new logic (with extra
> > *_pmu_context). And it should also solve the problem.=20
> >=20
> > Does this make sense? If this doesn't look too broken, I am happy to
> > draft RFC for it.=20
> >=20
>=20
> I am not sure whether you missed this one, or found it totally insane.=20
> Could you please share your comments on it? My gut feeling is that this=
=20
> would be a simpler patch to solve the problem (two hw PMUs). (It might=20
> be less efficient though).=20

Ah, sorry, somehow this email got lost.

That makes task and cpu contexts wildly different, which will complicate
matters I feel.

