Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD22C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21C52171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfABLim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:38:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbfABLil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:38:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 089E1C05B02D;
        Wed,  2 Jan 2019 11:38:41 +0000 (UTC)
Received: from [10.72.12.159] (ovpn-12-159.pek2.redhat.com [10.72.12.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 725795D756;
        Wed,  2 Jan 2019 11:38:36 +0000 (UTC)
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213102713-mutt-send-email-mst@kernel.org>
 <d70c5ac1-c805-cefd-ace1-643a2e271ba0@redhat.com>
 <20181214073332-mutt-send-email-mst@kernel.org>
 <2ea274df-a79a-250f-648f-12927529d78a@redhat.com>
 <20181224125237-mutt-send-email-mst@kernel.org>
 <b31dbf4c-d499-1d34-f39f-f10cc0febc84@redhat.com>
 <20181225071501-mutt-send-email-mst@kernel.org>
 <70978ed8-bf76-693a-0e11-d31b6234af5c@redhat.com>
 <20181226092431-mutt-send-email-mst@kernel.org>
 <8ef53a5c-ad4e-fadd-b460-18b3e589ead9@redhat.com>
 <20181230132614-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <16185718-e8f2-ff11-c695-aa5d9c9689f6@redhat.com>
Date:   Wed, 2 Jan 2019 19:38:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181230132614-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 02 Jan 2019 11:38:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/31 上午2:30, Michael S. Tsirkin wrote:
> On Thu, Dec 27, 2018 at 05:39:21PM +0800, Jason Wang wrote:
>> On 2018/12/26 下午11:02, Michael S. Tsirkin wrote:
>>> On Wed, Dec 26, 2018 at 11:57:32AM +0800, Jason Wang wrote:
>>>> On 2018/12/25 下午8:50, Michael S. Tsirkin wrote:
>>>>> On Tue, Dec 25, 2018 at 06:05:25PM +0800, Jason Wang wrote:
>>>>>> On 2018/12/25 上午2:10, Michael S. Tsirkin wrote:
>>>>>>> On Mon, Dec 24, 2018 at 03:53:16PM +0800, Jason Wang wrote:
>>>>>>>> On 2018/12/14 下午8:36, Michael S. Tsirkin wrote:
>>>>>>>>> On Fri, Dec 14, 2018 at 11:57:35AM +0800, Jason Wang wrote:
>>>>>>>>>> On 2018/12/13 下午11:44, Michael S. Tsirkin wrote:
>>>>>>>>>>> On Thu, Dec 13, 2018 at 06:10:22PM +0800, Jason Wang wrote:
>>>>>>>>>>>> It was noticed that the copy_user() friends that was used to access
>>>>>>>>>>>> virtqueue metdata tends to be very expensive for dataplane
>>>>>>>>>>>> implementation like vhost since it involves lots of software check,
>>>>>>>>>>>> speculation barrier, hardware feature toggling (e.g SMAP). The
>>>>>>>>>>>> extra cost will be more obvious when transferring small packets.
>>>>>>>>>>>>
>>>>>>>>>>>> This patch tries to eliminate those overhead by pin vq metadata pages
>>>>>>>>>>>> and access them through vmap(). During SET_VRING_ADDR, we will setup
>>>>>>>>>>>> those mappings and memory accessors are modified to use pointers to
>>>>>>>>>>>> access the metadata directly.
>>>>>>>>>>>>
>>>>>>>>>>>> Note, this was only done when device IOTLB is not enabled. We could
>>>>>>>>>>>> use similar method to optimize it in the future.
>>>>>>>>>>>>
>>>>>>>>>>>> Tests shows about ~24% improvement on TX PPS when using virtio-user +
>>>>>>>>>>>> vhost_net + xdp1 on TAP (CONFIG_HARDENED_USERCOPY is not enabled):
>>>>>>>>>>>>
>>>>>>>>>>>> Before: ~5.0Mpps
>>>>>>>>>>>> After:  ~6.1Mpps
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>        drivers/vhost/vhost.c | 178 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>        drivers/vhost/vhost.h |  11 +++
>>>>>>>>>>>>        2 files changed, 189 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>>>>>>>>>> index bafe39d2e637..1bd24203afb6 100644
>>>>>>>>>>>> --- a/drivers/vhost/vhost.c
>>>>>>>>>>>> +++ b/drivers/vhost/vhost.c
>>>>>>>>>>>> @@ -443,6 +443,9 @@ void vhost_dev_init(struct vhost_dev *dev,
>>>>>>>>>>>>        		vq->indirect = NULL;
>>>>>>>>>>>>        		vq->heads = NULL;
>>>>>>>>>>>>        		vq->dev = dev;
>>>>>>>>>>>> +		memset(&vq->avail_ring, 0, sizeof(vq->avail_ring));
>>>>>>>>>>>> +		memset(&vq->used_ring, 0, sizeof(vq->used_ring));
>>>>>>>>>>>> +		memset(&vq->desc_ring, 0, sizeof(vq->desc_ring));
>>>>>>>>>>>>        		mutex_init(&vq->mutex);
>>>>>>>>>>>>        		vhost_vq_reset(dev, vq);
>>>>>>>>>>>>        		if (vq->handle_kick)
>>>>>>>>>>>> @@ -614,6 +617,102 @@ static void vhost_clear_msg(struct vhost_dev *dev)
>>>>>>>>>>>>        	spin_unlock(&dev->iotlb_lock);
>>>>>>>>>>>>        }
>>>>>>>>>>>> +static int vhost_init_vmap(struct vhost_vmap *map, unsigned long uaddr,
>>>>>>>>>>>> +			   size_t size, int write)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +	struct page **pages;
>>>>>>>>>>>> +	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
>>>>>>>>>>>> +	int npinned;
>>>>>>>>>>>> +	void *vaddr;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
>>>>>>>>>>>> +	if (!pages)
>>>>>>>>>>>> +		return -ENOMEM;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	npinned = get_user_pages_fast(uaddr, npages, write, pages);
>>>>>>>>>>>> +	if (npinned != npages)
>>>>>>>>>>>> +		goto err;
>>>>>>>>>>>> +
>>>>>>>>>>> As I said I have doubts about the whole approach, but this
>>>>>>>>>>> implementation in particular isn't a good idea
>>>>>>>>>>> as it keeps the page around forever.
>>>>>>>> The pages wil be released during set features.
>>>>>>>>
>>>>>>>>
>>>>>>>>>>> So no THP, no NUMA rebalancing,
>>>>>>>> For THP, we will probably miss 2 or 4 pages, but does this really matter
>>>>>>>> consider the gain we have?
>>>>>>> We as in vhost? networking isn't the only thing guest does.
>>>>>>> We don't even know if this guest does a lot of networking.
>>>>>>> You don't
>>>>>>> know what else is in this huge page. Can be something very important
>>>>>>> that guest touches all the time.
>>>>>> Well, the probability should be very small consider we usually give several
>>>>>> gigabytes to guest. The rest of the pages that doesn't sit in the same
>>>>>> hugepage with metadata can still be merged by THP.  Anyway, I can test the
>>>>>> differences.
>>>>> Thanks!
>>>>>
>>>>>>>> For NUMA rebalancing, I'm even not quite sure if
>>>>>>>> it can helps for the case of IPC (vhost). It looks to me the worst case it
>>>>>>>> may cause page to be thrash between nodes if vhost and userspace are running
>>>>>>>> in two nodes.
>>>>>>> So again it's a gain for vhost but has a completely unpredictable effect on
>>>>>>> other functionality of the guest.
>>>>>>>
>>>>>>> That's what bothers me with this approach.
>>>>>> So:
>>>>>>
>>>>>> - The rest of the pages could still be balanced to other nodes, no?
>>>>>>
>>>>>> - try to balance metadata pages (belongs to co-operate processes) itself is
>>>>>> still questionable
>>>>> I am not sure why. It should be easy enough to force the VCPU and vhost
>>>>> to move (e.g. start them pinned to 1 cpu, then pin them to another one).
>>>>> Clearly sometimes this would be necessary for load balancing reasons.
>>>> Yes, but it looks to me the part of motivation of auto NUMA is to avoid
>>>> manual pinning.
>>> ... of memory. Yes.
>>>
>>>
>>>>> With autonuma after a while (could take seconds but it will happen) the
>>>>> memory will migrate.
>>>>>
>>>> Yes. As you mentioned during the discuss, I wonder we could do it similarly
>>>> through mmu notifier like APIC access page in commit c24ae0dcd3e ("kvm: x86:
>>>> Unpin and remove kvm_arch->apic_access_page")
>>> That would be a possible approach.
>>
>> Yes, this looks possible, and the conversion seems not hard. Let me have a
>> try with this.
>>
>>
>> [...]
>>
>>
>>>>>>>>> I don't see how a kthread makes any difference. We do have a validation
>>>>>>>>> step which makes some difference.
>>>>>>>> The problem is not kthread but the address of userspace address. The
>>>>>>>> addresses of vq metadata tends to be consistent for a while, and vhost knows
>>>>>>>> they will be frequently. SMAP doesn't help too much in this case.
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>> It's true for a real life applications but a malicious one
>>>>>>> can call the setup ioctls any number of times. And SMAP is
>>>>>>> all about malcious applications.
>>>>>> We don't do this in the path of ioctl, there's no context switch between
>>>>>> userspace and kernel in the worker thread. SMAP is used to prevent kernel
>>>>>> from accessing userspace pages unexpectedly which is not the case for
>>>>>> metadata access.
>>>>>>
>>>>>> Thanks
>>>>> OK let's forget smap for now.
>>>> Some numbers I measured:
>>>>
>>>> On an old Sandy bridge machine without SMAP support. Remove speculation
>>>> barrier boost the performance from 4.6Mpps to 5.1Mpps
>>>>
>>>> On a newer Broadwell machine with SMAP support. Remove speculation barrier
>>>> only gives 2%-5% improvement, disable SMAP completely through Kconfig boost
>>>> 57% performance from 4.8Mpps to 7.5Mpps. (Vmap gives 6Mpps - 6.1Mpps, it
>>>> only bypass SMAP for metadata).
>>>>
>>>> So it looks like for recent machine, SMAP becomes pain point when the copy
>>>> is short (e.g 64B) for high PPS.
>>>>
>>>> Thanks
>>> Thanks a lot for looking into this!
>>>
>>> So first of all users can just boot with nosmap, right?
>>> What's wrong with that?
>>
>> Nothing wrong, just realize we had this kernel parameter.
>>
>>
>>>    Yes it's not fine-grained but OTOH
>>> it's easy to understand.
>>>
>>> And I guess this confirms that if we are going to worry
>>> about smap enabled, we need to look into packet copies
>>> too, not just meta-data.
>>
>> For packet copies, we can do batch copy which is pretty simple for the case
>> of XDP. I've already had patches for this.
>>
>>
>>> Vaguely could see a module option (off by default)
>>> where vhost basically does user_access_begin
>>> when it starts running, then uses unsafe accesses
>>> in vhost and tun and then user_access_end.
>>
>> Using user_access_begin() is more tricky than imaged. E.g it requires:
>>
>> - userspace address to be validated before through access_ok() [1]
> This part is fine I think - addresses come from the memory
> map and when userspace supplies the memory map
> we validate everything with access_ok.
> Well do we validate with the iotlb too? Don't see it right now
> so maybe not but it's easy to add.


Yes, it's not hard.


>
>> - It doesn't support calling a function that does explicit schedule since
>> SMAP/PAN state is not maintained through schedule() [2]
>>
>> [1] https://lwn.net/Articles/736348/
>>
>> [2] https://lkml.org/lkml/2018/11/23/430
>>
>> So calling user_access_begin() all the time when vhost is running seems
>> pretty dangerous.
> Yes it requires some rework e.g. to try getting memory with
> GFP_ATOMIC. We could then do a slow path with GFP_KERNEL
> if that fails.


I'm not sure this is the only part that needs care. Consider all the 
under layer network or block codes assumes a process context, it's not 
easy to figure out all I'm afraid. And even if we could, it's hard to 
prevent it from being added in the future.

Thanks


>
>> For a better batched datacopy, I tend to build not only XDP but also skb in
>> vhost in the future.
>>
>> Thanks
> Sure, why not.
>
>>>
>>>>>>>>>> Packet or AF_XDP benefit from
>>>>>>>>>> accessing metadata directly, we should do it as well.
>>>>>>>>>>
>>>>>>>>>> Thanks
