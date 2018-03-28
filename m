Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeC1EBl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 00:01:41 -0400
Received: from mail2.tencent.com ([163.177.67.195]:43723 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC1EBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 00:01:40 -0400
From: =?gb2312?B?aGFpYmluemhhbmco1cW6o7HzKQ==?= <haibinzhang@tencent.com>
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?gb2312?B?bGlkb25nY2hlbiizwsGitqsp?= <lidongchen@tencent.com>,
        =?gb2312?B?eXVuZmFuZ3RhaSjMqNTLt70p?= <yunfangtai@tencent.com>
Subject: Re: [PATCH] vhost-net: add time limitation for tx polling(Internet
 mail)
Thread-Topic: [PATCH] vhost-net: add time limitation for tx polling(Internet
 mail)
Thread-Index: AdPGRajMc+aKWRhwQLO7GaudbjJWJA==
Date: Wed, 28 Mar 2018 04:01:34 +0000
Message-ID: <88D661ADF6AFBF42B2AB88D8E7682B0901FC412A@EXMBX-SZMAIL011.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.90.75]
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2S43I0d002703

On 2018年03月27日 19:26, Jason wrote
On 2018年03月27日 17:12, haibinzhang wrote:
>> handle_tx() will delay rx for a long time when busy tx polling udp packets
>> with short length(ie: 1byte udp payload), because setting VHOST_NET_WEIGHT
>> takes into account only sent-bytes but no time.
>
>Interesting.
>
>Looking at vhost_can_busy_poll() it tries to poke pending vhost work and 
>exit the busy loop if it found one. So I believe something block the 
>work queuing. E.g did reverting 8241a1e466cd56e6c10472cac9c1ad4e54bc65db 
>fix the issue?

"busy tx polling" means using netperf send udp packets with 1 bytes payload(total 47bytes frame lenght), 
and handle_tx() will be busy sending packets continuously.

>
>>   It's not fair for handle_rx(),
>> so needs to limit max time of tx polling.
>>
>> ---
>>   drivers/vhost/net.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index 8139bc70ad7d..dc9218a3a75b 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -473,6 +473,7 @@ static void handle_tx(struct vhost_net *net)
>>   	struct socket *sock;
>>   	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
>>   	bool zcopy, zcopy_used;
>> +	unsigned long start = jiffies;
>
>Checking jiffies is tricky, need to convert it to ms or whatever others.
>
>>   
>>   	mutex_lock(&vq->mutex);
>>   	sock = vq->private_data;
>> @@ -580,7 +581,7 @@ static void handle_tx(struct vhost_net *net)
>>   		else
>>   			vhost_zerocopy_signal_used(net, vq);
>>   		vhost_net_tx_packet(net);
>> -		if (unlikely(total_len >= VHOST_NET_WEIGHT)) {
>> +		if (unlikely(total_len >= VHOST_NET_WEIGHT) || unlikely(jiffies - start >= 1)) {
>
>How value 1 is determined here? And we need a complete test to make sure 
>this won't affect other use cases.

We just want <1ms ping latency, but actually we are not sure what value is reasonable.
We have some test results using netperf before this patch as follow,

    Udp payload    1byte    100bytes    1000bytes    1400bytes
  Ping avg latency    25ms     10ms       2ms         1.5ms

What is other testcases?

>
>Another thought is introduce another limit of #packets, but this need 
>benchmark too.
>
>Thanks
>
>>   			vhost_poll_queue(&vq->poll);
>>   			break;
>>   		}
>
>
