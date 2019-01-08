Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95468C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C08D2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546916213;
	bh=RIjbtEa8XyNcF5cd/yVs6e2GBQFmZDCFZEqeQLa4pig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K1MLHm2GLM1YKsEZWMEIJ3+9AsrVq7pzU8prNe0lKC+dke/PSWMj5poQw1KMfmh0I
	 mvX9Sufm3lOQ8gAL2qhhPfIOIKjwFgPuLCZ2k4yxcsT+Y2bv14n+U7rvnAhgB+gPVZ
	 WEomVSfdSd/banN8FXdlx5biptMvT260oL+U94yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfAHC4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfAHC4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:56:52 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439082085A;
        Tue,  8 Jan 2019 02:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546916211;
        bh=RIjbtEa8XyNcF5cd/yVs6e2GBQFmZDCFZEqeQLa4pig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u8P0PAW/RRqUmbTXk58EquKmWXA3NNhna4JvA4PxLKQPKnAi/K/5QHnXQS1v6LMMw
         qCZHRBeIPpWfuyvmg6Y63VCJaJ8Akwv/bhwbP6n5BeVYZubyci3h8WVimw64wBzOip
         K+aTuWsp+52eaID1nKg2++3ivp/UdQlzeFa/e9bU=
Date:   Tue, 8 Jan 2019 11:56:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-Id: <20190108115648.5ecf625bf5477ad3f3148b80@kernel.org>
In-Reply-To: <20190107213439.GD5966@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
        <20190107183444.GA5966@xps-13>
        <20190107142749.34231bb6@gandalf.local.home>
        <20190107195209.GB5966@xps-13>
        <20190107145918.407b851b@gandalf.local.home>
        <20190107211904.GC5966@xps-13>
        <20190107162833.1e034fc7@gandalf.local.home>
        <20190107213439.GD5966@xps-13>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea and Steve,

On Mon, 7 Jan 2019 22:34:39 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Mon, Jan 07, 2019 at 04:28:33PM -0500, Steven Rostedt wrote:
> > On Mon, 7 Jan 2019 22:19:04 +0100
> > Andrea Righi <righi.andrea@gmail.com> wrote:
> > 
> > > > > If we put a kretprobe to raw_spin_lock_irqsave() it looks like
> > > > > kretprobe is going to call kretprobe...  
> > > > 
> > > > Right, but we should be able to add some recursion protection to stop
> > > > that. I have similar protection in the ftrace code.  
> > > 
> > > If we assume that __raw_spin_lock/unlock*() are always inlined a
> > 
> > I wouldn't assume that.
> > 
> > > possible way to prevent this recursion could be to use directly those
> > > functions to do locking from the kretprobe trampoline.
> > > 
> > > But I'm not sure if that's a safe assumption... if not I'll see if I can
> > > find a better solution.
> > 
> > All you need to do is have a per_cpu variable, where you just do:
> > 
> > 	preempt_disable_notrace();
> > 	if (this_cpu_read(kprobe_recursion))
> > 		goto out;
> > 	this_cpu_inc(kprobe_recursion);
> > 	[...]
> > 	this_cpu_dec(kprobe_recursion);
> > out:
> > 	preempt_enable_notrace();
> > 
> > And then just ignore any kprobes that trigger while you are processing
> > the current kprobe.
> > 
> > Something like that. If you want (or if it already happens) replace
> > preempt_disable() with local_irq_save().
> 
> Oh.. definitely much better. I'll work on that and send a new patch.
> Thanks for the suggestion!

Thank you for pointing it out, 

Since we already have current_kprobe per_cpu, it can be done by setting up
a dummy kprobe on it. I'll add that in v2 series.

Actually, this bug has been introduced a long time ago by me... when I
introduced asm-coded kretprobe-trampoline. Before that, kretprobe trampoline
handler uses a kprobe to hook it, so the 2nd kretprobe must be skipped
automatically.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
