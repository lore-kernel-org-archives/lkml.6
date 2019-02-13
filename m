Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96E320835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392310AbfBMOi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:38:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59163 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbfBMOi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:38:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA10489AE4;
        Wed, 13 Feb 2019 14:38:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id A2E76608A5;
        Wed, 13 Feb 2019 14:38:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Feb 2019 15:38:56 +0100 (CET)
Date:   Wed, 13 Feb 2019 15:38:52 +0100
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
        syzkaller <syzkaller@googlegroups.com>,
        Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH] signal: Restore the stop PTRACE_EVENT_EXIT
Message-ID: <20190213143852.GC9356@redhat.com>
References: <87o97q1cky.fsf_-_@xmission.com>
 <20190206180754.GA23476@redhat.com>
 <87imxwv9jp.fsf@xmission.com>
 <875ztwt7yy.fsf_-_@xmission.com>
 <87zhr8rtd6.fsf_-_@xmission.com>
 <20190211141340.GA21430@redhat.com>
 <87zhr1g7ls.fsf@xmission.com>
 <871s4dctci.fsf@xmission.com>
 <20190212165022.GA29263@redhat.com>
 <87ef8c5nyt.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef8c5nyt.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 13 Feb 2019 14:38:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for noise, but after I read the changelog I have a minor nit,
feel free to ignore...

On 02/12, Eric W. Biederman wrote:
>
> Skipping past dequeue_signal when we know a fatal signal has already
> been delivered resulted in SIGKILL remaining pending and
> TIF_SIGPENDING remaining set.  This in turn caused the
> scheduler to not sleep in PTACE_EVENT_EXIT as it figured
> a fatal signal was pending.

Yes, but the status of TIF_SIGPENDING doesn't matter. However I agree
with recalc_sigpending() added by this patch, simply because this is what
the "normal" dequeue_signal() paths do.

> This also caused ptrace_freeze_traced
> in ptrace_check_attach to fail because it left a per thread
> SIGKILL pending which is what fatal_signal_pending tests for.

this is possible too, but in the likely case ptrace_check_attach() won't
be even called exactly because the tracee won't stop and thus waitpid()
won't report WIFSTOPPED. And even if waitpid() "wins" the race and debugger
calls ptrace(), most probably ptrace_freeze_traced() will fail because
task_is_traced() will be false.

I think this part of the changelog looks a bit confusing. It doesn't matter
why ptrace_check_attach() fails, it must fail if the tracee didn't stop.

PTACE_EVENT_EXIT won't stop and thus this event won't be reported, that is all.

again, feel free to ignore.

Oleg.

