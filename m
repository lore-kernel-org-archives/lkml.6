Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DFDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E6C20870
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E6C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeGIUWW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:22:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34059 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbeGIUWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:22:21 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fccfn-0000jX-2Z; Mon, 09 Jul 2018 22:22:15 +0200
Date:   Mon, 9 Jul 2018 22:22:15 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: cgroup trace events acquire sleeping locks
Message-ID: <20180709202214.h2t5t3ndx6xqtrtg@linutronix.de>
References: <20180703140750.1dab75ef@tagon>
 <20180706174745.hwvnwojzfbmp7ma5@linutronix.de>
 <20180708203600.2edf24e2@tagon>
 <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
 <20180709150154.66843cba@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709150154.66843cba@gandalf.local.home>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-09 15:01:54 [-0400], Steven Rostedt wrote:
> > which is the trace_cgroup_rmdir() trace event in cgroup_rmdir(). The
> > trace event invokes cgroup_path() which acquires a spin_lock_t and this
> > is invoked within a preempt_disable()ed section. 
> 
> Correct. And I wish no trace event took spin locks.

is there an easy way to detect this? I mean instead hitting the trace
event with debug enabled and doing a review of each of them.

> > It says "Preemption disabled at" migrate_enable() but this is not true.
> > A printk() just before the lock reports preempt_count() of two and
> > sometimes one. I *think*
> > - one is from rcu_read_lock_sched_notrace() in __DO_TRACE()
> > - the second is from preempt_disable_notrace() in ring_buffer_lock_reserve()
> > 
> > I would prefer not to turn kernfs_rename_lock into raw_spin_lock_t. We
> > had a similar problem with a i915 trace event which eventually vanished
> > (and before I just disabled it).
> > 
> > So how likely are chances that we can use rcu_read_lock() in __DO_TRACE()?
> 
> Not very.

Is there a reason for this? I don't think this is documented. I changed
it to the "normal" RCU read section and it appeared to work :)

> > And how likely are chances that the preempt_disable() in
> > ring_buffer_lock_reserve() could be avoided while the trace event is
> > invoked?
> 
> Even less likely. The design of the ring buffer is based on not being
> able to be preempted.

I was expecting this.

> > I guess nothing of this is easy peasy. Any suggestions?
> > 
> 
> One solution, albeit not so pretty, is to move the grabbing of the
> path, outside the trace event. But this should work.

okay, wasn't aware of the trace_cgroup_##type##_enabled() magic. Yes,
this should work. Do you mind posting this upstream?

> -- Steve

Sebastian
