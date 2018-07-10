Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ED9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D710208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D710208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeGJNct (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933169AbeGJNcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:32:48 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 013E2208E3;
        Tue, 10 Jul 2018 13:32:46 +0000 (UTC)
Date:   Tue, 10 Jul 2018 09:32:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de, Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: cgroup trace events acquire sleeping locks
Message-ID: <20180710093245.4e326156@gandalf.local.home>
In-Reply-To: <20180710092635.GD2476@hirez.programming.kicks-ass.net>
References: <20180703140750.1dab75ef@tagon>
        <20180706174745.hwvnwojzfbmp7ma5@linutronix.de>
        <20180708203600.2edf24e2@tagon>
        <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
        <20180709150154.66843cba@gandalf.local.home>
        <20180709202214.h2t5t3ndx6xqtrtg@linutronix.de>
        <20180709163010.257a08a0@gandalf.local.home>
        <20180710092635.GD2476@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 11:26:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Hmm, good question. I could possibly make all the tracepoint code into
> > its own section. And then look to see if any spin locks exist in them.
> > That wouldn't be too trivial to implement though.  
> 
> pick a bit from the preempt_count (say right above NMI_MASK) and set it
> inside a trace-event and add in_trace().
> 
> Then make lockdep explode when in_trace().
> 
> Or something along those lines.

Sure. We have current->trace for special tracing flags. That could
easily be used.

-- Steve
