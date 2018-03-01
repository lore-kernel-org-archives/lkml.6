Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966586AbeCAItf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:49:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965838AbeCAIte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:49:34 -0500
Subject: Re: [PATCH net-next 2/2] virtio-net: simplify XDP handling in small
 buffer
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
 <1519874345-10235-3-git-send-email-jasowang@redhat.com>
 <20180301090206.04e13a71@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dbbfd899-fb7e-c039-5c9a-0f3b6ce34b78@redhat.com>
Date: Thu, 1 Mar 2018 16:49:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301090206.04e13a71@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月01日 16:02, Jesper Dangaard Brouer wrote:
> On Thu,  1 Mar 2018 11:19:05 +0800 Jason Wang <jasowang@redhat.com> wrote:
>
>> We used to do data copy through xdp_linearize_page() for the buffer
>> without sufficient headroom, it brings extra complexity without
>> helping for the performance. So this patch remove it and switch to use
>> generic XDP routine to handle this case.
> I don't like where this is going.  I don't like intermixing the native
> XDP and generic XDP in this way, for several reasons:
>
> 1. XDP generic is not feature complete, e.g. cpumap will drop these
>     packets.

Well, then we'd better fix it, otherwise it would be even worse than not 
having it. For cpumap, it can be done through queuing skb in the pointer 
ring with some encoding/decoding.

>   It might not be possible to implement some features, think
>     of (AF_XDP) zero-copy.

Yes, but can AF_XDP support header adjustment? Consider the assumption 
of zerocopy, I was considering maybe we need a way to tell AF_XDP of 
whether or not zerocopy is supported by the driver.

>
> 2. This can easily cause out-of-order packets.

I may miss something, but it looks to me packets were still delivered in 
order? Or you mean the packets that was dropped by cpumap?

>
> 3. It makes it harder to troubleshoot, when diagnosing issues
>     around #1, we have a hard time determining what path an XDP packet
>     took (the xdp tracepoints doesn't know).

Looks like we can address this by adding tracepoints in generic code path.

>
>
> [...]
>> @@ -590,25 +526,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>   		if (unlikely(hdr->hdr.gso_type))
>>   			goto err_xdp;
>>   
>> +		/* This happnes when headroom is not enough because
>> +		 * the buffer was refilled before XDP is set. This
>> +		 * only happen for several packets, for simplicity,
>> +		 * offload them to generic XDP routine.
> In my practical tests, I also saw that sometime my ping packets were
> traveling this code-path, even after a long time when XDP were attached.

I don't see this, probably a bug somewhere. I would like to reproduce 
and see, how do you do the test? If there's just very few packets were 
received after XDP, we may still use the buffer that was refilled before 
XDP, that's by design.

>
> This worries me a bit, for troubleshooting purposes... as this can give
> a strange user experience given point #1.



I can stick to the xdp_linearize_page() logic if you don't like generic 
XDP stuffs, but it may not work for AF_XDP neither. Consider AF_XDP has 
still some distance of being merged, I'm not sure we could even care 
about it.

Thanks

>
>
>> +		 */
>>   		if (unlikely(xdp_headroom < virtnet_get_headroom(vi))) {
>> -			int offset = buf - page_address(page) + header_offset;
>> -			unsigned int tlen = len + vi->hdr_len;
>> -			u16 num_buf = 1;
>
