Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeDITyi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:54:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751549AbeDITyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:54:37 -0400
Date: Mon, 9 Apr 2018 22:54:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>, KVM list <kvm@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vhost: fix vhost_vq_access_ok() log check
Message-ID: <20180409224842-mutt-send-email-mst@kernel.org>
References: <20180409131021.5132-1-stefanha@redhat.com>
 <CA+55aFzJ_JPtU5SjAHHv--p3ZcAw4gVidxvrLLZF7w+kbHCNdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzJ_JPtU5SjAHHv--p3ZcAw4gVidxvrLLZF7w+kbHCNdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 09:52:13AM -0700, Linus Torvalds wrote:
> On Mon, Apr 9, 2018 at 6:10 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > @@ -1246,7 +1246,7 @@ int vhost_vq_access_ok(struct vhost_virtqueue *vq)
> >  {
> >         int ret = vq_log_access_ok(vq, vq->log_base);
> >
> > -       if (ret || vq->iotlb)
> > +       if (!ret || vq->iotlb)
> >                 return ret;
> 
> That logic is still very non-obvious.
> 
> This code already had one bug because of an odd illegible test
> sequence. Let's not keep the crazy code.
> 
> Why not just do the *obvious* thing, and get rid of "ret" entirely,
> and make the damn thing return a boolean, and then just write it all
> as
> 
>     /* Caller should have vq mutex and device mutex */
>     bool vhost_vq_access_ok(struct vhost_virtqueue *vq)
>     {
>             if (!vq_log_access_ok(vq, vq->log_base))
>                     return false;
> 
>             if (vq->iotlb || vq_access_ok(vq, vq->num, vq->desc,
> vq->avail, vq->used);
>     }
> 
> which makes the logic obvious: if vq_log_access_ok() fails, then then
> vhost_vq_access_ok() fails unconditionally.
> 
> Otherwise, we need to have an iotlb, or a successful vq_access_ok() check.
> 
> Doesn't that all make more sense, and avoid the insane "ret" value use
> that is really quite subtle?
> 
>                     Linus


I agree it's cleaner.

Stefan, I reposted your patch on netdev (since the breakage got applied
there too).

Would you like to self-nak it and post v2? Pls remember to CC netdev.

-- 
MST
