Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482D2C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF634216F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF634216F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeHHDFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeHHDFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:05:23 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D950216F5;
        Wed,  8 Aug 2018 00:48:22 +0000 (UTC)
Date:   Tue, 7 Aug 2018 20:48:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180807204820.50b83c6d@vmware.local.home>
In-Reply-To: <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180730222423.196630-4-joel@joelfernandes.org>
        <20180806155058.5ee875f4@gandalf.local.home>
        <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
        <20180806214300.13e63523@gandalf.local.home>
        <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
        <20180807094954.5137972d@gandalf.local.home>
        <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
        <20180807103410.4fe203cb@gandalf.local.home>
        <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com>
        <20180807110906.3a1b0ac4@gandalf.local.home>
        <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
        <20180807194515.4e549c1a@gandalf.local.home>
        <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018 19:54:13 -0400
Joel Fernandes <joelaf@google.com> wrote:


> >OK, I hit this bug, but it's not because of the partial revert. This
> >bug seems it needs to be another partial revert. I like you movement of
> >the code, but I'm starting to doubt that we can use a trace event as a
> >hook for critical areas yet. Well, not until we can use srcu in NMI.
> >  
> 
> I sent a patch to use srcu for all tracepoints including nmi. That
> patch also removes this warning and fixes the one other issue masami
> reported (hot plug causing a warning).

Is it one I can take, or does Paul have it? I'll need it to continue
with this as is, because I can't pass my tests without triggering that
warning (and that fails the test).

> 
> If Paul and Mathieu can confirm SRCU works on offline CPUs that would
> be great.

Yes please.

> 
> It's just this one warning or anything else that makes you feel
> tracepoints for critical paths isn't feasible?

Currently I'm down to this, but I can't get past my first test in my
ktest suite, because it fails here.

-- Steve

