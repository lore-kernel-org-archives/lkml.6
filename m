Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D30C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AD820685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hpzp7Irn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfAJRpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:45:30 -0500
Received: from mail.efficios.com ([167.114.142.138]:40854 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfAJRp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:45:29 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1AFEEAFDC3;
        Thu, 10 Jan 2019 12:45:28 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id UA8zXqf9cUMq; Thu, 10 Jan 2019 12:45:27 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6DA71AFDC0;
        Thu, 10 Jan 2019 12:45:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6DA71AFDC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547142327;
        bh=1HDDXuw6HG2C9Zr7vihnPP8ckoUl1b5QWqKMkeZc9ZY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hpzp7IrnFKr1Eg+9muTeU5GFhK+9scU5WIQpzNb20Lq2aBPnsE+IDn1UnhPnCUCYI
         cb1+m7Fkj6+qBTINDL7wQO5zMgDHWDagSoCrvWBcJTFxJP+UqzE6k5Xqpue4ZXIlap
         ubr/3vJ5Y4TTLx3POkyJrlrnu4Vl2JqfmKS3sc9e+lin4zy5oWyuRMLigpJ//TH4l1
         wV+wAyGGV+Er14aEnBRfbwODMMNwo/1fbwcmRzrDy6uhvD2IgipUSxAjwomckTGq1U
         EyET5l/5CTaXUTIhrCFJ67SYXkjI0gpR8HksqlrB1123m6YV1YKM2fdpwZ3bnl2gYT
         kdks4SiOV5yfg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dX9BIALUNWjR; Thu, 10 Jan 2019 12:45:27 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 58685AFDB5;
        Thu, 10 Jan 2019 12:45:27 -0500 (EST)
Date:   Thu, 10 Jan 2019 12:45:27 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1706586119.1203.1547142327142.JavaMail.zimbra@efficios.com>
In-Reply-To: <1083900143.1198.1547141113001.JavaMail.zimbra@efficios.com>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com> <20190110110839.7daeef3d@gandalf.local.home> <1884815641.993.1547138653377.JavaMail.zimbra@efficios.com> <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com> <1083900143.1198.1547141113001.JavaMail.zimbra@efficios.com>
Subject: Perf: event wakeup discards sched_waking events
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: Perf: event wakeup discards sched_waking events
Thread-Index: 27wp/p4E6gUF7FLK8PORZvci3aR5Z84PIFV8D5IKZ4YS1FTqWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 10, 2019, at 9:25 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jan 10, 2019, at 9:11 AM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Jan 10, 2019, at 8:44 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>>> ----- On Jan 10, 2019, at 8:08 AM, rostedt rostedt@goodmis.org wrote:
>>> 
>>>> On Wed, 9 Jan 2019 20:38:51 -0500 (EST)
>>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>> 
>>>>> Hi Paul,
>>>>> 
>>>>> I've had a user report that trace_sched_waking() appears to be
>>>>> invoked while !rcu_is_watching() in some situation, so I started
>>>>> digging into the scheduler idle code.
>>>> 
>>>> I'm wondering if this isn't a bug. Do you have the backtrace for where
>>>> trace_sched_waking() was called without rcu watching?
>>> 
>>> I strongly suspect a bug as well. I'm awaiting a reproducer from the
>>> user whom reported this issue so I can add a WARN_ON_ONCE(!rcu_is_watching())
>>> in the scheduler code near trace_sched_waking() and gather a backtrace.
>>> 
>>> It still has to be confirmed, but I suspect this have been triggered
>>> within a HyperV guest. It may therefore be related to a virtualized environment.
>>> 
>>> I'll try to ask more specifically on which environment this was encountered.
>> 
>> So it ends up it happens directly on hardware on a Linux laptop. Here is
>> the stacktrace:
>> 
>> vmlinux!try_to_wake_up
>> vmlinux!default_wake_function
>> vmlinux!pollwake
>> vmlinux!__wake_up_common
>> vmlinux!__wake_up_common_lock
>> vmlinux!__wake_up
>> vmlinux!perf_event_wakeup
>> vmlinux!perf_pending_event
>> vmlinux!irq_work_run_list
>> vmlinux!irq_work_run
>> vmlinux!smp_irq_work_iterrupt
>> vmlinux!irq_work_interrupt
>> vmlinux!finish_task_switch
>> vmlinux!__schedule
>> vmlinux!schedule_idle
>> vmlinux!do_idle
>> vmlinux!cpu_startup_entry
>> vmlinux!start_secondary
>> vmlinux!secondary_startup_64
>> 
>> Does it raise any red flag ?
> 
> Based on this backtrace, I think I start to get a better understanding
> of the situation.
> 
> The initial problem reported to me was that ftrace was showing some sched_waking
> events in its trace that were missed by perf.
> 
> I presumed this was because of the !rcu_is_watching() check, but I think I was
> wrong.
> 
> This backtrace seems to show that perf is itself triggering a sched_waking()
> event. It there is probably a check that discards nested events within perf,
> which would discard this from perf traces, but ftrace (and lttng) would trace
> it just fine.

Looking at:

static void perf_pending_event(struct irq_work *entry)
{
        struct perf_event *event = container_of(entry,
                        struct perf_event, pending);
        int rctx;

        rctx = perf_swevent_get_recursion_context();
        /*
         * If we 'fail' here, that's OK, it means recursion is already disabled
         * and we won't recurse 'further'.
         */

        if (event->pending_disable) {
                event->pending_disable = 0;
                perf_event_disable_local(event);
        }

        if (event->pending_wakeup) {
                event->pending_wakeup = 0;
                perf_event_wakeup(event);
        }

        if (rctx >= 0)
                perf_swevent_put_recursion_context(rctx);
}

One side-effect of perf_event_wakeup() is to generate a sched_waking
event. But I suspect it won't be traced by perf because it is invoked before
putting the recursion context.

Is there a reason why the wakeup is done before putting the recursion
context ?

Thanks,

Mathieu




-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
