Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A719DC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D529218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfAGT7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:59:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfAGT7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:59:20 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92234206B7;
        Mon,  7 Jan 2019 19:59:19 +0000 (UTC)
Date:   Mon, 7 Jan 2019 14:59:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-ID: <20190107145918.407b851b@gandalf.local.home>
In-Reply-To: <20190107195209.GB5966@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
        <20190107183444.GA5966@xps-13>
        <20190107142749.34231bb6@gandalf.local.home>
        <20190107195209.GB5966@xps-13>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 20:52:09 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> > Ug, kretprobe calls spinlocks in the callback? I wonder if we can
> > remove them.
> > 
> > I'm guessing this is a different issue than the one that this patch
> > fixes. This sounds like we are calling kretprobe from kretprobe?
> > 
> > -- Steve  
> 
> kretprobe_trampoline()
>   -> trampoline_handler()
>     -> kretprobe_hash_lock()
>       -> raw_spin_lock_irqsave()  
> 
> If we put a kretprobe to raw_spin_lock_irqsave() it looks like
> kretprobe is going to call kretprobe...

Right, but we should be able to add some recursion protection to stop
that. I have similar protection in the ftrace code.

-- Steve

