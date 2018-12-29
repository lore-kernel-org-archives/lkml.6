Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2311C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EA32176F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeL2Mlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:41:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeL2Mlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:41:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA026C057FA3;
        Sat, 29 Dec 2018 12:41:44 +0000 (UTC)
Received: from [10.72.12.130] (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BF79101963F;
        Sat, 29 Dec 2018 12:41:37 +0000 (UTC)
Subject: Re: [RFC PATCH V2 3/3] vhost: access vq metadata through kernel
 virtual address
To:     David Miller <davem@davemloft.net>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181228075537.21402-1-jasowang@redhat.com>
 <20181228075537.21402-4-jasowang@redhat.com>
 <20181228.113444.2162917443074434767.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <86418701-d57d-70a4-6f4c-25598b2c077e@redhat.com>
Date:   Sat, 29 Dec 2018 20:41:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181228.113444.2162917443074434767.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 29 Dec 2018 12:41:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/29 上午3:34, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Fri, 28 Dec 2018 15:55:37 +0800
>
>> +static int vhost_invalidate_vmap(struct vhost_virtqueue *vq,
>> +				 struct vhost_vmap *map,
>> +				 unsigned long uaddr,
>> +				 unsigned long start,
>> +				 unsigned long end,
>> +				 bool blockable)
>> +{
>> +	if (start < uaddr && end >= uaddr) {
>> +		if (!blockable)
>> +			return -EAGAIN;
>> +		mutex_lock(&vq->mutex);
>> +		if (map->addr)
>> +			vunmap(map->unmap_addr);
>> +		map->addr = NULL;
>> +		map->unmap_addr = NULL;
>> +		mutex_unlock(&vq->mutex);
>> +	}
>> +
>> +	return 0;
>> +}
> What are the rules for these invalidate operations?
>
> Can there be partial overlaps?  If so, wouldn't you need some way of
> keeping track of the partially overlapping unmaps so that once all of
> the invalidates covering the range occur you properly cleanup and do
> the vunmap()?


Yes, there can be partial overlap, so the check is buggy. We will remap 
the whole range in vq_meta_prefetch() before datapath path try to use 
them, so there's no need to track partial mapping here.

I spot another bug that the caller will access vq->avail without 
synchronized with vhost ioctl. Since we don't want to hold vq mutex for 
each invalidation, I will tear down MMU notifier during vhost ioctl to 
make sure invalidation request can access them without hold vq mutex.

Thanks

