Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F72F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iAFsu+4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfAJRZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:25:17 -0500
Received: from mail.efficios.com ([167.114.142.138]:56240 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbfAJRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:25:15 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C7F8BAF9CA;
        Thu, 10 Jan 2019 12:25:13 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ITDOvO0uAJ5p; Thu, 10 Jan 2019 12:25:13 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 237D4AF9C3;
        Thu, 10 Jan 2019 12:25:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 237D4AF9C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547141113;
        bh=hvYUZ9QjaJPqvytVtpzu7Pv2Pp4Nf8ojphZJIQfPkkA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=iAFsu+4RT9JCRSBChxSeEtiGoC3F3ev3LaUJ2DVwM+jPkTFzZFGgpTDcNFFckClFd
         f0U5sf5RVw3Aq1DADVUser3upxe5CPxlJNpn/vDIpLCYTGjlJJxdlqB+pNQL+yq/+d
         /Vnn+Qyc5E9ixtvfDY804lEOJkpyH96FI0Z0TgoVDUBNii+8H5TjRbIdVwMyZiylfj
         2K/z23JCyGjU43YcHorArT62AM+pnAILy8UU/br6kqBAbU+KIT4G4QkCEWTq45Zps9
         XrFDc6s40AaIyzg3ldSHL3jfInuVXdh9zC3ug8Fg61Dgg/Za0BNn72OZ1KPZRz5dMJ
         E30o2B5ZFo0IA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id EzSgvaXcXjNs; Thu, 10 Jan 2019 12:25:13 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0F3E9AF9BC;
        Thu, 10 Jan 2019 12:25:13 -0500 (EST)
Date:   Thu, 10 Jan 2019 12:25:13 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1083900143.1198.1547141113001.JavaMail.zimbra@efficios.com>
In-Reply-To: <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com> <20190110110839.7daeef3d@gandalf.local.home> <1884815641.993.1547138653377.JavaMail.zimbra@efficios.com> <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com>
Subject: Re: Possible use of RCU while in extended QS: idle vs RCU read-side
 in interrupt vs rcu_eqs_exit
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: Possible use of RCU while in extended QS: idle vs RCU read-side in interrupt vs rcu_eqs_exit
Thread-Index: 27wp/p4E6gUF7FLK8PORZvci3aR5Z84PIFV8D5IKZ4Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 10, 2019, at 9:11 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jan 10, 2019, at 8:44 AM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Jan 10, 2019, at 8:08 AM, rostedt rostedt@goodmis.org wrote:
>> 
>>> On Wed, 9 Jan 2019 20:38:51 -0500 (EST)
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> 
>>>> Hi Paul,
>>>> 
>>>> I've had a user report that trace_sched_waking() appears to be
>>>> invoked while !rcu_is_watching() in some situation, so I started
>>>> digging into the scheduler idle code.
>>> 
>>> I'm wondering if this isn't a bug. Do you have the backtrace for where
>>> trace_sched_waking() was called without rcu watching?
>> 
>> I strongly suspect a bug as well. I'm awaiting a reproducer from the
>> user whom reported this issue so I can add a WARN_ON_ONCE(!rcu_is_watching())
>> in the scheduler code near trace_sched_waking() and gather a backtrace.
>> 
>> It still has to be confirmed, but I suspect this have been triggered
>> within a HyperV guest. It may therefore be related to a virtualized environment.
>> 
>> I'll try to ask more specifically on which environment this was encountered.
> 
> So it ends up it happens directly on hardware on a Linux laptop. Here is
> the stacktrace:
> 
> vmlinux!try_to_wake_up
> vmlinux!default_wake_function
> vmlinux!pollwake
> vmlinux!__wake_up_common
> vmlinux!__wake_up_common_lock
> vmlinux!__wake_up
> vmlinux!perf_event_wakeup
> vmlinux!perf_pending_event
> vmlinux!irq_work_run_list
> vmlinux!irq_work_run
> vmlinux!smp_irq_work_iterrupt
> vmlinux!irq_work_interrupt
> vmlinux!finish_task_switch
> vmlinux!__schedule
> vmlinux!schedule_idle
> vmlinux!do_idle
> vmlinux!cpu_startup_entry
> vmlinux!start_secondary
> vmlinux!secondary_startup_64
> 
> Does it raise any red flag ?

Based on this backtrace, I think I start to get a better understanding
of the situation.

The initial problem reported to me was that ftrace was showing some sched_waking
events in its trace that were missed by perf.

I presumed this was because of the !rcu_is_watching() check, but I think I was
wrong.

This backtrace seems to show that perf is itself triggering a sched_waking()
event. It there is probably a check that discards nested events within perf,
which would discard this from perf traces, but ftrace (and lttng) would trace
it just fine.

Thoughts ?

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>>> 
>>> -- Steve
>>> 
>>>> 
>>>> It appears that interrupts are re-enabled before rcu_eqs_exit() is
>>>> invoked when exiting idle code from the scheduler.
>>>> 
>>>> I wonder what happens if an interrupt handler (including scheduler code)
>>>> happens to issue a RCU read-side critical section before rcu_eqs_exit()
>>>> is called ? Is there some code on interrupt entry that ensures rcu eqs
>>>> state is exited in such scenario ?
>>>> 
>>>> Thanks,
>>>> 
>>>> Mathieu
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
