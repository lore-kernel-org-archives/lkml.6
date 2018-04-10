Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeDJTxJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:53:09 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:38884 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeDJTxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:53:08 -0400
X-Google-Smtp-Source: AIpwx4+6Mej9LEbyGTO60nL86c15FdxxFDziHeeqc92ISFMAmJ54WDkZibAAwwsOu0TJfNLUhkIFhw==
Date: Tue, 10 Apr 2018 12:53:05 -0700
From: Tejun Heo <tj@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC] mm, slab: reschedule cache_reap() on the same CPU
Message-ID: <20180410195247.GQ3126663@devbig577.frc2.facebook.com>
References: <20180410081531.18053-1-vbabka@suse.cz>
 <alpine.DEB.2.20.1804100907160.27333@nuc-kabylake>
 <983c61d1-1444-db1f-65c1-3b519ac4d57b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983c61d1-1444-db1f-65c1-3b519ac4d57b@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 10, 2018 at 09:40:19PM +0200, Vlastimil Babka wrote:
> On 04/10/2018 04:12 PM, Christopher Lameter wrote:
> > On Tue, 10 Apr 2018, Vlastimil Babka wrote:
> > 
> >> cache_reap() is initially scheduled in start_cpu_timer() via
> >> schedule_delayed_work_on(). But then the next iterations are scheduled via
> >> schedule_delayed_work(), thus using WORK_CPU_UNBOUND.
> > 
> > That is a bug.. cache_reap must run on the same cpu since it deals with
> > the per cpu queues of the current cpu. Scheduled_delayed_work() used to
> > guarantee running on teh same cpu.
> 
> Did it? When did it stop? (which stable kernels should we backport to?)

It goes back to v4.5 - ef557180447f ("workqueue: schedule
WORK_CPU_UNBOUND work on wq_unbound_cpumask CPUs") which made
WQ_CPU_UNBOUND on percpu workqueues honor wq_unbound_cpusmask so that
cpu isolation works better.  Unless the force_rr option or
unbound_cpumask is set, it still follows local cpu.

> So is my assumption correct that without specifying a CPU, the next work
> might be processed on a different cpu than the current one, *and also*
> be executed with a kthread/u* that can migrate to another cpu *in the
> middle of the work*? Tejun?

For percpu work items, they'll keep executing on the same cpu it
started on unless the cpu goes down while executing.

> > schedule_delayed_work_on(smp_processor_id(), work, round_jiffies_relative(REAPTIMEOUT_AC));
> > 
> > instead all of the other changes?
> 
> If we can rely on that 100%, sure.

Yeah, you can.

Thanks.

-- 
tejun
