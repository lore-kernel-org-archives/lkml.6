Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC492086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547619856;
	bh=YWW4LOMX+ZEdEt5TdTuF4ZxDRSgIZsUv2ylwUh4PObE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cfau+36Xui3RHS6bv2Y3MQEBkCSLsbzGJfQz2Y1wuO283aUBX+V3L5xfIW2icD9X8
	 QRpItPZtNM8QsRisX6ANQVUHYCv01Iz6ygLZ3SePxBcs50GWaHoMb/4FwBHQg9ARH7
	 8rxZpbIiLuDUpviDLs8TbbwfBeRM++TOWBj0J2oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfAPGYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:24:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfAPGYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:24:13 -0500
Received: from localhost (lfbn-ncy-1-66-34.w83-194.abo.wanadoo.fr [83.194.157.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231C82082F;
        Wed, 16 Jan 2019 06:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547619852;
        bh=YWW4LOMX+ZEdEt5TdTuF4ZxDRSgIZsUv2ylwUh4PObE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poisE+uiow94oHPQLDztDy4JPiQrcNoRk1/m0E+ASsAJMj6V5k6vs8VPZrTf51QrC
         1UAardGr4sGzBqg3lIvWvskHpP+aU2AU4DjaxLvf4MZHiSQJzvd9QMZR9WMTBTOZY0
         BFaVcpyC/ruv5+V5TWDE0zc0JEjKw+8luqBg9rsY=
Date:   Wed, 16 Jan 2019 07:24:09 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
Message-ID: <20190116062408.GA26169@lenoir>
References: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:11:12AM +0100, Heiner Kallweit wrote:
> 
> # tracer: nop
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>           <idle>-0     [001] d.h2  1479.099092: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] d.h2  1479.099098: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.099106: softirq_raise: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.099114: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.099120: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.099121: softirq_entry: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.099134: softirq_exit: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.099135: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.099141: softirq_exit: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.100094: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.100109: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.100116: softirq_exit: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.101091: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.101113: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.101118: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] d.h2  1479.102094: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.102114: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.102121: softirq_exit: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.103091: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] d.h2  1479.103097: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.103105: softirq_raise: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.103114: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.103118: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.103119: softirq_entry: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.103131: softirq_exit: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.103132: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.103138: softirq_exit: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.105092: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.105115: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.105119: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] d.h2  1479.106092: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.106112: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] .Ns2  1479.106144: softirq_exit: vec=9 [action=RCU]
>          cpuhp/1-13    [001] d..2  1479.106279: timer_cancel: timer=0000000009a25653
>           <idle>-0     [001] d.h2  1479.106965: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] d.h2  1479.106969: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.106974: softirq_raise: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.106981: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.106984: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.106985: softirq_entry: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.106994: softirq_exit: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.106995: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.106999: softirq_exit: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.107996: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.108010: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.108014: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] d.h2  1479.109009: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] d.h2  1479.109013: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.109024: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.109028: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.109028: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.109033: softirq_exit: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.110013: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.110033: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] ..s2  1479.110040: softirq_exit: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.111011: softirq_raise: vec=1 [action=TIMER]
>           <idle>-0     [001] d.h2  1479.111017: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] d.h2  1479.111026: softirq_raise: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.111035: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.111040: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] ..s2  1479.111040: softirq_entry: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.111052: softirq_exit: vec=7 [action=SCHED]
>           <idle>-0     [001] ..s2  1479.111052: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] .Ns2  1479.111079: softirq_exit: vec=9 [action=RCU]
>          cpuhp/1-13    [001] dNh2  1479.112930: softirq_raise: vec=1 [action=TIMER]
>          cpuhp/1-13    [001] dNh2  1479.112935: softirq_raise: vec=9 [action=RCU]
>           <idle>-0     [001] d..1  1479.113077: <stack trace>
>  => can_stop_idle_tick.isra.14
>  => tick_nohz_get_sleep_length
>  => menu_select
>  => cpuidle_select
>  => do_idle
>  => cpu_startup_entry
>  => start_secondary
>  => secondary_startup_64
>           <idle>-0     [001] .Ns2  1479.113110: softirq_entry: vec=1 [action=TIMER]
>           <idle>-0     [001] .Ns2  1479.113114: softirq_exit: vec=1 [action=TIMER]
>           <idle>-0     [001] .Ns2  1479.113115: softirq_entry: vec=9 [action=RCU]
>           <idle>-0     [001] .Ns2  1479.113139: softirq_exit: vec=9 [action=RCU]


So, I'm being very doubtful now actually.

First of all, I realize my patch only fixes things halfway. Only softirq raised from
hardirqs are going to be handled after ksoftirqd is parked. If it's raised outside
interrupts, the softirq is going to be ignored. If other smpboot kthreads, following
ksoftirqd parking, raise softirqs from their park() callback we should at least warn
that we are ignoring that.

Also, I'm still not sure if you're running threaded IRQs. Very likely not as
the softirqs in your traces are executed in idle, which means from an IRQ interrupting
idle. You haven't passed "threadirqs" in your kernel parameters, right?
In any case we need to figure out why your softirqs raised at 1479.112930 and
1479.112935 don't get handled.

Finally I don't understand why you have so many timer softirqs and yet no timer traces
at all, I turned them on in the script I gave you. So something weird is happening with
the timers code. At best we are wasting lots of CPU cycles with those empty softirqs, at
worst we are miscalculating some expiration somewhere, possibly ignoring a timer.

So I'll need to cook up an updated debug patch for you to trigger if you don't
mind.

Thanks.
