Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61003ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AFC20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Keo8+DRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AFC20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbeGWRtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:49:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43418 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388283AbeGWRtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SOWNgE1DoVoWvSar1jHSbG/W7jf664ME7atkVJ0oJVs=; b=Keo8+DRzBrNmMiU9U4DetlASp
        Wt0VrFNgO38kBrGQWdjIeBT6HGVOxtTxJkK6s3SshunK9Kb+S0L9vyOCfRZtXuFuDVBjzqvyzuwPF
        cIH2zdeUUAUy0ajO5G4YJxU61XuEmE6G9P9o0uVOvBrgWkN7BK3CEKX0X+dmYSp/lt+V/CWh6iTQS
        LMEZMBarlcjiJj5gioGuy505kN+/xyM/5DsXKcpjdOSenlM8tF31vwOc5n3+fEyCQbBZSrsXJAjId
        b9EXK9BQyy0EBvxSV+O8Z03/wrTAqD4ekLb2N5p9G0rAuRZpOkfBIZco1hvSaToJZqhvbf22TsW8Q
        +XVt0XNMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhdzl-0008Rb-Po; Mon, 23 Jul 2018 16:47:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B3642026831C; Mon, 23 Jul 2018 18:47:35 +0200 (CEST)
Date:   Mon, 23 Jul 2018 18:47:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/19]  Fixes for sched/numa_balancing
Message-ID: <20180723164735.GI2494@hirez.programming.kicks-ass.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180723135700.GX2458@hirez.programming.kicks-ass.net>
 <20180723150954.GI30345@linux.vnet.ibm.com>
 <20180723152147.GE2494@hirez.programming.kicks-ass.net>
 <20180723162954.GA2699@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723162954.GA2699@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 09:29:54AM -0700, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-07-23 17:21:47]:
> 
> > On Mon, Jul 23, 2018 at 08:09:55AM -0700, Srikar Dronamraju wrote:
> > 
> > > > >   sched/numa: Stop multiple tasks from moving to the cpu at the same time
> > > 
> > > This patch has go-ahead from Mel and Rik and no outstanding comments.
> > 
> > I left it out because it's part of the big xchg() mess.
> > 
> > In particular:
> > 
> > +       if (xchg(&rq->numa_migrate_on, 1))
> > +               return;
> > +
> > +       if (env->best_cpu != -1) {
> > +               rq = cpu_rq(env->best_cpu);
> > +               WRITE_ONCE(rq->numa_migrate_on, 0);
> > +       }
> > 
> > I'm again confused by clearing numa_migrate_on at this point..
> 
> First task choose a cpu to swap/migrate, sets the cpu to best_cpu and
> also numa_migrate_on.  Next it finds a better cpu to swap/move. Now if
> the task is able to move to the better cpu, then it should clear
> numa_migrate_on on the previous best_cpu.
> 
> If we dont reset numa_migrate_on on finding a better cpu, the
> numa_migrate_on stays set for the previous cpu, causing previous cpu to
> never be a target of numa balance.

Don't tell me, write better patches.
