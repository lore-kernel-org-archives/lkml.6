Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeECHZm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:25:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751240AbeECHZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:25:39 -0400
Subject: Re: [RFC v3 4/5] virtio_ring: add event idx support in packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <20180425051550.24342-5-tiwei.bie@intel.com>
 <34781052-df9f-e505-cd3f-08e460b34dcc@redhat.com>
 <20180502072819.mf5l3dypk6dwx2s7@debian>
 <20180502164828-mutt-send-email-mst@kernel.org>
 <20180502151255.h3x6rhszxa3euinl@debian>
 <20180502184015-mutt-send-email-mst@kernel.org>
 <20180503011116.qvoyblcpklinrk26@debian>
 <20180503044218-mutt-send-email-mst@kernel.org>
 <20180503020949.5u3qz32gsk33z6vk@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9f0b4e37-63ff-42f9-f2e6-3747a19a0206@redhat.com>
Date: Thu, 3 May 2018 15:25:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503020949.5u3qz32gsk33z6vk@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月03日 10:09, Tiwei Bie wrote:
>>>> So how about we use the straightforward way then?
>>> You mean we do new += vq->vring_packed.num instead
>>> of event_idx -= vq->vring_packed.num before calling
>>> vring_need_event()?
>>>
>>> The problem is that, the second param (new_idx) of
>>> vring_need_event() will be used for:
>>>
>>> (__u16)(new_idx - event_idx - 1)
>>> (__u16)(new_idx - old)
>>>
>>> So if we change new, we will need to change old too.
>> I think that since we have a branch there anyway,
>> we are better off just special-casing if (wrap_counter != vq->wrap_counter).
>> Treat is differenty and avoid casts.
>>
>>> And that would be an ugly hack..
>>>
>>> Best regards,
>>> Tiwei Bie
>> I consider casts and huge numbers with two's complement
>> games even uglier.
> The dependency on two's complement game is introduced
> since the split ring.
>
> In packed ring, old is calculated via:
>
> old = vq->next_avail_idx - vq->num_added;
>
> In split ring, old is calculated via:
>
> old = vq->avail_idx_shadow - vq->num_added;
>
> In both cases, when vq->num_added is bigger, old will
> be a big number.
>
> Best regards,
> Tiwei Bie
>

How about just do something like vhost:

static u16 vhost_idx_diff(struct vhost_virtqueue *vq, u16 old, u16 new)
{
     if (new > old)
         return new - old;
     return  (new + vq->num - old);
}

static bool vhost_vring_packed_need_event(struct vhost_virtqueue *vq,
                       __u16 event_off, __u16 new,
                       __u16 old)
{
     return (__u16)(vhost_idx_diff(vq, new, event_off) - 1) <
            (__u16)vhost_idx_diff(vq, new, old);
}

?
