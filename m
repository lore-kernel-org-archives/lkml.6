Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B408C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18A62075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tVSJ462K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18A62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeIEOJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:09:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59216 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeIEOJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jEfNrN6VE7VmnubqZQBJULZSnD7HjwLBUII1KO1Sq4k=; b=tVSJ462KwfB7+pzm2+kKe92nr
        GF2nHrbCdWEfvHWX7nXVqODSbTo5nNUQTBiPNlqUVS1vwlzetm6fJvdvX12Hf4N4zTHMLQhxbrY5h
        kk/4ZDw88YRN0vBjOl+rKp+xmi3k/m8K4stkKFMEoyW4EbFzI0u/NNhUp9BODL16LGfIDhmPF6p/P
        WhEf/GXhlktm/dE0orVoiZvKKPX5B+rxWjzl7Qrv9/hov3hu+CC1cyZOBzRh3v7xWOv8WS9JII0wf
        q7ew+eUPd6+De7H4ZfQPwf+jaUNrxxgRSEI1L+NUIRdrZMxxb+xgy6hALp8oWshAPsHr1ojcUxPUh
        XX+eqXdXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxUII-0004NR-MC; Wed, 05 Sep 2018 09:40:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63DF2202AFE0E; Wed,  5 Sep 2018 11:40:12 +0200 (CEST)
Date:   Wed, 5 Sep 2018 11:40:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
Message-ID: <20180905094012.GT24082@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm>
 <alpine.DEB.2.21.1809041804080.3395@nanos.tec.linutronix.de>
 <20180905075913.GO24124@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1809051001360.15880@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1809051001360.15880@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:02:41AM +0200, Jiri Kosina wrote:
> Yeah, I did more or less that earlier today; my series currently has

Excellent, maybe add a wee comment like so?

> +static bool ibpb_needed(struct task_struct *tsk, u64 last_ctx_id)
> +{
	/*
	 * Check if the current (previous) task has access to the memory
	 * of the @tsk (next) task. If access is denied, make sure to
	 * issue a IBPB to stop user->user Spectre-v2 attacks.
	 *
	 * Note: __ptrace_may_access() returns 0 or -ERRNO.
	 */
> +       return (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id &&
> +                       __ptrace_may_access(tsk, PTRACE_MODE_IBPB));
> +}
