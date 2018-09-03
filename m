Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A670C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCBB2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NFqgltev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCBB2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeICS5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:57:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38398 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n+NrzANcKKKLQ89PESAM5PRPnf9DhymXBOWBVfZlMsQ=; b=NFqgltevm7URZAV75G7/fW3pG
        exLimpHCFt1N/Fq9B8C6JVxUsuo2ampjweNOpDsR9j2jmOMM/jrcIaJ8baX/gO6syo8Gb4UmOqANr
        b3NCCwc66PejBlr4QP16MFPbVvkbrGRK2HOE6+xUcFDolpPQPob1e5HhjuLHQ92sV+xkuDTZPLVBs
        kWf9Q6v4RxQkv6J1GEEh/7G+cOj7HhjvM3ZpbcRPEqRg/QYimSK/1q4g+hidSuFIodacdBug3dG3X
        x5dIYiIT+q6G4HsCPq8V2u+na+87reFhCotvm+Nr1SJr/GopM0+9h0welWacE19FUnu92mzKmitW0
        FWW2UCHxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwpyM-0008RS-Ts; Mon, 03 Sep 2018 14:36:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8A8F2018FA20; Mon,  3 Sep 2018 16:36:56 +0200 (CEST)
Date:   Mon, 3 Sep 2018 16:36:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 3/3] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
Message-ID: <20180903143656.GD24142@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1809031444160.25787@cbobk.fhfr.pm>
 <20180903143444.GW24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903143444.GW24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:34:44PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 03, 2018 at 02:45:31PM +0200, Jiri Kosina wrote:
> 
> > +static bool __init stibp_needed(void)
> > +{
> > +	return (cpu_smt_control != CPU_SMT_NOT_SUPPORTED &&
> > +			boot_cpu_has(X86_FEATURE_STIBP));
> > +}
> 
> Should that not be:
> 
> 	((cpu_smt_control != CPU_SMT_NOT_SUPPORTED) ||

s/||/&&/

> 	 (cpu_smt_control != CPU_SMT_FORCE_DISABLED)) &&
> 	boot_cpu_has(X86_FEATURE_STIBP);
> 
> instead?
