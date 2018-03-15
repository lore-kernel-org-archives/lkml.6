Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCOJjh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:39:37 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:54070 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeCOJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:39:35 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
Thread-Topic: Do we need to disable preemption in flush_tlb_range()?
Thread-Index: AQHTsW/Ph/wHPbUur0SfkKmu1J1Lq6PQL76AgADLfoCAABQpAA==
Date: Thu, 15 Mar 2018 09:39:31 +0000
Message-ID: <1521106770.11552.70.camel@synopsys.com>
References: <1519917189.13866.6.camel@synopsys.com>
         <5a5c67c1-9f45-f908-2c8d-0914cd616a18@synopsys.com>
         <20180315082720.GT4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180315082720.GT4064@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B6D4518BFFBD64793F3FEC19A670248@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2F9dfdE012553

Hi Peter,

On Thu, 2018-03-15 at 09:27 +0100, Peter Zijlstra wrote:
> On Wed, Mar 14, 2018 at 01:19:01PM -0700, Vineet Gupta wrote:
> > +CC Peter since we have his attention ;-)
> 
> Yeah, timezone collision there, I typically sleep at 1am ;-)
> 
> > On 03/01/2018 07:13 AM, Alexey Brodkin wrote:
> > > Hi Vineet,
> > > 
> > > Just noticed that in comments for smp_call_function_many() it is said that
> > > preemption must be disabled during its execution. And that function gets executed
> > > among other ways like that:
> > > -------------------------->8-----------------------
> > >    flush_tlb_range()
> > >      -> on_each_cpu_mask()
> > >           -> smp_call_function_many()
> > > -------------------------->8-----------------------
> > 
> > In general I prefer not to - Peter what say you ?
> 
> The comment with smp_call_function_many() is correct, it relies on
> preemption being disabled in a number of ways. I would expect
> this_cpu_ptr() for example to complain when used with preemption
> enabled (CONFIG_DEBUG_PREEMPT).

I just tried CONFIG_DEBUG_PREEMPT and the only thing I got was that:
-------------------------->8-----------------------
ARC perf        : 8 counters (32 bits), 32 conditions, [overflow IRQ support]
BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is arc_pmu_device_probe+0x24e/0x29c
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.14+ #67

Stack Trace:
  arc_unwind_core.constprop.1+0xd0/0xf4
  dump_stack+0x64/0x7c
  debug_smp_processor_id+0xb8/0xbc
  arc_pmu_device_probe+0x24e/0x29c
  platform_drv_probe+0x26/0x5c
  really_probe+0x288/0x338
  __driver_attach+0xc4/0xc8
  bus_for_each_dev+0x38/0x70
  bus_add_driver+0x12a/0x18c
  driver_register+0x50/0xec
  do_one_initcall+0x32/0x108
  kernel_init_freeable+0xfe/0x188
-------------------------->8-----------------------

That happens because in PMU probe routine we want to
configure IRQ handlers on all other cores:
-------------------------->8-----------------------
  arc_pmu_device_probe() ->
    on_each_cpu(arc_cpu_pmu_irq_init, &irq, 1): preempt_disable() ->
      enable_percpu_irq(irq, IRQ_TYPE_NONE) ->
        smp_processor_id() with disabled preemption.
-------------------------->8-----------------------

Which poses another preemption related question - how do IRQ setup on
all cores properly? :)

-Alexey
