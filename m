Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeDQU6X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 16:58:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:25152 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752633AbeDQU6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 16:58:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="47732664"
Date: Tue, 17 Apr 2018 13:57:44 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>, jgross@suse.com,
        Artem Mygaiev <Artem_Mygaiev@epam.com>, konrad.wilk@oracle.com,
        airlied@linux.ie,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper DRM driver
Message-ID: <20180417205744.GA15930@downor-Z87X-UD5H>
References: <20180329131931.29957-1-andr2000@gmail.com>
 <5d8fec7f-956c-378f-be90-f45029385740@gmail.com>
 <20180416192905.GA18096@downor-Z87X-UD5H>
 <20180417075928.GT31310@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417075928.GT31310@phenom.ffwll.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 09:59:28AM +0200, Daniel Vetter wrote:
> On Mon, Apr 16, 2018 at 12:29:05PM -0700, Dongwon Kim wrote:
> > Yeah, I definitely agree on the idea of expanding the use case to the 
> > general domain where dmabuf sharing is used. However, what you are
> > targetting with proposed changes is identical to the core design of
> > hyper_dmabuf.
> > 
> > On top of this basic functionalities, hyper_dmabuf has driver level
> > inter-domain communication, that is needed for dma-buf remote tracking
> > (no fence forwarding though), event triggering and event handling, extra
> > meta data exchange and hyper_dmabuf_id that represents grefs
> > (grefs are shared implicitly on driver level)
> 
> This really isn't a positive design aspect of hyperdmabuf imo. The core
> code in xen-zcopy (ignoring the ioctl side, which will be cleaned up) is
> very simple & clean.
> 
> If there's a clear need later on we can extend that. But for now xen-zcopy
> seems to cover the basic use-case needs, so gets the job done.
> 
> > Also it is designed with frontend (common core framework) + backend
> > (hyper visor specific comm and memory sharing) structure for portability.
> > We just can't limit this feature to Xen because we want to use the same
> > uapis not only for Xen but also other applicable hypervisor, like ACORN.
> 
> See the discussion around udmabuf and the needs for kvm. I think trying to
> make an ioctl/uapi that works for multiple hypervisors is misguided - it
> likely won't work.
> 
> On top of that the 2nd hypervisor you're aiming to support is ACRN. That's
> not even upstream yet, nor have I seen any patches proposing to land linux
> support for ACRN. Since it's not upstream, it doesn't really matter for
> upstream consideration. I'm doubting that ACRN will use the same grant
> references as xen, so the same uapi won't work on ACRN as on Xen anyway.

Yeah, ACRN doesn't have grant-table. Only Xen supports it. But that is why
hyper_dmabuf has been architectured with the concept of backend.
If you look at the structure of backend, you will find that
backend is just a set of standard function calls as shown here:

struct hyper_dmabuf_bknd_ops {
        /* backend initialization routine (optional) */
        int (*init)(void);

        /* backend cleanup routine (optional) */
        int (*cleanup)(void);

        /* retreiving id of current virtual machine */
        int (*get_vm_id)(void);

        /* get pages shared via hypervisor-specific method */
        int (*share_pages)(struct page **pages, int vm_id,
                           int nents, void **refs_info);

        /* make shared pages unshared via hypervisor specific method */
        int (*unshare_pages)(void **refs_info, int nents);

        /* map remotely shared pages on importer's side via
         * hypervisor-specific method
         */
        struct page ** (*map_shared_pages)(unsigned long ref, int vm_id,
                                           int nents, void **refs_info);

        /* unmap and free shared pages on importer's side via
         * hypervisor-specific method
         */
        int (*unmap_shared_pages)(void **refs_info, int nents);

        /* initialize communication environment */
        int (*init_comm_env)(void);

        void (*destroy_comm)(void);

        /* upstream ch setup (receiving and responding) */
        int (*init_rx_ch)(int vm_id);

        /* downstream ch setup (transmitting and parsing responses) */
        int (*init_tx_ch)(int vm_id);

        int (*send_req)(int vm_id, struct hyper_dmabuf_req *req, int wait);
};

