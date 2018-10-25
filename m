Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E2ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567EB20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FErjD/W7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567EB20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeJYJB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:01:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42890 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CgC4g0mll3ZZWqx4PkJGZeMlKrBWbcp3tZ2wKgX2aUo=; b=FErjD/W7EKmLANk8bT0AXqQ+9
        N/uKe1/Ar/eRnaJopl3bSIim2cjjpHkiSiVWZ+gLX3LyxnGWAKSq9IxJee06CfapnuoNclAeBngkn
        fnw+opUE+jYK/C/gHD4SIADzFji43Ozv+6FEEycAyW3NlxjtXKXK0kzY1GBFZ2FyKR2ouGbMOGAr0
        Tlef1J0AC+6Yf4XUDeU0Yp7hV7zzCGWqK8cJW48msC4Q9Vd1q/ib00Fid+2mZ6PveCpJuxqnGu54G
        Sgez83uTTZb5xP6SZVNRhb+jYzxVYZUFSq50JrbhynlUT4eONvG03m/ZfxVrVWw+gNIktzoLITd96
        MQz9HwqEw==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTYj-0002Up-Dm; Thu, 25 Oct 2018 00:31:33 +0000
Received: by worktop (Postfix, from userid 1000)
        id C92CD6E0794; Thu, 25 Oct 2018 02:31:30 +0200 (CEST)
Date:   Thu, 25 Oct 2018 02:31:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf: Add munmap callback
Message-ID: <20181025003130.GU3109@worktop.c.hoisthospitality.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <20181024162334.GG6218@tassilo.jf.intel.com>
 <20181024163208.GC15106@kernel.org>
 <18d5fcf4-84b2-806c-eb2c-787b96e0fb90@linux.intel.com>
 <20181024182854.GH6218@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024182854.GH6218@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:28:54AM -0700, Andi Kleen wrote:
> > > void perf_event_mmap(struct vm_area_struct *vma)
> > > {
> > >          struct perf_mmap_event mmap_event;
> > > 
> > >          if (!atomic_read(&nr_mmap_events))
> > >                  return;
> > > <SNIP>
> > > }
> > > 
> > 
> > Thanks. I'll add the nr_mmap_events check in V2.
> 
> No, that's the wrong check here. The PEBS flush is independent of mmap
> events being requested.
> 
> If anything would need to check for any PEBS events active, which
> would need a new counter.  I think the easiest is to just check if 
> this_cpu_ptr(&sched_cb_list)
> is empty, which should be good enough.

It is just the CLI+STI, not PUSHF;CLI+POPF that are required and that is
a lot cheaper already. Also, you need to have preemption disabled in
order to check the per-cpu cb list.

So I don't think it really makes much sense to try and frob a fast path
in there.
