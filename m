Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeDJUPc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:15:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54793 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752057AbeDJUPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:15:31 -0400
Subject: Re: [RFC] mm, slab: reschedule cache_reap() on the same CPU
To: Tejun Heo <tj@kernel.org>
Cc: Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
References: <20180410081531.18053-1-vbabka@suse.cz>
 <alpine.DEB.2.20.1804100907160.27333@nuc-kabylake>
 <983c61d1-1444-db1f-65c1-3b519ac4d57b@suse.cz>
 <20180410195247.GQ3126663@devbig577.frc2.facebook.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d4983f13-2c02-6082-f980-a6623ab363e6@suse.cz>
Date: Tue, 10 Apr 2018 22:13:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410195247.GQ3126663@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 09:53 PM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 10, 2018 at 09:40:19PM +0200, Vlastimil Babka wrote:
>> On 04/10/2018 04:12 PM, Christopher Lameter wrote:
>>> On Tue, 10 Apr 2018, Vlastimil Babka wrote:
>>>
>>>> cache_reap() is initially scheduled in start_cpu_timer() via
>>>> schedule_delayed_work_on(). But then the next iterations are scheduled via
>>>> schedule_delayed_work(), thus using WORK_CPU_UNBOUND.
>>>
>>> That is a bug.. cache_reap must run on the same cpu since it deals with
>>> the per cpu queues of the current cpu. Scheduled_delayed_work() used to
>>> guarantee running on teh same cpu.
>>
>> Did it? When did it stop? (which stable kernels should we backport to?)
> 
> It goes back to v4.5 - ef557180447f ("workqueue: schedule
> WORK_CPU_UNBOUND work on wq_unbound_cpumask CPUs") which made
> WQ_CPU_UNBOUND on percpu workqueues honor wq_unbound_cpusmask so that
> cpu isolation works better.  Unless the force_rr option or
> unbound_cpumask is set, it still follows local cpu.

I see, thanks.

>> So is my assumption correct that without specifying a CPU, the next work
>> might be processed on a different cpu than the current one, *and also*
>> be executed with a kthread/u* that can migrate to another cpu *in the
>> middle of the work*? Tejun?
> 
> For percpu work items, they'll keep executing on the same cpu it
> started on unless the cpu goes down while executing.

Right, but before this patch, with just schedule_delayed_work() i.e.
non-percpu? If such work can migrate in the middle, the slab bug is
potentially much more serious.

>>> schedule_delayed_work_on(smp_processor_id(), work, round_jiffies_relative(REAPTIMEOUT_AC));
>>>
>>> instead all of the other changes?
>>
>> If we can rely on that 100%, sure.
> 
> Yeah, you can.

Great, thanks.

> Thanks.
> 
