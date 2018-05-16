Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeEPMZ5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:25:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:62149 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeEPMZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:25:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="229056167"
Date: Wed, 16 May 2018 20:26:21 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v4 5/5] virtio_ring: enable packed ring
Message-ID: <20180516122621.GA986@debian>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-6-tiwei.bie@intel.com>
 <27dfb4e8-6d63-bf7d-0f97-ac51559f8040@cogentembedded.com>
 <20180516102159.GA11467@debian>
 <dc6f6d01-7ca5-5264-6a58-1d5327da08cb@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc6f6d01-7ca5-5264-6a58-1d5327da08cb@cogentembedded.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 02:42:53PM +0300, Sergei Shtylyov wrote:
> On 05/16/2018 01:21 PM, Tiwei Bie wrote:
> 
> >>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> >>> ---
> >>>   drivers/virtio/virtio_ring.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >>> index de3839f3621a..b158692263b0 100644
> >>> --- a/drivers/virtio/virtio_ring.c
> >>> +++ b/drivers/virtio/virtio_ring.c
> >>> @@ -1940,6 +1940,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >>>   			break;
> >>>   		case VIRTIO_F_IOMMU_PLATFORM:
> >>>   			break;
> >>> +		case VIRTIO_F_RING_PACKED:
> >>> +			break;
> >>
> >>    Why not just add this *case* under the previous *case*?
> > 
> > Do you mean fallthrough? Something like:
> > 
> > 		case VIRTIO_F_IOMMU_PLATFORM:
> > 		case VIRTIO_F_RING_PACKED:
> > 			break;
> 
>    Yes, exactly. :-)

Using fallthrough in this case will make the code more
compact. I like such coding style. But unfortunately,
it's not consistent with the existing code. :(

The whole function will become something like this:

void vring_transport_features(struct virtio_device *vdev)
{
	unsigned int i;

	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++) {
		switch (i) {
		case VIRTIO_RING_F_INDIRECT_DESC:
			break;
		case VIRTIO_RING_F_EVENT_IDX:
			break;
		case VIRTIO_F_VERSION_1:
			break;
		case VIRTIO_F_IOMMU_PLATFORM:
		case VIRTIO_F_RING_PACKED:
			break;
		default:
			/* We don't understand this bit. */
			__virtio_clear_bit(vdev, i);
		}
	}
}

Best regards,
Tiwei Bie

> 
> > Best regards,
> > Tiwei Bie
> 
> [...]
> 
> MBR, Sergei
> 