All of these can be mapped with any hypervisor specific implementation.
We designed backend implementation for Xen using grant-table, Xen event
and ring buffer communication. For ACRN, we have another backend using Virt-IO
for both memory sharing and communication.

We tried to define this structure of backend to make it general enough (or
it can be even modified or extended to support more cases.) so that it can
fit to other hypervisor cases. Only requirements/expectation on the hypervisor
are page-level memory sharing and inter-domain communication, which I think
are standard features of modern hypervisor.

And please review common UAPIs that hyper_dmabuf and xen-zcopy supports. They
are very general. One is getting FD (dmabuf) and get those shared. The other
is generating dmabuf from global handle (secure handle hiding gref behind it).
On top of this, hyper_dmabuf has "unshare" and "query" which are also useful
for any cases.

So I don't know why we wouldn't want to try to make these standard in most of
hypervisor cases instead of limiting it to certain hypervisor like Xen.
Frontend-backend structre is optimal for this I think.

> 
> > So I am wondering we can start with this hyper_dmabuf then modify it for
> > your use-case if needed and polish and fix any glitches if we want to 
> > to use this for all general dma-buf usecases.
> 
> Imo xen-zcopy is a much more reasonable starting point for upstream, which
> can then be extended (if really proven to be necessary).
> 
> > Also, I still have one unresolved question regarding the export/import flow
> > in both of hyper_dmabuf and xen-zcopy.
> > 
> > @danvet: Would this flow (guest1->import existing dmabuf->share underlying
> > pages->guest2->map shared pages->create/export dmabuf) be acceptable now?
> 
> I think if you just look at the pages, and make sure you handle the
> sg_page == NULL case it's ok-ish. It's not great, but mostly it should
> work. The real trouble with hyperdmabuf was the forwarding of all these
> calls, instead of just passing around a list of grant references.

I talked to danvet about this litte bit.

I think there was some misunderstanding on this "forwarding". Exporting
and importing flow in hyper_dmabuf are basically same as xen-zcopy's. I think
what made confusion was that importing domain notifies exporting domain when
there are dmabuf operations (like attach, mapping, detach and release) so that
exporting domain can track the usage of dmabuf on the importing domain. 

I designed this for some basic tracking. We may not need to notify for every
different activity but if none of them is there, exporting domain can't
determine if it is ok to unshare the buffer or the originator (like i915)
can free the object even if it's being accessed in importing domain.

Anyway I really hope we can have enough discussion and resolve all concerns
before nailing it down.

