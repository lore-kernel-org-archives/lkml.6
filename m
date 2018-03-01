Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966807AbeCAJMU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:12:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966677AbeCAJMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:12:12 -0500
Subject: Re: [PATCH net-next 1/2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
 <1519874345-10235-2-git-send-email-jasowang@redhat.com>
 <20180301094129.29fb6ce6@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a7f69341-cb15-1cfe-0edf-05dc3c2647e4@redhat.com>
Date: Thu, 1 Mar 2018 17:11:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301094129.29fb6ce6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月01日 16:41, Jesper Dangaard Brouer wrote:
> On Thu,  1 Mar 2018 11:19:04 +0800 Jason Wang <jasowang@redhat.com> wrote:
>
>> XDP_REDIRECT support for mergeable buffer was removed since commit
>> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
>> case"). This is because we don't reserve enough tailroom for struct
>> skb_shared_info which breaks XDP assumption. Other complaints are, the
>> complex linearize logic and EWMA estimation may increase the
>> possibility of linearizing.
> This patch also have the intermixing issues, I mentioned for patch 2/2.
>
> On Thu, 1 Mar 2018 09:02:06 +0100
> Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
>> 1. XDP generic is not feature complete, e.g. cpumap will drop these
>>     packets. It might not be possible to implement some features, think
>>     of (AF_XDP) zero-copy.
>>
>> 2. This can easily cause out-of-order packets.
>>
>> 3. It makes it harder to troubleshoot, when diagnosing issues
>>     around #1, we have a hard time determining what path an XDP packet
>>     took (the xdp tracepoints doesn't know).
>
> It is slightly better, as it is consistent in calling XDP-generic in
> the XDP_REDIRECT action, which an action under heavy development, here
> we want the freedom to develop in different code tempi.

Looks not, this patch did:

+               case XDP_REDIRECT:
+                       err = xdp_do_redirect(dev, &xdp, xdp_prog);
+                       if (err)
                                 goto err_xdp;
+                       *xdp_xmit = true;
                         rcu_read_unlock();
                         goto xdp_xmit;

So native version is used for most cases. XDP-generic will be only used 
for the packets of insufficient headroom which should be rare (just 
first few packets).

>    And some
> features might never be available in XDP-generic. Thus, when a feature
> is missing/broken it will be consistent for the user.

This sounds bad.

>
> The remaining question is how will a user know that XDP "mode" she is
> using?

So for this patch, skb mode will only happen for the first several 
packets. So mostly native mode. And it's even not clear to me if user 
need to know about this since the performance should be the same.

>    The user clearly loaded an XDP-native program, and expect the
> associated performance, but XDP_REDIRECT will be using the slow
> XDP-generic code path...

As I replied above, XDP_REDIRECT use native mode except for the first 
few packets.

>
>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 107 +++++++++++++++++++++++++++++------------------
>>   1 file changed, 67 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 9bb9e56..81190ba 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
> [...]
>> @@ -689,31 +709,30 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   	struct bpf_prog *xdp_prog;
>>   	unsigned int truesize;
>>   	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>> -	bool sent;
>> +	bool sent, skb_xdp = false;
>> +	int err;
>>   
>>   	head_skb = NULL;
>>   
>>   	rcu_read_lock();
>>   	xdp_prog = rcu_dereference(rq->xdp_prog);
>>   	if (xdp_prog) {
>> -		struct page *xdp_page;
>>   		struct xdp_buff xdp;
>>   		void *data;
>>   		u32 act;
>>   
>> -		/* This happens when rx buffer size is underestimated */
>> +		/* This happens when rx buffer size is underestimated
>> +		 * or headroom is not enough because of the buffer
>> +		 * was refilled before XDP is set. In both cases,
>> +		 * for simplicity, we will offload them to generic
>> +		 * XDP routine. This should only happen for the first
>> +		 * several packets, so we don't care much about its
>> +		 * performance.
>> +		 */
>>   		if (unlikely(num_buf > 1 ||
>>   			     headroom < virtnet_get_headroom(vi))) {
> I think you also need to check the tailroom here? (AFAIK this is hidden
> in the len_to_ctx as the "truesize").

add_recvbuf_mergeable() did this:

     unsigned int headroom = virtnet_get_headroom(vi);
     unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;

So if headroom is not zero, it implies tailroom here.

Thanks

>
>> -			/* linearize data for XDP */
>> -			xdp_page = xdp_linearize_page(rq, &num_buf,
>> -						      page, offset,
>> -						      VIRTIO_XDP_HEADROOM,
>> -						      &len);
>> -			if (!xdp_page)
>> -				goto err_xdp;
>> -			offset = VIRTIO_XDP_HEADROOM;
>> -		} else {
>> -			xdp_page = page;
>> +			skb_xdp = true;
>> +			goto skb_xdp;
>>   		}
>>   
>>   		/* Transient failure which in theory could occur if
>
