Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB83C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6745D222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfBLRVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:21:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbfBLRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:21:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 269D888E55;
        Tue, 12 Feb 2019 17:21:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B426600C6;
        Tue, 12 Feb 2019 17:21:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 Feb 2019 18:21:08 +0100 (CET)
Date:   Tue, 12 Feb 2019 18:21:04 +0100
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
Message-ID: <20190212172104.GC29263@redhat.com>
References: <8736p37xcn.fsf@xmission.com>
 <878syu7tcm.fsf@xmission.com>
 <87tvhi4vl7.fsf@xmission.com>
 <87o97q1cky.fsf_-_@xmission.com>
 <20190206180754.GA23476@redhat.com>
 <87imxwv9jp.fsf@xmission.com>
 <875ztwt7yy.fsf_-_@xmission.com>
 <87tvhgrtce.fsf_-_@xmission.com>
 <20190211151840.GB21430@redhat.com>
 <87va1pj2n0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va1pj2n0.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 12 Feb 2019 17:21:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> >> +	/*
> >> +	 * Check if there is another siginfo for the same signal.
> >> +	 */
> >> +	list_for_each_entry_continue(q, &pending->list, list) {
> >> +		if (q->info.si_signo == sync->info.si_signo)
> >> +			goto still_pending;
> >> +	}
> >
> > But this must not be possible? SYNCHRONOUS_MASK doesn't include real-time
> > signals, we can't have 2 siginfo's for the same signal < SIGRTMIN.
>
> Yes for that reason it should be safe to strip that logic out at the
> moment.  I overlooked that when writing the code.
>
> However.  I am not certain that is a limit we actually want to honor
> with synchronous signals.  As it results in a louzy quality of
> implementation.
>
> We start with an instruction in the program being debugged.  In
> principle before that instruction starts we know that no signals
> are pending because they were not delivered to that process.
>
> If we for some reason send signal A to the process and at the same time
> hit a fault that is reported as signal A.  It is currently a race which
> one wins.  I think we could legitimately say that the fault happened
> before signal A was enqueued, and deliver both. It is a bit murkier if
> signal A was blocked.
>
> If we let the enqueued signal A win (as we do today) we have SA_SIGNFO
> that is not useful for describing the fault the instruction generated.
> Which is a really lousy quality of implementation.

I doubt this would be really useful but this doesn't matter right now,

> Which is a long way of saying I think that hunk of code is useful as it
> allows us the possibility of fixing a lousy quality of implementation in
> our code today.

If we ever rework the legacy_queue() logic we can easily add this hunk back.

Until then it complicates the code for no reason imo, just to confuse the reader.

Oleg.

