Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA970ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563C921523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563C921523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbeITNxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:53:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeITNxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 832F044808;
        Thu, 20 Sep 2018 08:11:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3659F308BDA2;
        Thu, 20 Sep 2018 08:11:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1D8DC41A63; Thu, 20 Sep 2018 10:11:06 +0200 (CEST)
Date:   Thu, 20 Sep 2018 10:11:06 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org, kvm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] vfio: add edid api for display (vgpu) devices.
Message-ID: <20180920081106.luezmrzhjzjtm2qu@sirius.home.kraxel.org>
References: <20180918133813.1845-1-kraxel@redhat.com>
 <20180918133813.1845-2-kraxel@redhat.com>
 <20180919135219.3602d363@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919135219.3602d363@t450s.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 20 Sep 2018 08:11:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:52:19PM -0600, Alex Williamson wrote:
> On Tue, 18 Sep 2018 15:38:12 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> No empty commit logs please.  There must be something to say about the
> goal or motivation beyond the subject.
> 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/uapi/linux/vfio.h | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 1aa7b82e81..78e5a37d83 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -301,6 +301,45 @@ struct vfio_region_info_cap_type {
> >  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> >  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> >  
> > +#define VFIO_REGION_TYPE_PCI_GFX                (1)
> 
> nit, what's the PCI dependency?

None I guess, just copy&paste from the (pci) vendor cap above ...
Will rename it.

> > + * The guest should be notified about edid changes, for example by
> > + * setting the link status to down temporarely (emulate monitor
> > + * hotplug).
> 
> Who is responsible for this notification, the user interacting with
> this region or the driver providing the region when a new edid is
> provided?  This comment needs to state the expected API as clearly as
> possible.

> > + * @link_state:
> > + * VFIO_DEVICE_GFX_LINK_STATE_UP: Monitor is turned on.
> > + * VFIO_DEVICE_GFX_LINK_STATE_DOWN: Monitor is turned off.
> > + *
> > + * @edid_size: Size of the edid data blob.
> > + * @edid_blob: The actual edid data.
> 
> What signals that the user edid_blob update is complete?  Should the
> size be written before or after the blob?  Is the user required to
> update the entire blob in a single write or can it be written
> incrementally?

My qemu test code first sets link-state = down, then updates edid, then
sets link-state = up.  I can document that as official update protocol.

Drivers should be able to map it do emulation events pretty straight
forward.  Except maybe for the final down-up transition, drivers might
have to delay this to make sure the guest has seen the up-down
transition.

> It might also be worth defining access widths, I see that you use
> memcpy to support any width in mbochs, but we could define only native
> field accesses for discrete registers if it makes the implementation
> easier.

Makes sense for the u32 registers (especially the writable ones).

For mbochs the virtual hardware has no link state notification, so I can
just store whatever I get, then check link-state when the guest attempts
to read the edid.

When actually implementing link-state notification it is probably useful
to not have to deal with a half-written link-state field ...

> > + */
> > +struct vfio_region_gfx_edid {
> > +	/* device capability hints (read only) */
> > +	__u32 max_xres;
> > +	__u32 max_yres;
> > +	__u32 __reserved1[6];
> 
> Is the plan to use the version field within vfio_info_cap_header to
> make use of these reserved fields later, ie. version 2 might define a
> field from this reserved block?

Yes.

> > +	/* device state (read/write) */
> > +	__u32 link_state;
> > +#define VFIO_DEVICE_GFX_LINK_STATE_UP    1
> > +#define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
> > +	__u32 edid_size;
> > +	__u32 __reserved2[6];
> > +
> > +	/* edid blob (read/write) */
> > +	__u8 edid_blob[512];
> 
> It seems the placement of this blob is what makes us feel like we need
> to introduce reserved fields for later use, but we could instead define
> an edid_offset read-only field so that the blob is always at the end of
> whatever discrete fields we define.

Yes, sounds sensible.

> Perhaps then we wouldn't even need a read-only vs read-write section,
> simply define it per virtual register.

I'll look into this.

> Overall, I prefer this approach rather than adding yet more ioctls for
> every feature and extension we add, thanks for implementing it.  What's
> your impression vs ioctls?

I'd still prefer ioctls, but this is workable too.  So if you like it
better this way lets go for it.

cheers,
  Gerd

