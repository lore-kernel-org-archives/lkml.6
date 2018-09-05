Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FFBC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337A520839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2xEhAzwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337A520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeIEXep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:34:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MUsKO0pa0Um+zuT4YtYePUtZuX5JqC56U8InfzuVuVA=; b=2xEhAzwME1IIkrnorIEHrUx0/
        RYkTdflEibIfgJbdcToN9Y4fb+mE7yvT+NOTBF8uHlClXawRI5Edt3zhc8b8lKzFQKb9U5eG4+hdy
        sYTs5LljeJ5grJJ2hbJKywdZHQcxPOoJ5jKYXTcREQ1liSy8TZAgEsPRGzpWxUI+QauzBL9ifDEUB
        zzBQZFhdiCdAokwJ3rz8woCGGRlUnXU12O+JxmNbpKSctV5TCyJDD2fyEzwjjKE3vLaUVvyrInh3w
        beoxzvNKUZlTptX+cDNtIECD3VtidKTAN+dLMH72POZCG2jZSVqpGSPQsearqEjhtJF+HBegWB0Z6
        9qKxiUNzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxd53-0000xG-Dd; Wed, 05 Sep 2018 19:03:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4089920210301; Wed,  5 Sep 2018 21:03:08 +0200 (CEST)
Date:   Wed, 5 Sep 2018 21:03:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Message-ID: <20180905190308.GD24082@hirez.programming.kicks-ass.net>
References: <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809042046180.15880@cbobk.fhfr.pm>
 <3f24e8c8-eab8-66c2-9a8d-957e30cac809@linux.intel.com>
 <nycvar.YFH.7.76.1809050725390.15880@cbobk.fhfr.pm>
 <20180905155823.GL27886@tassilo.jf.intel.com>
 <20180905180459.GB11625@redhat.com>
 <nycvar.YFH.7.76.1809052026470.15880@cbobk.fhfr.pm>
 <20180905184018.GC11625@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905184018.GC11625@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:40:18PM -0400, Andrea Arcangeli wrote:
> [ 1838.769917]  <<EOE>>  [<ffffffff816391e5>] avc_compute_av+0x126/0x1b5

That does read_lock(), which is not allowed from scheduler context.

> [ 1838.777125]  [<ffffffff810b842e>] ? walk_tg_tree_from+0xbe/0x110
> [ 1838.783828]  [<ffffffff8128b9c4>] avc_has_perm_noaudit+0xc4/0x110

In current code this can end up in avc_update_node() which uses
spin_lock(), which is a bug from scheduler context.o

> [ 1838.790628]  [<ffffffff8128f1fb>] cred_has_capability+0x6b/0x120
> [ 1838.797331]  [<ffffffff810db71c>] ? ktime_get+0x4c/0xd0
> [ 1838.803160]  [<ffffffff810e167b>] ? clockevents_program_event+0x6b/0xf0
> [ 1838.810532]  [<ffffffff8128f2de>] selinux_capable+0x2e/0x40
> [ 1838.816748]  [<ffffffff81288f65>] security_capable_noaudit+0x15/0x20
> [ 1838.823829]  [<ffffffff8108b975>] has_ns_capability_noaudit+0x15/0x20
> [ 1838.831014]  [<ffffffff8108bc55>] ptrace_has_cap+0x35/0x40
> [ 1838.837126]  [<ffffffff8108c717>] ___ptrace_may_access+0xa7/0x1e0
> [ 1838.843925]  [<ffffffff8163f0ae>] __schedule+0x26e/0xa00
> [ 1838.849855]  [<ffffffff81640949>] schedule_preempt_disabled+0x29/0x70
> [ 1838.857041]  [<ffffffff810d9324>] cpu_startup_entry+0x184/0x290
> [ 1838.863637]  [<ffffffff8104891a>] start_secondary+0x1da/0x250

So yes, looks like all that security LSM nonsense isn't going to work
here.
