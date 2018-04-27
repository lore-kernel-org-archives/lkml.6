Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbeD0JLy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:11:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:61521 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932430AbeD0JLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:11:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,334,1520924400";
   d="scan'208";a="194829847"
Date: Fri, 27 Apr 2018 17:12:34 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v3 0/5] virtio: support packed ring
Message-ID: <20180427091234.n6vr3wcnbnqxd3so@debian>
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <5ad1ca01-1e5c-7105-f303-7e8d42f6a068@redhat.com>
 <20180427071725-mutt-send-email-mst@kernel.org>
 <5c712aa2-f00e-b472-cdfc-48175aea790d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c712aa2-f00e-b472-cdfc-48175aea790d@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 02:17:51PM +0800, Jason Wang wrote:
> On 2018年04月27日 12:18, Michael S. Tsirkin wrote:
> > On Fri, Apr 27, 2018 at 11:56:05AM +0800, Jason Wang wrote:
> > > On 2018年04月25日 13:15, Tiwei Bie wrote:
> > > > Hello everyone,
> > > > 
> > > > This RFC implements packed ring support in virtio driver.
> > > > 
> > > > Some simple functional tests have been done with Jason's
> > > > packed ring implementation in vhost:
> > > > 
> > > > https://lkml.org/lkml/2018/4/23/12
> > > > 
> > > > Both of ping and netperf worked as expected (with EVENT_IDX
> > > > disabled). But there are below known issues:
> > > > 
> > > > 1. Reloading the guest driver will break the Tx/Rx;
> > > Will have a look at this issue.
> > > 
> > > > 2. Zeroing the flags when detaching a used desc will
> > > >      break the guest -> host path.
> > > I still think zeroing flags is unnecessary or even a bug. At host, I track
> > > last observed avail wrap counter and detect avail like (what is suggested in
> > > the example code in the spec):
> > > 
> > > static bool desc_is_avail(struct vhost_virtqueue *vq, __virtio16 flags)
> > > {
> > >         bool avail = flags & cpu_to_vhost16(vq, DESC_AVAIL);
> > > 
> > >         return avail == vq->avail_wrap_counter;
> > > }
> > > 
> > > So zeroing wrap can not work with this obviously.
> > > 
> > > Thanks
> > I agree. I think what one should do is flip the available bit.
> > 
> 
> But is this flipping a must?
> 
> Thanks

Yeah, that's my question too. It seems to be a requirement
for driver that, the only change to the desc status that a
driver can do during running is to mark the desc as avail,
and any other changes to the desc status are not allowed.
Similarly, the device can only mark the desc as used, and
any other changes to the desc status are also not allowed.
So the question is, are there such requirements?

Based on below contents in the spec:

"""
Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different
for an available descriptor and equal for a used descriptor.

Note that this observation is mostly useful for sanity-checking
as these are necessary but not sufficient conditions
"""

It seems that, it's necessary for devices to check whether
the AVAIL bit and USED bit are different.

Best regards,
Tiwei Bie
