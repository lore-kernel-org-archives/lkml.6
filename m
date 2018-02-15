Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166277AbeBOSU2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:20:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163438AbeBOSUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:20:25 -0500
Date: Thu, 15 Feb 2018 20:20:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau
        <marcandre.lureau@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Subject: Re: [PATCH v14 2/9] fw_cfg: add a public uapi header
Message-ID: <20180215201547-mutt-send-email-mst@kernel.org>
References: <20180214141850.4017-1-marcandre.lureau@redhat.com>
 <20180214141850.4017-3-marcandre.lureau@redhat.com>
 <20180214223631-mutt-send-email-mst@kernel.org>
 <CAMxuvaz20UcZkiBwDUNM7H3vCQ=faRK+vC5b0HJSaEsfvy06oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaz20UcZkiBwDUNM7H3vCQ=faRK+vC5b0HJSaEsfvy06oA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 10:25:27AM +0100, Marc-Andre Lureau wrote:
> Hi
> 
> On Wed, Feb 14, 2018 at 9:41 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, Feb 14, 2018 at 03:18:43PM +0100, Marc-André Lureau wrote:
> >> Create a common header file for well-known values and structures to be
> >> shared by the Linux kernel with qemu or other projects.
> >>
> >> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >>
> >> ---
> >>
> >> The related qemu patch making use of it, to be submitted:
> >> https://github.com/elmarco/qemu/commit/4884fc9e9c4c4467a371e5a40f3181239e1b70f5
> >> ---
> >>  MAINTAINERS                    |   1 +
> >>  drivers/firmware/qemu_fw_cfg.c |  22 +--------
> >>  include/uapi/linux/fw_cfg.h    | 102 +++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 105 insertions(+), 20 deletions(-)
> >>  create mode 100644 include/uapi/linux/fw_cfg.h
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 3bdc260e36b7..a66b65f62811 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -11352,6 +11352,7 @@ M:    "Michael S. Tsirkin" <mst@redhat.com>
> >>  L:   qemu-devel@nongnu.org
> >>  S:   Maintained
> >>  F:   drivers/firmware/qemu_fw_cfg.c
> >> +F:   include/uapi/linux/fw_cfg.h
> >>
> >>  QIB DRIVER
> >>  M:   Dennis Dalessandro <dennis.dalessandro@intel.com>
> >> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> >> index a41b572eeeb1..90f467232777 100644
> >> --- a/drivers/firmware/qemu_fw_cfg.c
> >> +++ b/drivers/firmware/qemu_fw_cfg.c
> >> @@ -32,30 +32,12 @@
> >>  #include <linux/slab.h>
> >>  #include <linux/io.h>
> >>  #include <linux/ioport.h>
> >> +#include <linux/fw_cfg.h>
> >>
> >>  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
> >>  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
> >>  MODULE_LICENSE("GPL");
> >>
> >> -/* selector key values for "well-known" fw_cfg entries */
> >> -#define FW_CFG_SIGNATURE  0x00
> >> -#define FW_CFG_ID         0x01
> >> -#define FW_CFG_FILE_DIR   0x19
> >> -
> >> -/* size in bytes of fw_cfg signature */
> >> -#define FW_CFG_SIG_SIZE 4
> >> -
> >> -/* fw_cfg "file name" is up to 56 characters (including terminating nul) */
> >> -#define FW_CFG_MAX_FILE_PATH 56
> >> -
> >> -/* fw_cfg file directory entry type */
> >> -struct fw_cfg_file {
> >> -     u32 size;
> >> -     u16 select;
> >> -     u16 reserved;
> >> -     char name[FW_CFG_MAX_FILE_PATH];
> >> -};
> >> -
> >>  /* fw_cfg device i/o register addresses */
> >>  static bool fw_cfg_is_mmio;
> >>  static phys_addr_t fw_cfg_p_base;
> >> @@ -597,7 +579,7 @@ MODULE_DEVICE_TABLE(of, fw_cfg_sysfs_mmio_match);
> >>
> >>  #ifdef CONFIG_ACPI
> >>  static const struct acpi_device_id fw_cfg_sysfs_acpi_match[] = {
> >> -     { "QEMU0002", },
> >> +     { FW_CFG_ACPI_DEVICE_ID, },
> >>       {},
> >>  };
> >>  MODULE_DEVICE_TABLE(acpi, fw_cfg_sysfs_acpi_match);
> >> diff --git a/include/uapi/linux/fw_cfg.h b/include/uapi/linux/fw_cfg.h
> >> new file mode 100644
> >> index 000000000000..5b8136ce46ee
> >> --- /dev/null
> >> +++ b/include/uapi/linux/fw_cfg.h
> >> @@ -0,0 +1,102 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >> +#ifndef _LINUX_FW_CFG_H
> >> +#define _LINUX_FW_CFG_H
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +#define FW_CFG_ACPI_DEVICE_ID        "QEMU0002"
> >> +
> >> +/* selector key values for "well-known" fw_cfg entries */
> >> +#define FW_CFG_SIGNATURE     0x00
> >> +#define FW_CFG_ID            0x01
> >> +#define FW_CFG_UUID          0x02
> >> +#define FW_CFG_RAM_SIZE              0x03
> >> +#define FW_CFG_NOGRAPHIC     0x04
> >> +#define FW_CFG_NB_CPUS               0x05
> >> +#define FW_CFG_MACHINE_ID    0x06
> >> +#define FW_CFG_KERNEL_ADDR   0x07
> >> +#define FW_CFG_KERNEL_SIZE   0x08
> >> +#define FW_CFG_KERNEL_CMDLINE        0x09
> >> +#define FW_CFG_INITRD_ADDR   0x0a
> >> +#define FW_CFG_INITRD_SIZE   0x0b
> >> +#define FW_CFG_BOOT_DEVICE   0x0c
> >> +#define FW_CFG_NUMA          0x0d
> >> +#define FW_CFG_BOOT_MENU     0x0e
> >> +#define FW_CFG_MAX_CPUS              0x0f
> >> +#define FW_CFG_KERNEL_ENTRY  0x10
> >> +#define FW_CFG_KERNEL_DATA   0x11
> >> +#define FW_CFG_INITRD_DATA   0x12
> >> +#define FW_CFG_CMDLINE_ADDR  0x13
> >> +#define FW_CFG_CMDLINE_SIZE  0x14
> >> +#define FW_CFG_CMDLINE_DATA  0x15
> >> +#define FW_CFG_SETUP_ADDR    0x16
> >> +#define FW_CFG_SETUP_SIZE    0x17
> >> +#define FW_CFG_SETUP_DATA    0x18
> >> +#define FW_CFG_FILE_DIR              0x19
> >> +
> >> +#define FW_CFG_FILE_FIRST    0x20
> >> +#define FW_CFG_FILE_SLOTS_MIN        0x10
> >> +
> >> +#define FW_CFG_WRITE_CHANNEL 0x4000
> >> +#define FW_CFG_ARCH_LOCAL    0x8000
> >> +#define FW_CFG_ENTRY_MASK    (~(FW_CFG_WRITE_CHANNEL | FW_CFG_ARCH_LOCAL))
> >> +
> >> +#define FW_CFG_INVALID               0xffff
> >> +
> >> +/* width in bytes of fw_cfg control register */
> >> +#define FW_CFG_CTL_SIZE              0x02
> >> +
> >> +/* fw_cfg "file name" is up to 56 characters (including terminating nul) */
> >> +#define FW_CFG_MAX_FILE_PATH 56
> >> +
> >> +/* size in bytes of fw_cfg signature */
> >> +#define FW_CFG_SIG_SIZE 4
> >> +
> >> +/* FW_CFG_ID bits */
> >> +#define FW_CFG_VERSION               0x01
> >> +#define FW_CFG_VERSION_DMA   0x02
> >> +
> >> +/* fw_cfg file directory entry type */
> >> +struct fw_cfg_file {
> >> +     __be32 size;                    /* file size */
> >> +     __be16 select;                  /* write this to 0x510 to read it */
> >> +     __u16 reserved;
> >> +     char name[FW_CFG_MAX_FILE_PATH];
> >> +};
> >> +
> >> +struct fw_cfg_files {
> >> +     __be32 count; /* number of entries */
> >> +     struct fw_cfg_file f[];
> >> +};
> >
> > This struct wasn't there in the original file.
> > Is the source of these structures QEMU or Linux?
> > If Linux, then pls split this
> > 1. move code out to a header
> > 2. add more structs
> 
> It is based from Linux source + qemu docs/specs/fw_cfg.txt which
> references include/hw/nvram/fw_cfg_keys.h "for the most up-to-date and
> authoritative list" & vmcoreinfo.txt.
> 
> QEMU ./include/hw/nvram/fw_cfg_keys.h doesn't have specific licence
> text, and QEMU as a whole is released under the GNU General Public
> License, version 2.

