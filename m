Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE5E208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ATyCtEP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE5E208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeGJJ0m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:26:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbeGJJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XL/LVVJIcO8Yput1ZtZcqLc0ViBFYtfYvl7mk2jFKNQ=; b=ATyCtEP9N1mNbkeLHYKZKIEsj
        8w8Vyk1vAx4JBS+7TstXaol8hNM9p3FB6QStrA/8XMN0MqJm5YQ8NBFvAPEbNpeDpJZs+sQ+Bap8P
        8qkYjWO1hvEyR94cRVjmzOOuSLEWdFgjkPaKnTALTk/ypn9bA0vEZCdZAMUBNAFQsG42q1qaE9KZ/
        6oAS47ch0njbm+fscMur8gU/o7sJOX8RddlQmpTMov1jiDwFWAAJFJEF6LMWtqk5dbB8gVgDshsNV
        TH1uoIthefuejRhGFEewHEUVTS4iIjQF6FljXMfr3P11XqFwEO/eD4mhXZ1Jem/c5a1kWSZ76Y3IO
        o8aOO/yAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcouq-0000bD-JM; Tue, 10 Jul 2018 09:26:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16C52203E575C; Tue, 10 Jul 2018 11:26:35 +0200 (CEST)
Date:   Tue, 10 Jul 2018 11:26:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de, Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: cgroup trace events acquire sleeping locks
Message-ID: <20180710092635.GD2476@hirez.programming.kicks-ass.net>
References: <20180703140750.1dab75ef@tagon>
 <20180706174745.hwvnwojzfbmp7ma5@linutronix.de>
 <20180708203600.2edf24e2@tagon>
 <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
 <20180709150154.66843cba@gandalf.local.home>
 <20180709202214.h2t5t3ndx6xqtrtg@linutronix.de>
 <20180709163010.257a08a0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709163010.257a08a0@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:30:10PM -0400, Steven Rostedt wrote:
> On Mon, 9 Jul 2018 22:22:15 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2018-07-09 15:01:54 [-0400], Steven Rostedt wrote:
> > > > which is the trace_cgroup_rmdir() trace event in cgroup_rmdir(). The
> > > > trace event invokes cgroup_path() which acquires a spin_lock_t and this
> > > > is invoked within a preempt_disable()ed section.   
> > > 
> > > Correct. And I wish no trace event took spin locks.  
> > 
> > is there an easy way to detect this? I mean instead hitting the trace
> > event with debug enabled and doing a review of each of them.
> 
> Hmm, good question. I could possibly make all the tracepoint code into
> its own section. And then look to see if any spin locks exist in them.
> That wouldn't be too trivial to implement though.

pick a bit from the preempt_count (say right above NMI_MASK) and set it
inside a trace-event and add in_trace().

Then make lockdep explode when in_trace().

Or something along those lines.
