Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEDQaz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeEDQaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:30:52 -0400
Date: Fri, 4 May 2018 12:30:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: rcu-bh design
Message-ID: <20180504123050.2841f80d@gandalf.local.home>
In-Reply-To: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 May 2018 16:20:11 +0000
Joel Fernandes <joelaf@google.com> wrote:

> Hi Paul, everyone,
> 
> I had some question(s) about rcu-bh design.
> I am trying to understand the reasoning or need of it. I see that rcu-bh
> will disable softirqs across read-side sections. But I am wondering why
> this is needed. __do_softirq already disables softirq when a softirq
> handler is running. The only reason I can see is, rcu-bh helps in
> situations where - a softirq interrupts a preemptible RCU read-section and
> prevents that read section from completing. But this problem would happen
> if anyone where to use rcu-preempt - then does rcu-preempt even make sense
> to use and shouldn't everyone be using rcu-bh?

I thought rcu-bh uses softirqs as a quiescent state. Thus, blocking
softirqs from happening makes sense. I don't think an
rcu_read_lock_bh() makes sense in a softirq.

> 
> The other usecase for rcu-bh seems to be if context-switch is used as a
> quiescent state, then softirq flood can prevent that from happening and
> cause rcu grace periods from completing. 

> But preemptible RCU *does not* use context-switch as a quiescent state.

It doesn't?

> So in that case rcu-bh would make
> sense only in a configuration where we're not using preemptible-rcu at all
> and are getting flooded by softirqs. Is that the reason rcu-bh needs to
> exist?

Maybe I'm confused by what you are asking.

-- Steve
