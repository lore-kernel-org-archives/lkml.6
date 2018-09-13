Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300F9C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D10204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D10204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeIMXCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:02:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeIMXCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:02:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 974E5C058CB7;
        Thu, 13 Sep 2018 17:51:44 +0000 (UTC)
Received: from t450s.home (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 353AA19936;
        Thu, 13 Sep 2018 17:51:40 +0000 (UTC)
Date:   Thu, 13 Sep 2018 11:51:39 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 1/2] vfio: add edid api for display (vgpu) devices.
Message-ID: <20180913115139.02775316@t450s.home>
In-Reply-To: <20180913054745.6353-2-kraxel@redhat.com>
References: <20180913054745.6353-1-kraxel@redhat.com>
        <20180913054745.6353-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 13 Sep 2018 17:51:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 07:47:44 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

Some sort of commit log indicating the motivation for the change is
always appreciated.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/uapi/linux/vfio.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82e81..38b591e909 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -200,8 +200,11 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
>  #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
> +#define VFIO_DEVICE_FLAGS_EDID	(1 << 5)	/* Device supports edid */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
> +	__u32   edid_max_x;     /* Max display width (zero == no limit) */
> +	__u32   edid_max_y;     /* Max display height (zero == no limit) */
>  };

Hmm, not really what I was looking for, devices providing these values
are only a very small subset of devices supported by vfio, so I was
thinking a new flag bit would indicate the presence of a new __u32
cap_offset field and we'd define a capability something like:

struct vfio_device_info_edid_cap {
	struct vfio_info_cap_header header;
	__u32 edid_max_x;
	__u32 edid_max_y;
};

Therefore the capability is a generic expansion and the user would look
for this specific edid capability within that.  The protocol would be
as we have today with region info where a call using the base
vfio_device_info would return success regardless of argsz, but indicate
capabilities are supported and return in argsz the size necessary to
receive them.

Another possible implementation would be via a vfio region, we already
support device specific regions via capabilities with vfio_region_info,
so we could have an edid region which could handle both input and
output using a defined structure and protocol within the region.  With
an edid blob of up to 512 bytes now, that means the vendor driver would
need to buffer writes to that section of the region until some sort of
activation, possibly using another "register" within the field to
trigger the link state and only processing the edid blob on link down
to link up transition.  So the virtual register space of the region
might look like

struct vfio_device_edid_region {
	__u32 max_x;	/* read-only */
	__u32 max_y;	/* read-only */
	__u32 link_state;	/* read-write, 0=down, 1=up */
				/* edid blob processed on 0->1 */
	__u32 blob_size;	/* read-write */
			/* max size = region_size - end of blob_size */
	__u8 blob[];
};

This is sort of the "we're defining our own hardware, so why not use a
region as virtual register space for the device rather than throw a new
ioctl at everything" approach.  Thoughts?  Thanks,

Alex

>  #define VFIO_DEVICE_GET_INFO		_IO(VFIO_TYPE, VFIO_BASE + 7)
>  
> @@ -602,6 +605,41 @@ struct vfio_device_ioeventfd {
>  
>  #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +/**
> + * VFIO_DEVICE_SET_GFX_EDID - _IOW(VFIO_TYPE, VFIO_BASE + 17,
> + *                                 struct vfio_device_set_gfx_edid)
> + *
> + * Set display link state and edid blob (for UP state).
> + *
> + * For the edid blob spec look here:
> + * https://en.wikipedia.org/wiki/Extended_Display_Identification_Data
> + *
> + * The guest should be notified about edid changes, for example by
> + * setting the link status to down temporarely (emulate monitor
> + * hotplug).
> + *
> + * @link_state:
> + * VFIO_DEVICE_GFX_LINK_STATE_UP: Monitor is turned on.
> + * VFIO_DEVICE_GFX_LINK_STATE_DOWN: Monitor is turned off.
> + *
> + * @edid_size: Size of the edid data blob.
> + * @edid_blob: The actual edid data.
> + *
> + * Returns 0 on success, error code (such as -EINVAL) on failure.
> + */
> +struct vfio_device_set_gfx_edid {
> +	__u32 argsz;
> +	__u32 flags;
> +	/* in */
> +	__u32 link_state;
> +#define VFIO_DEVICE_GFX_LINK_STATE_UP    1
> +#define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
> +	__u32 edid_size;
> +	__u8  edid_blob[512];
> +};
> +
> +#define VFIO_DEVICE_SET_GFX_EDID _IO(VFIO_TYPE, VFIO_BASE + 17)
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

