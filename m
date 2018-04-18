Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeDRPpB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:45:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35469 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbeDRPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:44:39 -0400
Date: Wed, 18 Apr 2018 17:44:36 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Steven J . Hill" <steven.hill@cavium.com>,
        Tejun Heo <htejun@gmail.com>, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] Revert mm/vmstat.c: fix vmstat_update() preemption BUG
Message-ID: <20180418154435.bgakyv5kqsev2k3e@linutronix.de>
References: <20180411095757.28585-1-bigeasy@linutronix.de>
 <ef663b6d-9e9f-65c6-25ec-ffa88347c58d@suse.cz>
 <20180411140913.GE793541@devbig577.frc2.facebook.com>
 <20180411144221.o3v73v536tpnc6n3@linutronix.de>
 <20180411190729.7sbmbsxtkcng7ddx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411190729.7sbmbsxtkcng7ddx@linutronix.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping.
any reason not to accept the revert?

On 2018-04-11 21:07:29 [+0200], To Tejun Heo wrote:
> On 2018-04-11 16:42:21 [+0200], To Tejun Heo wrote:
> > > > So is this perhaps related to the cpu hotplug that [1] mentions? e.g. is
> > > > the cpu being hotplugged cpu 1, the worker started too early before
> > > > stuff can be scheduled on the CPU, so it has to run on different than
> > > > designated CPU?
> > > > 
> > > > [1] https://marc.info/?l=linux-mm&m=152088260625433&w=2
> > > 
> > > The report says that it happens when hotplug is attempted.  Per-cpu
> > > doesn't pin the cpu alive, so if the cpu goes down while a work item
> > > is in flight or a work item is queued while a cpu is offline it'll end
> > > up executing on some other cpu.  So, if a piece of code doesn't want
> > > that happening, it gotta interlock itself - ie. start queueing when
> > > the cpu comes online and flush and prevent further queueing when its
> > > cpu goes down.
> > 
> > I missed that cpuhotplug part while reading it. So in that case, let me
> > add a CPU-hotplug notifier which cancels that work. After all it is not
> > need once the CPU is gone.
> 
> This already happens:
> - vmstat_shepherd() does get_online_cpus() and within this block it does
>   queue_delayed_work_on(). So this has to wait until cpuhotplug
>   completed before it can schedule something and then it won't schedule
>   anything on the "off" CPU.
> 
> - The work item itself (vmstat_update()) schedules itself
>   (conditionally) again.
> 
> - vmstat_cpu_down_prep() is the down event and does
>   cancel_delayed_work_sync(). So it waits for the work-item to complete
>   and cancels it.
> 
> This looks all good to me.
> 
> > > Thanks.

Sebastian
