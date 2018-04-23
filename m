Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbeDWQ5y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:57:54 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:25593 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeDWQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:57:53 -0400
Subject: Re: [ANNOUNCE] v4.14.29-rt25
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20180325101204.ibuvdpnusv3vutyc@linutronix.de>
 <b04275af-000d-7b29-3031-508c9a01cd91@ti.com>
 <20180420171116.w2hxytgzvp4jgpyl@linutronix.de>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <764d0abc-7e88-a696-17a0-0bf807148d5b@ti.com>
Date: Mon, 23 Apr 2018 11:57:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420171116.w2hxytgzvp4jgpyl@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/20/2018 12:11 PM, Sebastian Andrzej Siewior wrote:
> On 2018-03-27 13:01:07 [-0500], Grygorii Strashko wrote:
>> Hi Sebastian,
> Hi Grygorii,
> 
>> I've took this RT version and applied "[RT] kernel/time/posix-timer: avoid schedule()
>> while holding the RCU lock" [1] on top. Then I run below tests:
> …
>> no stall or crashes were observed, but I've caught two "rcu_note_context_switch()" warnings
> 
> the warning is unrelated to the patch I posted. This should mute it:
> 
> Subject: [PATCH RT] rtmutex: annotate sleeping lock context
> 
> The RCU code complains on schedule() within a rcu_readlock() section.
> The valid scenario on -RT is if a sleeping is held. In order to suppress
> the warning the mirgrate_disable counter was used to identify the
> invocation of schedule() due to lock contention.
> 
> Grygorii Strashko report that during CPU hotplug we might see the
> warning via
>   rt_spin_lock() -> migrate_disable() -> pin_current_cpu() -> __read_rt_lock()
> 
> because the counter is not yet set.
> It is also possible to trigger the warning from cpu_chill()
> (seen on a kblockd_mod_delayed_work_on() caller).
> 
> To address this RCU warning I annotate the sleeping lock context. The
> counter is incremented before migrate_disable() so the warning Grygorii
> should not trigger anymore. Additionally I use that counter in
> cpu_chill() to avoid the RCU warning from there.

Sry, but I can't apply it. What's you base?

> 
> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
-- 
regards,
-grygorii
