Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032466AbeBOBgv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 20:36:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:16655 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032245AbeBOBgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 20:36:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,515,1511856000";
   d="scan'208";a="17745827"
Date: Wed, 14 Feb 2018 17:34:52 -0800
From: Dongwon Kim <dongwon.kim@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>
Subject: Re: [RFC PATCH 01/60] hyper_dmabuf: initial working version of
 hyper_dmabuf drv
Message-ID: <20180215013452.GB8672@downor-Z87X-UD5H>
References: <1513711816-2618-1-git-send-email-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1513711816-2618-1-git-send-email-dongwon.kim@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abandoning this series as a new version was submitted for the review

"[RFC PATCH v2 0/9] hyper_dmabuf: Hyper_DMABUF driver"

On Tue, Dec 19, 2017 at 11:29:17AM -0800, Kim, Dongwon wrote:
> Upload of intial version of hyper_DMABUF driver enabling
> DMA_BUF exchange between two different VMs in virtualized
> platform based on hypervisor such as KVM or XEN.
> 
> Hyper_DMABUF drv's primary role is to import a DMA_BUF
> from originator then re-export it to another Linux VM
> so that it can be mapped and accessed by it.
> 
> The functionality of this driver highly depends on
> Hypervisor's native page sharing mechanism and inter-VM
> communication support.
> 
> This driver has two layers, one is main hyper_DMABUF
> framework for scatter-gather list management that handles
> actual import and export of DMA_BUF. Lower layer is about
> actual memory sharing and communication between two VMs,
> which is hypervisor-specific interface.
> 
> This driver is initially designed to enable DMA_BUF
> sharing across VMs in Xen environment, so currently working
> with Xen only.
> 
> This also adds Kernel configuration for hyper_DMABUF drv
> under Device Drivers->Xen driver support->hyper_dmabuf
> options.
> 
> To give some brief information about each source file,
> 
> hyper_dmabuf/hyper_dmabuf_conf.h
> : configuration info
> 
> hyper_dmabuf/hyper_dmabuf_drv.c
> : driver interface and initialization
> 
> hyper_dmabuf/hyper_dmabuf_imp.c
> : scatter-gather list generation and management. DMA_BUF
> ops for DMA_BUF reconstructed from hyper_DMABUF
> 
> hyper_dmabuf/hyper_dmabuf_ioctl.c
> : IOCTLs calls for export/import and comm channel creation
> unexport.
> 
> hyper_dmabuf/hyper_dmabuf_list.c
> : Database (linked-list) for exported and imported
> hyper_DMABUF
> 
> hyper_dmabuf/hyper_dmabuf_msg.c
> : creation and management of messages between exporter and
> importer
> 
> hyper_dmabuf/xen/hyper_dmabuf_xen_comm.c
> : comm ch management and ISRs for incoming messages.
> 
> hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.c
> : Database (linked-list) for keeping information about
> existing comm channels among VMs
> 
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Mateusz Polrola <mateuszx.potrola@intel.com>
> ---
>  drivers/xen/Kconfig                                |   2 +
>  drivers/xen/Makefile                               |   1 +
>  drivers/xen/hyper_dmabuf/Kconfig                   |  14 +
>  drivers/xen/hyper_dmabuf/Makefile                  |  34 +
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_conf.h       |   2 +
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.c        |  54 ++
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.h        | 101 +++
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.c        | 852 +++++++++++++++++++++
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.h        |  31 +
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_ioctl.c      | 462 +++++++++++
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_list.c       | 119 +++
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_list.h       |  40 +
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.c        | 212 +++++
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.h        |  45 ++
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_query.h      |  16 +
>  drivers/xen/hyper_dmabuf/hyper_dmabuf_struct.h     |  70 ++
>  .../xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.c   | 328 ++++++++
>  .../xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.h   |  62 ++
>  .../hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.c  | 106 +++
>  .../hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.h  |  35 +
>  20 files changed, 2586 insertions(+)
>  create mode 100644 drivers/xen/hyper_dmabuf/Kconfig
>  create mode 100644 drivers/xen/hyper_dmabuf/Makefile
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_conf.h
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.c
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.h
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.c
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.h
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_ioctl.c
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_list.c
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_list.h
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.c
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.h
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_query.h
>  create mode 100644 drivers/xen/hyper_dmabuf/hyper_dmabuf_struct.h
>  create mode 100644 drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.c
>  create mode 100644 drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.h
>  create mode 100644 drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.c
>  create mode 100644 drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.h
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index d8dd546..b59b0e3 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -321,4 +321,6 @@ config XEN_SYMS
>  config XEN_HAVE_VPMU
>         bool
>  
> +source "drivers/xen/hyper_dmabuf/Kconfig"
> +
>  endmenu
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 451e833..a6e253a 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_X86)			+= fallback.o
>  obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
>  obj-y	+= events/
>  obj-y	+= xenbus/
> +obj-y	+= hyper_dmabuf/
>  
>  nostackp := $(call cc-option, -fno-stack-protector)
>  CFLAGS_features.o			:= $(nostackp)
> diff --git a/drivers/xen/hyper_dmabuf/Kconfig b/drivers/xen/hyper_dmabuf/Kconfig
> new file mode 100644
> index 0000000..75e1f96
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/Kconfig
> @@ -0,0 +1,14 @@
> +menu "hyper_dmabuf options"
> +
> +config HYPER_DMABUF
> +	tristate "Enables hyper dmabuf driver"
> +	default y
> +
> +config HYPER_DMABUF_XEN
> +	bool "Configure hyper_dmabuf for XEN hypervisor"
> +	default y
> +	depends on HYPER_DMABUF
> +	help
> +	  Configuring hyper_dmabuf driver for XEN hypervisor
> +
> +endmenu
> diff --git a/drivers/xen/hyper_dmabuf/Makefile b/drivers/xen/hyper_dmabuf/Makefile
> new file mode 100644
> index 0000000..0be7445
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/Makefile
> @@ -0,0 +1,34 @@
> +TARGET_MODULE:=hyper_dmabuf
> +
> +# If we running by kernel building system
> +ifneq ($(KERNELRELEASE),)
> +	$(TARGET_MODULE)-objs := hyper_dmabuf_drv.o \
> +                                 hyper_dmabuf_ioctl.o \
> +                                 hyper_dmabuf_list.o \
> +				 hyper_dmabuf_imp.o \
> +				 hyper_dmabuf_msg.o \
> +				 xen/hyper_dmabuf_xen_comm.o \
> +				 xen/hyper_dmabuf_xen_comm_list.o
> +
> +obj-$(CONFIG_HYPER_DMABUF) := $(TARGET_MODULE).o
> +
> +# If we are running without kernel build system
> +else
> +BUILDSYSTEM_DIR?=../../../
> +PWD:=$(shell pwd)
> +
> +all :
> +# run kernel build system to make module
> +$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) modules
> +
> +clean:
> +# run kernel build system to cleanup in current directory
> +$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) clean
> +
> +load:
> +	insmod ./$(TARGET_MODULE).ko
> +
> +unload:
> +	rmmod ./$(TARGET_MODULE).ko
> +
> +endif
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_conf.h b/drivers/xen/hyper_dmabuf/hyper_dmabuf_conf.h
> new file mode 100644
> index 0000000..3d9b2d6
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_conf.h
> @@ -0,0 +1,2 @@
> +#define CURRENT_TARGET XEN
> +#define INTER_DOMAIN_DMABUF_SYNCHRONIZATION
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.c b/drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.c
> new file mode 100644
> index 0000000..0698327
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.c
> @@ -0,0 +1,54 @@
> +#include <linux/init.h>       /* module_init, module_exit */
> +#include <linux/module.h> /* version info, MODULE_LICENSE, MODULE_AUTHOR, printk() */
> +#include "hyper_dmabuf_conf.h"
> +#include "hyper_dmabuf_list.h"
> +#include "xen/hyper_dmabuf_xen_comm_list.h"
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("IOTG-PED, INTEL");
> +
> +int register_device(void);
> +int unregister_device(void);
> +
> +/*===============================================================================================*/
> +static int hyper_dmabuf_drv_init(void)
> +{
> +	int ret = 0;
> +
> +	printk( KERN_NOTICE "hyper_dmabuf_starting: Initialization started" );
> +
> +	ret = register_device();
> +	if (ret < 0) {
> +		return -EINVAL;
> +	}
> +
> +	printk( KERN_NOTICE "initializing database for imported/exported dmabufs\n");
> +
> +	ret = hyper_dmabuf_table_init();
> +	if (ret < 0) {
> +		return -EINVAL;
> +	}
> +
> +	ret = hyper_dmabuf_ring_table_init();
> +	if (ret < 0) {
> +		return -EINVAL;
> +	}
> +
> +	/* interrupt for comm should be registered here: */
> +	return ret;
> +}
> +
> +/*-----------------------------------------------------------------------------------------------*/
> +static void hyper_dmabuf_drv_exit(void)
> +{
> +	/* hash tables for export/import entries and ring_infos */
> +	hyper_dmabuf_table_destroy();
> +	hyper_dmabuf_ring_table_init();
> +
> +	printk( KERN_NOTICE "dma_buf-src_sink model: Exiting" );
> +	unregister_device();
> +}
> +/*===============================================================================================*/
> +
> +module_init(hyper_dmabuf_drv_init);
> +module_exit(hyper_dmabuf_drv_exit);
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.h b/drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.h
> new file mode 100644
> index 0000000..2dad9a6
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_drv.h
> @@ -0,0 +1,101 @@
> +#ifndef __LINUX_PUBLIC_HYPER_DMABUF_DRV_H__
> +#define __LINUX_PUBLIC_HYPER_DMABUF_DRV_H__
> +
> +typedef int (*hyper_dmabuf_ioctl_t)(void *data);
> +
> +struct hyper_dmabuf_ioctl_desc {
> +	unsigned int cmd;
> +	int flags;
> +	hyper_dmabuf_ioctl_t func;
> +	const char *name;
> +};
> +
> +#define HYPER_DMABUF_IOCTL_DEF(ioctl, _func, _flags) 	\
> +	[_IOC_NR(ioctl)] = {				\
> +			.cmd = ioctl,			\
> +			.func = _func,			\
> +			.flags = _flags,		\
> +			.name = #ioctl			\
> +	}
> +
> +#define IOCTL_HYPER_DMABUF_EXPORTER_RING_SETUP \
> +_IOC(_IOC_NONE, 'G', 0, sizeof(struct ioctl_hyper_dmabuf_exporter_ring_setup))
> +struct ioctl_hyper_dmabuf_exporter_ring_setup {
> +	/* IN parameters */
> +	/* Remote domain id */
> +	uint32_t remote_domain;
> +	grant_ref_t ring_refid; /* assigned by driver, copied to userspace after initialization */
> +	uint32_t port; /* assigned by driver, copied to userspace after initialization */
> +};
> +
> +#define IOCTL_HYPER_DMABUF_IMPORTER_RING_SETUP \
> +_IOC(_IOC_NONE, 'G', 1, sizeof(struct ioctl_hyper_dmabuf_importer_ring_setup))
> +struct ioctl_hyper_dmabuf_importer_ring_setup {
> +	/* IN parameters */
> +	/* Source domain id */
> +	uint32_t source_domain;
> +	/* Ring shared page refid */
> +	grant_ref_t ring_refid;
> +	/* Port number */
> +	uint32_t port;
> +};
> +
> +#define IOCTL_HYPER_DMABUF_EXPORT_REMOTE \
> +_IOC(_IOC_NONE, 'G', 2, sizeof(struct ioctl_hyper_dmabuf_export_remote))
> +struct ioctl_hyper_dmabuf_export_remote {
> +	/* IN parameters */
> +	/* DMA buf fd to be exported */
> +	uint32_t dmabuf_fd;
> +	/* Domain id to which buffer should be exported */
> +	uint32_t remote_domain;
> +	/* exported dma buf id */
> +	uint32_t hyper_dmabuf_id;
> +	uint32_t private[4];
> +};
> +
> +#define IOCTL_HYPER_DMABUF_EXPORT_FD \
> +_IOC(_IOC_NONE, 'G', 3, sizeof(struct ioctl_hyper_dmabuf_export_fd))
> +struct ioctl_hyper_dmabuf_export_fd {
> +	/* IN parameters */
> +	/* hyper dmabuf id to be imported */
> +	uint32_t hyper_dmabuf_id;
> +	/* flags */
> +	uint32_t flags;
> +	/* OUT parameters */
> +	/* exported dma buf fd */
> +	uint32_t fd;
> +};
> +
> +#define IOCTL_HYPER_DMABUF_DESTROY \
> +_IOC(_IOC_NONE, 'G', 4, sizeof(struct ioctl_hyper_dmabuf_destroy))
> +struct ioctl_hyper_dmabuf_destroy {
> +	/* IN parameters */
> +	/* hyper dmabuf id to be destroyed */
> +	uint32_t hyper_dmabuf_id;
> +	/* OUT parameters */
> +	/* Status of request */
> +	uint32_t status;
> +};
> +
> +#define IOCTL_HYPER_DMABUF_QUERY \
> +_IOC(_IOC_NONE, 'G', 5, sizeof(struct ioctl_hyper_dmabuf_query))
> +struct ioctl_hyper_dmabuf_query {
> +	/* in parameters */
> +	/* hyper dmabuf id to be queried */
> +	uint32_t hyper_dmabuf_id;
> +	/* item to be queried */
> +	uint32_t item;
> +	/* OUT parameters */
> +	/* Value of queried item */
> +	uint32_t info;
> +};
> +
> +#define IOCTL_HYPER_DMABUF_REMOTE_EXPORTER_RING_SETUP \
> +_IOC(_IOC_NONE, 'G', 6, sizeof(struct ioctl_hyper_dmabuf_remote_exporter_ring_setup))
> +struct ioctl_hyper_dmabuf_remote_exporter_ring_setup {
> +	/* in parameters */
> +	uint32_t rdomain; /* id of remote domain where exporter's ring need to be setup */
> +	uint32_t info;
> +};
> +
> +#endif //__LINUX_PUBLIC_HYPER_DMABUF_DRV_H__
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.c b/drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.c
> new file mode 100644
> index 0000000..faa5c1b
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.c
> @@ -0,0 +1,852 @@
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/dma-buf.h>
> +#include <xen/grant_table.h>
> +#include <asm/xen/page.h>
> +#include "hyper_dmabuf_struct.h"
> +#include "hyper_dmabuf_imp.h"
> +#include "xen/hyper_dmabuf_xen_comm.h"
> +#include "hyper_dmabuf_msg.h"
> +
> +#define REFS_PER_PAGE (PAGE_SIZE/sizeof(grant_ref_t))
> +
> +/* return total number of pages referecned by a sgt
> + * for pre-calculation of # of pages behind a given sgt
> + */
> +static int hyper_dmabuf_get_num_pgs(struct sg_table *sgt)
> +{
> +	struct scatterlist *sgl;
> +	int length, i;
> +	/* at least one page */
> +	int num_pages = 1;
> +
> +	sgl = sgt->sgl;
> +
> +	length = sgl->length - PAGE_SIZE + sgl->offset;
> +	num_pages += ((length + PAGE_SIZE - 1)/PAGE_SIZE); /* round-up */
> +
> +	for (i = 1; i < sgt->nents; i++) {
> +		sgl = sg_next(sgl);
> +		num_pages += ((sgl->length + PAGE_SIZE - 1) / PAGE_SIZE); /* round-up */
> +	}
> +
> +	return num_pages;
> +}
> +
> +/* extract pages directly from struct sg_table */
> +struct hyper_dmabuf_pages_info *hyper_dmabuf_ext_pgs(struct sg_table *sgt)
> +{
> +	struct hyper_dmabuf_pages_info *pinfo;
> +	int i, j;
> +	int length;
> +	struct scatterlist *sgl;
> +
> +	pinfo = kmalloc(sizeof(*pinfo), GFP_KERNEL);
> +	if (pinfo == NULL)
> +		return NULL;
> +
> +	pinfo->pages = kmalloc(sizeof(struct page *)*hyper_dmabuf_get_num_pgs(sgt), GFP_KERNEL);
> +	if (pinfo->pages == NULL)
> +		return NULL;
> +
> +	sgl = sgt->sgl;
> +
> +	pinfo->nents = 1;
> +	pinfo->frst_ofst = sgl->offset;
> +	pinfo->pages[0] = sg_page(sgl);
> +	length = sgl->length - PAGE_SIZE + sgl->offset;
> +	i=1;
> +
> +	while (length > 0) {
> +		pinfo->pages[i] = nth_page(sg_page(sgl), i);
> +		length -= PAGE_SIZE;
> +		pinfo->nents++;
> +		i++;
> +	}
> +
> +	for (j = 1; j < sgt->nents; j++) {
> +		sgl = sg_next(sgl);
> +		pinfo->pages[i++] = sg_page(sgl);
> +		length = sgl->length - PAGE_SIZE;
> +		pinfo->nents++;
> +
> +		while (length > 0) {
> +			pinfo->pages[i] = nth_page(sg_page(sgl), i);
> +			length -= PAGE_SIZE;
> +			pinfo->nents++;
> +			i++;
> +		}
> +	}
> +
> +	/*
> +	 * lenght at that point will be 0 or negative,
> +	 * so to calculate last page size just add it to PAGE_SIZE
> +	 */
> +	pinfo->last_len = PAGE_SIZE + length;
> +
> +	return pinfo;
> +}
> +
> +/* create sg_table with given pages and other parameters */
> +struct sg_table* hyper_dmabuf_create_sgt(struct page **pages,
> +				int frst_ofst, int last_len, int nents)
> +{
> +	struct sg_table *sgt;
> +	struct scatterlist *sgl;
> +	int i, ret;
> +
> +	sgt = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
> +	if (sgt == NULL) {
> +		return NULL;
> +	}
> +
> +	ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
> +	if (ret) {
> +		kfree(sgt);
> +		return NULL;
> +	}
> +
> +	sgl = sgt->sgl;
> +
> +	sg_set_page(sgl, pages[0], PAGE_SIZE-frst_ofst, frst_ofst);
> +
> +	for (i=1; i<nents-1; i++) {
> +		sgl = sg_next(sgl);
> +		sg_set_page(sgl, pages[i], PAGE_SIZE, 0);
> +	}
> +
> +	if (i > 1) /* more than one page */ {
> +		sgl = sg_next(sgl);
> +		sg_set_page(sgl, pages[i], last_len, 0);
> +	}
> +
> +	return sgt;
> +}
> +
> +/*
> + * Creates 2 level page directory structure for referencing shared pages.
> + * Top level page is a single page that contains up to 1024 refids that
> + * point to 2nd level pages.
> + * Each 2nd level page contains up to 1024 refids that point to shared
> + * data pages.
> + * There will always be one top level page and number of 2nd level pages
> + * depends on number of shared data pages.
> + *
> + *      Top level page                2nd level pages            Data pages
> + * +-------------------------+   ┌>+--------------------+ ┌--->+------------+
> + * |2nd level page 0 refid   |---┘ |Data page 0 refid   |-┘    |Data page 0 |
> + * |2nd level page 1 refid   |---┐ |Data page 1 refid   |-┐    +------------+
> + * |           ...           |   | |     ....           | |
> + * |2nd level page 1023 refid|-┐ | |Data page 1023 refid| └--->+------------+
> + * +-------------------------+ | | +--------------------+      |Data page 1 |
> + *                             | |                             +------------+
> + *                             | └>+--------------------+
> + *                             |   |Data page 1024 refid|
> + *                             |   |Data page 1025 refid|
> + *                             |   |       ...          |
> + *                             |   |Data page 2047 refid|
> + *                             |   +--------------------+
> + *                             |
> + *                             |        .....
> + *                             └-->+-----------------------+
> + *                                 |Data page 1047552 refid|
> + *                                 |Data page 1047553 refid|
> + *                                 |       ...             |
> + *                                 |Data page 1048575 refid|-->+------------------+
> + *                                 +-----------------------+   |Data page 1048575 |
> + *                                                             +------------------+
> + *
> + * Using such 2 level structure it is possible to reference up to 4GB of
> + * shared data using single refid pointing to top level page.
> + *
> + * Returns refid of top level page.
> + */
> +grant_ref_t hyper_dmabuf_create_addressing_tables(grant_ref_t *data_refs, int nents, int rdomain,
> +						  struct hyper_dmabuf_shared_pages_info *shared_pages_info)
> +{
> +	/*
> +	 * Calculate number of pages needed for 2nd level addresing:
> +	 */
> +	int n_2nd_level_pages = (nents/REFS_PER_PAGE + ((nents % REFS_PER_PAGE) ? 1: 0));/* rounding */
> +	int i;
> +	unsigned long gref_page_start;
> +	grant_ref_t *tmp_page;
> +	grant_ref_t top_level_ref;
> +	grant_ref_t * addr_refs;
> +	addr_refs = kcalloc(sizeof(grant_ref_t), n_2nd_level_pages, GFP_KERNEL);
> +
> +	gref_page_start = __get_free_pages(GFP_KERNEL, n_2nd_level_pages);
> +	tmp_page = (grant_ref_t *)gref_page_start;
> +
> +	/* Store 2nd level pages to be freed later */
> +	shared_pages_info->addr_pages = tmp_page;
> +
> +	/*TODO: make sure that allocated memory is filled with 0*/
> +
> +	/* Share 2nd level addressing pages in readonly mode*/
> +	for (i=0; i< n_2nd_level_pages; i++) {
> +		addr_refs[i] = gnttab_grant_foreign_access(rdomain, virt_to_mfn((unsigned long)tmp_page+i*PAGE_SIZE ), 1);
> +	}
> +
> +	/*
> +	 * fill second level pages with data refs
> +	 */
> +	for (i = 0; i < nents; i++) {
> +		tmp_page[i] = data_refs[i];
> +	}
> +
> +
> +	/* allocate top level page */
> +	gref_page_start = __get_free_pages(GFP_KERNEL, 1);
> +	tmp_page = (grant_ref_t *)gref_page_start;
> +
> +	/* Store top level page to be freed later */
> +	shared_pages_info->top_level_page = tmp_page;
> +
> +	/*
> +	 * fill top level page with reference numbers of second level pages refs.
> +	 */
> +	for (i=0; i< n_2nd_level_pages; i++) {
> +		tmp_page[i] =  addr_refs[i];
> +	}
> +
> +	/* Share top level addressing page in readonly mode*/
> +	top_level_ref = gnttab_grant_foreign_access(rdomain, virt_to_mfn((unsigned long)tmp_page), 1);
> +
> +	kfree(addr_refs);
> +
> +	return top_level_ref;
> +}
> +
> +/*
> + * Maps provided top level ref id and then return array of pages containing data refs.
> + */
> +struct page** hyper_dmabuf_get_data_refs(grant_ref_t top_level_ref, int domid, int nents,
> +					 struct hyper_dmabuf_shared_pages_info *shared_pages_info)
> +{
> +	struct page *top_level_page;
> +	struct page **level2_pages;
> +
> +	grant_ref_t *top_level_refs;
> +
> +	struct gnttab_map_grant_ref top_level_map_ops;
> +	struct gnttab_unmap_grant_ref top_level_unmap_ops;
> +
> +	struct gnttab_map_grant_ref *map_ops;
> +	struct gnttab_unmap_grant_ref *unmap_ops;
> +
> +	unsigned long addr;
> +	int n_level2_refs = 0;
> +	int i;
> +
> +	n_level2_refs = (nents / REFS_PER_PAGE) + ((nents % REFS_PER_PAGE) ? 1 : 0);
> +
> +	level2_pages = kcalloc(sizeof(struct page*), n_level2_refs, GFP_KERNEL);
> +
> +	map_ops = kcalloc(sizeof(map_ops[0]), REFS_PER_PAGE, GFP_KERNEL);
> +	unmap_ops = kcalloc(sizeof(unmap_ops[0]), REFS_PER_PAGE, GFP_KERNEL);
> +
> +	/* Map top level addressing page */
> +	if (gnttab_alloc_pages(1, &top_level_page)) {
> +		printk("Cannot allocate pages\n");
> +		return NULL;
> +	}
> +
> +	addr = (unsigned long)pfn_to_kaddr(page_to_pfn(top_level_page));
> +	gnttab_set_map_op(&top_level_map_ops, addr, GNTMAP_host_map | GNTMAP_readonly, top_level_ref, domid);
> +	gnttab_set_unmap_op(&top_level_unmap_ops, addr, GNTMAP_host_map | GNTMAP_readonly, -1);
> +
> +	if (gnttab_map_refs(&top_level_map_ops, NULL, &top_level_page, 1)) {
> +		printk("\nxen: dom0: HYPERVISOR map grant ref failed");
> +		return NULL;
> +	}
> +
> +	if (top_level_map_ops.status) {
> +		printk("\nxen: dom0: HYPERVISOR map grant ref failed status = %d",
> +				top_level_map_ops.status);
> +		return NULL;
> +	} else {
> +		top_level_unmap_ops.handle = top_level_map_ops.handle;
> +	}
> +
> +	/* Parse contents of top level addressing page to find how many second level pages is there*/
> +	top_level_refs = pfn_to_kaddr(page_to_pfn(top_level_page));
> +
> +	/* Map all second level pages */
> +	if (gnttab_alloc_pages(n_level2_refs, level2_pages)) {
> +		printk("Cannot allocate pages\n");
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < n_level2_refs; i++) {
> +		addr = (unsigned long)pfn_to_kaddr(page_to_pfn(level2_pages[i]));
> +		gnttab_set_map_op(&map_ops[i], addr, GNTMAP_host_map | GNTMAP_readonly, top_level_refs[i], domid);
> +		gnttab_set_unmap_op(&unmap_ops[i], addr, GNTMAP_host_map | GNTMAP_readonly, -1);
> +	}
> +
> +	if (gnttab_map_refs(map_ops, NULL, level2_pages, n_level2_refs)) {
> +		printk("\nxen: dom0: HYPERVISOR map grant ref failed");
> +		return NULL;
> +	}
> +
> +	/* Checks if pages were mapped correctly and at the same time is calculating total number of data refids*/
> +	for (i = 0; i < n_level2_refs; i++) {
> +		if (map_ops[i].status) {
> +			printk("\nxen: dom0: HYPERVISOR map grant ref failed status = %d",
> +					map_ops[i].status);
> +			return NULL;
> +		} else {
> +			unmap_ops[i].handle = map_ops[i].handle;
> +		}
> +	}
> +
> +	/* Unmap top level page, as it won't be needed any longer */
> +	if (gnttab_unmap_refs(&top_level_unmap_ops, NULL, &top_level_page, 1)) {
> +		printk("\xen: cannot unmap top level page\n");
> +		return NULL;
> +	}
> +
> +	gnttab_free_pages(1, &top_level_page);
> +	kfree(map_ops);
> +	shared_pages_info->unmap_ops = unmap_ops;
> +
> +	return level2_pages;
> +}
> +
> +
> +/* This collects all reference numbers for 2nd level shared pages and create a table
> + * with those in 1st level shared pages then return reference numbers for this top level
> + * table. */
> +grant_ref_t hyper_dmabuf_create_gref_table(struct page **pages, int rdomain, int nents,
> +					   struct hyper_dmabuf_shared_pages_info *shared_pages_info)
> +{
> +	int i = 0;
> +	grant_ref_t *data_refs;
> +	grant_ref_t top_level_ref;
> +
> +	/* allocate temp array for refs of shared data pages */
> +	data_refs = kcalloc(nents, sizeof(grant_ref_t), GFP_KERNEL);
> +
> +	/* share data pages in rw mode*/
> +	for (i=0; i<nents; i++) {
> +		data_refs[i] = gnttab_grant_foreign_access(rdomain, pfn_to_mfn(page_to_pfn(pages[i])), 0);
> +	}
> +
> +	/* create additional shared pages with 2 level addressing of data pages */
> +	top_level_ref = hyper_dmabuf_create_addressing_tables(data_refs, nents, rdomain,
> +							      shared_pages_info);
> +
> +	/* Store exported pages refid to be unshared later */
> +	shared_pages_info->data_refs = data_refs;
> +	shared_pages_info->top_level_ref = top_level_ref;
> +
> +	return top_level_ref;
> +}
> +
> +int hyper_dmabuf_cleanup_gref_table(struct hyper_dmabuf_sgt_info *sgt_info) {
> +	uint32_t i = 0;
> +	struct hyper_dmabuf_shared_pages_info *shared_pages_info = &sgt_info->shared_pages_info;
> +
> +	grant_ref_t *ref = shared_pages_info->top_level_page;
> +	int n_2nd_level_pages = (sgt_info->sgt->nents/REFS_PER_PAGE + ((sgt_info->sgt->nents % REFS_PER_PAGE) ? 1: 0));/* rounding */
> +
> +
> +	if (shared_pages_info->data_refs == NULL ||
> +	    shared_pages_info->addr_pages ==  NULL ||
> +	    shared_pages_info->top_level_page == NULL ||
> +	    shared_pages_info->top_level_ref == -1) {
> +		printk("gref table for hyper_dmabuf already cleaned up\n");
> +		return 0;
> +	}
> +
> +	/* End foreign access for 2nd level addressing pages */
> +	while(ref[i] != 0 && i < n_2nd_level_pages) {
> +		if (gnttab_query_foreign_access(ref[i])) {
> +			printk("refid not shared !!\n");
> +		}
> +		if (!gnttab_end_foreign_access_ref(ref[i], 1)) {
> +			printk("refid still in use!!!\n");
> +		}
> +		i++;
> +	}
> +	free_pages((unsigned long)shared_pages_info->addr_pages, i);
> +
> +	/* End foreign access for top level addressing page */
> +	if (gnttab_query_foreign_access(shared_pages_info->top_level_ref)) {
> +		printk("refid not shared !!\n");
> +	}
> +	if (!gnttab_end_foreign_access_ref(shared_pages_info->top_level_ref, 1)) {
> +		printk("refid still in use!!!\n");
> +	}
> +	gnttab_end_foreign_access_ref(shared_pages_info->top_level_ref, 1);
> +	free_pages((unsigned long)shared_pages_info->top_level_page, 1);
> +
> +	/* End foreign access for data pages, but do not free them */
> +	for (i = 0; i < sgt_info->sgt->nents; i++) {
> +		if (gnttab_query_foreign_access(shared_pages_info->data_refs[i])) {
> +			printk("refid not shared !!\n");
> +		}
> +		gnttab_end_foreign_access_ref(shared_pages_info->data_refs[i], 0);
> +	}
> +
> +	kfree(shared_pages_info->data_refs);
> +
> +	shared_pages_info->data_refs = NULL;
> +	shared_pages_info->addr_pages = NULL;
> +	shared_pages_info->top_level_page = NULL;
> +	shared_pages_info->top_level_ref = -1;
> +
> +	return 0;
> +}
> +
> +int hyper_dmabuf_cleanup_imported_pages(struct hyper_dmabuf_imported_sgt_info *sgt_info) {
> +	struct hyper_dmabuf_shared_pages_info *shared_pages_info = &sgt_info->shared_pages_info;
> +
> +	if(shared_pages_info->unmap_ops == NULL || shared_pages_info->data_pages == NULL) {
> +		printk("Imported pages already cleaned up or buffer was not imported yet\n");
> +		return 0;
> +	}
> +
> +	if (gnttab_unmap_refs(shared_pages_info->unmap_ops, NULL, shared_pages_info->data_pages, sgt_info->nents) ) {
> +		printk("Cannot unmap data pages\n");
> +		return -EINVAL;
> +	}
> +
> +	gnttab_free_pages(sgt_info->nents, shared_pages_info->data_pages);
> +	kfree(shared_pages_info->data_pages);
> +	kfree(shared_pages_info->unmap_ops);
> +	shared_pages_info->unmap_ops = NULL;
> +	shared_pages_info->data_pages = NULL;
> +
> +	return 0;
> +}
> +
> +/* map and construct sg_lists from reference numbers */
> +struct sg_table* hyper_dmabuf_map_pages(grant_ref_t top_level_gref, int frst_ofst, int last_len, int nents, int sdomain,
> +					struct hyper_dmabuf_shared_pages_info *shared_pages_info)
> +{
> +	struct sg_table *st;
> +	struct page **pages;
> +	struct gnttab_map_grant_ref *ops;
> +	struct gnttab_unmap_grant_ref *unmap_ops;
> +	unsigned long addr;
> +	grant_ref_t *refs;
> +	int i;
> +	int n_level2_refs = (nents / REFS_PER_PAGE) + ((nents % REFS_PER_PAGE) ? 1 : 0);
> +
> +	/* Get data refids */
> +	struct page** refid_pages = hyper_dmabuf_get_data_refs(top_level_gref, sdomain, nents,
> +							       shared_pages_info);
> +
> +	pages = kcalloc(sizeof(struct page*), nents, GFP_KERNEL);
> +	if (pages == NULL) {
> +		return NULL;
> +	}
> +
> +	/* allocate new pages that are mapped to shared pages via grant-table */
> +	if (gnttab_alloc_pages(nents, pages)) {
> +		printk("Cannot allocate pages\n");
> +		return NULL;
> +	}
> +
> +	ops = (struct gnttab_map_grant_ref *)kcalloc(nents, sizeof(struct gnttab_map_grant_ref), GFP_KERNEL);
> +	unmap_ops = (struct gnttab_unmap_grant_ref *)kcalloc(nents, sizeof(struct gnttab_unmap_grant_ref), GFP_KERNEL);
> +
> +	for (i=0; i<nents; i++) {
> +		addr = (unsigned long)pfn_to_kaddr(page_to_pfn(pages[i]));
> +		refs = pfn_to_kaddr(page_to_pfn(refid_pages[i / REFS_PER_PAGE]));
> +		gnttab_set_map_op(&ops[i], addr, GNTMAP_host_map | GNTMAP_readonly, refs[i % REFS_PER_PAGE], sdomain);
> +		gnttab_set_unmap_op(&unmap_ops[i], addr, GNTMAP_host_map | GNTMAP_readonly, -1);
> +	}
> +
> +	if (gnttab_map_refs(ops, NULL, pages, nents)) {
> +		printk("\nxen: dom0: HYPERVISOR map grant ref failed\n");
> +		return NULL;
> +	}
> +
> +	for (i=0; i<nents; i++) {
> +		if (ops[i].status) {
> +			printk("\nxen: dom0: HYPERVISOR map grant ref failed status = %d\n",
> +				ops[0].status);
> +			return NULL;
> +		} else {
> +			unmap_ops[i].handle = ops[i].handle;
> +		}
> +	}
> +
> +	st = hyper_dmabuf_create_sgt(pages, frst_ofst, last_len, nents);
> +
> +	if (gnttab_unmap_refs(shared_pages_info->unmap_ops, NULL, refid_pages, n_level2_refs) ) {
> +		printk("Cannot unmap 2nd level refs\n");
> +		return NULL;
> +	}
> +
> +	gnttab_free_pages(n_level2_refs, refid_pages);
> +	kfree(refid_pages);
> +
> +	kfree(shared_pages_info->unmap_ops);
> +	shared_pages_info->unmap_ops = unmap_ops;
> +	shared_pages_info->data_pages = pages;
> +	kfree(ops);
> +
> +	return st;
> +}
> +
> +inline int hyper_dmabuf_sync_request_and_wait(int id, int ops)
> +{
> +	struct hyper_dmabuf_ring_rq *req;
> +	int operands[2];
> +	int ret;
> +
> +	operands[0] = id;
> +	operands[1] = ops;
> +
> +	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
> +
> +	hyper_dmabuf_create_request(req, HYPER_DMABUF_OPS_TO_SOURCE, &operands[0]);
> +
> +	/* send request */
> +	ret = hyper_dmabuf_send_request(id, req);
> +
> +	/* TODO: wait until it gets response.. or can we just move on? */
> +
> +	kfree(req);
> +
> +	return ret;
> +}
> +
> +static int hyper_dmabuf_ops_attach(struct dma_buf* dmabuf, struct device* dev,
> +			struct dma_buf_attachment *attach)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!attach->dmabuf->priv)
> +		return -EINVAL;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)attach->dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_ATTACH);
> +
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static void hyper_dmabuf_ops_detach(struct dma_buf* dmabuf, struct dma_buf_attachment *attach)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!attach->dmabuf->priv)
> +		return;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)attach->dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_DETACH);
> +
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +}
> +
> +static struct sg_table* hyper_dmabuf_ops_map(struct dma_buf_attachment *attachment,
> +						enum dma_data_direction dir)
> +{
> +	struct sg_table *st;
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	struct hyper_dmabuf_pages_info *page_info;
> +	int ret;
> +
> +	if (!attachment->dmabuf->priv)
> +		return NULL;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)attachment->dmabuf->priv;
> +
> +	/* extract pages from sgt */
> +	page_info = hyper_dmabuf_ext_pgs(sgt_info->sgt);
> +
> +	/* create a new sg_table with extracted pages */
> +	st = hyper_dmabuf_create_sgt(page_info->pages, page_info->frst_ofst,
> +				page_info->last_len, page_info->nents);
> +	if (st == NULL)
> +		goto err_free_sg;
> +
> +        if (!dma_map_sg(attachment->dev, st->sgl, st->nents, dir)) {
> +                goto err_free_sg;
> +        }
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_MAP);
> +
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +
> +	return st;
> +
> +err_free_sg:
> +	sg_free_table(st);
> +	kfree(st);
> +	return NULL;
> +}
> +
> +static void hyper_dmabuf_ops_unmap(struct dma_buf_attachment *attachment,
> +						struct sg_table *sg,
> +						enum dma_data_direction dir)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!attachment->dmabuf->priv)
> +		return;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)attachment->dmabuf->priv;
> +
> +	dma_unmap_sg(attachment->dev, sg->sgl, sg->nents, dir);
> +
> +	sg_free_table(sg);
> +	kfree(sg);
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_UNMAP);
> +
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +}
> +
> +static void hyper_dmabuf_ops_release(struct dma_buf *dmabuf)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_RELEASE);
> +
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +}
> +
> +static int hyper_dmabuf_ops_begin_cpu_access(struct dma_buf *dmabuf, enum dma_data_direction dir)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return -EINVAL;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_BEGIN_CPU_ACCESS);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int hyper_dmabuf_ops_end_cpu_access(struct dma_buf *dmabuf, enum dma_data_direction dir)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return -EINVAL;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_END_CPU_ACCESS);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void *hyper_dmabuf_ops_kmap_atomic(struct dma_buf *dmabuf, unsigned long pgnum)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return NULL;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_KMAP_ATOMIC);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +
> +	return NULL; /* for now NULL.. need to return the address of mapped region */
> +}
> +
> +static void hyper_dmabuf_ops_kunmap_atomic(struct dma_buf *dmabuf, unsigned long pgnum, void *vaddr)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_KUNMAP_ATOMIC);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +}
> +
> +static void *hyper_dmabuf_ops_kmap(struct dma_buf *dmabuf, unsigned long pgnum)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return NULL;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_KMAP);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +
> +	return NULL; /* for now NULL.. need to return the address of mapped region */
> +}
> +
> +static void hyper_dmabuf_ops_kunmap(struct dma_buf *dmabuf, unsigned long pgnum, void *vaddr)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_KUNMAP);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +}
> +
> +static int hyper_dmabuf_ops_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return -EINVAL;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_MMAP);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static void *hyper_dmabuf_ops_vmap(struct dma_buf *dmabuf)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return NULL;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_VMAP);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +
> +	return NULL;
> +}
> +
> +static void hyper_dmabuf_ops_vunmap(struct dma_buf *dmabuf, void *vaddr)
> +{
> +	struct hyper_dmabuf_imported_sgt_info *sgt_info;
> +	int ret;
> +
> +	if (!dmabuf->priv)
> +		return;
> +
> +	sgt_info = (struct hyper_dmabuf_imported_sgt_info *)dmabuf->priv;
> +
> +	ret = hyper_dmabuf_sync_request_and_wait(HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(sgt_info->hyper_dmabuf_id),
> +						HYPER_DMABUF_OPS_VUNMAP);
> +	if (ret < 0) {
> +		printk("send dmabuf sync request failed\n");
> +	}
> +}
> +
> +static const struct dma_buf_ops hyper_dmabuf_ops = {
> +		.attach = hyper_dmabuf_ops_attach,
> +		.detach = hyper_dmabuf_ops_detach,
> +		.map_dma_buf = hyper_dmabuf_ops_map,
> +		.unmap_dma_buf = hyper_dmabuf_ops_unmap,
> +		.release = hyper_dmabuf_ops_release,
> +		.begin_cpu_access = (void*)hyper_dmabuf_ops_begin_cpu_access,
> +		.end_cpu_access = (void*)hyper_dmabuf_ops_end_cpu_access,
> +		.map_atomic = hyper_dmabuf_ops_kmap_atomic,
> +		.unmap_atomic = hyper_dmabuf_ops_kunmap_atomic,
> +		.map = hyper_dmabuf_ops_kmap,
> +		.unmap = hyper_dmabuf_ops_kunmap,
> +		.mmap = hyper_dmabuf_ops_mmap,
> +		.vmap = hyper_dmabuf_ops_vmap,
> +		.vunmap = hyper_dmabuf_ops_vunmap,
> +};
> +
> +/* exporting dmabuf as fd */
> +int hyper_dmabuf_export_fd(struct hyper_dmabuf_imported_sgt_info *dinfo, int flags)
> +{
> +	int fd;
> +
> +	struct dma_buf* dmabuf;
> +
> +/* call hyper_dmabuf_export_dmabuf and create and bind a handle for it
> + * then release */
> +
> +	dmabuf = hyper_dmabuf_export_dma_buf(dinfo);
> +
> +	fd = dma_buf_fd(dmabuf, flags);
> +
> +	return fd;
> +}
> +
> +struct dma_buf* hyper_dmabuf_export_dma_buf(struct hyper_dmabuf_imported_sgt_info *dinfo)
> +{
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +
> +	exp_info.ops = &hyper_dmabuf_ops;
> +	exp_info.size = dinfo->sgt->nents * PAGE_SIZE; /* multiple of PAGE_SIZE, not considering offset */
> +	exp_info.flags = /* not sure about flag */0;
> +	exp_info.priv = dinfo;
> +
> +	return dma_buf_export(&exp_info);
> +};
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.h b/drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.h
> new file mode 100644
> index 0000000..003c158
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_imp.h
> @@ -0,0 +1,31 @@
> +#ifndef __HYPER_DMABUF_IMP_H__
> +#define __HYPER_DMABUF_IMP_H__
> +
> +#include "hyper_dmabuf_struct.h"
> +
> +/* extract pages directly from struct sg_table */
> +struct hyper_dmabuf_pages_info *hyper_dmabuf_ext_pgs(struct sg_table *sgt);
> +
> +/* create sg_table with given pages and other parameters */
> +struct sg_table* hyper_dmabuf_create_sgt(struct page **pages,
> +                                int frst_ofst, int last_len, int nents);
> +
> +grant_ref_t hyper_dmabuf_create_gref_table(struct page **pages, int rdomain, int nents,
> +					   struct hyper_dmabuf_shared_pages_info *shared_pages_info);
> +
> +int hyper_dmabuf_cleanup_gref_table(struct hyper_dmabuf_sgt_info *sgt_info);
> +
> +int hyper_dmabuf_cleanup_imported_pages(struct hyper_dmabuf_imported_sgt_info *sgt_info);
> +
> +/* map first level tables that contains reference numbers for actual shared pages */
> +grant_ref_t *hyper_dmabuf_map_gref_table(grant_ref_t *gref_table, int n_pages_table);
> +
> +/* map and construct sg_lists from reference numbers */
> +struct sg_table* hyper_dmabuf_map_pages(grant_ref_t gref, int frst_ofst, int last_len, int nents, int sdomain,
> +					struct hyper_dmabuf_shared_pages_info *shared_pages_info);
> +
> +int hyper_dmabuf_export_fd(struct hyper_dmabuf_imported_sgt_info *dinfo, int flags);
> +
> +struct dma_buf* hyper_dmabuf_export_dma_buf(struct hyper_dmabuf_imported_sgt_info *dinfo);
> +
> +#endif /* __HYPER_DMABUF_IMP_H__ */
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_ioctl.c b/drivers/xen/hyper_dmabuf/hyper_dmabuf_ioctl.c
> new file mode 100644
> index 0000000..5e50908
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_ioctl.c
> @@ -0,0 +1,462 @@
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/miscdevice.h>
> +#include <linux/uaccess.h>
> +#include <linux/dma-buf.h>
> +#include <linux/delay.h>
> +#include "hyper_dmabuf_struct.h"
> +#include "hyper_dmabuf_imp.h"
> +#include "hyper_dmabuf_list.h"
> +#include "hyper_dmabuf_drv.h"
> +#include "hyper_dmabuf_query.h"
> +#include "xen/hyper_dmabuf_xen_comm.h"
> +#include "hyper_dmabuf_msg.h"
> +
> +struct hyper_dmabuf_private {
> +	struct device *device;
> +} hyper_dmabuf_private;
> +
> +static uint32_t hyper_dmabuf_id_gen(void) {
> +	/* TODO: add proper implementation */
> +	static uint32_t id = 0;
> +	static int32_t domid = -1;
> +	if (domid == -1) {
> +		domid = hyper_dmabuf_get_domid();
> +	}
> +	return HYPER_DMABUF_ID_IMPORTER(domid, id++);
> +}
> +
> +static int hyper_dmabuf_exporter_ring_setup(void *data)
> +{
> +	struct ioctl_hyper_dmabuf_exporter_ring_setup *ring_attr;
> +	int ret = 0;
> +
> +	if (!data) {
> +		printk("user data is NULL\n");
> +		return -1;
> +	}
> +	ring_attr = (struct ioctl_hyper_dmabuf_exporter_ring_setup *)data;
> +
> +	ret = hyper_dmabuf_exporter_ringbuf_init(ring_attr->remote_domain,
> +						&ring_attr->ring_refid,
> +						&ring_attr->port);
> +
> +	return ret;
> +}
> +
> +static int hyper_dmabuf_importer_ring_setup(void *data)
> +{
> +	struct ioctl_hyper_dmabuf_importer_ring_setup *setup_imp_ring_attr;
> +	int ret = 0;
> +
> +	if (!data) {
> +		printk("user data is NULL\n");
> +		return -1;
> +	}
> +
> +	setup_imp_ring_attr = (struct ioctl_hyper_dmabuf_importer_ring_setup *)data;
> +
> +	/* user need to provide a port number and ref # for the page used as ring buffer */
> +	ret = hyper_dmabuf_importer_ringbuf_init(setup_imp_ring_attr->source_domain,
> +						 setup_imp_ring_attr->ring_refid,
> +						 setup_imp_ring_attr->port);
> +
> +	return ret;
> +}
> +
> +static int hyper_dmabuf_export_remote(void *data)
> +{
> +	struct ioctl_hyper_dmabuf_export_remote *export_remote_attr;
> +	struct dma_buf *dma_buf;
> +	struct dma_buf_attachment *attachment;
> +	struct sg_table *sgt;
> +	struct hyper_dmabuf_pages_info *page_info;
> +	struct hyper_dmabuf_sgt_info *sgt_info;
> +	struct hyper_dmabuf_ring_rq *req;
> +	int operands[9];
> +	int ret = 0;
> +
> +	if (!data) {
> +		printk("user data is NULL\n");
> +		return -1;
> +	}
> +
> +	export_remote_attr = (struct ioctl_hyper_dmabuf_export_remote *)data;
> +
> +	dma_buf = dma_buf_get(export_remote_attr->dmabuf_fd);
> +	if (!dma_buf) {
> +		printk("Cannot get dma buf\n");
> +		return -1;
> +	}
> +
> +	attachment = dma_buf_attach(dma_buf, hyper_dmabuf_private.device);
> +	if (!attachment) {
> +		printk("Cannot get attachment\n");
> +		return -1;
> +	}
> +
> +	/* we check if this specific attachment was already exported
> +	 * to the same domain and if yes, it returns hyper_dmabuf_id
> +	 * of pre-exported sgt */
> +	ret = hyper_dmabuf_find_id(attachment, export_remote_attr->remote_domain);
> +	if (ret != -1) {
> +		dma_buf_detach(dma_buf, attachment);
> +		dma_buf_put(dma_buf);
> +		export_remote_attr->hyper_dmabuf_id = ret;
> +		return 0;
> +	}
> +	/* Clear ret, as that will cause whole ioctl to return failure to userspace, which is not true */
> +	ret = 0;
> +
> +	sgt = dma_buf_map_attachment(attachment, DMA_BIDIRECTIONAL);
> +
> +	sgt_info = kmalloc(sizeof(*sgt_info), GFP_KERNEL);
> +
> +	sgt_info->hyper_dmabuf_id = hyper_dmabuf_id_gen();
> +	/* TODO: We might need to consider using port number on event channel? */
> +	sgt_info->hyper_dmabuf_rdomain = export_remote_attr->remote_domain;
> +	sgt_info->sgt = sgt;
> +	sgt_info->attachment = attachment;
> +	sgt_info->dma_buf = dma_buf;
> +
> +	page_info = hyper_dmabuf_ext_pgs(sgt);
> +	if (page_info == NULL)
> +		goto fail_export;
> +
> +	/* now register it to export list */
> +	hyper_dmabuf_register_exported(sgt_info);
> +
> +	page_info->hyper_dmabuf_rdomain = sgt_info->hyper_dmabuf_rdomain;
> +	page_info->hyper_dmabuf_id = sgt_info->hyper_dmabuf_id; /* may not be needed */
> +
> +	export_remote_attr->hyper_dmabuf_id = sgt_info->hyper_dmabuf_id;
> +
> +	/* now create table of grefs for shared pages and */
> +
> +	/* now create request for importer via ring */
> +	operands[0] = page_info->hyper_dmabuf_id;
> +	operands[1] = page_info->nents;
> +	operands[2] = page_info->frst_ofst;
> +	operands[3] = page_info->last_len;
> +	operands[4] = hyper_dmabuf_create_gref_table(page_info->pages, export_remote_attr->remote_domain,
> +						page_info->nents, &sgt_info->shared_pages_info);
> +	/* driver/application specific private info, max 32 bytes */
> +	operands[5] = export_remote_attr->private[0];
> +	operands[6] = export_remote_attr->private[1];
> +	operands[7] = export_remote_attr->private[2];
> +	operands[8] = export_remote_attr->private[3];
> +
> +	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
> +
> +	/* composing a message to the importer */
> +	hyper_dmabuf_create_request(req, HYPER_DMABUF_EXPORT, &operands[0]);
> +	if(hyper_dmabuf_send_request(export_remote_attr->remote_domain, req))
> +		goto fail_send_request;
> +
> +	/* free msg */
> +	kfree(req);
> +	/* free page_info */
> +	kfree(page_info);
> +
> +	return ret;
> +
> +fail_send_request:
> +	kfree(req);
> +	hyper_dmabuf_remove_exported(sgt_info->hyper_dmabuf_id);
> +
> +fail_export:
> +	dma_buf_unmap_attachment(sgt_info->attachment, sgt_info->sgt, DMA_BIDIRECTIONAL);
> +	dma_buf_detach(sgt_info->dma_buf, sgt_info->attachment);
> +	dma_buf_put(sgt_info->dma_buf);
> +
> +	return -EINVAL;
> +}
> +
> +static int hyper_dmabuf_export_fd_ioctl(void *data)
> +{
> +	struct ioctl_hyper_dmabuf_export_fd *export_fd_attr;
> +	struct hyper_dmabuf_imported_sgt_info *imported_sgt_info;
> +	int ret = 0;
> +
> +	if (!data) {
> +		printk("user data is NULL\n");
> +		return -1;
> +	}
> +
> +	export_fd_attr = (struct ioctl_hyper_dmabuf_export_fd *)data;
> +
> +	/* look for dmabuf for the id */
> +	imported_sgt_info = hyper_dmabuf_find_imported(export_fd_attr->hyper_dmabuf_id);
> +	if (imported_sgt_info == NULL) /* can't find sgt from the table */
> +		return -1;
> +
> +	printk("%s Found buffer gref %d  off %d last len %d nents %d domain %d\n", __func__,
> +		imported_sgt_info->gref, imported_sgt_info->frst_ofst,
> +		imported_sgt_info->last_len, imported_sgt_info->nents,
> +		HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(imported_sgt_info->hyper_dmabuf_id));
> +
> +	imported_sgt_info->sgt = hyper_dmabuf_map_pages(imported_sgt_info->gref,
> +						imported_sgt_info->frst_ofst,
> +						imported_sgt_info->last_len,
> +						imported_sgt_info->nents,
> +						HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(imported_sgt_info->hyper_dmabuf_id),
> +						&imported_sgt_info->shared_pages_info);
> +
> +	if (!imported_sgt_info->sgt) {
> +		return -1;
> +	}
> +
> +	export_fd_attr->fd = hyper_dmabuf_export_fd(imported_sgt_info, export_fd_attr->flags);
> +	if (export_fd_attr < 0) {
> +		ret = export_fd_attr->fd;
> +	}
> +
> +	return ret;
> +}
> +
> +/* removing dmabuf from the database and send int req to the source domain
> +* to unmap it. */
> +static int hyper_dmabuf_destroy(void *data)
> +{
> +	struct ioctl_hyper_dmabuf_destroy *destroy_attr;
> +	struct hyper_dmabuf_sgt_info *sgt_info;
> +	struct hyper_dmabuf_ring_rq *req;
> +	int ret;
> +
> +	if (!data) {
> +		printk("user data is NULL\n");
> +		return -EINVAL;
> +	}
> +
> +	destroy_attr = (struct ioctl_hyper_dmabuf_destroy *)data;
> +
> +	/* find dmabuf in export list */
> +	sgt_info = hyper_dmabuf_find_exported(destroy_attr->hyper_dmabuf_id);
> +	if (sgt_info == NULL) { /* failed to find corresponding entry in export list */
> +		destroy_attr->status = -EINVAL;
> +		return -EFAULT;
> +	}
> +
> +	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
> +
> +	hyper_dmabuf_create_request(req, HYPER_DMABUF_DESTROY, &destroy_attr->hyper_dmabuf_id);
> +
> +	/* now send destroy request to remote domain
> +	 * currently assuming there's only one importer exist */
> +	ret = hyper_dmabuf_send_request(sgt_info->hyper_dmabuf_rdomain, req);
> +	if (ret < 0) {
> +		kfree(req);
> +		return -EFAULT;
> +	}
> +
> +	/* free msg */
> +	kfree(req);
> +	destroy_attr->status = ret;
> +
> +	/* Rest of cleanup will follow when importer will free it's buffer,
> +	 * current implementation assumes that there is only one importer
> +         */
> +
> +	return ret;
> +}
> +
> +static int hyper_dmabuf_query(void *data)
> +{
> +	struct ioctl_hyper_dmabuf_query *query_attr;
> +	struct hyper_dmabuf_sgt_info *sgt_info;
> +	struct hyper_dmabuf_imported_sgt_info *imported_sgt_info;
> +	int ret = 0;
> +
> +	if (!data) {
> +		printk("user data is NULL\n");
> +		return -EINVAL;
> +	}
> +
> +	query_attr = (struct ioctl_hyper_dmabuf_query *)data;
> +
> +	sgt_info = hyper_dmabuf_find_exported(query_attr->hyper_dmabuf_id);
> +	imported_sgt_info = hyper_dmabuf_find_imported(query_attr->hyper_dmabuf_id);
> +
> +	/* if dmabuf can't be found in both lists, return */
> +	if (!(sgt_info && imported_sgt_info)) {
> +		printk("can't find entry anywhere\n");
> +		return -EINVAL;
> +	}
> +
> +	/* not considering the case where a dmabuf is found on both queues
> +	 * in one domain */
> +	switch (query_attr->item)
> +	{
> +		case DMABUF_QUERY_TYPE_LIST:
> +			if (sgt_info) {
> +				query_attr->info = EXPORTED;
> +			} else {
> +				query_attr->info = IMPORTED;
> +			}
> +			break;
> +
> +		/* exporting domain of this specific dmabuf*/
> +		case DMABUF_QUERY_EXPORTER:
> +			if (sgt_info) {
> +				query_attr->info = 0xFFFFFFFF; /* myself */
> +			} else {
> +				query_attr->info = (HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(imported_sgt_info->hyper_dmabuf_id));
> +			}
> +			break;
> +
> +		/* importing domain of this specific dmabuf */
> +		case DMABUF_QUERY_IMPORTER:
> +			if (sgt_info) {
> +				query_attr->info = sgt_info->hyper_dmabuf_rdomain;
> +			} else {
> +#if 0 /* TODO: a global variable, current_domain does not exist yet*/
> +				query_attr->info = current_domain;
> +#endif
> +			}
> +			break;
> +
> +		/* size of dmabuf in byte */
> +		case DMABUF_QUERY_SIZE:
> +			if (sgt_info) {
> +#if 0 /* TODO: hyper_dmabuf_buf_size is not implemented yet */
> +				query_attr->info = hyper_dmabuf_buf_size(sgt_info->sgt);
> +#endif
> +			} else {
> +				query_attr->info = imported_sgt_info->nents * 4096 -
> +						   imported_sgt_info->frst_ofst - 4096 +
> +						   imported_sgt_info->last_len;
> +			}
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int hyper_dmabuf_remote_exporter_ring_setup(void *data)
> +{
> +	struct ioctl_hyper_dmabuf_remote_exporter_ring_setup *remote_exporter_ring_setup;
> +	struct hyper_dmabuf_ring_rq *req;
> +
> +	remote_exporter_ring_setup = (struct ioctl_hyper_dmabuf_remote_exporter_ring_setup *)data;
> +
> +	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
> +	hyper_dmabuf_create_request(req, HYPER_DMABUF_EXPORTER_RING_SETUP, NULL);
> +
> +	/* requesting remote domain to set-up exporter's ring */
> +	if(hyper_dmabuf_send_request(remote_exporter_ring_setup->rdomain, req) < 0) {
> +		kfree(req);
> +		return -EINVAL;
> +	}
> +
> +	kfree(req);
> +	return 0;
> +}
> +
> +static const struct hyper_dmabuf_ioctl_desc hyper_dmabuf_ioctls[] = {
> +	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_EXPORTER_RING_SETUP, hyper_dmabuf_exporter_ring_setup, 0),
> +	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_IMPORTER_RING_SETUP, hyper_dmabuf_importer_ring_setup, 0),
> +	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_EXPORT_REMOTE, hyper_dmabuf_export_remote, 0),
> +	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_EXPORT_FD, hyper_dmabuf_export_fd_ioctl, 0),
> +	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_DESTROY, hyper_dmabuf_destroy, 0),
> +	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_QUERY, hyper_dmabuf_query, 0),
> +	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_REMOTE_EXPORTER_RING_SETUP, hyper_dmabuf_remote_exporter_ring_setup, 0),
> +};
> +
> +static long hyper_dmabuf_ioctl(struct file *filp,
> +			unsigned int cmd, unsigned long param)
> +{
> +	const struct hyper_dmabuf_ioctl_desc *ioctl = NULL;
> +	unsigned int nr = _IOC_NR(cmd);
> +	int ret = -EINVAL;
> +	hyper_dmabuf_ioctl_t func;
> +	char *kdata;
> +
> +	ioctl = &hyper_dmabuf_ioctls[nr];
> +
> +	func = ioctl->func;
> +
> +	if (unlikely(!func)) {
> +		printk("no function\n");
> +		return -EINVAL;
> +	}
> +
> +	kdata = kmalloc(_IOC_SIZE(cmd), GFP_KERNEL);
> +	if (!kdata) {
> +		printk("no memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (copy_from_user(kdata, (void __user *)param, _IOC_SIZE(cmd)) != 0) {
> +		printk("failed to copy from user arguments\n");
> +		return -EFAULT;
> +	}
> +
> +	ret = func(kdata);
> +
> +	if (copy_to_user((void __user *)param, kdata, _IOC_SIZE(cmd)) != 0) {
> +		printk("failed to copy to user arguments\n");
> +		return -EFAULT;
> +	}
> +
> +	kfree(kdata);
> +
> +	return ret;
> +}
> +
> +struct device_info {
> +	int curr_domain;
> +};
> +
> +/*===============================================================================================*/
> +static struct file_operations hyper_dmabuf_driver_fops =
> +{
> +   .owner = THIS_MODULE,
> +   .unlocked_ioctl = hyper_dmabuf_ioctl,
> +};
> +
> +static struct miscdevice hyper_dmabuf_miscdev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "xen/hyper_dmabuf",
> +	.fops = &hyper_dmabuf_driver_fops,
> +};
> +
> +static const char device_name[] = "hyper_dmabuf";
> +
> +/*===============================================================================================*/
> +int register_device(void)
> +{
> +	int result = 0;
> +
> +	result = misc_register(&hyper_dmabuf_miscdev);
> +
> +	if (result != 0) {
> +		printk(KERN_WARNING "hyper_dmabuf: driver can't be registered\n");
> +		return result;
> +	}
> +
> +	hyper_dmabuf_private.device = hyper_dmabuf_miscdev.this_device;
> +
> +	/* TODO: Check if there is a different way to initialize dma mask nicely */
> +	dma_coerce_mask_and_coherent(hyper_dmabuf_private.device, 0xFFFFFFFF);
> +
> +	/* TODO find a way to provide parameters for below function or move that to ioctl */
> +/*	err = bind_interdomain_evtchn_to_irqhandler(rdomain, evtchn,
> +				src_sink_isr, PORT_NUM, "remote_domain", &info);
> +	if (err < 0) {
> +		printk("hyper_dmabuf: can't register interrupt handlers\n");
> +		return -EFAULT;
> +	}
> +
> +	info.irq = err;
> +*/
> +	return result;
> +}
> +
> +/*-----------------------------------------------------------------------------------------------*/
> +void unregister_device(void)
> +{
> +	printk( KERN_NOTICE "hyper_dmabuf: unregister_device() is called" );
> +	misc_deregister(&hyper_dmabuf_miscdev);
> +}
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_list.c b/drivers/xen/hyper_dmabuf/hyper_dmabuf_list.c
> new file mode 100644
> index 0000000..77a7e65
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_list.c
> @@ -0,0 +1,119 @@
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/cdev.h>
> +#include <asm/uaccess.h>
> +#include <linux/hashtable.h>
> +#include <linux/dma-buf.h>
> +#include "hyper_dmabuf_list.h"
> +
> +DECLARE_HASHTABLE(hyper_dmabuf_hash_imported, MAX_ENTRY_IMPORTED);
> +DECLARE_HASHTABLE(hyper_dmabuf_hash_exported, MAX_ENTRY_EXPORTED);
> +
> +int hyper_dmabuf_table_init()
> +{
> +	hash_init(hyper_dmabuf_hash_imported);
> +	hash_init(hyper_dmabuf_hash_exported);
> +	return 0;
> +}
> +
> +int hyper_dmabuf_table_destroy()
> +{
> +	/* TODO: cleanup hyper_dmabuf_hash_imported and hyper_dmabuf_hash_exported */
> +	return 0;
> +}
> +
> +int hyper_dmabuf_register_exported(struct hyper_dmabuf_sgt_info *info)
> +{
> +	struct hyper_dmabuf_info_entry_exported *info_entry;
> +
> +	info_entry = kmalloc(sizeof(*info_entry), GFP_KERNEL);
> +
> +	info_entry->info = info;
> +
> +	hash_add(hyper_dmabuf_hash_exported, &info_entry->node,
> +		info_entry->info->hyper_dmabuf_id);
> +
> +	return 0;
> +}
> +
> +int hyper_dmabuf_register_imported(struct hyper_dmabuf_imported_sgt_info* info)
> +{
> +	struct hyper_dmabuf_info_entry_imported *info_entry;
> +
> +	info_entry = kmalloc(sizeof(*info_entry), GFP_KERNEL);
> +
> +	info_entry->info = info;
> +
> +	hash_add(hyper_dmabuf_hash_imported, &info_entry->node,
> +		info_entry->info->hyper_dmabuf_id);
> +
> +	return 0;
> +}
> +
> +struct hyper_dmabuf_sgt_info *hyper_dmabuf_find_exported(int id)
> +{
> +	struct hyper_dmabuf_info_entry_exported *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_exported, bkt, info_entry, node)
> +		if(info_entry->info->hyper_dmabuf_id == id)
> +			return info_entry->info;
> +
> +	return NULL;
> +}
> +
> +/* search for pre-exported sgt and return id of it if it exist */
> +int hyper_dmabuf_find_id(struct dma_buf_attachment *attach, int domid)
> +{
> +	struct hyper_dmabuf_info_entry_exported *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_exported, bkt, info_entry, node)
> +		if(info_entry->info->attachment == attach &&
> +			info_entry->info->hyper_dmabuf_rdomain == domid)
> +			return info_entry->info->hyper_dmabuf_id;
> +
> +	return -1;
> +}
> +
> +struct hyper_dmabuf_imported_sgt_info *hyper_dmabuf_find_imported(int id)
> +{
> +	struct hyper_dmabuf_info_entry_imported *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_imported, bkt, info_entry, node)
> +		if(info_entry->info->hyper_dmabuf_id == id)
> +			return info_entry->info;
> +
> +	return NULL;
> +}
> +
> +int hyper_dmabuf_remove_exported(int id)
> +{
> +	struct hyper_dmabuf_info_entry_exported *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_exported, bkt, info_entry, node)
> +		if(info_entry->info->hyper_dmabuf_id == id) {
> +			hash_del(&info_entry->node);
> +			return 0;
> +		}
> +
> +	return -1;
> +}
> +
> +int hyper_dmabuf_remove_imported(int id)
> +{
> +	struct hyper_dmabuf_info_entry_imported *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_imported, bkt, info_entry, node)
> +		if(info_entry->info->hyper_dmabuf_id == id) {
> +			hash_del(&info_entry->node);
> +			return 0;
> +		}
> +
> +	return -1;
> +}
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_list.h b/drivers/xen/hyper_dmabuf/hyper_dmabuf_list.h
> new file mode 100644
> index 0000000..869cd9a
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_list.h
> @@ -0,0 +1,40 @@
> +#ifndef __HYPER_DMABUF_LIST_H__
> +#define __HYPER_DMABUF_LIST_H__
> +
> +#include "hyper_dmabuf_struct.h"
> +
> +/* number of bits to be used for exported dmabufs hash table */
> +#define MAX_ENTRY_EXPORTED 7
> +/* number of bits to be used for imported dmabufs hash table */
> +#define MAX_ENTRY_IMPORTED 7
> +
> +struct hyper_dmabuf_info_entry_exported {
> +        struct hyper_dmabuf_sgt_info *info;
> +        struct hlist_node node;
> +};
> +
> +struct hyper_dmabuf_info_entry_imported {
> +        struct hyper_dmabuf_imported_sgt_info *info;
> +        struct hlist_node node;
> +};
> +
> +int hyper_dmabuf_table_init(void);
> +
> +int hyper_dmabuf_table_destroy(void);
> +
> +int hyper_dmabuf_register_exported(struct hyper_dmabuf_sgt_info *info);
> +
> +/* search for pre-exported sgt and return id of it if it exist */
> +int hyper_dmabuf_find_id(struct dma_buf_attachment *attach, int domid);
> +
> +int hyper_dmabuf_register_imported(struct hyper_dmabuf_imported_sgt_info* info);
> +
> +struct hyper_dmabuf_sgt_info *hyper_dmabuf_find_exported(int id);
> +
> +struct hyper_dmabuf_imported_sgt_info *hyper_dmabuf_find_imported(int id);
> +
> +int hyper_dmabuf_remove_exported(int id);
> +
> +int hyper_dmabuf_remove_imported(int id);
> +
> +#endif // __HYPER_DMABUF_LIST_H__
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.c b/drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.c
> new file mode 100644
> index 0000000..3237e50
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.c
> @@ -0,0 +1,212 @@
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/dma-buf.h>
> +#include "hyper_dmabuf_imp.h"
> +//#include "hyper_dmabuf_remote_sync.h"
> +#include "xen/hyper_dmabuf_xen_comm.h"
> +#include "hyper_dmabuf_msg.h"
> +#include "hyper_dmabuf_list.h"
> +
> +void hyper_dmabuf_create_request(struct hyper_dmabuf_ring_rq *request,
> +				        enum hyper_dmabuf_command command, int *operands)
> +{
> +	int i;
> +
> +	request->request_id = hyper_dmabuf_next_req_id_export();
> +	request->status = HYPER_DMABUF_REQ_NOT_RESPONDED;
> +	request->command = command;
> +
> +	switch(command) {
> +	/* as exporter, commands to importer */
> +	case HYPER_DMABUF_EXPORT:
> +		/* exporting pages for dmabuf */
> +		/* command : HYPER_DMABUF_EXPORT,
> +		 * operands0 : hyper_dmabuf_id
> +		 * operands1 : number of pages to be shared
> +		 * operands2 : offset of data in the first page
> +		 * operands3 : length of data in the last page
> +		 * operands4 : top-level reference number for shared pages
> +		 * operands5~8 : Driver-specific private data (e.g. graphic buffer's meta info)
> +		 */
> +		for (i=0; i < 8; i++)
> +			request->operands[i] = operands[i];
> +		break;
> +
> +	case HYPER_DMABUF_DESTROY:
> +		/* destroy sg_list for hyper_dmabuf_id on remote side */
> +		/* command : DMABUF_DESTROY,
> +		 * operands0 : hyper_dmabuf_id
> +		 */
> +		request->operands[0] = operands[0];
> +		break;
> +
> +	case HYPER_DMABUF_OPS_TO_REMOTE:
> +		/* notifying dmabuf map/unmap to importer (probably not needed) */
> +		/* for dmabuf synchronization */
> +		break;
> +
> +	/* as importer, command to exporter */
> +	case HYPER_DMABUF_OPS_TO_SOURCE:
> +		/* notifying dmabuf map/unmap to exporter, map will make the driver to do shadow mapping
> +		* or unmapping for synchronization with original exporter (e.g. i915) */
> +		/* command : DMABUF_OPS_TO_SOURCE.
> +		 * operands0 : hyper_dmabuf_id
> +		 * operands1 : map(=1)/unmap(=2)/attach(=3)/detach(=4)
> +		 */
> +		for (i=0; i<2; i++)
> +			request->operands[i] = operands[i];
> +		break;
> +
> +	/* requesting the other side to setup another ring channel for reverse direction */
> +	case HYPER_DMABUF_EXPORTER_RING_SETUP:
> +		/* command : HYPER_DMABUF_EXPORTER_RING_SETUP */
> +		/* no operands needed */
> +		break;
> +
> +	default:
> +		/* no command found */
> +		return;
> +	}
> +}
> +
> +int hyper_dmabuf_msg_parse(int domid, struct hyper_dmabuf_ring_rq *req)
> +{
> +	uint32_t i, ret;
> +	struct hyper_dmabuf_imported_sgt_info *imported_sgt_info;
> +	struct hyper_dmabuf_sgt_info *sgt_info;
> +
> +	/* make sure req is not NULL (may not be needed) */
> +	if (!req) {
> +		return -EINVAL;
> +	}
> +
> +	req->status = HYPER_DMABUF_REQ_PROCESSED;
> +
> +	switch (req->command) {
> +	case HYPER_DMABUF_EXPORT:
> +		/* exporting pages for dmabuf */
> +		/* command : HYPER_DMABUF_EXPORT,
> +		 * operands0 : hyper_dmabuf_id
> +		 * operands1 : number of pages to be shared
> +		 * operands2 : offset of data in the first page
> +		 * operands3 : length of data in the last page
> +		 * operands4 : top-level reference number for shared pages
> +		 * operands5~8 : Driver-specific private data (e.g. graphic buffer's meta info)
> +		 */
> +		imported_sgt_info = (struct hyper_dmabuf_imported_sgt_info*)kcalloc(1, sizeof(*imported_sgt_info), GFP_KERNEL);
> +		imported_sgt_info->hyper_dmabuf_id = req->operands[0];
> +		imported_sgt_info->frst_ofst = req->operands[2];
> +		imported_sgt_info->last_len = req->operands[3];
> +		imported_sgt_info->nents = req->operands[1];
> +		imported_sgt_info->gref = req->operands[4];
> +
> +		printk("DMABUF was exported\n");
> +		printk("\thyper_dmabuf_id %d\n", req->operands[0]);
> +		printk("\tnents %d\n", req->operands[1]);
> +		printk("\tfirst offset %d\n", req->operands[2]);
> +		printk("\tlast len %d\n", req->operands[3]);
> +		printk("\tgrefid %d\n", req->operands[4]);
> +
> +		for (i=0; i<4; i++)
> +			imported_sgt_info->private[i] = req->operands[5+i];
> +
> +		hyper_dmabuf_register_imported(imported_sgt_info);
> +		break;
> +
> +	case HYPER_DMABUF_DESTROY:
> +		/* destroy sg_list for hyper_dmabuf_id on remote side */
> +		/* command : DMABUF_DESTROY,
> +		 * operands0 : hyper_dmabuf_id
> +		 */
> +
> +		imported_sgt_info =
> +			hyper_dmabuf_find_imported(req->operands[0]);
> +
> +		if (imported_sgt_info) {
> +			hyper_dmabuf_cleanup_imported_pages(imported_sgt_info);
> +
> +			hyper_dmabuf_remove_imported(req->operands[0]);
> +
> +			/* TODO: cleanup sgt on importer side etc */
> +		}
> +
> +		/* Notify exporter that buffer is freed and it can cleanup it */
> +		req->status = HYPER_DMABUF_REQ_NEEDS_FOLLOW_UP;
> +		req->command = HYPER_DMABUF_DESTROY_FINISH;
> +
> +#if 0 /* function is not implemented yet */
> +
> +		ret = hyper_dmabuf_destroy_sgt(req->hyper_dmabuf_id);
> +#endif
> +		break;
> +
> +	case HYPER_DMABUF_DESTROY_FINISH:
> +		/* destroy sg_list for hyper_dmabuf_id on local side */
> +		/* command : DMABUF_DESTROY_FINISH,
> +		 * operands0 : hyper_dmabuf_id
> +		 */
> +
> +		/* TODO: that should be done on workqueue, when received ack from all importers that buffer is no longer used */
> +		sgt_info =
> +			hyper_dmabuf_find_exported(req->operands[0]);
> +
> +		if (sgt_info) {
> +			hyper_dmabuf_cleanup_gref_table(sgt_info);
> +
> +			/* unmap dmabuf */
> +			dma_buf_unmap_attachment(sgt_info->attachment, sgt_info->sgt, DMA_BIDIRECTIONAL);
> +			dma_buf_detach(sgt_info->dma_buf, sgt_info->attachment);
> +			dma_buf_put(sgt_info->dma_buf);
> +
> +			/* TODO: Rest of cleanup, sgt cleanup etc */
> +		}
> +
> +		break;
> +
> +	case HYPER_DMABUF_OPS_TO_REMOTE:
> +		/* notifying dmabuf map/unmap to importer (probably not needed) */
> +		/* for dmabuf synchronization */
> +		break;
> +
> +	/* as importer, command to exporter */
> +	case HYPER_DMABUF_OPS_TO_SOURCE:
> +		/* notifying dmabuf map/unmap to exporter, map will make the driver to do shadow mapping
> +		* or unmapping for synchronization with original exporter (e.g. i915) */
> +		/* command : DMABUF_OPS_TO_SOURCE.
> +		 * operands0 : hyper_dmabuf_id
> +		 * operands1 : map(=1)/unmap(=2)/attach(=3)/detach(=4)
> +		 */
> +		break;
> +
> +	/* requesting the other side to setup another ring channel for reverse direction */
> +	case HYPER_DMABUF_EXPORTER_RING_SETUP:
> +		/* command: HYPER_DMABUF_EXPORTER_RING_SETUP
> +		 * no operands needed */
> +		ret = hyper_dmabuf_exporter_ringbuf_init(domid, &req->operands[0], &req->operands[1]);
> +		if (ret < 0) {
> +			req->status = HYPER_DMABUF_REQ_ERROR;
> +			return -EINVAL;
> +		}
> +
> +		req->status = HYPER_DMABUF_REQ_NEEDS_FOLLOW_UP;
> +		req->command = HYPER_DMABUF_IMPORTER_RING_SETUP;
> +		break;
> +
> +	case HYPER_DMABUF_IMPORTER_RING_SETUP:
> +		/* command: HYPER_DMABUF_IMPORTER_RING_SETUP */
> +		/* no operands needed */
> +		ret = hyper_dmabuf_importer_ringbuf_init(domid, req->operands[0], req->operands[1]);
> +		if (ret < 0)
> +			return -EINVAL;
> +
> +		break;
> +
> +	default:
> +		/* no matched command, nothing to do.. just return error */
> +		return -EINVAL;
> +	}
> +
> +	return req->command;
> +}
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.h b/drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.h
> new file mode 100644
> index 0000000..44bfb70
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_msg.h
> @@ -0,0 +1,45 @@
> +#ifndef __HYPER_DMABUF_MSG_H__
> +#define __HYPER_DMABUF_MSG_H__
> +
> +enum hyper_dmabuf_command {
> +	HYPER_DMABUF_EXPORT = 0x10,
> +	HYPER_DMABUF_DESTROY,
> +	HYPER_DMABUF_DESTROY_FINISH,
> +	HYPER_DMABUF_OPS_TO_REMOTE,
> +	HYPER_DMABUF_OPS_TO_SOURCE,
> +	HYPER_DMABUF_EXPORTER_RING_SETUP, /* requesting remote domain to set up exporter's ring */
> +	HYPER_DMABUF_IMPORTER_RING_SETUP, /* requesting remote domain to set up importer's ring */
> +};
> +
> +enum hyper_dmabuf_ops {
> +	HYPER_DMABUF_OPS_ATTACH = 0x1000,
> +	HYPER_DMABUF_OPS_DETACH,
> +	HYPER_DMABUF_OPS_MAP,
> +	HYPER_DMABUF_OPS_UNMAP,
> +	HYPER_DMABUF_OPS_RELEASE,
> +	HYPER_DMABUF_OPS_BEGIN_CPU_ACCESS,
> +	HYPER_DMABUF_OPS_END_CPU_ACCESS,
> +	HYPER_DMABUF_OPS_KMAP_ATOMIC,
> +	HYPER_DMABUF_OPS_KUNMAP_ATOMIC,
> +	HYPER_DMABUF_OPS_KMAP,
> +	HYPER_DMABUF_OPS_KUNMAP,
> +	HYPER_DMABUF_OPS_MMAP,
> +	HYPER_DMABUF_OPS_VMAP,
> +	HYPER_DMABUF_OPS_VUNMAP,
> +};
> +
> +enum hyper_dmabuf_req_feedback {
> +	HYPER_DMABUF_REQ_PROCESSED = 0x100,
> +	HYPER_DMABUF_REQ_NEEDS_FOLLOW_UP,
> +	HYPER_DMABUF_REQ_ERROR,
> +	HYPER_DMABUF_REQ_NOT_RESPONDED
> +};
> +
> +/* create a request packet with given command and operands */
> +void hyper_dmabuf_create_request(struct hyper_dmabuf_ring_rq *request,
> +                                        enum hyper_dmabuf_command command, int *operands);
> +
> +/* parse incoming request packet (or response) and take appropriate actions for those */
> +int hyper_dmabuf_msg_parse(int domid, struct hyper_dmabuf_ring_rq *req);
> +
> +#endif // __HYPER_DMABUF_MSG_H__
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_query.h b/drivers/xen/hyper_dmabuf/hyper_dmabuf_query.h
> new file mode 100644
> index 0000000..a577167
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_query.h
> @@ -0,0 +1,16 @@
> +#ifndef __HYPER_DMABUF_QUERY_H__
> +#define __HYPER_DMABUF_QUERY_H__
> +
> +enum hyper_dmabuf_query {
> +	DMABUF_QUERY_TYPE_LIST = 0x10,
> +	DMABUF_QUERY_EXPORTER,
> +	DMABUF_QUERY_IMPORTER,
> +	DMABUF_QUERY_SIZE
> +};
> +
> +enum hyper_dmabuf_status {
> +	EXPORTED = 0x01,
> +	IMPORTED
> +};
> +
> +#endif /* __HYPER_DMABUF_QUERY_H__ */
> diff --git a/drivers/xen/hyper_dmabuf/hyper_dmabuf_struct.h b/drivers/xen/hyper_dmabuf/hyper_dmabuf_struct.h
> new file mode 100644
> index 0000000..c8a2f4d
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/hyper_dmabuf_struct.h
> @@ -0,0 +1,70 @@
> +#ifndef __HYPER_DMABUF_STRUCT_H__
> +#define __HYPER_DMABUF_STRUCT_H__
> +
> +#include <xen/interface/grant_table.h>
> +
> +/* Importer combine source domain id with given hyper_dmabuf_id
> + * to make it unique in case there are multiple exporters */
> +
> +#define HYPER_DMABUF_ID_IMPORTER(sdomain, id) \
> +	((((sdomain) & 0xFF) << 24) | ((id) & 0xFFFFFF))
> +
> +#define HYPER_DMABUF_ID_IMPORTER_GET_SDOMAIN_ID(id) \
> +	(((id) >> 24) & 0xFF)
> +
> +/* each grant_ref_t is 4 bytes, so total 4096 grant_ref_t can be
> + * in this block meaning we can share 4KB*4096 = 16MB of buffer
> + * (needs to be increased for large buffer use-cases such as 4K
> + * frame buffer) */
> +#define MAX_ALLOWED_NUM_PAGES_FOR_GREF_NUM_ARRAYS 4
> +
> +struct hyper_dmabuf_shared_pages_info {
> +	grant_ref_t *data_refs;	/* table with shared buffer pages refid */
> +	grant_ref_t *addr_pages; /* pages of 2nd level addressing */
> +	grant_ref_t *top_level_page; /* page of top level addressing, it contains refids of 2nd level pages */
> +	grant_ref_t top_level_ref; /* top level refid */
> +	struct gnttab_unmap_grant_ref* unmap_ops; /* unmap ops for mapped pages */
> +	struct page **data_pages; /* data pages to be unmapped */
> +};
> +
> +/* Exporter builds pages_info before sharing pages */
> +struct hyper_dmabuf_pages_info {
> +        int hyper_dmabuf_id; /* unique id to reference dmabuf in source domain */
> +        int hyper_dmabuf_rdomain; /* currenting considering just one remote domain access it */
> +        int frst_ofst; /* offset of data in the first page */
> +        int last_len; /* length of data in the last page */
> +        int nents; /* # of pages */
> +        struct page **pages; /* pages that contains reference numbers of shared pages*/
> +};
> +
> +/* Both importer and exporter use this structure to point to sg lists
> + *
> + * Exporter stores references to sgt in a hash table
> + * Exporter keeps these references for synchronization and tracking purposes
> + *
> + * Importer use this structure exporting to other drivers in the same domain */
> +struct hyper_dmabuf_sgt_info {
> +        int hyper_dmabuf_id; /* unique id to reference dmabuf in remote domain */
> +	int hyper_dmabuf_rdomain; /* domain importing this sgt */
> +        struct sg_table *sgt; /* pointer to sgt */
> +	struct dma_buf *dma_buf; /* needed to store this for freeing it later */
> +	struct dma_buf_attachment *attachment; /* needed to store this for freeing this later */
> +	struct hyper_dmabuf_shared_pages_info shared_pages_info;
> +	int private[4]; /* device specific info (e.g. image's meta info?) */
> +};
> +
> +/* Importer store references (before mapping) on shared pages
> + * Importer store these references in the table and map it in
> + * its own memory map once userspace asks for reference for the buffer */
> +struct hyper_dmabuf_imported_sgt_info {
> +	int hyper_dmabuf_id; /* unique id to reference dmabuf (HYPER_DMABUF_ID_IMPORTER(source domain id, exporter's hyper_dmabuf_id */
> +	int frst_ofst;	/* start offset in shared page #1 */
> +	int last_len;	/* length of data in the last shared page */
> +	int nents;	/* number of pages to be shared */
> +	grant_ref_t gref; /* reference number of top level addressing page of shared pages */
> +	struct sg_table *sgt; /* sgt pointer after importing buffer */
> +	struct hyper_dmabuf_shared_pages_info shared_pages_info;
> +	int private[4]; /* device specific info (e.g. image's meta info?) */
> +};
> +
> +#endif /* __HYPER_DMABUF_STRUCT_H__ */
> diff --git a/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.c b/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.c
> new file mode 100644
> index 0000000..22f2ef0
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.c
> @@ -0,0 +1,328 @@
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +#include <xen/grant_table.h>
> +#include <xen/events.h>
> +#include <xen/xenbus.h>
> +#include <asm/xen/page.h>
> +#include "hyper_dmabuf_xen_comm.h"
> +#include "hyper_dmabuf_xen_comm_list.h"
> +#include "../hyper_dmabuf_imp.h"
> +#include "../hyper_dmabuf_list.h"
> +#include "../hyper_dmabuf_msg.h"
> +
> +static int export_req_id = 0;
> +static int import_req_id = 0;
> +
> +int32_t hyper_dmabuf_get_domid(void)
> +{
> +	struct xenbus_transaction xbt;
> +	int32_t domid;
> +
> +        xenbus_transaction_start(&xbt);
> +
> +        if (!xenbus_scanf(xbt, "domid","", "%d", &domid)) {
> +		domid = -1;
> +        }
> +        xenbus_transaction_end(xbt, 0);
> +
> +	return domid;
> +}
> +
> +int hyper_dmabuf_next_req_id_export(void)
> +{
> +        export_req_id++;
> +        return export_req_id;
> +}
> +
> +int hyper_dmabuf_next_req_id_import(void)
> +{
> +        import_req_id++;
> +        return import_req_id;
> +}
> +
> +/* For now cache latast rings as global variables TODO: keep them in list*/
> +static irqreturn_t hyper_dmabuf_front_ring_isr(int irq, void *dev_id);
> +static irqreturn_t hyper_dmabuf_back_ring_isr(int irq, void *dev_id);
> +
> +/* exporter needs to generated info for page sharing */
> +int hyper_dmabuf_exporter_ringbuf_init(int rdomain, grant_ref_t *refid, int *port)
> +{
> +	struct hyper_dmabuf_ring_info_export *ring_info;
> +	struct hyper_dmabuf_sring *sring;
> +	struct evtchn_alloc_unbound alloc_unbound;
> +	struct evtchn_close close;
> +
> +	void *shared_ring;
> +	int ret;
> +
> +	ring_info = (struct hyper_dmabuf_ring_info_export*)
> +				kmalloc(sizeof(*ring_info), GFP_KERNEL);
> +
> +	/* from exporter to importer */
> +	shared_ring = (void *)__get_free_pages(GFP_KERNEL, 1);
> +	if (shared_ring == 0) {
> +		return -EINVAL;
> +	}
> +
> +	sring = (struct hyper_dmabuf_sring *) shared_ring;
> +
> +	SHARED_RING_INIT(sring);
> +
> +	FRONT_RING_INIT(&(ring_info->ring_front), sring, PAGE_SIZE);
> +
> +	ring_info->gref_ring = gnttab_grant_foreign_access(rdomain,
> +							virt_to_mfn(shared_ring), 0);
> +	if (ring_info->gref_ring < 0) {
> +		return -EINVAL; /* fail to get gref */
> +	}
> +
> +	alloc_unbound.dom = DOMID_SELF;
> +	alloc_unbound.remote_dom = rdomain;
> +	ret = HYPERVISOR_event_channel_op(EVTCHNOP_alloc_unbound, &alloc_unbound);
> +	if (ret != 0) {
> +		printk("Cannot allocate event channel\n");
> +		return -EINVAL;
> +	}
> +
> +	/* setting up interrupt */
> +	ret = bind_evtchn_to_irqhandler(alloc_unbound.port,
> +					hyper_dmabuf_front_ring_isr, 0,
> +					NULL, (void*) ring_info);
> +
> +	if (ret < 0) {
> +		printk("Failed to setup event channel\n");
> +		close.port = alloc_unbound.port;
> +		HYPERVISOR_event_channel_op(EVTCHNOP_close, &close);
> +		gnttab_end_foreign_access(ring_info->gref_ring, 0, virt_to_mfn(shared_ring));
> +		return -EINVAL;
> +	}
> +
> +	ring_info->rdomain = rdomain;
> +	ring_info->irq = ret;
> +	ring_info->port = alloc_unbound.port;
> +
> +	/* store refid and port numbers for userspace's use */
> +	*refid = ring_info->gref_ring;
> +	*port = ring_info->port;
> +
> +	printk("%s: allocated eventchannel gref %d  port: %d  irq: %d\n", __func__,
> +		ring_info->gref_ring,
> +		ring_info->port,
> +		ring_info->irq);
> +
> +	/* register ring info */
> +	ret = hyper_dmabuf_register_exporter_ring(ring_info);
> +
> +	return ret;
> +}
> +
> +/* importer needs to know about shared page and port numbers for ring buffer and event channel */
> +int hyper_dmabuf_importer_ringbuf_init(int sdomain, grant_ref_t gref, int port)
> +{
> +	struct hyper_dmabuf_ring_info_import *ring_info;
> +	struct hyper_dmabuf_sring *sring;
> +
> +	struct page *shared_ring;
> +
> +	struct gnttab_map_grant_ref *ops;
> +	struct gnttab_unmap_grant_ref *unmap_ops;
> +	int ret;
> +
> +	ring_info = (struct hyper_dmabuf_ring_info_import *)
> +			kmalloc(sizeof(*ring_info), GFP_KERNEL);
> +
> +	ring_info->sdomain = sdomain;
> +	ring_info->evtchn = port;
> +
> +	ops = (struct gnttab_map_grant_ref*)kmalloc(sizeof(*ops), GFP_KERNEL);
> +	unmap_ops = (struct gnttab_unmap_grant_ref*)kmalloc(sizeof(*unmap_ops), GFP_KERNEL);
> +
> +	if (gnttab_alloc_pages(1, &shared_ring)) {
> +		return -EINVAL;
> +	}
> +
> +	gnttab_set_map_op(&ops[0], (unsigned long)pfn_to_kaddr(page_to_pfn(shared_ring)),
> +			GNTMAP_host_map, gref, sdomain);
> +
> +	ret = gnttab_map_refs(ops, NULL, &shared_ring, 1);
> +	if (ret < 0) {
> +		printk("Cannot map ring\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ops[0].status) {
> +		printk("Ring mapping failed\n");
> +		return -EINVAL;
> +	}
> +
> +	sring = (struct hyper_dmabuf_sring*) pfn_to_kaddr(page_to_pfn(shared_ring));
> +
> +	BACK_RING_INIT(&ring_info->ring_back, sring, PAGE_SIZE);
> +
> +	ret = bind_interdomain_evtchn_to_irqhandler(sdomain, port, hyper_dmabuf_back_ring_isr, 0,
> +						    NULL, (void*)ring_info);
> +	if (ret < 0) {
> +		return -EINVAL;
> +	}
> +
> +	ring_info->irq = ret;
> +
> +	printk("%s: bound to eventchannel port: %d  irq: %d\n", __func__,
> +		port,
> +		ring_info->irq);
> +
> +	ret = hyper_dmabuf_register_importer_ring(ring_info);
> +
> +	return ret;
> +}
> +
> +int hyper_dmabuf_send_request(int domain, struct hyper_dmabuf_ring_rq *req)
> +{
> +	struct hyper_dmabuf_front_ring *ring;
> +	struct hyper_dmabuf_ring_rq *new_req;
> +	struct hyper_dmabuf_ring_info_export *ring_info;
> +	int notify;
> +
> +	/* find a ring info for the channel */
> +	ring_info = hyper_dmabuf_find_exporter_ring(domain);
> +	if (!ring_info) {
> +		printk("Can't find ring info for the channel\n");
> +		return -EINVAL;
> +	}
> +
> +	ring = &ring_info->ring_front;
> +
> +	if (RING_FULL(ring))
> +		return -EBUSY;
> +
> +	new_req = RING_GET_REQUEST(ring, ring->req_prod_pvt);
> +	if (!new_req) {
> +		printk("NULL REQUEST\n");
> +		return -EIO;
> +	}
> +
> +	memcpy(new_req, req, sizeof(*new_req));
> +
> +	ring->req_prod_pvt++;
> +
> +	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(ring, notify);
> +	if (notify) {
> +		notify_remote_via_irq(ring_info->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +/* called by interrupt (WORKQUEUE) */
> +int hyper_dmabuf_send_response(struct hyper_dmabuf_ring_rp* response, int domain)
> +{
> +	/* as a importer and as a exporter */
> +	return 0;
> +}
> +
> +/* ISR for request from exporter (as an importer) */
> +static irqreturn_t hyper_dmabuf_back_ring_isr(int irq, void *dev_id)
> +{
> +	RING_IDX rc, rp;
> +	struct hyper_dmabuf_ring_rq request;
> +	struct hyper_dmabuf_ring_rp response;
> +	int notify, more_to_do;
> +	int ret;
> +//	struct hyper_dmabuf_work *work;
> +
> +	struct hyper_dmabuf_ring_info_import *ring_info = (struct hyper_dmabuf_ring_info_import *)dev_id;
> +	struct hyper_dmabuf_back_ring *ring;
> +
> +	ring = &ring_info->ring_back;
> +
> +	do {
> +		rc = ring->req_cons;
> +		rp = ring->sring->req_prod;
> +
> +		while (rc != rp) {
> +			if (RING_REQUEST_CONS_OVERFLOW(ring, rc))
> +				break;
> +
> +			memcpy(&request, RING_GET_REQUEST(ring, rc), sizeof(request));
> +			printk("Got request\n");
> +			ring->req_cons = ++rc;
> +
> +			/* TODO: probably using linked list for multiple requests then let
> +			 * a task in a workqueue to process those is better idea becuase
> +			 * we do not want to stay in ISR for long.
> +			 */
> +			ret = hyper_dmabuf_msg_parse(ring_info->sdomain, &request);
> +
> +			if (ret > 0) {
> +				/* build response */
> +				memcpy(&response, &request, sizeof(response));
> +
> +				/* we sent back modified request as a response.. we might just need to have request only..*/
> +				memcpy(RING_GET_RESPONSE(ring, ring->rsp_prod_pvt), &response, sizeof(response));
> +				ring->rsp_prod_pvt++;
> +
> +				RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(ring, notify);
> +
> +				if (notify) {
> +					printk("Notyfing\n");
> +					notify_remote_via_irq(ring_info->irq);
> +				}
> +			}
> +
> +			RING_FINAL_CHECK_FOR_REQUESTS(ring, more_to_do);
> +			printk("Final check for requests %d\n", more_to_do);
> +		}
> +	} while (more_to_do);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* ISR for responses from importer */
> +static irqreturn_t hyper_dmabuf_front_ring_isr(int irq, void *dev_id)
> +{
> +	/* front ring only care about response from back */
> +	struct hyper_dmabuf_ring_rp *response;
> +	RING_IDX i, rp;
> +	int more_to_do, ret;
> +
> +	struct hyper_dmabuf_ring_info_export *ring_info = (struct hyper_dmabuf_ring_info_export *)dev_id;
> +	struct hyper_dmabuf_front_ring *ring;
> +	ring = &ring_info->ring_front;
> +
> +	do {
> +		more_to_do = 0;
> +		rp = ring->sring->rsp_prod;
> +		for (i = ring->rsp_cons; i != rp; i++) {
> +			unsigned long id;
> +
> +			response = RING_GET_RESPONSE(ring, i);
> +			id = response->response_id;
> +
> +			if (response->status == HYPER_DMABUF_REQ_NEEDS_FOLLOW_UP) {
> +				/* parsing response */
> +				ret = hyper_dmabuf_msg_parse(ring_info->rdomain, (struct hyper_dmabuf_ring_rq*)response);
> +
> +				if (ret < 0) {
> +					printk("getting error while parsing response\n");
> +				}
> +			} else if (response->status == HYPER_DMABUF_REQ_ERROR) {
> +				printk("remote domain %d couldn't process request %d\n", ring_info->rdomain, response->command);
> +			}
> +
> +		}
> +
> +		ring->rsp_cons = i;
> +
> +		if (i != ring->req_prod_pvt) {
> +			RING_FINAL_CHECK_FOR_RESPONSES(ring, more_to_do);
> +			printk("more to do %d\n", more_to_do);
> +		} else {
> +			ring->sring->rsp_event = i+1;
> +		}
> +	} while (more_to_do);
> +
> +	return IRQ_HANDLED;
> +}
> diff --git a/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.h b/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.h
> new file mode 100644
> index 0000000..2754917
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm.h
> @@ -0,0 +1,62 @@
> +#ifndef __HYPER_DMABUF_XEN_COMM_H__
> +#define __HYPER_DMABUF_XEN_COMM_H__
> +
> +#include "xen/interface/io/ring.h"
> +
> +#define MAX_NUMBER_OF_OPERANDS 9
> +
> +struct hyper_dmabuf_ring_rq {
> +        unsigned int request_id;
> +        unsigned int status;
> +        unsigned int command;
> +        unsigned int operands[MAX_NUMBER_OF_OPERANDS];
> +};
> +
> +struct hyper_dmabuf_ring_rp {
> +        unsigned int response_id;
> +        unsigned int status;
> +        unsigned int command;
> +        unsigned int operands[MAX_NUMBER_OF_OPERANDS];
> +};
> +
> +DEFINE_RING_TYPES(hyper_dmabuf, struct hyper_dmabuf_ring_rq, struct hyper_dmabuf_ring_rp);
> +
> +struct hyper_dmabuf_ring_info_export {
> +        struct hyper_dmabuf_front_ring ring_front;
> +	int rdomain;
> +        int gref_ring;
> +        int irq;
> +        int port;
> +};
> +
> +struct hyper_dmabuf_ring_info_import {
> +        int sdomain;
> +        int irq;
> +        int evtchn;
> +        struct hyper_dmabuf_back_ring ring_back;
> +};
> +
> +//struct hyper_dmabuf_work {
> +//	hyper_dmabuf_ring_rq requrest;
> +//	struct work_struct msg_parse;
> +//};
> +
> +int32_t hyper_dmabuf_get_domid(void);
> +
> +int hyper_dmabuf_next_req_id_export(void);
> +
> +int hyper_dmabuf_next_req_id_import(void);
> +
> +/* exporter needs to generated info for page sharing */
> +int hyper_dmabuf_exporter_ringbuf_init(int rdomain, grant_ref_t *gref, int *port);
> +
> +/* importer needs to know about shared page and port numbers for ring buffer and event channel */
> +int hyper_dmabuf_importer_ringbuf_init(int sdomain, grant_ref_t gref, int port);
> +
> +/* send request to the remote domain */
> +int hyper_dmabuf_send_request(int domain, struct hyper_dmabuf_ring_rq *req);
> +
> +/* called by interrupt (WORKQUEUE) */
> +int hyper_dmabuf_send_response(struct hyper_dmabuf_ring_rp* response, int domain);
> +
> +#endif // __HYPER_DMABUF_XEN_COMM_H__
> diff --git a/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.c b/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.c
> new file mode 100644
> index 0000000..15c9d29
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.c
> @@ -0,0 +1,106 @@
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/cdev.h>
> +#include <asm/uaccess.h>
> +#include <linux/hashtable.h>
> +#include <xen/grant_table.h>
> +#include "hyper_dmabuf_xen_comm.h"
> +#include "hyper_dmabuf_xen_comm_list.h"
> +
> +DECLARE_HASHTABLE(hyper_dmabuf_hash_importer_ring, MAX_ENTRY_IMPORT_RING);
> +DECLARE_HASHTABLE(hyper_dmabuf_hash_exporter_ring, MAX_ENTRY_EXPORT_RING);
> +
> +int hyper_dmabuf_ring_table_init()
> +{
> +	hash_init(hyper_dmabuf_hash_importer_ring);
> +	hash_init(hyper_dmabuf_hash_exporter_ring);
> +	return 0;
> +}
> +
> +int hyper_dmabuf_ring_table_destroy()
> +{
> +	/* TODO: cleanup tables*/
> +	return 0;
> +}
> +
> +int hyper_dmabuf_register_exporter_ring(struct hyper_dmabuf_ring_info_export *ring_info)
> +{
> +	struct hyper_dmabuf_exporter_ring_info *info_entry;
> +
> +	info_entry = kmalloc(sizeof(*info_entry), GFP_KERNEL);
> +
> +	info_entry->info = ring_info;
> +
> +	hash_add(hyper_dmabuf_hash_exporter_ring, &info_entry->node,
> +		info_entry->info->rdomain);
> +
> +	return 0;
> +}
> +
> +int hyper_dmabuf_register_importer_ring(struct hyper_dmabuf_ring_info_import *ring_info)
> +{
> +	struct hyper_dmabuf_importer_ring_info *info_entry;
> +
> +	info_entry = kmalloc(sizeof(*info_entry), GFP_KERNEL);
> +
> +	info_entry->info = ring_info;
> +
> +	hash_add(hyper_dmabuf_hash_importer_ring, &info_entry->node,
> +		info_entry->info->sdomain);
> +
> +	return 0;
> +}
> +
> +struct hyper_dmabuf_ring_info_export *hyper_dmabuf_find_exporter_ring(int domid)
> +{
> +	struct hyper_dmabuf_exporter_ring_info *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_exporter_ring, bkt, info_entry, node)
> +		if(info_entry->info->rdomain == domid)
> +			return info_entry->info;
> +
> +	return NULL;
> +}
> +
> +struct hyper_dmabuf_ring_info_import *hyper_dmabuf_find_importer_ring(int domid)
> +{
> +	struct hyper_dmabuf_importer_ring_info *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_importer_ring, bkt, info_entry, node)
> +		if(info_entry->info->sdomain == domid)
> +			return info_entry->info;
> +
> +	return NULL;
> +}
> +
> +int hyper_dmabuf_remove_exporter_ring(int domid)
> +{
> +	struct hyper_dmabuf_exporter_ring_info *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_exporter_ring, bkt, info_entry, node)
> +		if(info_entry->info->rdomain == domid) {
> +			hash_del(&info_entry->node);
> +			return 0;
> +		}
> +
> +	return -1;
> +}
> +
> +int hyper_dmabuf_remove_importer_ring(int domid)
> +{
> +	struct hyper_dmabuf_importer_ring_info *info_entry;
> +	int bkt;
> +
> +	hash_for_each(hyper_dmabuf_hash_importer_ring, bkt, info_entry, node)
> +		if(info_entry->info->sdomain == domid) {
> +			hash_del(&info_entry->node);
> +			return 0;
> +		}
> +
> +	return -1;
> +}
> diff --git a/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.h b/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.h
> new file mode 100644
> index 0000000..5929f99
> --- /dev/null
> +++ b/drivers/xen/hyper_dmabuf/xen/hyper_dmabuf_xen_comm_list.h
> @@ -0,0 +1,35 @@
> +#ifndef __HYPER_DMABUF_XEN_COMM_LIST_H__
> +#define __HYPER_DMABUF_XEN_COMM_LIST_H__
> +
> +/* number of bits to be used for exported dmabufs hash table */
> +#define MAX_ENTRY_EXPORT_RING 7
> +/* number of bits to be used for imported dmabufs hash table */
> +#define MAX_ENTRY_IMPORT_RING 7
> +
> +struct hyper_dmabuf_exporter_ring_info {
> +        struct hyper_dmabuf_ring_info_export *info;
> +        struct hlist_node node;
> +};
> +
> +struct hyper_dmabuf_importer_ring_info {
> +        struct hyper_dmabuf_ring_info_import *info;
> +        struct hlist_node node;
> +};
> +
> +int hyper_dmabuf_ring_table_init(void);
> +
> +int hyper_dmabuf_ring_table_destroy(void);
> +
> +int hyper_dmabuf_register_exporter_ring(struct hyper_dmabuf_ring_info_export *ring_info);
> +
> +int hyper_dmabuf_register_importer_ring(struct hyper_dmabuf_ring_info_import *ring_info);
> +
> +struct hyper_dmabuf_ring_info_export *hyper_dmabuf_find_exporter_ring(int domid);
> +
> +struct hyper_dmabuf_ring_info_import *hyper_dmabuf_find_importer_ring(int domid);
> +
> +int hyper_dmabuf_remove_exporter_ring(int domid);
> +
> +int hyper_dmabuf_remove_importer_ring(int domid);
> +
> +#endif // __HYPER_DMABUF_XEN_COMM_LIST_H__
> -- 
> 2.7.4
> 
> 
