Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0A0C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8550218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SvrFrD5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfA3JBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:01:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NqDUB5Wd/XUEMgwbEk0/BKMTKVF42AwD0C25SlxCTsM=; b=SvrFrD5cUNam1gYWkvb1RnzpR
        hNfxNzmybxyoP19xMFsEJKPRUpI+/COB/9jjy4pg5F9BlbdgfnIg90I8yXvSMPZ6WG4ApAJqmNajs
        zPMFx6BjDAGPK4GG4sIDm5YV8KfH9s7NcnH+nc1vEtuUgOCS3eiBRJtqfCroG3J6d6gWHcUM8eUj4
        xUqIEMTUwQlnC/XEHRjZb1fzwEC+tQ6frpPUb/G6seIPLKd+YK5vo5KhJFcLDWA1xfMKfv9c9sgHH
        mHODA4EenUzIqVqtJwKX8vFaL/t1a70AO6MA140B6B3cfp2CGuYYbUgq6Lx3D91H30Vcwy4ysDUGu
        jwf2QmVVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1golkj-0005NI-8S; Wed, 30 Jan 2019 09:01:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC9F020289CC5; Wed, 30 Jan 2019 10:01:47 +0100 (CET)
Date:   Wed, 30 Jan 2019 10:01:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] perf: convert perf_event_context.refcount to
 refcount_t
Message-ID: <20190130090147.GB2278@hirez.programming.kicks-ass.net>
References: <1548678448-24458-1-git-send-email-elena.reshetova@intel.com>
 <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
 <20190129093748.GF28467@hirez.programming.kicks-ass.net>
 <2236FBA76BA1254E88B949DDB74E612BA4B98D3A@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B98D3A@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 01:55:32PM +0000, Reshetova, Elena wrote:
> > On Mon, Jan 28, 2019 at 02:27:26PM +0200, Elena Reshetova wrote:
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 3cd13a3..a1e87d2 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -1171,7 +1171,7 @@ static void perf_event_ctx_deactivate(struct
> > perf_event_context *ctx)
> > >
> > >  static void get_ctx(struct perf_event_context *ctx)
> > >  {
> > > -	WARN_ON(!atomic_inc_not_zero(&ctx->refcount));
> > > +	WARN_ON(!refcount_inc_not_zero(&ctx->refcount));
> > 
> > This could be refcount_inc(), remember how that already produces a WARN
> > when we try and increment 0.
> 
> But is this true for the x86 arch-specific implementation also? 

Dunno; but when debugging you should not have those enabled anyway.
