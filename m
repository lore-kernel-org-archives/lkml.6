Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeDXUgB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:36:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:7095 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbeDXUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:35:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="49619626"
Date: Tue, 24 Apr 2018 13:35:14 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Wei Liu <wei.liu2@citrix.com>, jgross@suse.com,
        Artem Mygaiev <Artem_Mygaiev@epam.com>, konrad.wilk@oracle.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
Message-ID: <20180424203514.GA26787@downor-Z87X-UD5H>
References: <41487acb-a67a-8933-d0c3-702c19b0938e@gmail.com>
 <20180418073508.ptvntwedczpvl7bx@MacBook-Pro-de-Roger.local>
 <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <20180420071914.GG31310@phenom.ffwll.local>
 <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
 <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
 <20180424115437.GT31310@phenom.ffwll.local>
 <18ab5f76-00b0-42a0-fcb8-e0cbf4cdd527@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ab5f76-00b0-42a0-fcb8-e0cbf4cdd527@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Had a meeting with Daniel and talked about bringing out generic
part of hyper-dmabuf to the userspace, which means we most likely
reuse IOCTLs defined in xen-zcopy for our use-case if we follow
his suggestion.

So assuming we use these IOCTLs as they are,
Several things I would like you to double-check..

1. returning gref as is to the user space is still unsafe because
it is a constant, easy to guess and any process that hijacks it can easily
exploit the buffer. So I am wondering if it's possible to keep dmabuf-to
-gref or gref-to-dmabuf in kernel space and add other layers on top
of those in actual IOCTLs to add some safety.. We introduced flink like
hyper_dmabuf_id including random number but many says even that is still
not safe.

2. maybe we could take hypervisor-independent process (e.g. SGT<->page)
out of xen-zcopy and put those in a new helper library. 

3. please consider the case where original DMA-BUF's first offset
and last length are not 0 and PAGE_SIZE respectively. I assume current
xen-zcopy only supports page-aligned buffer with PAGE_SIZE x n big.

thanks,
DW

On Tue, Apr 24, 2018 at 02:59:39PM +0300, Oleksandr Andrushchenko wrote:
> On 04/24/2018 02:54 PM, Daniel Vetter wrote:
> >On Mon, Apr 23, 2018 at 03:10:35PM +0300, Oleksandr Andrushchenko wrote:
> >>On 04/23/2018 02:52 PM, Wei Liu wrote:
> >>>On Fri, Apr 20, 2018 at 02:25:20PM +0300, Oleksandr Andrushchenko wrote:
> >>>>>>      the gntdev.
> >>>>>>
> >>>>>>I think this is generic enough that it could be implemented by a
> >>>>>>device not tied to Xen. AFAICT the hyper_dma guys also wanted
> >>>>>>something similar to this.
> >>>>>You can't just wrap random userspace memory into a dma-buf. We've just had
> >>>>>this discussion with kvm/qemu folks, who proposed just that, and after a
> >>>>>bit of discussion they'll now try to have a driver which just wraps a
> >>>>>memfd into a dma-buf.
> >>>>So, we have to decide either we introduce a new driver
> >>>>(say, under drivers/xen/xen-dma-buf) or extend the existing
> >>>>gntdev/balloon to support dma-buf use-cases.
> >>>>
> >>>>Can anybody from Xen community express their preference here?
> >>>>
> >>>Oleksandr talked to me on IRC about this, he said a few IOCTLs need to
> >>>be added to either existing drivers or a new driver.
> >>>
> >>>I went through this thread twice and skimmed through the relevant
> >>>documents, but I couldn't see any obvious pros and cons for either
> >>>approach. So I don't really have an opinion on this.
> >>>
> >>>But, assuming if implemented in existing drivers, those IOCTLs need to
> >>>be added to different drivers, which means userspace program needs to
> >>>write more code and get more handles, it would be slightly better to
> >>>implement a new driver from that perspective.
> >>If gntdev/balloon extension is still considered:
> >>
> >>All the IOCTLs will be in gntdev driver (in current xen-zcopy terminology):
> I was lazy to change dumb to dma-buf, so put this notice ;)
> >>  - DRM_ICOTL_XEN_ZCOPY_DUMB_FROM_REFS
> >>  - DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
> >>  - DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE
> >s/DUMB/DMA_BUF/ please. This is generic dma-buf, it has nothing to do with
> >the dumb scanout buffer support in the drm/gfx subsystem. This here can be
> >used for any zcopy sharing among guests (as long as your endpoints
> >understands dma-buf, which most relevant drivers do).
> Of course, please see above
> >-Daniel
> >
> >>Balloon driver extension, which is needed for contiguous/DMA
> >>buffers, will be to provide new *kernel API*, no UAPI is needed.
> >>
> >>>Wei.
> >>Thank you,
> >>Oleksandr
> >>_______________________________________________
> >>dri-devel mailing list
> >>dri-devel@lists.freedesktop.org
> >>https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
