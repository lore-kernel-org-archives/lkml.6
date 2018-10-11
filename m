Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2065C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6252085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6252085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeJKUdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:33:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeJKUdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:33:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D11DF3D96B;
        Thu, 11 Oct 2018 13:06:24 +0000 (UTC)
Received: from [10.72.12.114] (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A330C65F6C;
        Thu, 11 Oct 2018 13:06:20 +0000 (UTC)
Subject: Re: [PATCH] virtio_net: enable tx after resuming from suspend
To:     ake <ake@igel.co.jp>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011075127.2608-1-ake@igel.co.jp>
 <dd530053-efab-b661-3423-1faaab8fb12f@redhat.com>
 <7e87b140-79ae-c79e-40ed-dc76b38eeae4@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a156fd7e-e36e-e4e9-c240-3117ecc5b1b4@redhat.com>
Date:   Thu, 11 Oct 2018 21:06:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7e87b140-79ae-c79e-40ed-dc76b38eeae4@igel.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 11 Oct 2018 13:06:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月11日 18:22, ake wrote:
>
> On 2018年10月11日 18:44, Jason Wang wrote:
>>
>> On 2018年10月11日 15:51, Ake Koomsin wrote:
>>> commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
>>> disabled the virtio tx before going to suspend to avoid a use after free.
>>> However, after resuming, it causes the virtio_net device to lose its
>>> network connectivity.
>>>
>>> To solve the issue, we need to enable tx after resuming.
>>>
>>> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during
>>> reset")
>>> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
>>> ---
>>>    drivers/net/virtio_net.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index dab504ec5e50..3453d80f5f81 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -2256,6 +2256,7 @@ static int virtnet_restore_up(struct
>>> virtio_device *vdev)
>>>        }
>>>          netif_device_attach(vi->dev);
>>> +    netif_start_queue(vi->dev);
>> I believe this is duplicated with netif_tx_wake_all_queues() in
>> netif_device_attach() above?
> Thank you for your review.
>
> If both netif_tx_wake_all_queues() and netif_start_queue() result in
> clearing __QUEUE_STATE_DRV_XOFF, then is it possible that some
> conditions in netif_device_attach() is not satisfied?

Yes, maybe. One case I can see now is when the device is down, in this 
case netif_device_attach() won't try to wakeup the queue.

>   Without
> netif_start_queue(), the virtio_net device does not resume properly
> after waking up.

How do you trigger the issue? Just do suspend/resume?

>
> Is it better to report this as a bug first?

Nope, you're very welcome to post patch directly.

> If I am to do more
> investigation, what areas should I look into?

As you've figured out, you can start with why netif_tx_wake_all_queues() 
were not executed?

(Btw, does the issue disappear if you move netif_tx_disable() under the 
check of netif_running() in virtnet_freeze_down()?)

Thanks

>
> Best Regards
> Ake Koomsin
>

