Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4850C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91956214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fw5AuDDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfBDQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:15:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37326 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfBDQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VYajBa1BYby6ufTum2M/rjNHepYAF4BRHR9z6RTXB1k=; b=fw5AuDDlJNzy77pZ8zfdXhxSq
        9BEE1famCD0lj+DIuUjqDNCX4lm2RCFbnlFezU9yDZegCr0GHfjf5fwdxQCV69KS3VbExjRrmfPEe
        nvwfTvWgnf876f7zuedw8eV/FooPIxoORmZM3dvyE7R5mOVvUDRHPcKJdwJGivnAZZaZC2ydcjbWP
        EGoi0HOpBZJQ+GNWdjGqUly3kgGX67UEdkH6Fx4Mv7Cv0ojQOZFuyV0sjsWcXE880tJTGGUNdrMwn
        jj+2SCzVeKx9xxKge303VrnHRyU0ypuBUX9smkmcoEhYFTHsG6YdGhkwZIpOqvP/g331PgSpMJtgI
        5M4c3p02g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqgu2-0002BY-92; Mon, 04 Feb 2019 16:15:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE0632029F1D6; Mon,  4 Feb 2019 17:15:20 +0100 (CET)
Date:   Mon, 4 Feb 2019 17:15:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204161520.GI17528@hirez.programming.kicks-ass.net>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <d1161b7f-0f2c-4219-4f6d-225f12a333a2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1161b7f-0f2c-4219-4f6d-225f12a333a2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:43:41AM -0500, Liang, Kan wrote:
> > --- a/arch/x86/events/intel/ds.c
> > +++ b/arch/x86/events/intel/ds.c
> > @@ -1628,6 +1628,7 @@ void __init intel_ds_init(void)
> >   	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
> >   	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
> >   	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
> > +	x86_pmu.pebs_no_isolation = 1;
> 
> We will submit the Icelake support soon (probably next week).
> That will be a problem for Icelake.

We can have ICL set it to 0 explicitly, but explicitly setting it to 1
_11_ times is just silly.

Also, what perfmon version will ICL have? If it were to be 5 we could
key off of that.
