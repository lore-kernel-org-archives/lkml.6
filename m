Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DEAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D16621479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D16621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeKVAUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:20:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKVAUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:20:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6288830001D4;
        Wed, 21 Nov 2018 13:46:14 +0000 (UTC)
Received: from [10.72.12.110] (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B979160923;
        Wed, 21 Nov 2018 13:46:09 +0000 (UTC)
Subject: Re: [PATCH net-next v3 00/13] virtio: support packed ring
To:     Tiwei Bie <tiwei.bie@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
References: <20181121100330.24846-1-tiwei.bie@intel.com>
 <20181121071308-mutt-send-email-mst@kernel.org>
 <20181121124233.GA32189@debian>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <84e80a22-75cc-5b9d-7f6e-980e41850e00@redhat.com>
Date:   Wed, 21 Nov 2018 21:46:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121124233.GA32189@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 21 Nov 2018 13:46:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/11/21 下午8:42, Tiwei Bie wrote:
> On Wed, Nov 21, 2018 at 07:20:27AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Nov 21, 2018 at 06:03:17PM +0800, Tiwei Bie wrote:
>>> Hi,
>>>
>>> This patch set implements packed ring support in virtio driver.
>>>
>>> A performance test between pktgen (pktgen_sample03_burst_single_flow.sh)
>>> and DPDK vhost (testpmd/rxonly/vhost-PMD) has been done, I saw
>>> ~30% performance gain in packed ring in this case.
>> Thanks a lot, this is very exciting!
>> Dave, given the holiday, attempts to wrap up the 1.1 spec and the
>> patchset size I would very much appreciate a bit more time for
>> review. Say until Nov 28?
>>
>>> To make this patch set work with below patch set for vhost,
>>> some hacks are needed to set the _F_NEXT flag in indirect
>>> descriptors (this should be fixed in vhost):
>>>
>>> https://lkml.org/lkml/2018/7/3/33
>> Could you pls clarify - do you mean it doesn't yet work with vhost
>> because of a vhost bug, and to test it with the linked patches
>> you had to hack in _F_NEXT? Because I do not see _F_NEXT
>> in indirect descriptors in this patch (which is fine).
>> Or did I miss it?
> You didn't miss anything. :)
>
> I think it's a small bug in vhost, which Jason may fix very
> quickly, so I didn't post it. Below is the hack I used:


Good catch. I didn't notice the subtle difference since split ring 
requires for it.

Let me fix it in next version.

Thanks.


>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..42faea7d8cf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -980,6 +980,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>   	unsigned int i, n, err_idx;
>   	u16 head, id;
>   	dma_addr_t addr;
> +	int c = 0;
>   
>   	head = vq->packed.next_avail_idx;
>   	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1001,8 +1002,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>   			if (vring_mapping_error(vq, addr))
>   				goto unmap_release;
>   
> -			desc[i].flags = cpu_to_le16(n < out_sgs ?
> -						0 : VRING_DESC_F_WRITE);
> +			desc[i].flags = cpu_to_le16((n < out_sgs ?
> +						0 : VRING_DESC_F_WRITE) |
> +				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT));
>   			desc[i].addr = cpu_to_le64(addr);
>   			desc[i].len = cpu_to_le32(sg->length);
>   			i++;
