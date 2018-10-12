Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD5FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8A92087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8A92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJLPzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbeJLPzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:55:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C7B59D411;
        Fri, 12 Oct 2018 08:24:03 +0000 (UTC)
Received: from [10.72.12.161] (ovpn-12-161.pek2.redhat.com [10.72.12.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF29B84942;
        Fri, 12 Oct 2018 08:23:53 +0000 (UTC)
Subject: Re: [PATCH] virtio_net: enable tx after resuming from suspend
To:     ake <ake@igel.co.jp>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011075127.2608-1-ake@igel.co.jp>
 <dd530053-efab-b661-3423-1faaab8fb12f@redhat.com>
 <7e87b140-79ae-c79e-40ed-dc76b38eeae4@igel.co.jp>
 <a156fd7e-e36e-e4e9-c240-3117ecc5b1b4@redhat.com>
 <b294cbba-24a0-939d-98e8-d1483e3688a1@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4918ed7c-4c63-6f19-530b-8e16b0c496d4@redhat.com>
Date:   Fri, 12 Oct 2018 16:23:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b294cbba-24a0-939d-98e8-d1483e3688a1@igel.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 12 Oct 2018 08:24:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月12日 12:30, ake wrote:
>
> On 2018年10月11日 22:06, Jason Wang wrote:
>>
>> On 2018年10月11日 18:22, ake wrote:
>>> On 2018年10月11日 18:44, Jason Wang wrote:
>>>> On 2018年10月11日 15:51, Ake Koomsin wrote:
>>>>> commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
>>>>> disabled the virtio tx before going to suspend to avoid a use after
>>>>> free.
>>>>> However, after resuming, it causes the virtio_net device to lose its
>>>>> network connectivity.
>>>>>
>>>>> To solve the issue, we need to enable tx after resuming.
>>>>>
>>>>> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during
>>>>> reset")
>>>>> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
>>>>> ---
>>>>>     drivers/net/virtio_net.c | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>> index dab504ec5e50..3453d80f5f81 100644
>>>>> --- a/drivers/net/virtio_net.c
>>>>> +++ b/drivers/net/virtio_net.c
>>>>> @@ -2256,6 +2256,7 @@ static int virtnet_restore_up(struct
>>>>> virtio_device *vdev)
>>>>>         }
>>>>>           netif_device_attach(vi->dev);
>>>>> +    netif_start_queue(vi->dev);
>>>> I believe this is duplicated with netif_tx_wake_all_queues() in
>>>> netif_device_attach() above?
>>> Thank you for your review.
>>>
>>> If both netif_tx_wake_all_queues() and netif_start_queue() result in
>>> clearing __QUEUE_STATE_DRV_XOFF, then is it possible that some
>>> conditions in netif_device_attach() is not satisfied?
>> Yes, maybe. One case I can see now is when the device is down, in this
>> case netif_device_attach() won't try to wakeup the queue.
>>
>>>    Without
>>> netif_start_queue(), the virtio_net device does not resume properly
>>> after waking up.
>> How do you trigger the issue? Just do suspend/resume?
> Yes, simply suspend and resume.
>
> Here is how I trigger the issue:
>
> 1) Start the Virtual Machine Manager GUI program.
> 2) Create a guest Linux OS. Make sure that the guest OS kernel is
>     >= 4.12. Make sure that it uses virtio_net as its network device.
>     In addition, make sure that the video adapter is VGA. Otherwise,
>     waking up with the virtual power button does not work.
> 3) After installing the guest OS, log in, and test the network
>     connectivity by ping the host machine.
> 4) Suspend. After this, the screen is blank.
> 5) Resume by hitting the virtual power button. The login screen
>     appears again.
> 6) Log in again. The guest loses its network connection.
>
> In my test:
> Guest: Ubuntu 16.04/18.04 with kernel 4.15.0-36-generic
> Host: Ubuntu 16.04 with kernel 4.15.0-36-generic/4.4.0-137-generic

I can not reproduce this issue if virtio-net interface is up in guest 
before the suspend. I'm using net-next.git and qemu master. But I do 
reproduce when virtio-net interface is down in guest before suspend, 
after resume, even if I make it up, the network is still lost.

I think the interface is up in your case, but please confirm this.

>
>>> Is it better to report this as a bug first?
>> Nope, you're very welcome to post patch directly.
>>
>>> If I am to do more
>>> investigation, what areas should I look into?
>> As you've figured out, you can start with why netif_tx_wake_all_queues()
>> were not executed?
>>
>> (Btw, does the issue disappear if you move netif_tx_disable() under the
>> check of netif_running() in virtnet_freeze_down()?)
> The issue disappears if I move netif_tx_disable() under the check of
> netif_running() in virtnet_freeze_down(). Moving netif_tx_disable()
> is probably better as its logic is consistent with
> netif_device_attach() implementation. If you are OK with this idea,
> I will submit another patch.

I think the it helps for the case when interface is down before suspend. 
But it's still unclear why it help even if the interface is up 
(netif_running() is true).

Please submit a patch but we should figure out why it help for a up 
interface as well.

Thanks

>
>> Thanks
>>
>>> Best Regards
>>> Ake Koomsin
>>>
> Best Regards

