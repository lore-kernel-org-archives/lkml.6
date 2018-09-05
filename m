Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A81C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EE92073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EE92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeIEMYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:24:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:49022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727494AbeIEMYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:24:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 349B2AD47;
        Wed,  5 Sep 2018 07:55:37 +0000 (UTC)
Date:   Wed, 5 Sep 2018 09:55:35 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 2/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <20180905075238.GN24124@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.76.1809050953440.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm> <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm> <20180905075238.GN24124@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Peter Zijlstra wrote:

> >  		if (tsk && tsk->mm &&
> >  		    tsk->mm->context.ctx_id != last_ctx_id &&
> > -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> > +		    ___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))
> >  			indirect_branch_prediction_barrier();
> 
> See how the new (first) argument is 'current' and you could've just used
> the old __ptrace_may_access().

Yeah, 1/3 is dropped in my current series already; this was cherry-picked 
from original Tim's series, but it is indeed superfluous.

Thanks,

-- 
Jiri Kosina
SUSE Labs

