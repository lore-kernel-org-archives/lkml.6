Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeBSRBf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:01:35 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52197 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753108AbeBSRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:01:33 -0500
X-Google-Smtp-Source: AH8x226ADKF6SvRIRVPbZKUkk7zhlYCtWQR/+RB5BT/y5iXOf2NBVU6//FvAJLTenqLYIKEOcSZcjQ==
Date: Mon, 19 Feb 2018 18:01:29 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        mateuszx.potrola@intel.com
Subject: Re: [RFC PATCH v2 0/9] hyper_dmabuf: Hyper_DMABUF driver
Message-ID: <20180219170129.GC22199@phenom.ffwll.local>
Mail-Followup-To: Dongwon Kim <dongwon.kim@intel.com>,
        linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        mateuszx.potrola@intel.com
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 05:49:59PM -0800, Dongwon Kim wrote:
> This patch series contains the implementation of a new device driver,
> hyper_DMABUF driver, which provides a way to expand the boundary of
> Linux DMA-BUF sharing to across different VM instances in Multi-OS platform
> enabled by a Hypervisor (e.g. XEN)
> 
> This version 2 series is basically refactored version of old series starting
> with "[RFC PATCH 01/60] hyper_dmabuf: initial working version of hyper_dmabuf
> drv"
> 
> Implementation details of this driver are described in the reference guide
> added by the second patch, "[RFC PATCH v2 2/5] hyper_dmabuf: architecture
> specification and reference guide".
> 
> Attaching 'Overview' section here as a quick summary.
> 
> ------------------------------------------------------------------------------
> Section 1. Overview
> ------------------------------------------------------------------------------
> 
> Hyper_DMABUF driver is a Linux device driver running on multiple Virtual
> achines (VMs), which expands DMA-BUF sharing capability to the VM environment
> where multiple different OS instances need to share same physical data without
> data-copy across VMs.
> 
> To share a DMA_BUF across VMs, an instance of the Hyper_DMABUF drv on the
> exporting VM (so called, “exporter”) imports a local DMA_BUF from the original
> producer of the buffer, then re-exports it with an unique ID, hyper_dmabuf_id
> for the buffer to the importing VM (so called, “importer”).
> 
> Another instance of the Hyper_DMABUF driver on importer registers
> a hyper_dmabuf_id together with reference information for the shared physical
> pages associated with the DMA_BUF to its database when the export happens.
> 
> The actual mapping of the DMA_BUF on the importer’s side is done by
> the Hyper_DMABUF driver when user space issues the IOCTL command to access
> the shared DMA_BUF. The Hyper_DMABUF driver works as both an importing and
> exporting driver as is, that is, no special configuration is required.
> Consequently, only a single module per VM is needed to enable cross-VM DMA_BUF
> exchange.
> 
> ------------------------------------------------------------------------------
> 
> There is a git repository at github.com where this series of patches are all
> integrated in Linux kernel tree based on the commit:
> 
>         commit ae64f9bd1d3621b5e60d7363bc20afb46aede215
>         Author: Linus Torvalds <torvalds@xxxxxxxxxxxxxxxxxxxx>
>         Date:   Sun Dec 3 11:01:47 2018 -0500
> 
>             Linux 4.15-rc2
> 
> https://github.com/downor/linux_hyper_dmabuf.git hyper_dmabuf_integration_v4

Since you place this under drivers/dma-buf I'm assuming you want to
maintain this as part of the core dma-buf support, and not as some
Xen-specific thing. Given that, usual graphics folks rules apply:

Where's the userspace for this (must be open source)? What exactly is the
use-case you're trying to solve by sharing dma-bufs in this fashion?

Iirc my feedback on v1 was why exactly you really need to be able to
import a normal dma-buf into a hyper-dmabuf, instead of allocating them
directly in the hyper-dmabuf driver. Which would _massively_ simplify your
design, since you don't need to marshall all the attach and map business
around (since the hypervisor would be in control of the dma-buf, not a
guest OS). Also, all this marshalling leaves me with the impression that
the guest that exports the dma-buf could take down the importer. That
kinda nukes all the separation guarantees that vms provide.

Or you just stuff this somewhere deeply hidden within Xen where gpu folks
can't find it :-)
-Daniel

> 
> Dongwon Kim, Mateusz Polrola (9):
>   hyper_dmabuf: initial upload of hyper_dmabuf drv core framework
>   hyper_dmabuf: architecture specification and reference guide
>   MAINTAINERS: adding Hyper_DMABUF driver section in MAINTAINERS
>   hyper_dmabuf: user private data attached to hyper_DMABUF
>   hyper_dmabuf: hyper_DMABUF synchronization across VM
>   hyper_dmabuf: query ioctl for retreiving various hyper_DMABUF info
>   hyper_dmabuf: event-polling mechanism for detecting a new hyper_DMABUF
>   hyper_dmabuf: threaded interrupt in Xen-backend
>   hyper_dmabuf: default backend for XEN hypervisor
> 
>  Documentation/hyper-dmabuf-sharing.txt             | 734 ++++++++++++++++
>  MAINTAINERS                                        |  11 +
>  drivers/dma-buf/Kconfig                            |   2 +
>  drivers/dma-buf/Makefile                           |   1 +
>  drivers/dma-buf/hyper_dmabuf/Kconfig               |  50 ++
>  drivers/dma-buf/hyper_dmabuf/Makefile              |  44 +
>  .../backends/xen/hyper_dmabuf_xen_comm.c           | 944 +++++++++++++++++++++
>  .../backends/xen/hyper_dmabuf_xen_comm.h           |  78 ++
>  .../backends/xen/hyper_dmabuf_xen_comm_list.c      | 158 ++++
>  .../backends/xen/hyper_dmabuf_xen_comm_list.h      |  67 ++
>  .../backends/xen/hyper_dmabuf_xen_drv.c            |  46 +
>  .../backends/xen/hyper_dmabuf_xen_drv.h            |  53 ++
>  .../backends/xen/hyper_dmabuf_xen_shm.c            | 525 ++++++++++++
>  .../backends/xen/hyper_dmabuf_xen_shm.h            |  46 +
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c    | 410 +++++++++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h    | 122 +++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.c  | 122 +++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.h  |  38 +
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.c     | 135 +++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h     |  53 ++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c  | 794 +++++++++++++++++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.h  |  52 ++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c   | 295 +++++++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.h   |  73 ++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c    | 416 +++++++++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h    |  89 ++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c    | 415 +++++++++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.h    |  34 +
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.c  | 174 ++++
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.h  |  36 +
>  .../hyper_dmabuf/hyper_dmabuf_remote_sync.c        | 324 +++++++
>  .../hyper_dmabuf/hyper_dmabuf_remote_sync.h        |  32 +
>  .../dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c   | 257 ++++++
>  .../dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.h   |  43 +
>  drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h | 143 ++++
>  include/uapi/linux/hyper_dmabuf.h                  | 134 +++
>  36 files changed, 6950 insertions(+)
>  create mode 100644 Documentation/hyper-dmabuf-sharing.txt
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/Kconfig
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/Makefile
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.h
>  create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h
>  create mode 100644 include/uapi/linux/hyper_dmabuf.h
> 
> -- 
> 2.16.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
