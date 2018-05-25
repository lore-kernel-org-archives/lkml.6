Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935679AbeEYC2y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:28:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935184AbeEYC2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:28:48 -0400
Subject: Re: [RFC V4 PATCH 8/8] vhost: event suppression for packed ring
To: mst@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfreimann@redhat.com, wexu@redhat.com, tiwei.bie@intel.com
References: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
 <1526473941-16199-9-git-send-email-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2757710b-3c36-9730-f205-dd198475bc70@redhat.com>
Date: Fri, 25 May 2018 10:28:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526473941-16199-9-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月16日 20:32, Jason Wang wrote:
> +static bool vhost_notify_packed(struct vhost_dev *dev,
> +				struct vhost_virtqueue *vq)
> +{
> +	__virtio16 event_off_wrap, event_flags;
> +	__u16 old, new, off_wrap;
> +	bool v;
> +
> +	/* Flush out used descriptors updates. This is paired
> +	 * with the barrier that the Guest executes when enabling
> +	 * interrupts.
> +	 */
> +	smp_mb();
> +
> +	if (vhost_get_avail(vq, event_flags,
> +			   &vq->driver_event->flags) < 0) {
> +		vq_err(vq, "Failed to get driver desc_event_flags");
> +		return true;
> +	}
> +
> +	if (event_flags == cpu_to_vhost16(vq, RING_EVENT_FLAGS_DISABLE))
> +		return false;
> +	else if (event_flags == cpu_to_vhost16(vq, RING_EVENT_FLAGS_ENABLE))
> +		return true;
> +
> +	/* Read desc event flags before event_off and event_wrap */
> +	smp_rmb();
> +
> +	if (vhost_get_avail(vq, event_off_wrap,
> +			    &vq->driver_event->off_warp) < 0) {
> +		vq_err(vq, "Failed to get driver desc_event_off/wrap");
> +		return true;
> +	}
> +
> +	off_wrap = vhost16_to_cpu(vq, event_off_wrap);
> +
> +	old = vq->signalled_used;
> +	v = vq->signalled_used_valid;
> +	new = vq->signalled_used = vq->last_used_idx;
> +	vq->signalled_used_valid = true;

We should move those idx tracking before checking event_flags. Otherwise 
we may lose interrupts because of a wrong signalled_used value.

Thanks

> +
> +	if (unlikely(!v))
> +		return true;
> +
> +	return vhost_vring_packed_need_event(vq, off_wrap, new, old);
> +}
