Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D60C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B83222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391874AbfBKPSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:18:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391861AbfBKPSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:18:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1036087648;
        Mon, 11 Feb 2019 15:18:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B92B620D7;
        Mon, 11 Feb 2019 15:18:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Feb 2019 16:18:43 +0100 (CET)
Date:   Mon, 11 Feb 2019 16:18:40 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH 2/2] signal: Better detection of synchronous signals
Message-ID: <20190211151840.GB21430@redhat.com>
References: <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
 <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
 <8736p37xcn.fsf@xmission.com>
 <878syu7tcm.fsf@xmission.com>
 <87tvhi4vl7.fsf@xmission.com>
 <87o97q1cky.fsf_-_@xmission.com>
 <20190206180754.GA23476@redhat.com>
 <87imxwv9jp.fsf@xmission.com>
 <875ztwt7yy.fsf_-_@xmission.com>
 <87tvhgrtce.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvhgrtce.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 11 Feb 2019 15:18:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, I'll try to finally read the whole thread later, probably I missed
something, but...

On 02/07, Eric W. Biederman wrote:
>
> Recently syzkaller was able to create unkillablle processes by
> creating a timer that is delivered as a thread local signal on SIGHUP,
> and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop failing
> to deliver SIGHUP but always trying.
>
> When the stack overflows delivery of SIGHUP fails and force_sigsegv is
> called.  Unfortunately because SIGSEGV is numerically higher than
> SIGHUP next_signal tries again to deliver a SIGHUP.

Confused... In this particular case next_signal() should return SIGSEGV
because it must be pending too and SYNCHRONOUS_MASK doesn't include SIGHUP.

Not that it really matters, the timer can deliver another SYNCHRONOUS_MASK
signal < SIGSEGV, just I am trying to understand what have I missed...

> +	/*
> +	 * Check if there is another siginfo for the same signal.
> +	 */
> +	list_for_each_entry_continue(q, &pending->list, list) {
> +		if (q->info.si_signo == sync->info.si_signo)
> +			goto still_pending;
> +	}

But this must not be possible? SYNCHRONOUS_MASK doesn't include real-time
signals, we can't have 2 siginfo's for the same signal < SIGRTMIN.

Oleg.

