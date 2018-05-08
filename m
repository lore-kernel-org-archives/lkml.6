Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbeEHFky (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:40:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752546AbeEHFkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:40:52 -0400
Subject: Re: [RFC v3 4/5] virtio_ring: add event idx support in packed ring
From: Jason Wang <jasowang@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180425051550.24342-5-tiwei.bie@intel.com>
 <34781052-df9f-e505-cd3f-08e460b34dcc@redhat.com>
 <20180502072819.mf5l3dypk6dwx2s7@debian>
 <20180502164828-mutt-send-email-mst@kernel.org>
 <20180502151255.h3x6rhszxa3euinl@debian>
 <20180502184015-mutt-send-email-mst@kernel.org>
 <20180503011116.qvoyblcpklinrk26@debian>
 <20180503044218-mutt-send-email-mst@kernel.org>
 <20180503020949.5u3qz32gsk33z6vk@debian>
 <9f0b4e37-63ff-42f9-f2e6-3747a19a0206@redhat.com>
 <20180503135430.lbtvn4p4lyu3ksqo@debian>
 <fbe06940-1618-5d34-7321-f4888c5dd1ee@redhat.com>
Message-ID: <12ede490-f674-2b89-d639-266b5fe15466@redhat.com>
Date: Tue, 8 May 2018 13:40:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fbe06940-1618-5d34-7321-f4888c5dd1ee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月08日 11:05, Jason Wang wrote:
>>
>> Because in virtqueue_enable_cb_delayed(), we may set an
>> event_off which is bigger than new and both of them have
>> wrapped. And in this case, although new is smaller than
>> event_off (i.e. the third param -- old), new shouldn't
>> add vq->num, and actually we are expecting a very big
>> idx diff.
>
> Yes, so to calculate distance correctly between event and new, we just 
> need to compare the warp counter and return false if it doesn't match 
> without the need to try to add vq.num here.
>
> Thanks 

Sorry, looks like the following should work, we need add vq.num if 
used_wrap_counter does not match:

static bool vhost_vring_packed_need_event(struct vhost_virtqueue *vq,
                       __u16 off_wrap, __u16 new,
                       __u16 old)
{
     bool wrap = off_wrap >> 15;
     int off = off_wrap & ~(1 << 15);
     __u16 d1, d2;

     if (wrap != vq->used_wrap_counter)
         d1 = new + vq->num - off - 1;
     else
         d1 = new - off - 1;

     if (new > old)
         d2 = new - old;
     else
         d2 = new + vq->num - old;

     return d1 < d2;
}

Thanks
