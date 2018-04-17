Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeDQCyG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:54:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:63374 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeDQCyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:54:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,461,1517904000";
   d="scan'208";a="217122779"
Date: Tue, 17 Apr 2018 10:51:33 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jfreimann@redhat.com
Subject: Re: [RFC v2] virtio: support packed ring
Message-ID: <20180417025133.7t7exmizgolr565z@debian>
References: <20180401141216.8969-1-tiwei.bie@intel.com>
 <ebfbfc3e-9e52-9331-61b6-258e131f822d@redhat.com>
 <20180413071529.f4esh654dakodf4f@debian>
 <8dee7d62-ac0b-54ba-6bec-4bc4a6fb34e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dee7d62-ac0b-54ba-6bec-4bc4a6fb34e9@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 10:11:58AM +0800, Jason Wang wrote:
> On 2018年04月13日 15:15, Tiwei Bie wrote:
> > On Fri, Apr 13, 2018 at 12:30:24PM +0800, Jason Wang wrote:
> > > On 2018年04月01日 22:12, Tiwei Bie wrote:
[...]
> > > > +static int detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
> > > > +			      void **ctx)
> > > > +{
> > > > +	struct vring_packed_desc *desc;
> > > > +	unsigned int i, j;
> > > > +
> > > > +	/* Clear data ptr. */
> > > > +	vq->desc_state[head].data = NULL;
> > > > +
> > > > +	i = head;
> > > > +
> > > > +	for (j = 0; j < vq->desc_state[head].num; j++) {
> > > > +		desc = &vq->vring_packed.desc[i];
> > > > +		vring_unmap_one_packed(vq, desc);
> > > > +		desc->flags = 0x0;
> > > Looks like this is unnecessary.
> > It's safer to zero it. If we don't zero it, after we
> > call virtqueue_detach_unused_buf_packed() which calls
> > this function, the desc is still available to the
> > device.
> 
> Well detach_unused_buf_packed() should be called after device is stopped,
> otherwise even if you try to clear, there will still be a window that device
> may use it.

This is not about whether the device has been stopped or
not. We don't have other places to re-initialize the ring
descriptors and wrap_counter. So they need to be set to
the correct values when doing detach_unused_buf.

Best regards,
Tiwei Bie
