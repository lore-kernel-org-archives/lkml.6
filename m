Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94347C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC1E2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC1E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeLND5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:57:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLND5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:57:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76B06307D852;
        Fri, 14 Dec 2018 03:57:42 +0000 (UTC)
Received: from [10.72.12.142] (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D23B5C1A1;
        Fri, 14 Dec 2018 03:57:37 +0000 (UTC)
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213101022.12475-4-jasowang@redhat.com>
 <20181213102713-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d70c5ac1-c805-cefd-ace1-643a2e271ba0@redhat.com>
Date:   Fri, 14 Dec 2018 11:57:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213102713-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 14 Dec 2018 03:57:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/13 下午11:44, Michael S. Tsirkin wrote:
> On Thu, Dec 13, 2018 at 06:10:22PM +0800, Jason Wang wrote:
>> It was noticed that the copy_user() friends that was used to access
>> virtqueue metdata tends to be very expensive for dataplane
>> implementation like vhost since it involves lots of software check,
>> speculation barrier, hardware feature toggling (e.g SMAP). The
>> extra cost will be more obvious when transferring small packets.
>>
>> This patch tries to eliminate those overhead by pin vq metadata pages
>> and access them through vmap(). During SET_VRING_ADDR, we will setup
>> those mappings and memory accessors are modified to use pointers to
>> access the metadata directly.
>>
>> Note, this was only done when device IOTLB is not enabled. We could
>> use similar method to optimize it in the future.
>>
>> Tests shows about ~24% improvement on TX PPS when using virtio-user +
>> vhost_net + xdp1 on TAP (CONFIG_HARDENED_USERCOPY is not enabled):
>>
>> Before: ~5.0Mpps
>> After:  ~6.1Mpps
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 178 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/vhost/vhost.h |  11 +++
>>   2 files changed, 189 insertions(+)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index bafe39d2e637..1bd24203afb6 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -443,6 +443,9 @@ void vhost_dev_init(struct vhost_dev *dev,
>>   		vq->indirect = NULL;
>>   		vq->heads = NULL;
>>   		vq->dev = dev;
>> +		memset(&vq->avail_ring, 0, sizeof(vq->avail_ring));
>> +		memset(&vq->used_ring, 0, sizeof(vq->used_ring));
>> +		memset(&vq->desc_ring, 0, sizeof(vq->desc_ring));
>>   		mutex_init(&vq->mutex);
>>   		vhost_vq_reset(dev, vq);
>>   		if (vq->handle_kick)
>> @@ -614,6 +617,102 @@ static void vhost_clear_msg(struct vhost_dev *dev)
>>   	spin_unlock(&dev->iotlb_lock);
>>   }
>>   
>> +static int vhost_init_vmap(struct vhost_vmap *map, unsigned long uaddr,
>> +			   size_t size, int write)
>> +{
>> +	struct page **pages;
>> +	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
>> +	int npinned;
>> +	void *vaddr;
>> +
>> +	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	npinned = get_user_pages_fast(uaddr, npages, write, pages);
>> +	if (npinned != npages)
>> +		goto err;
>> +
> As I said I have doubts about the whole approach, but this
> implementation in particular isn't a good idea
> as it keeps the page around forever.
> So no THP, no NUMA rebalancing,


This is the price of all GUP users not only vhost itself. What's more 
important, the goal is not to be left too much behind for other backends 
like DPDK or AF_XDP (all of which are using GUP).


> userspace-controlled
> amount of memory locked up and not accounted for.


It's pretty easy to add this since the slow path was still kept. If we 
exceeds the limitation, we can switch back to slow path.


>
> Don't get me wrong it's a great patch in an ideal world.
> But then in an ideal world no barriers smap etc are necessary at all.


Again, this is only for metadata accessing not the data which has been 
used for years for real use cases.

For SMAP, it makes senses for the address that kernel can not forcast. 
But it's not the case for the vhost metadata since we know the address 
will be accessed very frequently. For speculation barrier, it helps 
nothing for the data path of vhost which is a kthread. Packet or AF_XDP 
benefit from accessing metadata directly, we should do it as well.

Thanks

