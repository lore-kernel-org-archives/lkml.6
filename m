Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031331AbeCAOQI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:16:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031264AbeCAOQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:16:06 -0500
Date: Thu, 1 Mar 2018 15:16:01 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, brouer@redhat.com
Subject: Re: [PATCH net-next 0/2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
Message-ID: <20180301151601.611d6b83@redhat.com>
In-Reply-To: <872bf3ea-7631-4e5f-9a6a-d632213cd15c@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
        <20180301101038.4253424d@redhat.com>
        <b0f55100-183d-a507-8510-3c67f6106031@redhat.com>
        <20180301113531.7b25e2df@redhat.com>
        <872bf3ea-7631-4e5f-9a6a-d632213cd15c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 21:15:36 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2018年03月01日 18:35, Jesper Dangaard Brouer wrote:
> > On Thu, 1 Mar 2018 17:23:37 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >  
> >> On 2018年03月01日 17:10, Jesper Dangaard Brouer wrote:  
> >>> On Thu,  1 Mar 2018 11:19:03 +0800
> >>> Jason Wang <jasowang@redhat.com> wrote:
> >>>     
> >>>> This series tries to re-enable XDP_REDIRECT for mergeable buffer which
> >>>> was removed since commit 7324f5399b06 ("virtio_net: disable
> >>>> XDP_REDIRECT in receive_mergeable() case"). Main concerns are:
> >>>>
> >>>> - not enough tailroom was reserved which breaks cpumap  
> >>> To address this at a more fundamental level, I would suggest that we/you
> >>> instead extend XDP to know it's buffers "frame" size/end.  (The
> >>> assumption use to be, xdp_buff->data_hard_start + PAGE_SIZE, but
> >>> ixgbe+virtio_net broke that assumption).
> >>>
> >>> It should actually be fairly easy to implement:
> >>>    * Simply extend xdp_buff with a "data_hard_end" pointer.  
> >> Right, and then cpumap can warn and drop packets with insufficient
> >> tailroom.
> >>
> >> But it should be a patch on top of this I think.  
> > Hmmm, not really.  If we/you instead fix the issue of XDP doesn't know
> > the end/size of the frame, then we don't need this mixed XDP
> > generic/native code path mixing.  
> 
> I know this but I'm still a little bit confused. According to the commit 
> log of 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in 
> receive_mergeable() case"), you said:
> 
> """
>      The longer explaination is that receive_mergeable() tries to
>      work-around and satisfy these XDP requiresments e.g. by having a
>      function xdp_linearize_page() that allocates and memcpy RX buffers
>      around (in case packet is scattered across multiple rx buffers).  This
>      does currently satisfy XDP_PASS, XDP_DROP and XDP_TX (but only because
>      we have not implemented bpf_xdp_adjust_tail yet).
> """
> 
> So I consider the tailroom is a must for the (future) tail adjustment.

That is true, BUT implementing the "data_hard_end" extension is a
pre-requisite.  It will also be to catch the issue of too little
tail-room if/when implementing bpf_xdp_adjust_tail().

It is of-cause a "nice-to-have", to fix this virtio_net driver's
receive_mergeable() call to have enough tail-room, but I don't see it
as a solution to the fundamental problem.


> > You could re-enable native redirect, and push the responsibility to
> > cpumap for detecting this too-small frame "missing tailroom" (and avoid
> > crashing...). (If we really want to support this, cpumap could fallback
> > to dev_alloc_skb, and handle it gracefully).
> >  
> 
> Right but it will be slower than build_skb().

True, but bad argument in this context, as you are already using a
similar function call napi_alloc_skb().  And it will be even slower to
call generic-XDP code path.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
