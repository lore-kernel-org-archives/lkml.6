Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B91CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A012073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1L4BEoJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A012073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIEMVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:21:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57914 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeIEMVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qhzfZW+9aQS7VMMF3q18FnhsfKlwAziHfmHjOfyfhig=; b=1L4BEoJqpWnsC8cyD4/tuBq3y
        Tb6+F0YLqA7C2vXHSo0V2F8+rxPc1z974m/CBnNDmJeiCpsjSsDKlJt2hUbMloUUWM8mNwqJSX+iN
        GC+zIJmE+UD+rOlI2nRoV4R7qyIsdo1sLWo3RhACxwaSnAtHz9gELNO+2s57AlVTk8zFyZDvJADDI
        wd27sGW3YmpzXD2JQoZIq6ktTjmPACuo8WnGUp5KNtQCghZhjQcYPNIehq8eRqdAXdOQjpCveF4FA
        mjJmFF0zQHljf8dD+OghOZzok1g16R4LVsYOm15fL9Q3BzguJujRqRAFKqCJtG8vy9AAeNJls0C7p
        tvQDYh1bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxScE-0003iQ-2e; Wed, 05 Sep 2018 07:52:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5587C20191BFF; Wed,  5 Sep 2018 09:52:38 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:52:38 +0200
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
Message-ID: <20180905075238.GN24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 04:42:02PM +0200, Jiri Kosina wrote:
>  		if (tsk && tsk->mm &&
>  		    tsk->mm->context.ctx_id != last_ctx_id &&
> -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> +		    ___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))
>  			indirect_branch_prediction_barrier();

See how the new (first) argument is 'current' and you could've just used
the old __ptrace_may_access().
