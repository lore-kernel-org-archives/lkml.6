Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274EC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53D020892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53D020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeKHV2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:28:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:64446 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeKHV2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:28:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 03:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="84292164"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.173])
  by fmsmga007.fm.intel.com with ESMTP; 08 Nov 2018 03:53:21 -0800
Date:   Thu, 8 Nov 2018 19:51:48 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
Message-ID: <20181108115148.GA15701@debian>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
 <20181107123933-mutt-send-email-mst@kernel.org>
 <20181108013759.GA20591@debian>
 <2d46a41e-bc00-276a-e19a-105c9dffc75a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d46a41e-bc00-276a-e19a-105c9dffc75a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 04:18:25PM +0800, Jason Wang wrote:
> 
> On 2018/11/8 上午9:38, Tiwei Bie wrote:
> > > > +
> > > > +	if (vq->vq.num_free < descs_used) {
> > > > +		pr_debug("Can't add buf len %i - avail = %i\n",
> > > > +			 descs_used, vq->vq.num_free);
> > > > +		/* FIXME: for historical reasons, we force a notify here if
> > > > +		 * there are outgoing parts to the buffer.  Presumably the
> > > > +		 * host should service the ring ASAP. */
> > > I don't think we have a reason to do this for packed ring.
> > > No historical baggage there, right?
> > Based on the original commit log, it seems that the notify here
> > is just an "optimization". But I don't quite understand what does
> > the "the heuristics which KVM uses" refer to. If it's safe to drop
> > this in packed ring, I'd like to do it.
> 
> 
> According to the commit log, it seems like a workaround of lguest networking
> backend.

Do you know why removing this notify in Tx will break "the
heuristics which KVM uses"? Or what does "the heuristics
which KVM uses" refer to?


> I agree to drop it, we should not have such burden.
> 
> But we should notice that, with this removed, the compare between packed vs
> split is kind of unfair. Consider the removal of lguest support recently,
> maybe we can drop this for split ring as well?
> 
> Thanks
> 
> 
> > 
> > commit 44653eae1407f79dff6f52fcf594ae84cb165ec4
> > Author: Rusty Russell<rusty@rustcorp.com.au>
> > Date:   Fri Jul 25 12:06:04 2008 -0500
> > 
> >      virtio: don't always force a notification when ring is full
> >      We force notification when the ring is full, even if the host has
> >      indicated it doesn't want to know.  This seemed like a good idea at
> >      the time: if we fill the transmit ring, we should tell the host
> >      immediately.
> >      Unfortunately this logic also applies to the receiving ring, which is
> >      refilled constantly.  We should introduce real notification thesholds
> >      to replace this logic.  Meanwhile, removing the logic altogether breaks
> >      the heuristics which KVM uses, so we use a hack: only notify if there are
> >      outgoing parts of the new buffer.
> >      Here are the number of exits with lguest's crappy network implementation:
> >      Before:
> >              network xmit 7859051 recv 236420
> >      After:
> >              network xmit 7858610 recv 118136
> >      Signed-off-by: Rusty Russell<rusty@rustcorp.com.au>
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 72bf8bc09014..21d9a62767af 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -87,8 +87,11 @@ static int vring_add_buf(struct virtqueue *_vq,
> >   	if (vq->num_free < out + in) {
> >   		pr_debug("Can't add buf len %i - avail = %i\n",
> >   			 out + in, vq->num_free);
> > -		/* We notify*even if*  VRING_USED_F_NO_NOTIFY is set here. */
> > -		vq->notify(&vq->vq);
> > +		/* FIXME: for historical reasons, we force a notify here if
> > +		 * there are outgoing parts to the buffer.  Presumably the
> > +		 * host should service the ring ASAP. */
> > +		if (out)
> > +			vq->notify(&vq->vq);
> >   		END_USE(vq);
> >   		return -ENOSPC;
> >   	}
> > 
> > 
