Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D751C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F330F20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfBAKc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:32:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbfBAKc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:32:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD29C80D;
        Fri,  1 Feb 2019 02:32:58 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18E813F71E;
        Fri,  1 Feb 2019 02:32:56 -0800 (PST)
Date:   Fri, 1 Feb 2019 10:32:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190201103254.GB31409@lakrids.cambridge.arm.com>
References: <1548678448-24458-1-git-send-email-elena.reshetova@intel.com>
 <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
 <20190129093748.GF28467@hirez.programming.kicks-ass.net>
 <2236FBA76BA1254E88B949DDB74E612BA4B98D3A@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B98D3A@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
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

If you use recount_inc_checked(), it will always produce the WARN(),
even when using the x86-specific refcount implementation.

(this was one place I had intended to use the *_checked() forms of the
refcount ops).

Thanks,
Mark.
