Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBHUaY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:30:24 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35432 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeBHUaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:30:23 -0500
X-Google-Smtp-Source: AH8x226D6Q8xHtGYxTGWCqgB4kZaHc034TJv2X0L4HFBdrNlaNPSaZOAuZL2fssNyZdv853hCrjFBw==
Message-ID: <1518121820.2849.17.camel@arista.com>
Subject: Re: [RFC PATCH 2/4] softirq: Per vector deferment to workqueue
From: Dmitry Safonov <dima@arista.com>
To: David Miller <davem@davemloft.net>
Cc: bigeasy@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, alexander.levin@verizon.com,
        peterz@infradead.org, mchehab@s-opensource.com,
        torvalds@linux-foundation.org, hannes@stressinduktion.org,
        paulmck@linux.vnet.ibm.com, wanpeng.li@hotmail.com, tglx@linutronix.de,
        akpm@linux-foundation.org, pabeni@redhat.com, rrendec@arista.com,
        mingo@kernel.org, sgruszka@redhat.com, riel@redhat.com,
        edumazet@google.com
Date: Thu, 08 Feb 2018 20:30:20 +0000
In-Reply-To: <20180208.152236.2148696725742511754.davem@davemloft.net>
References: <20180208174450.qjvjy752jf4ngt2g@breakpoint.cc>
         <20180208.134506.1374787894560277876.davem@davemloft.net>
         <1518120895.2849.14.camel@arista.com>
         <20180208.152236.2148696725742511754.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-08 at 15:22 -0500, David Miller wrote:
> From: Dmitry Safonov <dima@arista.com>
> Date: Thu, 08 Feb 2018 20:14:55 +0000
> 
> > On Thu, 2018-02-08 at 13:45 -0500, David Miller wrote:
> >> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> Date: Thu, 8 Feb 2018 18:44:52 +0100
> >> 
> >> > May I instead suggest to stick to ksoftirqd? So you run in
> softirq
> >> > context (after return from IRQ) and if takes too long, you
> offload
> >> the
> >> > vector to ksoftirqd instead. You may want to play with the
> metric
> >> on
> >> > which you decide when you want switch to ksoftirqd / account how
> >> long a
> >> > vector runs.
> >> 
> >> Having read over this stuff for the past few weeks this is how I
> feel
> >> as well.  Just make ksofbitrq do what we want (only execute the
> >> overloaded softirq vectors).
> >> 
> >> The more I look at the workqueue stuff, the more complications and
> >> weird behavioral artifacts we are getting for questionable gain.
> > 
> > What about creating several ksoftirqd threads per-cpu?
> > Like I did with boot parameter to specify how many threads and
> which
> > softirqs to serve.
> 
> Why do we need more than one per cpu?

Ugh, yeah, I remember why I did it - I tried to reuse scheduler for
each ksoftirqd thread to decide if it need to run now or later.
That would give an admin a way to prioritise softirqs with nice.
Not sure if it's a nice idea at all..

> 
> There is a set of vectors which are "overloaded" and ksoftirqd
> processes
> them one by one.
> 
> The only difference with what happens now is that one softirq being
> overloaded doesn't defer the processing of all softirqs to ksoftirqd.
