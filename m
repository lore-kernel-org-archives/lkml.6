Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeBWB7u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:59:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750916AbeBWB7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:59:49 -0500
Subject: Re: [PATCH net v3 2/2] tuntap: correctly add the missing xdp flush
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        christoffer.dall@linaro.org, sergei.shtylyov@cogentembedded.com
References: <1519292206-6384-1-git-send-email-jasowang@redhat.com>
 <1519292206-6384-2-git-send-email-jasowang@redhat.com>
 <20180222184647.0e1d6631@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6b0a7fac-1b4a-c621-e391-b5e763f007f7@redhat.com>
Date: Fri, 23 Feb 2018 09:59:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222184647.0e1d6631@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月23日 01:46, Jesper Dangaard Brouer wrote:
> On Thu, 22 Feb 2018 17:36:46 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> Commit 762c330d670e ("tuntap: add missing xdp flush") tries to fix the
>> devmap stall caused by missed xdp flush by counting the pending xdp
>> redirected packets and flush when it exceeds NAPI_POLL_WEIGHT or
>> MSG_MORE is clear. This may lead to BUG() since xdp_do_flush() was
>> called in the process context with preemption enabled. Simply
>> disabling preemption may silence the warning but be not enough since
>> process may move between different CPUS during a batch which cause
>> xdp_do_flush() misses some CPU where the process run
>> previously. Consider the fallouts, that commit was reverted. To fix
>> the issue correctly, we can simply call xdp_do_flush() immediately
>> after xdp_do_redirect(), a side effect is that this removes any
>> possibility of batching which could be addressed in the future.
>>
>> Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Fixes: 762c330d670e ("tuntap: add missing xdp flush")
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/net/tun.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 2823a4a..a363ea2 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1662,6 +1662,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   			get_page(alloc_frag->page);
>>   			alloc_frag->offset += buflen;
>>   			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
>> +			xdp_do_flush_map();
>>   			if (err)
>>   				goto err_redirect;
>>   			rcu_read_unlock();
> As you have noticed, the xdp_do_redirect() + xdp_do_flush_map() rely
> heavily on being executed in softirq/napi_schedule context.
> Particularly the map infra devmap[1]+cpumap depend on the enqueue and
> flush operation MUST happen on the same CPU (e.g. stores which
> devices needs flushing in a this_cpu_ptr bitmap [1]).
>
> What context is tun_build_skb() invoked under?
>
> Even when you call xdp_do_redirect and xdp_do_flush_map right after
> each-other, are we sure we cannot be preempted here?

Ok, I miss the fact that we can be preempted here with preemptible RCU. 
Let me disable preemption here and post a V4.

Thanks

>
>
> [1] https://github.com/torvalds/linux/blob/master/kernel/bpf/devmap.c#L209-L215
