Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D595BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98A42077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98A42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeKIBcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:32:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22087 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeKIBcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:32:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7358F2D7E5;
        Thu,  8 Nov 2018 15:56:09 +0000 (UTC)
Received: from redhat.com (ovpn-120-200.rdu2.redhat.com [10.10.120.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FB325D9CA;
        Thu,  8 Nov 2018 15:56:03 +0000 (UTC)
Date:   Thu, 8 Nov 2018 10:56:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
Message-ID: <20181108103155-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
 <20181107123933-mutt-send-email-mst@kernel.org>
 <20181108013759.GA20591@debian>
 <2d46a41e-bc00-276a-e19a-105c9dffc75a@redhat.com>
 <20181108115148.GA15701@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108115148.GA15701@debian>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 08 Nov 2018 15:56:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:51:48PM +0800, Tiwei Bie wrote:
> On Thu, Nov 08, 2018 at 04:18:25PM +0800, Jason Wang wrote:
> > 
> > On 2018/11/8 上午9:38, Tiwei Bie wrote:
> > > > > +
> > > > > +	if (vq->vq.num_free < descs_used) {
> > > > > +		pr_debug("Can't add buf len %i - avail = %i\n",
> > > > > +			 descs_used, vq->vq.num_free);
> > > > > +		/* FIXME: for historical reasons, we force a notify here if
> > > > > +		 * there are outgoing parts to the buffer.  Presumably the
> > > > > +		 * host should service the ring ASAP. */
> > > > I don't think we have a reason to do this for packed ring.
> > > > No historical baggage there, right?
> > > Based on the original commit log, it seems that the notify here
> > > is just an "optimization". But I don't quite understand what does
> > > the "the heuristics which KVM uses" refer to. If it's safe to drop
> > > this in packed ring, I'd like to do it.
> > 
> > 
> > According to the commit log, it seems like a workaround of lguest networking
> > backend.
> 
> Do you know why removing this notify in Tx will break "the
> heuristics which KVM uses"? Or what does "the heuristics
> which KVM uses" refer to?

Yes. QEMU has a mode where it disables notifications and processes TX
ring periodically from a timer.  It's off by default but used to be on
by default a long time ago. If ring becomes full this causes traffic
stalls.  As a work-around Rusty put in this hack to kick on ring full
even with notifications disabled.  It's easy enough to make sure QEMU
does not combine devices with packed ring support with the timer hack.
And I am guessing it's safe enough to also block that option completely
e.g. when virtio 1.0 is enabled.

> 
> > I agree to drop it, we should not have such burden.
> > 
> > But we should notice that, with this removed, the compare between packed vs
> > split is kind of unfair. Consider the removal of lguest support recently,
> > maybe we can drop this for split ring as well?
> > 
> > Thanks
> > 
> > 
> > > 
> > > commit 44653eae1407f79dff6f52fcf594ae84cb165ec4
> > > Author: Rusty Russell<rusty@rustcorp.com.au>
> > > Date:   Fri Jul 25 12:06:04 2008 -0500
> > > 
> > >      virtio: don't always force a notification when ring is full
> > >      We force notification when the ring is full, even if the host has
> > >      indicated it doesn't want to know.  This seemed like a good idea at
> > >      the time: if we fill the transmit ring, we should tell the host
> > >      immediately.
> > >      Unfortunately this logic also applies to the receiving ring, which is
> > >      refilled constantly.  We should introduce real notification thesholds
> > >      to replace this logic.  Meanwhile, removing the logic altogether breaks
> > >      the heuristics which KVM uses, so we use a hack: only notify if there are
> > >      outgoing parts of the new buffer.
> > >      Here are the number of exits with lguest's crappy network implementation:
> > >      Before:
> > >              network xmit 7859051 recv 236420
> > >      After:
> > >              network xmit 7858610 recv 118136
> > >      Signed-off-by: Rusty Russell<rusty@rustcorp.com.au>
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 72bf8bc09014..21d9a62767af 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -87,8 +87,11 @@ static int vring_add_buf(struct virtqueue *_vq,
> > >   	if (vq->num_free < out + in) {
> > >   		pr_debug("Can't add buf len %i - avail = %i\n",
> > >   			 out + in, vq->num_free);
> > > -		/* We notify*even if*  VRING_USED_F_NO_NOTIFY is set here. */
> > > -		vq->notify(&vq->vq);
> > > +		/* FIXME: for historical reasons, we force a notify here if
> > > +		 * there are outgoing parts to the buffer.  Presumably the
> > > +		 * host should service the ring ASAP. */
> > > +		if (out)
> > > +			vq->notify(&vq->vq);
> > >   		END_USE(vq);
> > >   		return -ENOSPC;
> > >   	}
> > > 
> > > 
