Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42510C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A2B2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A2B2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeITBbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:31:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeITBbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:31:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9D3C308404C;
        Wed, 19 Sep 2018 19:52:19 +0000 (UTC)
Received: from t450s.home (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88CA11DB;
        Wed, 19 Sep 2018 19:52:19 +0000 (UTC)
Date:   Wed, 19 Sep 2018 13:52:19 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 1/2] vfio: add edid api for display (vgpu) devices.
Message-ID: <20180919135219.3602d363@t450s.home>
In-Reply-To: <20180918133813.1845-2-kraxel@redhat.com>
References: <20180918133813.1845-1-kraxel@redhat.com>
        <20180918133813.1845-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 19 Sep 2018 19:52:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 15:38:12 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

No empty commit logs please.  There must be something to say about the
goal or motivation beyond the subject.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/uapi/linux/vfio.h | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82e81..78e5a37d83 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -301,6 +301,45 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>  
> +#define VFIO_REGION_TYPE_PCI_GFX                (1)

nit, what's the PCI dependency?

> +#define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
> +
> +/**
> + * Set display link state and edid blob.
> + *
> + * For the edid blob spec look here:
> + * https://en.wikipedia.org/wiki/Extended_Display_Identification_Data
> + *
> + * The guest should be notified about edid changes, for example by
> + * setting the link status to down temporarely (emulate monitor
> + * hotplug).

Who is responsible for this notification, the user interacting with
this region or the driver providing the region when a new edid is
provided?  This comment needs to state the expected API as clearly as
possible.

> + *
> + * @link_state:
> + * VFIO_DEVICE_GFX_LINK_STATE_UP: Monitor is turned on.
> + * VFIO_DEVICE_GFX_LINK_STATE_DOWN: Monitor is turned off.
> + *
> + * @edid_size: Size of the edid data blob.
> + * @edid_blob: The actual edid data.

What signals that the user edid_blob update is complete?  Should the
size be written before or after the blob?  Is the user required to
update the entire blob in a single write or can it be written
incrementally?

It might also be worth defining access widths, I see that you use
memcpy to support any width in mbochs, but we could define only native
field accesses for discrete registers if it makes the implementation
easier.

> + *
> + * Returns 0 on success, error code (such as -EINVAL) on failure.

Left over from ioctl.

> + */
> +struct vfio_region_gfx_edid {
> +	/* device capability hints (read only) */
> +	__u32 max_xres;
> +	__u32 max_yres;
> +	__u32 __reserved1[6];

Is the plan to use the version field within vfio_info_cap_header to
make use of these reserved fields later, ie. version 2 might define a
field from this reserved block?

> +
> +	/* device state (read/write) */
> +	__u32 link_state;
> +#define VFIO_DEVICE_GFX_LINK_STATE_UP    1
> +#define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
> +	__u32 edid_size;
> +	__u32 __reserved2[6];
> +
> +	/* edid blob (read/write) */
> +	__u8 edid_blob[512];

It seems the placement of this blob is what makes us feel like we need
to introduce reserved fields for later use, but we could instead define
an edid_offset read-only field so that the blob is always at the end of
whatever discrete fields we define.  Perhaps then we wouldn't even need
a read-only vs read-write section, simply define it per virtual
register.

Overall, I prefer this approach rather than adding yet more ioctls for
every feature and extension we add, thanks for implementing it.  What's
your impression vs ioctls?  Thanks,

Alex
