Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F009C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AACB21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeLZD5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:57:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbeLZD5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:57:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FB8C8666D;
        Wed, 26 Dec 2018 03:57:42 +0000 (UTC)
Received: from [10.72.12.31] (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 688CA5C219;
        Wed, 26 Dec 2018 03:57:38 +0000 (UTC)
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213101022.12475-4-jasowang@redhat.com>
 <20181213102713-mutt-send-email-mst@kernel.org>
 <d70c5ac1-c805-cefd-ace1-643a2e271ba0@redhat.com>
 <20181214073332-mutt-send-email-mst@kernel.org>
 <2ea274df-a79a-250f-648f-12927529d78a@redhat.com>
 <20181224125237-mutt-send-email-mst@kernel.org>
 <b31dbf4c-d499-1d34-f39f-f10cc0febc84@redhat.com>
 <20181225071501-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <70978ed8-bf76-693a-0e11-d31b6234af5c@redhat.com>
Date:   Wed, 26 Dec 2018 11:57:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181225071501-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 26 Dec 2018 03:57:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/25 下午8:50, Michael S. Tsirkin wrote:
> On Tue, Dec 25, 2018 at 06:05:25PM +0800, Jason Wang wrote:
>> On 2018/12/25 上午2:10, Michael S. Tsirkin wrote:
>>> On Mon, Dec 24, 2018 at 03:53:16PM +0800, Jason Wang wrote:
>>>> On 2018/12/14 下午8:36, Michael S. Tsirkin wrote:
>>>>> On Fri, Dec 14, 2018 at 11:57:35AM +0800, Jason Wang wrote:
>>>>>> On 2018/12/13 下午11:44, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Dec 13, 2018 at 06:10:22PM +0800, Jason Wang wrote:
>>>>>>>> It was noticed that the copy_user() friends that was used to access
>>>>>>>> virtqueue metdata tends to be very expensive for dataplane
>>>>>>>> implementation like vhost since it involves lots of software check,
>>>>>>>> speculation barrier, hardware feature toggling (e.g SMAP). The
>>>>>>>> extra cost will be more obvious when transferring small packets.
>>>>>>>>
>>>>>>>> This patch tries to eliminate those overhead by pin vq metadata pages
>>>>>>>> and access them through vmap(). During SET_VRING_ADDR, we will setup
>>>>>>>> those mappings and memory accessors are modified to use pointers to
>>>>>>>> access the metadata directly.
>>>>>>>>
>>>>>>>> Note, this was only done when device IOTLB is not enabled. We could
>>>>>>>> use similar method to optimize it in the future.
>>>>>>>>
>>>>>>>> Tests shows about ~24% improvement on TX PPS when using virtio-user +
>>>>>>>> vhost_net + xdp1 on TAP (CONFIG_HARDENED_USERCOPY is not enabled):
>>>>>>>>
>>>>>>>> Before: ~5.0Mpps
>>>>>>>> After:  ~6.1Mpps
>>>>>>>>
>>>>>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>>>>>> ---
>>>>>>>>      drivers/vhost/vhost.c | 178 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>      drivers/vhost/vhost.h |  11 +++
>>>>>>>>      2 files changed, 189 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>>>>>> index bafe39d2e637..1bd24203afb6 100644
>>>>>>>> --- a/drivers/vhost/vhost.c
>>>>>>>> +++ b/drivers/vhost/vhost.c
>>>>>>>> @@ -443,6 +443,9 @@ void vhost_dev_init(struct vhost_dev *dev,
>>>>>>>>      		vq->indirect = NULL;
>>>>>>>>      		vq->heads = NULL;
>>>>>>>>      		vq->dev = dev;
>>>>>>>> +		memset(&vq->avail_ring, 0, sizeof(vq->avail_ring));
>>>>>>>> +		memset(&vq->used_ring, 0, sizeof(vq->used_ring));
>>>>>>>> +		memset(&vq->desc_ring, 0, sizeof(vq->desc_ring));
>>>>>>>>      		mutex_init(&vq->mutex);
>>>>>>>>      		vhost_vq_reset(dev, vq);
>>>>>>>>      		if (vq->handle_kick)
>>>>>>>> @@ -614,6 +617,102 @@ static void vhost_clear_msg(struct vhost_dev *dev)
>>>>>>>>      	spin_unlock(&dev->iotlb_lock);
>>>>>>>>      }
>>>>>>>> +static int vhost_init_vmap(struct vhost_vmap *map, unsigned long uaddr,
>>>>>>>> +			   size_t size, int write)
>>>>>>>> +{
>>>>>>>> +	struct page **pages;
>>>>>>>> +	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
>>>>>>>> +	int npinned;
>>>>>>>> +	void *vaddr;
>>>>>>>> +
>>>>>>>> +	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
>>>>>>>> +	if (!pages)
>>>>>>>> +		return -ENOMEM;
>>>>>>>> +
>>>>>>>> +	npinned = get_user_pages_fast(uaddr, npages, write, pages);
>>>>>>>> +	if (npinned != npages)
>>>>>>>> +		goto err;
>>>>>>>> +
>>>>>>> As I said I have doubts about the whole approach, but this
>>>>>>> implementation in particular isn't a good idea
>>>>>>> as it keeps the page around forever.
>>>> The pages wil be released during set features.
>>>>
>>>>
>>>>>>> So no THP, no NUMA rebalancing,
>>>> For THP, we will probably miss 2 or 4 pages, but does this really matter
>>>> consider the gain we have?
>>> We as in vhost? networking isn't the only thing guest does.
>>> We don't even know if this guest does a lot of networking.
>>> You don't
>>> know what else is in this huge page. Can be something very important
>>> that guest touches all the time.
>>
>> Well, the probability should be very small consider we usually give several
>> gigabytes to guest. The rest of the pages that doesn't sit in the same
>> hugepage with metadata can still be merged by THP.  Anyway, I can test the
>> differences.
> Thanks!
>
>>>> For NUMA rebalancing, I'm even not quite sure if
>>>> it can helps for the case of IPC (vhost). It looks to me the worst case it
>>>> may cause page to be thrash between nodes if vhost and userspace are running
>>>> in two nodes.
>>> So again it's a gain for vhost but has a completely unpredictable effect on
>>> other functionality of the guest.
>>>
>>> That's what bothers me with this approach.
>>
>> So:
>>
>> - The rest of the pages could still be balanced to other nodes, no?
>>
>> - try to balance metadata pages (belongs to co-operate processes) itself is
>> still questionable
> I am not sure why. It should be easy enough to force the VCPU and vhost
> to move (e.g. start them pinned to 1 cpu, then pin them to another one).
> Clearly sometimes this would be necessary for load balancing reasons.


Yes, but it looks to me the part of motivation of auto NUMA is to avoid 
manual pinning.


> With autonuma after a while (could take seconds but it will happen) the
> memory will migrate.
>

Yes. As you mentioned during the discuss, I wonder we could do it 
similarly through mmu notifier like APIC access page in commit 
c24ae0dcd3e ("kvm: x86: Unpin and remove kvm_arch->apic_access_page")


>
>
>>>
>>>
>>>
>>>>>> This is the price of all GUP users not only vhost itself.
>>>>> Yes. GUP is just not a great interface for vhost to use.
>>>> Zerocopy codes (enabled by defualt) use them for years.
>>> But only for TX and temporarily. We pin, read, unpin.
>>
>> Probably not. For several reasons that the page will be not be released soon
>> or held for a very long period of time or even forever.
>
> With zero copy? Well it's pinned until transmit. Takes a while
> but could be enough for autocopy to work esp since
> its the packet memory so not reused immediately.
>
>>> Your patch is different
>>>
>>> - it writes into memory and GUP has known issues with file
>>>     backed memory
>>
>> The ordinary user for vhost is anonymous pages I think?
>
> It's not the most common scenario and not the fastest one
> (e.g. THP does not work) but file backed is useful sometimes.
> It would not be nice at all to corrupt guest memory in that case.


Ok.


>
>>> - it keeps pages pinned forever
>>>
>>>
>>>
>>>>>> What's more
>>>>>> important, the goal is not to be left too much behind for other backends
>>>>>> like DPDK or AF_XDP (all of which are using GUP).
>>>>> So these guys assume userspace knows what it's doing.
>>>>> We can't assume that.
>>>> What kind of assumption do you they have?
>>>>
>>>>
>>>>>>> userspace-controlled
>>>>>>> amount of memory locked up and not accounted for.
>>>>>> It's pretty easy to add this since the slow path was still kept. If we
>>>>>> exceeds the limitation, we can switch back to slow path.
>>>>>>
>>>>>>> Don't get me wrong it's a great patch in an ideal world.
>>>>>>> But then in an ideal world no barriers smap etc are necessary at all.
>>>>>> Again, this is only for metadata accessing not the data which has been used
>>>>>> for years for real use cases.
>>>>>>
>>>>>> For SMAP, it makes senses for the address that kernel can not forcast. But
>>>>>> it's not the case for the vhost metadata since we know the address will be
>>>>>> accessed very frequently. For speculation barrier, it helps nothing for the
>>>>>> data path of vhost which is a kthread.
>>>>> I don't see how a kthread makes any difference. We do have a validation
>>>>> step which makes some difference.
>>>> The problem is not kthread but the address of userspace address. The
>>>> addresses of vq metadata tends to be consistent for a while, and vhost knows
>>>> they will be frequently. SMAP doesn't help too much in this case.
>>>>
>>>> Thanks.
>>> It's true for a real life applications but a malicious one
>>> can call the setup ioctls any number of times. And SMAP is
>>> all about malcious applications.
>>
>> We don't do this in the path of ioctl, there's no context switch between
>> userspace and kernel in the worker thread. SMAP is used to prevent kernel
>> from accessing userspace pages unexpectedly which is not the case for
>> metadata access.
>>
>> Thanks
> OK let's forget smap for now.


Some numbers I measured:

On an old Sandy bridge machine without SMAP support. Remove speculation 
barrier boost the performance from 4.6Mpps to 5.1Mpps

On a newer Broadwell machine with SMAP support. Remove speculation 
barrier only gives 2%-5% improvement, disable SMAP completely through 
Kconfig boost 57% performance from 4.8Mpps to 7.5Mpps. (Vmap gives 6Mpps 
- 6.1Mpps, it only bypass SMAP for metadata).

So it looks like for recent machine, SMAP becomes pain point when the 
copy is short (e.g 64B) for high PPS.

Thanks


>
>>>>>> Packet or AF_XDP benefit from
>>>>>> accessing metadata directly, we should do it as well.
>>>>>>
>>>>>> Thanks
