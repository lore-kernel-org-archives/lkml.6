Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeEVDhr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:37:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751719AbeEVDho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:37:44 -0400
Subject: Re: [PATCH net 4/4] virito-net: fix leaking page for gso packet
 during mergeable XDP
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>
References: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
 <1526891706-18516-5-git-send-email-jasowang@redhat.com>
 <20180521175919-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cc243ed3-72b7-6970-a9aa-9836179a8949@redhat.com>
Date: Tue, 22 May 2018 11:37:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521175919-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月21日 23:01, Michael S. Tsirkin wrote:
> On Mon, May 21, 2018 at 04:35:06PM +0800, Jason Wang wrote:
>> We need to drop refcnt to xdp_page if we see a gso packet. Otherwise
>> it will be leaked. Fixing this by moving the check of gso packet above
>> the linearizing logic.
>>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Fixes: 72979a6c3590 ("virtio_net: xdp, add slowpath case for non contiguous buffers")
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> typo in subject

Let me fix it in V2.

>> ---
>>   drivers/net/virtio_net.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 165a922..f8db809 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -707,6 +707,14 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   		void *data;
>>   		u32 act;
>>   
>> +		/* Transient failure which in theory could occur if
>> +		 * in-flight packets from before XDP was enabled reach
>> +		 * the receive path after XDP is loaded. In practice I
>> +		 * was not able to create this condition.
> BTW we should probably drop the last sentence. It says in theory, should be enough.

Ok.

Thanks

>> +		 */
>> +		if (unlikely(hdr->hdr.gso_type))
>> +			goto err_xdp;
>> +
>>   		/* This happens when rx buffer size is underestimated
>>   		 * or headroom is not enough because of the buffer
>>   		 * was refilled before XDP is set. This should only
>> @@ -728,14 +736,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   			xdp_page = page;
>>   		}
>>   
>> -		/* Transient failure which in theory could occur if
>> -		 * in-flight packets from before XDP was enabled reach
>> -		 * the receive path after XDP is loaded. In practice I
>> -		 * was not able to create this condition.
>> -		 */
>> -		if (unlikely(hdr->hdr.gso_type))
>> -			goto err_xdp;
>> -
>>   		/* Allow consuming headroom but reserve enough space to push
>>   		 * the descriptor on if we get an XDP_TX return code.
>>   		 */
>> -- 
>> 2.7.4
