Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeCZPfT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752377AbeCZPfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:35:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC9E21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 11:35:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: joe.korty@concurrent-rt.com
Cc: Julia Cartwright <julia@ni.com>, <bigeasy@linutronix.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Message-ID: <20180326113515.720e7fb3@gandalf.local.home>
In-Reply-To: <20180323172131.GA2670@zipoli.concurrent-rt.com>
References: <20180323150959.GA16131@zipoli.concurrent-rt.com>
        <20180323165921.GG10942@jcartwri.amer.corp.natinst.com>
        <20180323172131.GA2670@zipoli.concurrent-rt.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 13:21:31 -0400
joe.korty@concurrent-rt.com wrote:

> My understanding is, in standard Linux and in rt, setting
> task state to anything other than TASK_RUNNING in of itself
> blocks preemption.

That is clearly false. The only thing that blocks preemption with a
CONFIG_PREEMPT kernel is preempt_disable() and local_irq*() disabling.

(Note spin_locks call preempt_disable in non RT).

Otherwise, nothing will stop preemption.

>  A preemption is not really needed here
> as it is expected that there is a schedule() written in that
> will shortly be executed.  And if a 'involuntary schedule'
> (ie, preemption) were allowed to occur between the task
> state set and the schedule(), that would change the task
> state back to TASK_RUNNING, which would cause the schedule
> to NOP.  Thus we risk not having paused long enough here
> for the condition we were waiting for to become true.

That is also incorrect. As Julia mentioned, a preemption keeps the
state of the task.

-- Steve
