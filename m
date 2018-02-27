Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeB0Mkv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:40:51 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36221 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbeB0Mkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:40:47 -0500
X-Google-Smtp-Source: AH8x224ilZZ0Ql0NJBatnf/6Ri/lzk8oaxPckkFw3hxqmid4UAjegGpM4OG3dYEax5UqDr24oaE04g==
Subject: Re: [PATCH 0/9] drm/xen-front: Add support for Xen PV display
 frontend
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <4c7e6f65-1787-3815-22b5-f9495e388c06@gmail.com>
Message-ID: <7e265c53-db9a-0946-6b1c-b946bcbb4100@gmail.com>
Date: Tue, 27 Feb 2018 14:40:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4c7e6f65-1787-3815-22b5-f9495e388c06@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please find some more clarifications on VirtIO use with Xen
(I would like to thank Xen community for helping with this)

1. Possible security issues - VirtIO devices are PCI bus masters, thus
allowing real device (running, for example, in untrusted driver domain)
to get control over guest's memory by writing to its memory

2. VirtIO currently uses GFNs written into the shared ring, without Xen
grants support. This will require generic grant-mapping/sharing layer
to be added to VirtIO.

3. VirtIO requires QEMU PCI emulation for setting up a device. Xen PV 
(and PVH)
domains don't use QEMU for platform emulation in order to reduce attack 
surface.
(PVH is in the process of gaining PCI config space emulation though, but 
it is
optional, not a requirement)

4. Most of the PV drivers a guest uses at the moment are Xen PV drivers, 
e.g. net,
block, console, so only virtio-gpu will require QEMU to run.
Although this use case would work on x86 it will require additional changes
to get this running on ARM, which is my target platform.

Thank you,
Oleksandr

