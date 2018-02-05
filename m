Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeBEIYz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:24:55 -0500
Received: from [210.13.100.6] ([210.13.100.6]:53612 "EHLO
        mail2012.asrmicro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752510AbeBEIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:24:35 -0500
Subject: Re: [PATCH] tick/broadcast: set next event of bc to KTIME_MAX
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1517540567-23599-1-git-send-email-qiaozhou@asrmicro.com>
 <201802051045.tkPgpDTw%fengguang.wu@intel.com>
From: qiaozhou <qiaozhou@asrmicro.com>
Message-ID: <40be5566-99d7-6d1a-610b-4c1849254fd0@asrmicro.com>
Date: Mon, 5 Feb 2018 16:24:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201802051045.tkPgpDTw%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.50.16]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch needs refine and I'll check more. Thanks a lot.

On 2018年02月05日 10:17, kbuild test robot wrote:
> Hi Qiao,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/timers/nohz]
> [also build test ERROR on v4.15]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Qiao-Zhou/tick-broadcast-set-next-event-of-bc-to-KTIME_MAX/20180205-093126
> config: x86_64-randconfig-x017-201805 (attached as .config)
> compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>     kernel/time/tick-broadcast.c: In function 'tick_handle_oneshot_broadcast':
>>> kernel/time/tick-broadcast.c:669:18: error: request for member 'tv64' in something not a structure or union
>        dev->next_event.tv64 = KTIME_MAX;
>                       ^
> 
> vim +/tv64 +669 kernel/time/tick-broadcast.c
> 
>     595	
>     596	/*
>     597	 * Handle oneshot mode broadcasting
>     598	 */
>     599	static void tick_handle_oneshot_broadcast(struct clock_event_device *dev)
>     600	{
>     601		struct tick_device *td;
>     602		ktime_t now, next_event;
>     603		int cpu, next_cpu = 0;
>     604		bool bc_local;
>     605	
>     606		raw_spin_lock(&tick_broadcast_lock);
>     607		dev->next_event = KTIME_MAX;
>     608		next_event = KTIME_MAX;
>     609		cpumask_clear(tmpmask);
>     610		now = ktime_get();
>     611		/* Find all expired events */
>     612		for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
>     613			td = &per_cpu(tick_cpu_device, cpu);
>     614			if (td->evtdev->next_event <= now) {
>     615				cpumask_set_cpu(cpu, tmpmask);
>     616				/*
>     617				 * Mark the remote cpu in the pending mask, so
>     618				 * it can avoid reprogramming the cpu local
>     619				 * timer in tick_broadcast_oneshot_control().
>     620				 */
>     621				cpumask_set_cpu(cpu, tick_broadcast_pending_mask);
>     622			} else if (td->evtdev->next_event < next_event) {
>     623				next_event = td->evtdev->next_event;
>     624				next_cpu = cpu;
>     625			}
>     626		}
>     627	
>     628		/*
>     629		 * Remove the current cpu from the pending mask. The event is
>     630		 * delivered immediately in tick_do_broadcast() !
>     631		 */
>     632		cpumask_clear_cpu(smp_processor_id(), tick_broadcast_pending_mask);
>     633	
>     634		/* Take care of enforced broadcast requests */
>     635		cpumask_or(tmpmask, tmpmask, tick_broadcast_force_mask);
>     636		cpumask_clear(tick_broadcast_force_mask);
>     637	
>     638		/*
>     639		 * Sanity check. Catch the case where we try to broadcast to
>     640		 * offline cpus.
>     641		 */
>     642		if (WARN_ON_ONCE(!cpumask_subset(tmpmask, cpu_online_mask)))
>     643			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
>     644	
>     645		/*
>     646		 * Wakeup the cpus which have an expired event.
>     647		 */
>     648		bc_local = tick_do_broadcast(tmpmask);
>     649	
>     650		/*
>     651		 * Two reasons for reprogram:
>     652		 *
>     653		 * - The global event did not expire any CPU local
>     654		 * events. This happens in dyntick mode, as the maximum PIT
>     655		 * delta is quite small.
>     656		 *
>     657		 * - There are pending events on sleeping CPUs which were not
>     658		 * in the event mask
>     659		 */
>     660		if (next_event != KTIME_MAX)
>     661			tick_broadcast_set_event(dev, next_cpu, next_event);
>     662		else
>     663			/*
>     664			 * not program broadcast timer, but set the value to show that
>     665			 * the next event is not set, which is used in
>     666			 * __tick_broadcast_oneshot_control in idle tick_broadcast
>     667			 * enter/exit control flow.
>     668			 */
>   > 669			dev->next_event.tv64 = KTIME_MAX;
>     670	
>     671		raw_spin_unlock(&tick_broadcast_lock);
>     672	
>     673		if (bc_local) {
>     674			td = this_cpu_ptr(&tick_cpu_device);
>     675			td->evtdev->event_handler(td->evtdev);
>     676		}
>     677	}
>     678	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
