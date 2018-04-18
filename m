Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeDRBUF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 21:20:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:27721 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752679AbeDRBUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 21:20:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="44125309"
Date: Wed, 18 Apr 2018 09:17:57 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jfreimann@redhat.com
Subject: Re: [RFC v2] virtio: support packed ring
Message-ID: <20180418011757.ldeju5zh3e4366m5@debian>
References: <20180401141216.8969-1-tiwei.bie@intel.com>
 <ebfbfc3e-9e52-9331-61b6-258e131f822d@redhat.com>
 <20180413071529.f4esh654dakodf4f@debian>
 <8dee7d62-ac0b-54ba-6bec-4bc4a6fb34e9@redhat.com>
 <20180417025133.7t7exmizgolr565z@debian>
 <20180417151654-mutt-send-email-mst@kernel.org>
 <20180417124716.wsypd5zl4n4galrz@debian>
 <20180417170354-mutt-send-email-mst@kernel.org>
 <20180417145626.y5vei4y6irrdw7ky@debian>
 <20180417184810-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180417184810-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 06:54:51PM +0300, Michael S. Tsirkin wrote:
> On Tue, Apr 17, 2018 at 10:56:26PM +0800, Tiwei Bie wrote:
> > On Tue, Apr 17, 2018 at 05:04:59PM +0300, Michael S. Tsirkin wrote:
> > > On Tue, Apr 17, 2018 at 08:47:16PM +0800, Tiwei Bie wrote:
> > > > On Tue, Apr 17, 2018 at 03:17:41PM +0300, Michael S. Tsirkin wrote:
> > > > > On Tue, Apr 17, 2018 at 10:51:33AM +0800, Tiwei Bie wrote:
> > > > > > On Tue, Apr 17, 2018 at 10:11:58AM +0800, Jason Wang wrote:
> > > > > > > On 2018年04月13日 15:15, Tiwei Bie wrote:
> > > > > > > > On Fri, Apr 13, 2018 at 12:30:24PM +0800, Jason Wang wrote:
> > > > > > > > > On 2018年04月01日 22:12, Tiwei Bie wrote:
> > > > > > [...]
> > > > > > > > > > +static int detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
> > > > > > > > > > +			      void **ctx)
> > > > > > > > > > +{
> > > > > > > > > > +	struct vring_packed_desc *desc;
> > > > > > > > > > +	unsigned int i, j;
> > > > > > > > > > +
> > > > > > > > > > +	/* Clear data ptr. */
> > > > > > > > > > +	vq->desc_state[head].data = NULL;
> > > > > > > > > > +
> > > > > > > > > > +	i = head;
> > > > > > > > > > +
> > > > > > > > > > +	for (j = 0; j < vq->desc_state[head].num; j++) {
> > > > > > > > > > +		desc = &vq->vring_packed.desc[i];
> > > > > > > > > > +		vring_unmap_one_packed(vq, desc);
> > > > > > > > > > +		desc->flags = 0x0;
> > > > > > > > > Looks like this is unnecessary.
> > > > > > > > It's safer to zero it. If we don't zero it, after we
> > > > > > > > call virtqueue_detach_unused_buf_packed() which calls
> > > > > > > > this function, the desc is still available to the
> > > > > > > > device.
> > > > > > > 
> > > > > > > Well detach_unused_buf_packed() should be called after device is stopped,
> > > > > > > otherwise even if you try to clear, there will still be a window that device
> > > > > > > may use it.
> > > > > > 
> > > > > > This is not about whether the device has been stopped or
> > > > > > not. We don't have other places to re-initialize the ring
> > > > > > descriptors and wrap_counter. So they need to be set to
> > > > > > the correct values when doing detach_unused_buf.
> > > > > > 
> > > > > > Best regards,
> > > > > > Tiwei Bie
> > > > > 
> > > > > find vqs is the time to do it.
> > > > 
> > > > The .find_vqs() will call .setup_vq() which will eventually
> > > > call vring_create_virtqueue(). It's a different case. Here
> > > > we're talking about re-initializing the descs and updating
> > > > the wrap counter when detaching the unused descs (In this
> > > > case, split ring just needs to decrease vring.avail->idx).
> > > > 
> > > > Best regards,
> > > > Tiwei Bie
> > > 
> > > There's no requirement that  virtqueue_detach_unused_buf re-initializes
> > > the descs. It happens on cleanup path just before drivers delete the
> > > vqs.
> > 
> > Cool, I wasn't aware of it. I saw split ring decrease
> > vring.avail->idx after detaching an unused desc, so I
> > thought detaching unused desc also needs to make sure
> > that the ring state will be updated correspondingly.
> 
> 
> Hmm. You are right. Seems to be out console driver being out of spec.
> Will have to look at how to fix that :(
> 
> It was done here:
> 
> Commit b3258ff1d6086bd2b9eeb556844a868ad7d49bc8
> Author: Amit Shah <amit.shah@redhat.com>
> Date:   Wed Mar 16 19:12:10 2011 +0530
> 
>     virtio: Decrement avail idx on buffer detach
>     
>     When detaching a buffer from a vq, the avail.idx value should be
>     decremented as well.
>     
>     This was noticed by hot-unplugging a virtio console port and then
>     plugging in a new one on the same number (re-using the vqs which were
>     just 'disowned').  qemu reported
>     
>        'Guest moved used index from 0 to 256'
>     
>     when any IO was attempted on the new port.
>     
>     CC: stable@kernel.org
>     Reported-by: juzhang <juzhang@redhat.com>
>     Signed-off-by: Amit Shah <amit.shah@redhat.com>
>     Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> The spec is quite explicit though:
> 	A driver MUST NOT decrement the available idx on a live virtqueue (ie. there is no way to “unexpose”
> 	buffers).
> 

Hmm.. Got it. Thanks!

Best regards,
Tiwei Bie


> 
> 
> 
> 
> > If there is no such requirement, do you think it's OK
> > to remove below two lines:
> > 
> > vq->avail_idx_shadow--;
> > vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
> > 
> > from virtqueue_detach_unused_buf(), and we could have
> > one generic function to handle both rings:
> > 
> > void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
> > {
> > 	struct vring_virtqueue *vq = to_vvq(_vq);
> > 	unsigned int num, i;
> > 	void *buf;
> > 
> > 	START_USE(vq);
> > 
> > 	num = vq->packed ? vq->vring_packed.num : vq->vring.num;
> > 
> > 	for (i = 0; i < num; i++) {
> > 		if (!vq->desc_state[i].data)
> > 			continue;
> > 		/* detach_buf clears data, so grab it now. */
> > 		buf = vq->desc_state[i].data;
> > 		detach_buf(vq, i, NULL);
> > 		END_USE(vq);
> > 		return buf;
> > 	}
> > 	/* That should have freed everything. */
> > 	BUG_ON(vq->vq.num_free != num);
> > 
> > 	END_USE(vq);
> > 	return NULL;
> > }
> > 
> > Best regards,
> > Tiwei Bie
