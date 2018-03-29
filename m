Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeC2CBC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 22:01:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751513AbeC2CBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 22:01:00 -0400
Subject: Re: [PATCH] vhost-net: add time limitation for tx polling(Internet
 mail)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?=
        <haibinzhang@tencent.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?bGlkb25nY2hlbijpmYjnq4vkuJwp?= <lidongchen@tencent.com>,
        =?UTF-8?B?eXVuZmFuZ3RhaSjlj7Dov5Dmlrkp?= <yunfangtai@tencent.com>
References: <88D661ADF6AFBF42B2AB88D8E7682B0901FC412A@EXMBX-SZMAIL011.tencent.com>
 <0b1846d3-dfcf-df0c-f94c-65d414331d88@redhat.com>
 <20180328182813-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f1a80199-ccf2-850b-1249-31f8f920ede3@redhat.com>
Date: Thu, 29 Mar 2018 10:00:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328182813-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月28日 23:31, Michael S. Tsirkin wrote:
> On Wed, Mar 28, 2018 at 02:37:04PM +0800, Jason Wang wrote:
>>
>> On 2018年03月28日 12:01, haibinzhang(张海斌) wrote:
>>> On 2018年03月27日 19:26, Jason wrote
>>> On 2018年03月27日 17:12, haibinzhang wrote:
>>>>> handle_tx() will delay rx for a long time when busy tx polling udp packets
>>>>> with short length(ie: 1byte udp payload), because setting VHOST_NET_WEIGHT
>>>>> takes into account only sent-bytes but no time.
>>>> Interesting.
>>>>
>>>> Looking at vhost_can_busy_poll() it tries to poke pending vhost work and
>>>> exit the busy loop if it found one. So I believe something block the
>>>> work queuing. E.g did reverting 8241a1e466cd56e6c10472cac9c1ad4e54bc65db
>>>> fix the issue?
>>> "busy tx polling" means using netperf send udp packets with 1 bytes payload(total 47bytes frame lenght),
>>> and handle_tx() will be busy sending packets continuously.
>>>
>>>>>     It's not fair for handle_rx(),
>>>>> so needs to limit max time of tx polling.
>>>>>
>>>>> ---
>>>>>     drivers/vhost/net.c | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>>>> index 8139bc70ad7d..dc9218a3a75b 100644
>>>>> --- a/drivers/vhost/net.c
>>>>> +++ b/drivers/vhost/net.c
>>>>> @@ -473,6 +473,7 @@ static void handle_tx(struct vhost_net *net)
>>>>>     	struct socket *sock;
>>>>>     	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
>>>>>     	bool zcopy, zcopy_used;
>>>>> +	unsigned long start = jiffies;
>>>> Checking jiffies is tricky, need to convert it to ms or whatever others.
>>>>
>>>>>     	mutex_lock(&vq->mutex);
>>>>>     	sock = vq->private_data;
>>>>> @@ -580,7 +581,7 @@ static void handle_tx(struct vhost_net *net)
>>>>>     		else
>>>>>     			vhost_zerocopy_signal_used(net, vq);
>>>>>     		vhost_net_tx_packet(net);
>>>>> -		if (unlikely(total_len >= VHOST_NET_WEIGHT)) {
>>>>> +		if (unlikely(total_len >= VHOST_NET_WEIGHT) || unlikely(jiffies - start >= 1)) {
>>>> How value 1 is determined here? And we need a complete test to make sure
>>>> this won't affect other use cases.
>>> We just want <1ms ping latency, but actually we are not sure what value is reasonable.
>>> We have some test results using netperf before this patch as follow,
>>>
>>>       Udp payload    1byte    100bytes    1000bytes    1400bytes
>>>     Ping avg latency    25ms     10ms       2ms         1.5ms
>>>
>>> What is other testcases?
>> Something like https://patchwork.kernel.org/patch/10151645/.
>>
>> Btw, you need use time_before() to properly handle jiffies overflow and I
>> would also suggest you to try something like #packets limit (e.g 64).
> Maybe a ring size?

Yes or a factor of ring size.

>
>> For long term, we definitely need more worker threads.
>>
>> Thanks
> Only helps when you have spare CPUs.

Right.

Thanks

>>>> Another thought is introduce another limit of #packets, but this need
>>>> benchmark too.
>>>>
>>>> Thanks
>>>>
>>>>>     			vhost_poll_queue(&vq->poll);
>>>>>     			break;
>>>>>     		}
