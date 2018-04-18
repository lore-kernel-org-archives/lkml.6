Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeDRQCD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:02:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:64423 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeDRQCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:02:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,465,1517904000";
   d="scan'208";a="221430902"
Date: Wed, 18 Apr 2018 09:01:15 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Paul Durrant <Paul.Durrant@citrix.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Artem Mygaiev <Artem_Mygaiev@epam.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
Message-ID: <20180418160115.GA20588@downor-Z87X-UD5H>
References: <20180417075928.GT31310@phenom.ffwll.local>
 <20180417205744.GA15930@downor-Z87X-UD5H>
 <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <7d6710a76b9a42299139d7914358ed52@AMSPEX02CL03.citrite.net>
 <46489b33-e6fc-b874-6cd4-dbb94c002ef8@gmail.com>
 <20180418105526.a4qtlhofrn3gubsl@MacBook-Pro-de-Roger.local>
 <11ec6f16-6eff-6439-2e66-f1ef14cdff21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11ec6f16-6eff-6439-2e66-f1ef14cdff21@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 03:42:29PM +0300, Oleksandr Andrushchenko wrote:
> On 04/18/2018 01:55 PM, Roger Pau Monné wrote:
> >On Wed, Apr 18, 2018 at 01:39:35PM +0300, Oleksandr Andrushchenko wrote:
> >>On 04/18/2018 01:18 PM, Paul Durrant wrote:
> >>>>-----Original Message-----
> >>>>From: Xen-devel [mailto:xen-devel-bounces@lists.xenproject.org] On Behalf
> >>>>Of Roger Pau Monné
> >>>>Sent: 18 April 2018 11:11
> >>>>To: Oleksandr Andrushchenko <andr2000@gmail.com>
> >>>>Cc: jgross@suse.com; Artem Mygaiev <Artem_Mygaiev@epam.com>;
> >>>>Dongwon Kim <dongwon.kim@intel.com>; airlied@linux.ie;
> >>>>Oleksandr_Andrushchenko@epam.com; linux-kernel@vger.kernel.org; dri-
> >>>>devel@lists.freedesktop.org; Potrola, MateuszX
> >>>><mateuszx.potrola@intel.com>; xen-devel@lists.xenproject.org;
> >>>>daniel.vetter@intel.com; boris.ostrovsky@oracle.com; Matt Roper
> >>>><matthew.d.roper@intel.com>
> >>>>Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy
> >>>>helper DRM driver
> >>>>
> >>>>On Wed, Apr 18, 2018 at 11:01:12AM +0300, Oleksandr Andrushchenko
> >>>>wrote:
> >>>>>On 04/18/2018 10:35 AM, Roger Pau Monné wrote:
> >>>>After speaking with Oleksandr on IRC, I think the main usage of the
> >>>>gntdev extension is to:
> >>>>
> >>>>1. Create a dma-buf from a set of grant references.
> >>>>2. Share dma-buf and get a list of grant references.
> >>>>
> >>>>I think this set of operations could be broken into:
> >>>>
> >>>>1.1 Map grant references into user-space using the gntdev.
> >>>>1.2 Create a dma-buf out of a set of user-space virtual addresses.
> >>>>
> >>>>2.1 Map a dma-buf into user-space.
> >>>>2.2 Get grefs out of the user-space addresses where the dma-buf is
> >>>>      mapped.
> >>>>
> >>>>So it seems like what's actually missing is a way to:
> >>>>
> >>>>   - Create a dma-buf from a list of user-space virtual addresses.
> >>>>   - Allow to map a dma-buf into user-space, so it can then be used with
> >>>>     the gntdev.
> >>>>
> >>>>I think this is generic enough that it could be implemented by a
> >>>>device not tied to Xen. AFAICT the hyper_dma guys also wanted
> >>>>something similar to this.
> >>Ok, so just to summarize, xen-zcopy/hyper-dmabuf as they are now,
> >>are no go from your POV?

FYI,

our use-case is "surface sharing" or "graphic obj sharing" where a client
application in one guest renders and export this render target(e.g. EGL surface)
as dma-buf. This dma-buf is then exported to another guest/host via hyper_dmabuf
drv where a compositor is running. This importing domain creates a dmabuf with
shared reference then it is imported as EGL image that later can be used as
texture object via EGL api. Mapping dmabuf to the userspace or vice versa
might be possible with modifying user space drivers/applications but it is an
unnecessary extra step from our perspective. Also, we want to keep all objects
in the kernel level.

> >My opinion is that there seems to be a more generic way to implement
> >this, and thus I would prefer that one.
> >
> >>Instead, we have to make all that fancy stuff
> >>with VAs <-> device-X and have that device-X driver live out of drivers/xen
> >>as it is not a Xen specific driver?
> >That would be my preference if feasible, simply because it can be
> >reused by other use-cases that need to create dma-bufs in user-space.
> There is a use-case I have: a display unit on my target has a DMA
> controller which can't do scatter-gather, e.g. it only expects a
> single starting address of the buffer.
> In order to create a dma-buf from grefs in this case
> I allocate memory with dma_alloc_xxx and then balloon pages of the
> buffer and finally map grefs onto this DMA buffer.
> This way I can give this shared buffer to the display unit as its bus
> addresses are contiguous.
> 
> With the proposed solution (gntdev + device-X) I won't be able to achieve
> this,
> as I have no control over from where gntdev/balloon drivers get the pages
> (even more, those can easily be out of DMA address space of the display
> unit).
> 
> Thus, even if implemented, I can't use this approach.
> >
> >In any case I just knew about dma-bufs this morning, there might be
> >things that I'm missing.
> >
> >Roger.
> 
