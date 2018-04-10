Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeDJTmc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:52460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeDJTmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:42:17 -0400
Subject: Re: [RFC] mm, slab: reschedule cache_reap() on the same CPU
To: Christopher Lameter <cl@linux.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
References: <20180410081531.18053-1-vbabka@suse.cz>
 <alpine.DEB.2.20.1804100907160.27333@nuc-kabylake>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <983c61d1-1444-db1f-65c1-3b519ac4d57b@suse.cz>
Date: Tue, 10 Apr 2018 21:40:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1804100907160.27333@nuc-kabylake>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 04:12 PM, Christopher Lameter wrote:
> On Tue, 10 Apr 2018, Vlastimil Babka wrote:
> 
>> cache_reap() is initially scheduled in start_cpu_timer() via
>> schedule_delayed_work_on(). But then the next iterations are scheduled via
>> schedule_delayed_work(), thus using WORK_CPU_UNBOUND.
> 
> That is a bug.. cache_reap must run on the same cpu since it deals with
> the per cpu queues of the current cpu. Scheduled_delayed_work() used to
> guarantee running on teh same cpu.

Did it? When did it stop? (which stable kernels should we backport to?)
So is my assumption correct that without specifying a CPU, the next work
might be processed on a different cpu than the current one, *and also*
be executed with a kthread/u* that can migrate to another cpu *in the
middle of the work*? Tejun?

>> This patch makes sure schedule_delayed_work_on() is used with the proper cpu
>> when scheduling the next iteration. The cpu is stored with delayed_work on a
>> new slab_reap_work_struct super-structure.
> 
> The current cpu is readily available via smp_processor_id(). Why a
> super structure?

Mostly for the WARN_ON_ONCE, and general paranoia.

>> @@ -4074,7 +4086,8 @@ static void cache_reap(struct work_struct *w)
>>  	next_reap_node();
>>  out:
>>  	/* Set up the next iteration */
>> -	schedule_delayed_work(work, round_jiffies_relative(REAPTIMEOUT_AC));
>> +	schedule_delayed_work_on(reap_work->cpu, work,
>> +					round_jiffies_relative(REAPTIMEOUT_AC));
> 
> schedule_delayed_work_on(smp_processor_id(), work, round_jiffies_relative(REAPTIMEOUT_AC));
> 
> instead all of the other changes?

If we can rely on that 100%, sure.
