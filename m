Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D274C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A75219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A75219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeHHPGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHHPGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:06:05 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E0521742;
        Wed,  8 Aug 2018 12:46:31 +0000 (UTC)
Date:   Wed, 8 Aug 2018 08:46:29 -0400
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
Message-ID: <20180808084629.3290d1d6@gandalf.local.home>
In-Reply-To: <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
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
        <20180807204820.50b83c6d@vmware.local.home>
        <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
        <20180807215522.04114097@vmware.local.home>
        <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
        <20180807222856.3ede96e7@vmware.local.home>
        <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
        <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018 20:53:54 -0700
Joel Fernandes <joelaf@google.com> wrote:


> > When I talked to Paul few months ago about SRCU from NMI context, he
> > mentioned the per-cpu memory operations during srcu_read_lock can be
> > NMI interrupted, that's why we added that warning.  
> 
> So I looked more closely, __srcu_read_lock on 2 different handles may
> still be doing a this_cpu_inc on the same location..
> (sp->sda->srcu_lock_count). :-(
> 
> Paul any ideas on how to solve this?
> 
> It does start to seem like a show stopper :-(

What's wrong with a this_cpu_inc()? It's atomic for the CPU. Although
it wont be atomic for the capture of the idx. But I also don't see
interrupts being disabled, thus an NMI is no different than any
interrupt doing the same thing, right?

-- Steve
