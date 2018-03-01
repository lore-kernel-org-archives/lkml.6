Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030904AbeCANk2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:40:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030701AbeCANk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:40:27 -0500
Date: Thu, 1 Mar 2018 15:40:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH net-next 0/2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
Message-ID: <20180301153900-mutt-send-email-mst@kernel.org>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
 <20180301101038.4253424d@redhat.com>
 <b0f55100-183d-a507-8510-3c67f6106031@redhat.com>
 <20180301113531.7b25e2df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180301113531.7b25e2df@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:35:31AM +0100, Jesper Dangaard Brouer wrote:
> On Thu, 1 Mar 2018 17:23:37 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > On 2018年03月01日 17:10, Jesper Dangaard Brouer wrote:
> > > On Thu,  1 Mar 2018 11:19:03 +0800
> > > Jason Wang <jasowang@redhat.com> wrote:
> > >  
> > >> This series tries to re-enable XDP_REDIRECT for mergeable buffer which
> > >> was removed since commit 7324f5399b06 ("virtio_net: disable
> > >> XDP_REDIRECT in receive_mergeable() case"). Main concerns are:
> > >>
> > >> - not enough tailroom was reserved which breaks cpumap  
> >
> > > To address this at a more fundamental level, I would suggest that we/you
> > > instead extend XDP to know it's buffers "frame" size/end.  (The
> > > assumption use to be, xdp_buff->data_hard_start + PAGE_SIZE, but
> > > ixgbe+virtio_net broke that assumption).
> > >
> > > It should actually be fairly easy to implement:
> > >   * Simply extend xdp_buff with a "data_hard_end" pointer.  
> > 
> > Right, and then cpumap can warn and drop packets with insufficient 
> > tailroom.
> >
> > But it should be a patch on top of this I think.
> 
> Hmmm, not really.  If we/you instead fix the issue of XDP doesn't know
> the end/size of the frame, then we don't need this mixed XDP
> generic/native code path mixing.
> 
> You could re-enable native redirect, and push the responsibility to
> cpumap for detecting this too-small frame "missing tailroom" (and avoid
> crashing...). (If we really want to support this, cpumap could fallback
> to dev_alloc_skb, and handle it gracefully).

Yea, we probably should.

However it's not nice that redirect is now gone in net.
IMHO a smaller version of patch 1/2 (without using generic code)
should go into net. tailroom tracking and fallback to dev_alloc_skb
can go into net-next.

> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
