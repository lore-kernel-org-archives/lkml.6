Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC3121582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PirmT4s2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC3121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeI0U6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:58:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0U6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=buCRwmHNvExvu+LfuynG8JvJ7SOBenDPor7zQBjTu3Q=; b=PirmT4s2BBnGd57Z9gBRfkCGF
        tbCAiCrnWlCKmACDY9ITdEd6pmKKasizUyXoYekrUbBkAw1OpEI9qde6vCXioV/dypg809OPmqlom
        dim/bWoHHp7fg3JqGladyo7wpaf49a7SHsGhQgtXIKbfJH7VXE6U6YCTcBRiifE0SmN9AvqgAY97e
        qibVFUju19ktacJI946765oBOpB22PtM6BEjTvhmGnwiA2bmBtnvLPzeHjg4U/PdCIndnVeh1CktH
        FTa2Nr2nl2DvLs+tvyz796Ma3KxXFw6ylo6IEyy6jAyQXxbCiNrNSpOKEz7JThGq3UL6vbI30YHqI
        Ey9J5XS0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5XRd-0007gO-1M; Thu, 27 Sep 2018 14:39:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5819210708F2; Thu, 27 Sep 2018 16:39:04 +0200 (CEST)
Date:   Thu, 27 Sep 2018 16:39:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V2 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI
 handler
Message-ID: <20180927143904.GC3439@hirez.programming.kicks-ass.net>
References: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
 <1533712328-2834-2-git-send-email-kan.liang@linux.intel.com>
 <20180927125141.GA3439@hirez.programming.kicks-ass.net>
 <79e026f0-dabc-ba29-2a90-a6b24521b525@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e026f0-dabc-ba29-2a90-a6b24521b525@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:53:28AM -0400, Liang, Kan wrote:
> 
> 
> On 9/27/2018 8:51 AM, Peter Zijlstra wrote:
> > On Wed, Aug 08, 2018 at 12:12:07AM -0700, kan.liang@linux.intel.com wrote:
> > > @@ -4325,6 +4428,8 @@ __init int intel_pmu_init(void)
> > >   		x86_pmu.extra_regs = intel_skl_extra_regs;
> > >   		x86_pmu.pebs_aliases = intel_pebs_aliases_skl;
> > >   		x86_pmu.pebs_prec_dist = true;
> > > +		x86_pmu.counter_freezing = disable_counter_freezing ?
> > > +					   false : true;
> > >   		/* all extra regs are per-cpu when HT is on */
> > >   		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
> > >   		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
> > 
> > 
> > How about so instead? It is very much tied to the perfmon version, not
> > the FMS.
> > 
> 
> Yes, it matches the name of the handler.
> But the change as below is not sufficient. We have to temporarily disable
> counter_freezing in this patch for small core.
> The 3/3 patch will also be impact.
> 
> I will send V3 patch for these changes.

Hold on, I just munched the third patch on top as well.

Let me push out the lot so you can have a peek..

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/core
