Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86F5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A2D2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tvCkL/4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A2D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeKESxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:53:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59230 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pH81c98NhXivIurhWwXCUWO3HaHYTUbZvABviZkqZk4=; b=tvCkL/4NCEY29kPsreHpQaqA4
        VrjM/K8wA/FD5FQIij5ZchAeEI3BAKCU11gLgqIHjP5ffFJhaPvHLt4cM0GqDK6PYFrao75mtgjm7
        MSAM4zNPnchzNUdCVODi0XM34n6dn6Xm5RmbytrJf3ydqilTDO8FOUgd1pEB+wa0zx0iiR2VW9/sF
        J2XuvyqXBLVtr6slqAGpAYuPz46aQeUa8mrdSbSSJzymV7IP2WniXAFDTOlffUVBfrWJlylXblB08
        zcrdsWI61wIjAsnsmNkzX4/FHHCA4pGtPsPNL3a/9YNPkzMkZGB761QZNEA93nRhyY1vM+Yfx67Ob
        YmwlmYgaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJbGz-0002Tu-1d; Mon, 05 Nov 2018 09:34:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CED42029F86D; Mon,  5 Nov 2018 10:34:13 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:34:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v1 1/8] perf/x86: add support to mask counters from host
Message-ID: <20181105093413.GO3178@hirez.programming.kicks-ass.net>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
 <1541066648-40690-2-git-send-email-wei.w.wang@intel.com>
 <20181101145257.GD3178@hirez.programming.kicks-ass.net>
 <5BDC140F.6060303@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BDC140F.6060303@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 05:08:31PM +0800, Wei Wang wrote:
> On 11/01/2018 10:52 PM, Peter Zijlstra wrote:
> > > @@ -723,6 +724,9 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
> > >   	sched->max_weight	= wmax;
> > >   	sched->max_gp		= gpmax;
> > >   	sched->constraints	= constraints;
> > > +#ifdef CONFIG_CPU_SUP_INTEL
> > > +	sched->state.used[0]	= cpuc->intel_ctrl_guest_mask;
> > > +#endif
> > NAK.  This completely undermines the whole purpose of event scheduling.
> > 
> 
> Hi Peter,
> 
> Could you share more details how it would affect the host side event
> scheduling?

Not all counters are equal; suppose you have one of those chips that can
only do PEBS on counter 0, and then hand out 0 to the guest for some
silly event. That means nobody can use PEBS anymore.

> Would you have any suggestions?

I would suggest not to use virt in the first place of course ;-)

But whatever you do; you have to keep using host events to emulate the
guest PMU. That doesn't mean you can't improve things; that code is
quite insane from what you told earlier.
