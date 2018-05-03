Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeECNxt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:53:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:8547 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECNxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:53:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36584013"
Date: Thu, 3 May 2018 21:54:30 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v3 4/5] virtio_ring: add event idx support in packed ring
Message-ID: <20180503135430.lbtvn4p4lyu3ksqo@debian>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f0b4e37-63ff-42f9-f2e6-3747a19a0206@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 03:25:29PM +0800, Jason Wang wrote:
> On 2018年05月03日 10:09, Tiwei Bie wrote:
> > > > > So how about we use the straightforward way then?
> > > > You mean we do new += vq->vring_packed.num instead
> > > > of event_idx -= vq->vring_packed.num before calling
> > > > vring_need_event()?
> > > > 
> > > > The problem is that, the second param (new_idx) of
> > > > vring_need_event() will be used for:
> > > > 
> > > > (__u16)(new_idx - event_idx - 1)
> > > > (__u16)(new_idx - old)
> > > > 
> > > > So if we change new, we will need to change old too.
> > > I think that since we have a branch there anyway,
> > > we are better off just special-casing if (wrap_counter != vq->wrap_counter).
> > > Treat is differenty and avoid casts.
> > > 
> > > > And that would be an ugly hack..
> > > > 
> > > > Best regards,
> > > > Tiwei Bie
> > > I consider casts and huge numbers with two's complement
> > > games even uglier.
> > The dependency on two's complement game is introduced
> > since the split ring.
> > 
> > In packed ring, old is calculated via:
> > 
> > old = vq->next_avail_idx - vq->num_added;
> > 
> > In split ring, old is calculated via:
> > 
> > old = vq->avail_idx_shadow - vq->num_added;
> > 
> > In both cases, when vq->num_added is bigger, old will
> > be a big number.
> > 
> > Best regards,
> > Tiwei Bie
> > 
> 
> How about just do something like vhost:
> 
> static u16 vhost_idx_diff(struct vhost_virtqueue *vq, u16 old, u16 new)
> {
>     if (new > old)
>         return new - old;
>     return  (new + vq->num - old);
> }
> 
> static bool vhost_vring_packed_need_event(struct vhost_virtqueue *vq,
>                       __u16 event_off, __u16 new,
>                       __u16 old)
> {
>     return (__u16)(vhost_idx_diff(vq, new, event_off) - 1) <
>            (__u16)vhost_idx_diff(vq, new, old);
> }
> 
> ?

It seems that there is a typo in above code. The second
param of vhost_idx_diff() is `old`, but when calling this
function in vhost_vring_packed_need_event(), `new` is
passed as the second param.

If we assume the second param of vhost_idx_diff() is new
and the third one is old, i.e.:

static u16 vhost_idx_diff(struct vhost_virtqueue *vq, u16 new, u16 old)
{
    if (new > old)
        return new - old;
    return  (new + vq->num - old);
}

I think it's still not right.

Because in virtqueue_enable_cb_delayed(), we may set an
event_off which is bigger than new and both of them have
wrapped. And in this case, although new is smaller than
event_off (i.e. the third param -- old), new shouldn't
add vq->num, and actually we are expecting a very big
idx diff.

Best regards,
Tiwei Bie
