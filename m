Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163672AbeCBABZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:01:25 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:56909 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163541AbeCBABX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:01:23 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.184
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH] rcu: Clean up rcu_init_nohz() by removing unnecessary
 statements
To: paulmck@linux.vnet.ibm.com
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
References: <1519808695-28097-1-git-send-email-byungchul.park@lge.com>
 <20180228184106.GN3777@linux.vnet.ibm.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <166b5b47-8b6f-4b35-df4c-b42b47a173da@lge.com>
Date: Fri, 2 Mar 2018 09:01:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228184106.GN3777@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2018 3:41 AM, Paul E. McKenney wrote:
> On Wed, Feb 28, 2018 at 06:04:55PM +0900, Byungchul Park wrote:
>> Since the commit 44c65ff2e3b0(rcu: Eliminate NOCBs CPU-state Kconfig
>> options) made nocb-cpus identified only through the rcu_nocbs= boot
>> parameter, we don't have to care NOCBs CPU-state Kconfig options
>> anymore, which means now we can just rely on rcu_nocb_mask to
>> decide whether going ahead in rcu_init_nohz().
>>
>> Remove the deprecated code.
>>
>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> 
> Good catch!  However, you missed a (relatively harmless) bug in my commit
> 44c65ff2e3b0, namely that if neither the nohz_full= nor the rcu_nocbs=
> kernel boot parameters specify any CPUs, we don't need to allocate
> rcu_nocb_mask.  (That is, when both of those parameters are omitted.)
> 
> Now, if the rcu_nocbs= kernel boot parameter was specified, we know that
> rcu_nocb_mask was already allocated in rcu_nocb_setup().  So in
> rcu_init_nohz() we only need to do the allocation if NO_HZ_FULL needs
> some NOCBs CPUs, that is, when tick_nohz_full_running and when there
> is at least one CPU specified in tick_nohz_full_mask.

Why didn't I catch it in advance? :)

> So the change that is actually needed is to reverse the initialization
> of need_rcu_nocb_mask, that is, to initialize it to false rather than
> to true.  I annotated your patch with my reasoning and have a patch
> below with your Reported-by.  Please take a look and let me know what
> you think.

No doubt. I agree with you.

Acked-by: Byungchul Park <byungchul.park@lge.com>

> If I am not too confused, the only effect of this bug was to needlessly
> allocate rcu_nocb_mask and to initialize it to all zeros bits, but please
> let me know if I missed something.

I think so as you.

-- 
Thanks,
Byungchul