On 02/26/2018 10:21 AM, Oleksandr Andrushchenko wrote:
> **
>
> *Hi, all!*
>
> *
>
> Last *Friday* some concerns on #dri-devel were raised wrt "yet
>
> another driver" for Xen and why not virtio-gpu. Let me highlight
>
> on why we need a new paravirtualized driver for Xen and why we
>
> can't just use virtio. Hope this helps the communities (both Xen
>
> and DRI) to have better understanding of this work and our motivation.
>
>
> Disclaimer: some or all of the below may sound weak argument or
>
> not 100% correct, so any help on clarifying the below is more
>
> than welcome ;)
>
>
> 1. First of all, we are targeting ARM embedded use-cases and for
>
> ARM we do not use QEMU [1]: "...Xen on ARM is not just a straight
>
> 1:1 port of x86 Xen... Xen on ARM does not need QEMU because it does
>
> not do any emulation. It accomplishes the goal by exploiting
>
> virtualization support in hardware as much as possible and using
>
> paravirtualized interfaces for IO."
>
>
> That being said it is still possible to run virtio-gpu and Xen+QEMU: [2]
>
>
> In this case QEMU can be used for device virtualization, e.g. network,
>
> block, console. But these already exist as Xen para-virtualized drivers
>
> again eliminating the need for QEMU: typical ARM system runs 
> para-virtualized
>
> drivers for network, block, console etc.
>
>
> 2. virtio-gpu requires PCI/MMIO emulation
>
> virtio-gpu (virtio-gpu-pci) require virtio-pci, but para-virtualized 
> device
>
> drivers do not need this.
>
>
> 3. No need for 3d/virgl.
>
> There are use-cases which either do not use OpenGL at all or will use
>
> custom virtualization solutions allowing sharing of a real GPU with 
> guest,
>
> e.g. vGPU approach.
>
>
> 4. More freedom for buffer allocation.
>
> As of now virtio-gpu is only capable of allocating buffers via TTM, while
>
> there are use-cases where we need to have more freedom:
>
> for systems which do not provide IOMMU support, but having specific
>
> requirements for display buffers, it is possible to allocate such buffers
>
> at backend side and share those with the frontend driver.
>
> For example, if host domain is 1:1 mapped and has DRM/GPU hardware 
> expecting
>
> physically contiguous memory (in PA, not IPA), this allows implementing
>
> zero-copying use-cases.
>
>
> 5. Zero-copying support at backend side
>
> Having native Xen implementation allows implementing zero-copying 
> use-cases
>
> on backend side with the help of supporting driver DRM driver [3] 
> which we
>
> hope to upstream as well (it is not yet ready in terms of code cleanup).
>
>
> 6. QEMU backends for virtio-gpu cannot be used as is, e.g. guest displays
>
> could be just a part of the final user experience. Thus, a QEMU backend
>
> must be modified to interact, for example, with Automotive Grade Linux
>
> display manager. So, QEMU part needs modifications.
>
> In our use-case we have a backend which supports multi-touch and guest
>
> display(s) and running either as a weston client (which is not supported
>
> by QEMU at the moment?) or KMS/DRM client. This allows us to enable much
>
> more use-cases**without the need to run QEMU.
>
> *
>
> *Thank you,*
>
> **Oleksandr Andrushchenko*
> *
>
> *
> *
>
> *[1] 
> https://wiki.xen.org/wiki/Xen_ARM_with_Virtualization_Extensions_whitepaper*
>
> *
>
> [2] https://elinux.org/R-Car/Virtualization
>
> [3] 
> https://github.com/xen-troops/linux/blob/ces2018/drivers/gpu/drm/xen/xen_drm_zcopy_drv.c
>
>
> *
>
>
> On 02/21/2018 10:03 AM, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Hello!
>>
>> This patch series adds support for Xen [1] para-virtualized
>> frontend display driver. It implements the protocol from
>> include/xen/interface/io/displif.h [2].
>> Accompanying backend [3] is implemented as a user-space application
>> and its helper library [4], capable of running as a Weston client
>> or DRM master.
>> Configuration of both backend and frontend is done via
>> Xen guest domain configuration options [5].
>>
>> ******************************************************************************* 
>>
>> * Driver limitations
>> ******************************************************************************* 
>>
>>   1. Configuration options 1.1 (contiguous display buffers) and 2 
>> (backend
>>      allocated buffers) below are not supported at the same time.
>>
>>   2. Only primary plane without additional properties is supported.
>>
>>   3. Only one video mode supported which resolution is configured via 
>> XenStore.
>>
>>   4. All CRTCs operate at fixed frequency of 60Hz.
>>
>> ******************************************************************************* 
>>
>> * Driver modes of operation in terms of display buffers used
>> ******************************************************************************* 
>>
>>   Depending on the requirements for the para-virtualized environment, 
>> namely
>>   requirements dictated by the accompanying DRM/(v)GPU drivers 
>> running in both
>>   host and guest environments, number of operating modes of 
>> para-virtualized
>>   display driver are supported:
>>    - display buffers can be allocated by either frontend driver or 
>> backend
>>    - display buffers can be allocated to be contiguous in memory or not
>>
>>   Note! Frontend driver itself has no dependency on contiguous memory 
>> for
>>         its operation.
>>
>> ******************************************************************************* 
>>
>> * 1. Buffers allocated by the frontend driver.
>> ******************************************************************************* 
>>
>>
>>   The below modes of operation are configured at compile-time via
>>   frontend driver's kernel configuration.
>>
>>   1.1. Front driver configured to use GEM CMA helpers
>>        This use-case is useful when used with accompanying DRM/vGPU 
>> driver in
>>        guest domain which was designed to only work with contiguous 
>> buffers,
>>        e.g. DRM driver based on GEM CMA helpers: such drivers can 
>> only import
>>        contiguous PRIME buffers, thus requiring frontend driver to 
>> provide
>>        such. In order to implement this mode of operation 
>> para-virtualized
>>        frontend driver can be configured to use GEM CMA helpers.
>>
>>   1.2. Front driver doesn't use GEM CMA
>>        If accompanying drivers can cope with non-contiguous memory 
>> then, to
>>        lower pressure on CMA subsystem of the kernel, driver can 
>> allocate
>>        buffers from system memory.
>>
>>   Note! If used with accompanying DRM/(v)GPU drivers this mode of 
>> operation
>>     may require IOMMU support on the platform, so accompanying DRM/vGPU
>>     hardware can still reach display buffer memory while importing PRIME
>>     buffers from the frontend driver.
>>
>> ******************************************************************************* 
>>
>> * 2. Buffers allocated by the backend
>> ******************************************************************************* 
>>
>>
>>   This mode of operation is run-time configured via guest domain 
>> configuration
>>   through XenStore entries.
>>
>>   For systems which do not provide IOMMU support, but having specific
>>   requirements for display buffers it is possible to allocate such 
>> buffers
>>   at backend side and share those with the frontend.
>>   For example, if host domain is 1:1 mapped and has DRM/GPU hardware 
>> expecting
>>   physically contiguous memory, this allows implementing zero-copying
>>   use-cases.
>>
>>
>> I would like to thank at least, but not at last the following
>> people/communities who helped this driver to happen ;)
>>
>> 1. My team at EPAM for continuous support
>> 2. Xen community for answering tons of questions on different
>> modes of operation of the driver with respect to virtualized
>> environment.
>> 3. Rob Clark for "GEM allocation for para-virtualized DRM driver" [6]
>> 4. Maarten Lankhorst for "Atomic driver and old remove FB behavior" [7]
>> 5. Ville Syrjälä for "Questions on page flips and atomic modeset" [8]
>>
>> Thank you,
>> Oleksandr Andrushchenko
>>
>> P.S. There are two dependencies for this driver limiting some of the
>> use-cases which are on review now:
>> 1. "drm/simple_kms_helper: Add {enable|disable}_vblank callback 
>> support" [9]
>> 2. "drm/simple_kms_helper: Fix NULL pointer dereference with no 
>> active CRTC" [10]
>>
>> [1] https://wiki.xen.org/wiki/Paravirtualization_(PV)#PV_IO_Drivers
>> [2] 
>> https://elixir.bootlin.com/linux/v4.16-rc2/source/include/xen/interface/io/displif.h
>> [3] https://github.com/xen-troops/displ_be
>> [4] https://github.com/xen-troops/libxenbe
>> [5] 
>> https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=docs/man/xl.cfg.pod.5.in;h=a699367779e2ae1212ff8f638eff0206ec1a1cc9;hb=refs/heads/master#l1257
>> [6] 
>> https://lists.freedesktop.org/archives/dri-devel/2017-March/136038.html
>> [7] https://www.spinics.net/lists/dri-devel/msg164102.html
>> [8] https://www.spinics.net/lists/dri-devel/msg164463.html
>> [9] https://patchwork.freedesktop.org/series/38073/
>> [10] https://patchwork.freedesktop.org/series/38139/
>>
>> Oleksandr Andrushchenko (9):
>>    drm/xen-front: Introduce Xen para-virtualized frontend driver
>>    drm/xen-front: Implement Xen bus state handling
>>    drm/xen-front: Read driver configuration from Xen store
>>    drm/xen-front: Implement Xen event channel handling
>>    drm/xen-front: Implement handling of shared display buffers
>>    drm/xen-front: Introduce DRM/KMS virtual display driver
>>    drm/xen-front: Implement KMS/connector handling
>>    drm/xen-front: Implement GEM operations
>>    drm/xen-front: Implement communication with backend
>>
>>   drivers/gpu/drm/Kconfig                     |   2 +
>>   drivers/gpu/drm/Makefile                    |   1 +
>>   drivers/gpu/drm/xen/Kconfig                 |  30 ++
>>   drivers/gpu/drm/xen/Makefile                |  17 +
>>   drivers/gpu/drm/xen/xen_drm_front.c         | 712 
>> ++++++++++++++++++++++++++++
>>   drivers/gpu/drm/xen/xen_drm_front.h         | 154 ++++++
>>   drivers/gpu/drm/xen/xen_drm_front_cfg.c     |  84 ++++
>>   drivers/gpu/drm/xen/xen_drm_front_cfg.h     |  45 ++
>>   drivers/gpu/drm/xen/xen_drm_front_conn.c    | 125 +++++
>>   drivers/gpu/drm/xen/xen_drm_front_conn.h    |  35 ++
>>   drivers/gpu/drm/xen/xen_drm_front_drv.c     | 294 ++++++++++++
>>   drivers/gpu/drm/xen/xen_drm_front_drv.h     |  73 +++
>>   drivers/gpu/drm/xen/xen_drm_front_evtchnl.c | 399 ++++++++++++++++
>>   drivers/gpu/drm/xen/xen_drm_front_evtchnl.h |  89 ++++
>>   drivers/gpu/drm/xen/xen_drm_front_gem.c     | 360 ++++++++++++++
>>   drivers/gpu/drm/xen/xen_drm_front_gem.h     |  46 ++
>>   drivers/gpu/drm/xen/xen_drm_front_gem_cma.c |  93 ++++
>>   drivers/gpu/drm/xen/xen_drm_front_kms.c     | 299 ++++++++++++
>>   drivers/gpu/drm/xen/xen_drm_front_kms.h     |  30 ++
>>   drivers/gpu/drm/xen/xen_drm_front_shbuf.c   | 430 +++++++++++++++++
>>   drivers/gpu/drm/xen/xen_drm_front_shbuf.h   |  80 ++++
>>   21 files changed, 3398 insertions(+)
>>   create mode 100644 drivers/gpu/drm/xen/Kconfig
>>   create mode 100644 drivers/gpu/drm/xen/Makefile
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front.h
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_cfg.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_cfg.h
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_conn.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_conn.h
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_drv.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_drv.h
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_evtchnl.h
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem.h
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_gem_cma.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_kms.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_kms.h
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front_shbuf.h
>>
>
