Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857BEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB0220868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB0220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeICSSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:18:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbeICSSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:18:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A906FAFCE;
        Mon,  3 Sep 2018 13:57:52 +0000 (UTC)
Date:   Mon, 3 Sep 2018 15:57:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/3] x86/speculation: Apply IBPB more strictly to
 avoid cross-process spectre v2 leak
In-Reply-To: <20180903134751.GV24124@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.76.1809031555530.25787@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809031443540.25787@cbobk.fhfr.pm> <20180903134751.GV24124@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018, Peter Zijlstra wrote:

> >  		if (tsk && tsk->mm &&
> >  		    tsk->mm->context.ctx_id != last_ctx_id &&
> > -		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
> > +		    ___ptrace_may_access(tsk, current, PTRACE_MODE_IBPB))
> >  			indirect_branch_prediction_barrier();
> 
> So the question posed here is: can @next ptrace @prev?
> 
> Which confuses me greatly; it is @prev doing the BTB poisoning for
> @next, so we want to know if @prev can ptrace @next, no?

Good catch, it's the other way around, thanks.

I'll wait for more review and send eventually v3 properly threaded (sorry 
for that as well ... not the best monday I've had today).

-- 
Jiri Kosina
SUSE Labs