> -Daniel
> 
> > 
> > Regards,
> > DW
> >  
> > On Mon, Apr 16, 2018 at 05:33:46PM +0300, Oleksandr Andrushchenko wrote:
> > > Hello, all!
> > > 
> > > After discussing xen-zcopy and hyper-dmabuf [1] approaches
> > > 
> > > it seems that xen-zcopy can be made not depend on DRM core any more
> > > 
> > > and be dma-buf centric (which it in fact is).
> > > 
> > > The DRM code was mostly there for dma-buf's FD import/export
> > > 
> > > with DRM PRIME UAPI and with DRM use-cases in mind, but it comes out that if
> > > 
> > > the proposed 2 IOCTLs (DRM_XEN_ZCOPY_DUMB_FROM_REFS and
> > > DRM_XEN_ZCOPY_DUMB_TO_REFS)
> > > 
> > > are extended to also provide a file descriptor of the corresponding dma-buf,
> > > then
> > > 
> > > PRIME stuff in the driver is not needed anymore.
> > > 
> > > That being said, xen-zcopy can safely be detached from DRM and moved from
> > > 
> > > drivers/gpu/drm/xen into drivers/xen/dma-buf-backend(?).
> > > 
> > > This driver then becomes a universal way to turn any shared buffer between
> > > Dom0/DomD
> > > 
> > > and DomU(s) into a dma-buf, e.g. one can create a dma-buf from any grant
> > > references
> > > 
> > > or represent a dma-buf as grant-references for export.
> > > 
> > > This way the driver can be used not only for DRM use-cases, but also for
> > > other
> > > 
> > > use-cases which may require zero copying between domains.
> > > 
> > > For example, the use-cases we are about to work in the nearest future will
> > > use
> > > 
> > > V4L, e.g. we plan to support cameras, codecs etc. and all these will benefit
> > > 
> > > from zero copying much. Potentially, even block/net devices may benefit,
> > > 
> > > but this needs some evaluation.
> > > 
> > > 
> > > I would love to hear comments for authors of the hyper-dmabuf
> > > 
> > > and Xen community, as well as DRI-Devel and other interested parties.
> > > 
> > > 
> > > Thank you,
> > > 
> > > Oleksandr
> > > 
> > > 
> > > On 03/29/2018 04:19 PM, Oleksandr Andrushchenko wrote:
> > > >From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > >
> > > >Hello!
> > > >
> > > >When using Xen PV DRM frontend driver then on backend side one will need
> > > >to do copying of display buffers' contents (filled by the
> > > >frontend's user-space) into buffers allocated at the backend side.
> > > >Taking into account the size of display buffers and frames per seconds
> > > >it may result in unneeded huge data bus occupation and performance loss.
> > > >
> > > >This helper driver allows implementing zero-copying use-cases
> > > >when using Xen para-virtualized frontend display driver by
> > > >implementing a DRM/KMS helper driver running on backend's side.
> > > >It utilizes PRIME buffers API to share frontend's buffers with
> > > >physical device drivers on backend's side:
> > > >
> > > >  - a dumb buffer created on backend's side can be shared
> > > >    with the Xen PV frontend driver, so it directly writes
> > > >    into backend's domain memory (into the buffer exported from
> > > >    DRM/KMS driver of a physical display device)
> > > >  - a dumb buffer allocated by the frontend can be imported
> > > >    into physical device DRM/KMS driver, thus allowing to
> > > >    achieve no copying as well
> > > >
> > > >For that reason number of IOCTLs are introduced:
> > > >  -  DRM_XEN_ZCOPY_DUMB_FROM_REFS
> > > >     This will create a DRM dumb buffer from grant references provided
> > > >     by the frontend
> > > >  - DRM_XEN_ZCOPY_DUMB_TO_REFS
> > > >    This will grant references to a dumb/display buffer's memory provided
> > > >    by the backend
> > > >  - DRM_XEN_ZCOPY_DUMB_WAIT_FREE
> > > >    This will block until the dumb buffer with the wait handle provided
> > > >    be freed
> > > >
> > > >With this helper driver I was able to drop CPU usage from 17% to 3%
> > > >on Renesas R-Car M3 board.
> > > >
> > > >This was tested with Renesas' Wayland-KMS and backend running as DRM master.
> > > >
> > > >Thank you,
> > > >Oleksandr
> > > >
> > > >Oleksandr Andrushchenko (1):
> > > >   drm/xen-zcopy: Add Xen zero-copy helper DRM driver
> > > >
> > > >  Documentation/gpu/drivers.rst               |   1 +
> > > >  Documentation/gpu/xen-zcopy.rst             |  32 +
> > > >  drivers/gpu/drm/xen/Kconfig                 |  25 +
> > > >  drivers/gpu/drm/xen/Makefile                |   5 +
> > > >  drivers/gpu/drm/xen/xen_drm_zcopy.c         | 880 ++++++++++++++++++++++++++++
> > > >  drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c | 154 +++++
> > > >  drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h |  38 ++
> > > >  include/uapi/drm/xen_zcopy_drm.h            | 129 ++++
> > > >  8 files changed, 1264 insertions(+)
> > > >  create mode 100644 Documentation/gpu/xen-zcopy.rst
> > > >  create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy.c
> > > >  create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.c
> > > >  create mode 100644 drivers/gpu/drm/xen/xen_drm_zcopy_balloon.h
> > > >  create mode 100644 include/uapi/drm/xen_zcopy_drm.h
> > > >
> > > [1]
> > > https://lists.xenproject.org/archives/html/xen-devel/2018-02/msg01202.html
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
