Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbeEHHRB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:17:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754287AbeEHHRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:17:00 -0400
Subject: Re: [RFC v3 4/5] virtio_ring: add event idx support in packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180502164828-mutt-send-email-mst@kernel.org>
 <20180502151255.h3x6rhszxa3euinl@debian>
 <20180502184015-mutt-send-email-mst@kernel.org>
 <20180503011116.qvoyblcpklinrk26@debian>
 <20180503044218-mutt-send-email-mst@kernel.org>
 <20180503020949.5u3qz32gsk33z6vk@debian>
 <9f0b4e37-63ff-42f9-f2e6-3747a19a0206@redhat.com>
 <20180503135430.lbtvn4p4lyu3ksqo@debian>
 <fbe06940-1618-5d34-7321-f4888c5dd1ee@redhat.com>
 <12ede490-f674-2b89-d639-266b5fe15466@redhat.com>
 <20180508064409.kcn6amhsxu7nkuuc@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <34f2c690-7cb2-f9ea-2ce9-40f4ccb594c9@redhat.com>
Date: Tue, 8 May 2018 15:16:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508064409.kcn6amhsxu7nkuuc@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月08日 14:44, Tiwei Bie wrote:
> On Tue, May 08, 2018 at 01:40:40PM +0800, Jason Wang wrote:
>> On 2018年05月08日 11:05, Jason Wang wrote:
>>>> Because in virtqueue_enable_cb_delayed(), we may set an
>>>> event_off which is bigger than new and both of them have
>>>> wrapped. And in this case, although new is smaller than
>>>> event_off (i.e. the third param -- old), new shouldn't
>>>> add vq->num, and actually we are expecting a very big
>>>> idx diff.
>>> Yes, so to calculate distance correctly between event and new, we just
>>> need to compare the warp counter and return false if it doesn't match
>>> without the need to try to add vq.num here.
>>>
>>> Thanks
>> Sorry, looks like the following should work, we need add vq.num if
>> used_wrap_counter does not match:
>>
>> static bool vhost_vring_packed_need_event(struct vhost_virtqueue *vq,
>>                        __u16 off_wrap, __u16 new,
>>                        __u16 old)
>> {
>>      bool wrap = off_wrap >> 15;
>>      int off = off_wrap & ~(1 << 15);
>>      __u16 d1, d2;
>>
>>      if (wrap != vq->used_wrap_counter)
>>          d1 = new + vq->num - off - 1;
> Just to draw your attention (maybe you have already
> noticed this).

I miss this, thanks!

>
> In this case (i.e. wrap != vq->used_wrap_counter),
> it's also possible that (off < new) is true. Because,
>
> when virtqueue_enable_cb_delayed_packed() is used,
> `off` is calculated in driver in a way like this:
>
> 	off = vq->last_used_idx + bufs;
> 	if (off >= vq->vring_packed.num) {
> 		off -= vq->vring_packed.num;
> 		wrap_counter ^= 1;
> 	}
>
> And when `new` (in vhost) is close to vq->num. The
> vq->last_used_idx + bufs (in driver) can be bigger
> than vq->vring_packed.num, and:
>
> 1. `off` will wrap;
> 2. wrap counters won't match;
> 3. off < new;
>
> And d1 (i.e. new + vq->num - off - 1) will be a value
> bigger than vq->num. I'm okay with this, although it's
> a bit weird.


So I'm considering something more compact by reusing vring_need_event() 
by pretending a larger queue size and adding vq->num back when necessary:

static bool vhost_vring_packed_need_event(struct vhost_virtqueue *vq,
                       __u16 off_wrap, __u16 new,
                       __u16 old)
{
     bool wrap = vq->used_wrap_counter;
     int off = off_wrap & ~(1 << 15);
     __u16 d1, d2;

     if (new < old) {
         new += vq->num;
         wrap ^= 1;
     }

     if (wrap != off_wrap >> 15)
         off += vq->num;

     return vring_need_event(off, new, old);
}


>
> Best regards,
> Tiwei Bie
>
>>      else
>>          d1 = new - off - 1;
>>
>>      if (new > old)
>>          d2 = new - old;
>>      else
>>          d2 = new + vq->num - old;
>>
>>      return d1 < d2;
>> }
>>
>> Thanks
>>
