Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E581C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD5820870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD5820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeLMOb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:31:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeLMOb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:31:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 331343001FD1;
        Thu, 13 Dec 2018 14:31:27 +0000 (UTC)
Received: from redhat.com (ovpn-120-178.rdu2.redhat.com [10.10.120.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C5345D6A9;
        Thu, 13 Dec 2018 14:31:26 +0000 (UTC)
Date:   Thu, 13 Dec 2018 09:31:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jintack Lim <jintack@cs.columbia.edu>
Subject: Re: [PATCH net V2 4/4] vhost: log dirty page correctly
Message-ID: <20181213092930-mutt-send-email-mst@kernel.org>
References: <20181212100819.21295-1-jasowang@redhat.com>
 <20181212100819.21295-5-jasowang@redhat.com>
 <20181212092435-mutt-send-email-mst@kernel.org>
 <0239c220-e7ca-c08f-be26-eb9be63fced3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0239c220-e7ca-c08f-be26-eb9be63fced3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Dec 2018 14:31:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:39:41AM +0800, Jason Wang wrote:
> 
> On 2018/12/12 下午10:32, Michael S. Tsirkin wrote:
> > On Wed, Dec 12, 2018 at 06:08:19PM +0800, Jason Wang wrote:
> > > Vhost dirty page logging API is designed to sync through GPA. But we
> > > try to log GIOVA when device IOTLB is enabled. This is wrong and may
> > > lead to missing data after migration.
> > > 
> > > To solve this issue, when logging with device IOTLB enabled, we will:
> > > 
> > > 1) reuse the device IOTLB translation result of GIOVA->HVA mapping to
> > >     get HVA, for writable descriptor, get HVA through iovec. For used
> > >     ring update, translate its GIOVA to HVA
> > > 2) traverse the GPA->HVA mapping to get the possible GPA and log
> > >     through GPA. Pay attention this reverse mapping is not guaranteed
> > >     to be unique, so we should log each possible GPA in this case.
> > > 
> > > This fix the failure of scp to guest during migration. In -next, we
> > > will probably support passing GIOVA->GPA instead of GIOVA->HVA.
> > > 
> > > Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> > > Reported-by: Jintack Lim <jintack@cs.columbia.edu>
> > > Cc: Jintack Lim <jintack@cs.columbia.edu>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > It's a nasty bug for sure but it's been like this for a long
> > time so I'm inclined to say let's put it in 4.21,
> > and queue for stable.
> > 
> > So please split this out from this series.
> 
> 
> Ok.
> 
> 
> > 
> > Also, I'd like to see a feature bit that allows GPA in IOTLBs.
> 
> 
> Just to make sure I understand this. It looks to me we should:
> 
> - allow passing GIOVA->GPA through UAPI
> 
> - cache GIOVA->GPA somewhere but still use GIOVA->HVA in device IOTLB for
> performance
> 
> Is this what you suggest?
> 
> Thanks

Not really. We already have GPA->HVA, so I suggested a flag to pass
GIOVA->GPA in the IOTLB.

This has advantages for security since a single table needs
then to be validated to ensure guest does not corrupt
QEMU memory.


