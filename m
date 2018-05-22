Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeEVDgZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:36:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751719AbeEVDgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:36:24 -0400
Subject: Re: [PATCH net 3/4] virtio-net: reset num_buf to 1 after linearizing
 packet
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
 <1526891706-18516-4-git-send-email-jasowang@redhat.com>
 <20180521174725-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d3a78362-c6e9-7361-d2b0-c3351b9a9c5a@redhat.com>
Date: Tue, 22 May 2018 11:36:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521174725-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月21日 22:59, Michael S. Tsirkin wrote:
> On Mon, May 21, 2018 at 04:35:05PM +0800, Jason Wang wrote:
>> If we successfully linearize the packets, num_buf were set to zero
>> which was wrong since we now have only 1 buffer to be used for e.g in
>> the error path of receive_mergeable(). Zero num_buf will lead the code
>> try to pop the buffers of next packet and drop it. Fixing this by set
>> num_buf to 1 if we successfully linearize the packet.
>>
>> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 6260d65..165a922 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -722,6 +722,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   						      &len);
>>   			if (!xdp_page)
>>   				goto err_xdp;
>> +			num_buf = 1;
> So this is tweaked here for the benefit of err_skb below.
> That's confusing and we won't remember to change it
> if we change the error handling.
>
> How about fixing the error path?
>
>
> -        while (--num_buf) {
> +        while (num_buf-- > 1) {
>
> Seems more robust to me.

Looks good, will do this in V2.

Thanks

>
>>   			offset = VIRTIO_XDP_HEADROOM;
>>   		} else {
>>   			xdp_page = page;
>> -- 
>> 2.7.4
