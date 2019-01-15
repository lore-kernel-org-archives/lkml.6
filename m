Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF8C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D1B2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfAOHOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:14:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfAOHOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:14:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96AEA83F3C;
        Tue, 15 Jan 2019 07:14:42 +0000 (UTC)
Received: from [10.72.12.209] (ovpn-12-209.pek2.redhat.com [10.72.12.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB1B15D777;
        Tue, 15 Jan 2019 07:14:36 +0000 (UTC)
Subject: Re: [PATCH net V3] vhost: log dirty page correctly
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jintack Lim <jintack@cs.columbia.edu>
References: <20190111040036.12413-1-jasowang@redhat.com>
 <20190114125357-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <066c07e4-d8e4-40ec-8689-64b90b76c6d6@redhat.com>
Date:   Tue, 15 Jan 2019 15:14:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114125357-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Jan 2019 07:14:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/15 上午2:04, Michael S. Tsirkin wrote:
> On Fri, Jan 11, 2019 at 12:00:36PM +0800, Jason Wang wrote:
>> Vhost dirty page logging API is designed to sync through GPA. But we
>> try to log GIOVA when device IOTLB is enabled. This is wrong and may
>> lead to missing data after migration.
>>
>> To solve this issue, when logging with device IOTLB enabled, we will:
>>
>> 1) reuse the device IOTLB translation result of GIOVA->HVA mapping to
>>     get HVA, for writable descriptor, get HVA through iovec. For used
>>     ring update, translate its GIOVA to HVA
>> 2) traverse the GPA->HVA mapping to get the possible GPA and log
>>     through GPA. Pay attention this reverse mapping is not guaranteed
>>     to be unique, so we should log each possible GPA in this case.
>>
>> This fix the failure of scp to guest during migration. In -next, we
>> will probably support passing GIOVA->GPA instead of GIOVA->HVA.
>>
>> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
>> Reported-by: Jintack Lim<jintack@cs.columbia.edu>
>> Cc: Jintack Lim<jintack@cs.columbia.edu>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>> Changes from V2:
>> - check and log the case of range overlap
>> - remove unnecessary u64 cast
>> - use smp_wmb() for the case of device IOTLB as well
>> Changes from V1:
>> - return error instead of warn
>> ---
>>   drivers/vhost/net.c   |  3 +-
>>   drivers/vhost/vhost.c | 88 ++++++++++++++++++++++++++++++++++++-------
>>   drivers/vhost/vhost.h |  3 +-
>>   3 files changed, 78 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index 36f3d0f49e60..bca86bf7189f 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -1236,7 +1236,8 @@ static void handle_rx(struct vhost_net *net)
>>   		if (nvq->done_idx > VHOST_NET_BATCH)
>>   			vhost_net_signal_used(nvq);
>>   		if (unlikely(vq_log))
>> -			vhost_log_write(vq, vq_log, log, vhost_len);
>> +			vhost_log_write(vq, vq_log, log, vhost_len,
>> +					vq->iov, in);
>>   		total_len += vhost_len;
>>   		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
>>   			vhost_poll_queue(&vq->poll);
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 9f7942cbcbb2..55a2e8f9f8ca 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -1733,13 +1733,78 @@ static int log_write(void __user *log_base,
>>   	return r;
>>   }
>>   
>> +static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
>> +{
>> +	struct vhost_umem *umem = vq->umem;
>> +	struct vhost_umem_node *u;
>> +	u64 start, end;
>> +	int r;
>> +	bool hit = false;
>> +
>> +	/* More than one GPAs can be mapped into a single HVA. So
>> +	 * iterate all possible umems here to be safe.
>> +	 */
>> +	list_for_each_entry(u, &umem->umem_list, link) {
>> +		if (u->userspace_addr > hva - 1 + len ||
>> +		    u->userspace_addr - 1 + u->size < hva)
>> +			continue;
>> +		start = max(u->userspace_addr, hva);
>> +		end = min(u->userspace_addr - 1 + u->size, hva - 1 + len);
>> +		r = log_write(vq->log_base,
>> +			      u->start + start - u->userspace_addr,
>> +			      end - start + 1);
>> +		if (r < 0)
>> +			return r;
>> +		hit = true;
>> +	}
>> +
>> +	if (!hit)
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
> I definitely like the simplicity.
>
> But there's one point left here: if len crosses a region boundary,
> but doesn't all fall within a region, we don't consistently report -EFAULT.
>
> So I suspect we need to start by finding a region that contains hva.
> If there are many of these - move right to the end of the
> leftmost one and then repeat until we run out of len
> or fail to find a region and exit with -EFAULT.
>

Ok, will do it in V4.

Thanks


>
>
