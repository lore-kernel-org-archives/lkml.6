Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id q5CUJP3/GFufEwAAmS7hNA
	; Thu, 07 Jun 2018 09:50:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 80C0D607F7; Thu,  7 Jun 2018 09:50:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0943C601C3;
	Thu,  7 Jun 2018 09:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0943C601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeFGJuu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:50:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753082AbeFGJut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:50:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 795CBC12BA;
        Thu,  7 Jun 2018 09:50:43 +0000 (UTC)
Received: from [10.72.12.43] (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0271820357CA;
        Thu,  7 Jun 2018 09:50:35 +0000 (UTC)
Subject: Re: [RFC v6 4/5] virtio_ring: add event idx support in packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com
References: <20180605074046.20709-1-tiwei.bie@intel.com>
 <20180605074046.20709-5-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c0621b16-3143-0bf7-f44f-3d1173577734@redhat.com>
Date: Thu, 7 Jun 2018 17:50:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605074046.20709-5-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 09:50:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 09:50:48 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年06月05日 15:40, Tiwei Bie wrote:
>   static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>   {
>   	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 bufs, used_idx, wrap_counter;
>   
>   	START_USE(vq);
>   
>   	/* We optimistically turn back on interrupts, then check if there was
>   	 * more to do. */
> +	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
> +	 * either clear the flags bit or point the event index at the next
> +	 * entry. Always update the event index to keep code simple. */
> +

Maybe for packed ring, it's time to treat event index separately to 
avoid a virtio_wmb() for event idx is off.

> +	/* TODO: tune this threshold */
> +	if (vq->next_avail_idx < vq->last_used_idx)
> +		bufs = (vq->vring_packed.num + vq->next_avail_idx -
> +				vq->last_used_idx) * 3 / 4;
> +	else
> +		bufs = (vq->next_avail_idx - vq->last_used_idx) * 3 / 4;

vq->next_avail-idx could be equal to vq->last_usd_idx when the ring is 
full. Though virito-net is the only user now and it can guarantee this 
won't happen. But consider this is a core API, we should make sure it 
can work for any cases.

It looks to me that bufs is just vq->vring_packed.num - vq->num_free?

> +
> +	wrap_counter = vq->used_wrap_counter;
> +
> +	used_idx = vq->last_used_idx + bufs;
> +	if (used_idx >= vq->vring_packed.num) {
> +		used_idx -= vq->vring_packed.num;
> +		wrap_counter ^= 1;
> +	}
> +
> +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> +			used_idx | (wrap_counter << 15));
>   
>   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> +		/* We need to update event offset and event wrap
> +		 * counter first before updating event flags. */
> +		virtio_wmb(vq->weak_barriers);
> +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> +						     VRING_EVENT_F_ENABLE;
>   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
>   							vq->event_flags_shadow);
> -		/* We need to enable interrupts first before re-checking
> -		 * for more used buffers. */
> -		virtio_mb(vq->weak_barriers);
>   	}
>   
> +	/* We need to update event suppression structure first
> +	 * before re-checking for more used buffers. */
> +	virtio_mb(vq->weak_barriers);
> +
>   	if (more_used_packed(vq)) {
>   		END_USE(vq);
>   		return false;

I think what we need to to make sure the descriptor used_idx is used? 
Otherwise we may stop and restart qdisc too frequently?

Thanks

> -- 
