Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2AB208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2AB208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbeGKBJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:09:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:21851 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeGKBJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:09:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 18:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,336,1526367600"; 
   d="scan'208";a="63764520"
Received: from debian.sh.intel.com (HELO debian) ([10.67.104.228])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2018 18:07:43 -0700
Date:   Wed, 11 Jul 2018 09:07:30 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v1 5/5] virtio_ring: enable packed ring
Message-ID: <20180711010730.GA28235@debian>
References: <20180709072241.8886-1-tiwei.bie@intel.com>
 <20180709072241.8886-6-tiwei.bie@intel.com>
 <27ae72ad-247b-e8f0-aa37-a75a719e0e01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27ae72ad-247b-e8f0-aa37-a75a719e0e01@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 01:51:20PM +0800, Jason Wang wrote:
> On 2018年07月09日 15:22, Tiwei Bie wrote:
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >   drivers/s390/virtio/virtio_ccw.c | 8 ++++++++
> >   drivers/virtio/virtio_ring.c     | 2 ++
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index 8f5c1d7f751a..ff5b85736d8d 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -765,6 +765,11 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
> >   	return rc;
> >   }
> > +static void ccw_transport_features(struct virtio_device *vdev)
> > +{
> > +	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
> > +}
> 
> I think we need a better comment to explain why it was disabled here.

Yeah, I'll do it!

Best regards,
Tiwei Bie

> 
> Thanks
> 
> > +
> >   static int virtio_ccw_finalize_features(struct virtio_device *vdev)
> >   {
> >   	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> > @@ -791,6 +796,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
> >   	/* Give virtio_ring a chance to accept features. */
> >   	vring_transport_features(vdev);
> > +	/* Give virtio_ccw a chance to accept features. */
> > +	ccw_transport_features(vdev);
> > +
> >   	features->index = 0;
> >   	features->features = cpu_to_le32((u32)vdev->features);
> >   	/* Write the first half of the feature bits to the host. */
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 4b3f9e1a3cab..64f20023f088 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1968,6 +1968,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >   			break;
> >   		case VIRTIO_F_IOMMU_PLATFORM:
> >   			break;
> > +		case VIRTIO_F_RING_PACKED:
> > +			break;
> >   		default:
> >   			/* We don't understand this bit. */
> >   			__virtio_clear_bit(vdev, i);
> 