> 
> > 
> > > ---
> > >   drivers/vhost/net.c   |  3 +-
> > >   drivers/vhost/vhost.c | 79 +++++++++++++++++++++++++++++++++++--------
> > >   drivers/vhost/vhost.h |  3 +-
> > >   3 files changed, 69 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index ad7a6f475a44..784df2b49628 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -1192,7 +1192,8 @@ static void handle_rx(struct vhost_net *net)
> > >   		if (nvq->done_idx > VHOST_NET_BATCH)
> > >   			vhost_net_signal_used(nvq);
> > >   		if (unlikely(vq_log))
> > > -			vhost_log_write(vq, vq_log, log, vhost_len);
> > > +			vhost_log_write(vq, vq_log, log, vhost_len,
> > > +					vq->iov, in);
> > >   		total_len += vhost_len;
> > >   		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
> > >   			vhost_poll_queue(&vq->poll);
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 55e5aa662ad5..3660310604fd 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -1733,11 +1733,67 @@ static int log_write(void __user *log_base,
> > >   	return r;
> > >   }
> > > +static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
> > > +{
> > > +	struct vhost_umem *umem = vq->umem;
> > > +	struct vhost_umem_node *u;
> > > +	u64 gpa;
> > > +	int r;
> > > +	bool hit = false;
> > > +
> > > +	list_for_each_entry(u, &umem->umem_list, link) {
> > > +		if (u->userspace_addr < hva &&
> > > +		    u->userspace_addr + u->size >=
> > > +		    hva + len) {
> > > +			gpa = u->start + hva - u->userspace_addr;
> > > +			r = log_write(vq->log_base, gpa, len);
> > > +			if (r < 0)
> > > +				return r;
> > > +			hit = true;
> > > +		}
> > > +	}
> > > +
> > > +	/* No reverse mapping, should be a bug */
> > > +	WARN_ON(!hit);
> > Maybe it should but userspace can trigger this easily I think.
> > We need to stop the device not warn in kernel log.
> > 
> > Also there's an error fd: VHOST_SET_VRING_ERR, need to wake it up.
> > 
> 
> Ok.
> 
> 
> > > +	return 0;
> > > +}
> > > +
> > > +static void log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
> > > +{
> > > +	struct iovec iov[64];
> > > +	int i, ret;
> > > +
> > > +	if (!vq->iotlb) {
> > > +		log_write(vq->log_base, vq->log_addr + used_offset, len);
> > > +		return;
> > > +	}
> > This change seems questionable. used ring writes
> > use their own machinery it does not go through iotlb.
> > Same should apply to log I think.
> 
> 
> The problem is used ring may not be physically contiguous with Device IOTLB
> enabled. So it should go through it.
> 
> 
> > 
> > > +
> > > +	ret = translate_desc(vq, (u64)(uintptr_t)vq->used + used_offset,
> > > +			     len, iov, 64, VHOST_ACCESS_WO);
> > > +	WARN_ON(ret < 0);
> > 
> > Same thing here. translation failures can be triggered from guest.
> > warn on is not a good error handling strategy ...
> 
> 
> Ok. Let me fix it.
> 
> 
> Thanks
> 
> 
> > > +
> > > +	for (i = 0; i < ret; i++) {
> > > +		ret = log_write_hva(vq,	(u64)(uintptr_t)iov[i].iov_base,
> > > +				    iov[i].iov_len);
> > > +		WARN_ON(ret);
> > > +	}
> > > +}
> > > +
> > >   int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
> > > -		    unsigned int log_num, u64 len)
> > > +		    unsigned int log_num, u64 len, struct iovec *iov, int count)
> > >   {
> > >   	int i, r;
> > > +	if (vq->iotlb) {
> > > +		for (i = 0; i < count; i++) {
> > > +			r = log_write_hva(vq, (u64)(uintptr_t)iov[i].iov_base,
> > > +					  iov[i].iov_len);
> > > +			if (r < 0)
> > > +				return r;
> > > +		}
> > > +		return 0;
> > > +	}
> > > +
> > >   	/* Make sure data written is seen before log. */
> > >   	smp_wmb();
> > >   	for (i = 0; i < log_num; ++i) {
> > > @@ -1769,9 +1825,8 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
> > >   		smp_wmb();
> > >   		/* Log used flag write. */
> > >   		used = &vq->used->flags;
> > > -		log_write(vq->log_base, vq->log_addr +
> > > -			  (used - (void __user *)vq->used),
> > > -			  sizeof vq->used->flags);
> > > +		log_used(vq, (used - (void __user *)vq->used),
> > > +			 sizeof vq->used->flags);
> > >   		if (vq->log_ctx)
> > >   			eventfd_signal(vq->log_ctx, 1);
> > >   	}
> > > @@ -1789,9 +1844,8 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
> > >   		smp_wmb();
> > >   		/* Log avail event write */
> > >   		used = vhost_avail_event(vq);
> > > -		log_write(vq->log_base, vq->log_addr +
> > > -			  (used - (void __user *)vq->used),
> > > -			  sizeof *vhost_avail_event(vq));
> > > +		log_used(vq, (used - (void __user *)vq->used),
> > > +			 sizeof *vhost_avail_event(vq));
> > >   		if (vq->log_ctx)
> > >   			eventfd_signal(vq->log_ctx, 1);
> > >   	}
> > > @@ -2191,10 +2245,8 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
> > >   		/* Make sure data is seen before log. */
> > >   		smp_wmb();
> > >   		/* Log used ring entry write. */
> > > -		log_write(vq->log_base,
> > > -			  vq->log_addr +
> > > -			   ((void __user *)used - (void __user *)vq->used),
> > > -			  count * sizeof *used);
> > > +		log_used(vq, ((void __user *)used - (void __user *)vq->used),
> > > +			 count * sizeof *used);
> > >   	}
> > >   	old = vq->last_used_idx;
> > >   	new = (vq->last_used_idx += count);
> > > @@ -2236,9 +2288,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
> > >   		/* Make sure used idx is seen before log. */
> > >   		smp_wmb();
> > >   		/* Log used index update. */
> > > -		log_write(vq->log_base,
> > > -			  vq->log_addr + offsetof(struct vring_used, idx),
> > > -			  sizeof vq->used->idx);
> > > +		log_used(vq, offsetof(struct vring_used, idx),
> > > +			 sizeof vq->used->idx);
> > >   		if (vq->log_ctx)
> > >   			eventfd_signal(vq->log_ctx, 1);
> > >   	}
> > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > index 466ef7542291..1b675dad5e05 100644
> > > --- a/drivers/vhost/vhost.h
> > > +++ b/drivers/vhost/vhost.h
> > > @@ -205,7 +205,8 @@ bool vhost_vq_avail_empty(struct vhost_dev *, struct vhost_virtqueue *);
> > >   bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
> > >   int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
> > > -		    unsigned int log_num, u64 len);
> > > +		    unsigned int log_num, u64 len,
> > > +		    struct iovec *iov, int count);
> > >   int vq_iotlb_prefetch(struct vhost_virtqueue *vq);
> > >   struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type);
> > > -- 
> > > 2.17.1