Yes but it was split off from ./include/hw/nvram/fw_cfg.h
so it's a mistake that license was not copied.

But I think that for headers BSD is preferrable,
and this is exactly the license in QEMU.

> Let me know if I still need to change the license and what you
> recommend instead.


vmcoreinfo as I said should be a separate patch.

> >
> >> +
> >> +/* FW_CFG_DMA_CONTROL bits */
> >> +#define FW_CFG_DMA_CTL_ERROR 0x01
> >> +#define FW_CFG_DMA_CTL_READ  0x02
> >> +#define FW_CFG_DMA_CTL_SKIP  0x04
> >> +#define FW_CFG_DMA_CTL_SELECT        0x08
> >> +#define FW_CFG_DMA_CTL_WRITE 0x10
> >> +
> >> +#define FW_CFG_DMA_SIGNATURE    0x51454d5520434647ULL /* "QEMU CFG" */
> >> +
> >> +/* Control as first field allows for different structures selected by this
> >> + * field, which might be useful in the future
> >> + */
> >> +struct fw_cfg_dma_access {
> >> +     __be32 control;
> >> +     __be32 length;
> >> +     __be64 address;
> >> +};
> >
> > Maybe this should be part of the dma patch.
> 
> I prefer to introduce all the spec defines in one patch, but I can
> split it if it helps.


Probably - this way it's a harmless refactor.

> >
> >> +
> >> +#define FW_CFG_VMCOREINFO_FILENAME "etc/vmcoreinfo"
> >> +
> >> +#define FW_CFG_VMCOREINFO_FORMAT_NONE 0x0
> >> +#define FW_CFG_VMCOREINFO_FORMAT_ELF 0x1
> >> +
> >> +struct fw_cfg_vmcoreinfo {
> >> +     __le16 host_format;
> >> +     __le16 guest_format;
> >> +     __le32 size;
> >> +     __le64 paddr;
> >> +};
> >
> > Maybe this should be part of the vmcore patch.
> 
> same
> 
> 
> Thanks
