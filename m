Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeDEL0f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:26:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751249AbeDEL0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:26:33 -0400
Subject: Re: [RFC] qemu: Add virtio pmem device
To: Pankaj Gupta <pagupta@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com,
        xiaoguangrong.eric@gmail.com, hch@infradead.org, marcel@redhat.com,
        mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com
References: <20180405104834.10457-1-pagupta@redhat.com>
 <20180405104834.10457-4-pagupta@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ad08ca09-71ee-08d5-3479-8b3d06380a03@redhat.com>
Date: Thu, 5 Apr 2018 13:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180405104834.10457-4-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2018 12:48, Pankaj Gupta wrote:
>  This patch adds virtio-pmem Qemu device.
> 
>  This device configures memory address range information with file
>  backend type. It acts like persistent memory device for KVM guest.
>  It presents the memory address range to virtio-pmem driver over
>  virtio channel and does the block flush whenever there is request
>  from guest to flush/sync. (Qemu part for backing file flush
>  is yet to be implemented).
> 
>  Current code is a RFC to support guest with persistent memory 
>  range & DAX. 
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  hw/virtio/Makefile.objs                     |   2 +-
>  hw/virtio/virtio-pci.c                      |  44 +++++++++
>  hw/virtio/virtio-pci.h                      |  14 +++
>  hw/virtio/virtio-pmem.c                     | 133 ++++++++++++++++++++++++++++
>  include/hw/pci/pci.h                        |   1 +
>  include/hw/virtio/virtio-pmem.h             |  43 +++++++++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  7 files changed, 237 insertions(+), 1 deletion(-)
>  create mode 100644 hw/virtio/virtio-pmem.c
>  create mode 100644 include/hw/virtio/virtio-pmem.h
> 
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 765d363c1f..bb5573d2ef 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -5,7 +5,7 @@ common-obj-y += virtio-bus.o
>  common-obj-y += virtio-mmio.o
>  
>  obj-y += virtio.o virtio-balloon.o 
> -obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
> +obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o virtio-pmem.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
>  obj-y += virtio-crypto.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c20537f31d..114ca05497 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2491,6 +2491,49 @@ static const TypeInfo virtio_rng_pci_info = {
>      .class_init    = virtio_rng_pci_class_init,
>  };
>  
> +/* virtio-pmem-pci */
> +
> +static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOPMEMPCI *vpmem = VIRTIO_PMEM_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&vpmem->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void virtio_pmem_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +    k->realize = virtio_pmem_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_PMEM;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
> +}
> +
> +static void virtio_pmem_pci_instance_init(Object *obj)
> +{
> +    VirtIOPMEMPCI *dev = VIRTIO_PMEM_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_PMEM);
> +    object_property_add_alias(obj, "memdev", OBJECT(&dev->vdev), "memdev",
> +                              &error_abort);
> +}
> +
> +static const TypeInfo virtio_pmem_pci_info = {
> +    .name          = TYPE_VIRTIO_PMEM_PCI,
> +    .parent        = TYPE_VIRTIO_PCI,
> +    .instance_size = sizeof(VirtIOPMEMPCI),
> +    .instance_init = virtio_pmem_pci_instance_init,
> +    .class_init    = virtio_pmem_pci_class_init,
> +};
> +
> +
>  /* virtio-input-pci */
>  
>  static Property virtio_input_pci_properties[] = {
> @@ -2683,6 +2726,7 @@ static void virtio_pci_register_types(void)
>      type_register_static(&virtio_balloon_pci_info);
>      type_register_static(&virtio_serial_pci_info);
>      type_register_static(&virtio_net_pci_info);
> +    type_register_static(&virtio_pmem_pci_info);
>  #ifdef CONFIG_VHOST_SCSI
>      type_register_static(&vhost_scsi_pci_info);
>  #endif
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 813082b0d7..fe74fcad3f 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -19,6 +19,7 @@
>  #include "hw/virtio/virtio-blk.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-rng.h"
> +#include "hw/virtio/virtio-pmem.h"
>  #include "hw/virtio/virtio-serial.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/virtio-balloon.h"
> @@ -57,6 +58,7 @@ typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>  typedef struct VirtIOGPUPCI VirtIOGPUPCI;
>  typedef struct VHostVSockPCI VHostVSockPCI;
>  typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
> +typedef struct VirtIOPMEMPCI VirtIOPMEMPCI;
>  
>  /* virtio-pci-bus */
>  
> @@ -274,6 +276,18 @@ struct VirtIOBlkPCI {
>      VirtIOBlock vdev;
>  };
>  
> +/*
> + * virtio-pmem-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_PMEM_PCI "virtio-pmem-pci"
> +#define VIRTIO_PMEM_PCI(obj) \
> +        OBJECT_CHECK(VirtIOPMEMPCI, (obj), TYPE_VIRTIO_PMEM_PCI)
> +
> +struct VirtIOPMEMPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOPMEM vdev;
> +};
> +
>  /*
>   * virtio-balloon-pci: This extends VirtioPCIProxy.
>   */
> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> new file mode 100644
> index 0000000000..28d06fc501
> --- /dev/null
> +++ b/hw/virtio/virtio-pmem.c
> @@ -0,0 +1,133 @@
> +/*
> + * Virtio pmem device
> + *
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "hw/virtio/virtio-pmem.h"
> +
> +
> +static void virtio_pmem_system_reset(void *opaque)
> +{
> +
> +}
> +
> +static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem;
> +
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!elem) {
> +        return;
> +    }
> +    /* todo flush raw file */
> +
> +    virtio_notify(vdev, vq);
> +    g_free(elem);
> +
> +}
> +
> +static void virtio_pmem_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> +    struct virtio_pmem_config *pmemcfg = (struct virtio_pmem_config *) config;
> +
> +    pmemcfg->start = pmem->start;
> +    pmemcfg->size  = pmem->size;
> +    pmemcfg->align = pmem->align;
> +}
> +
> +static uint64_t virtio_pmem_get_features(VirtIODevice *vdev, uint64_t features,
> +                                        Error **errp)
> +{
> +    virtio_add_feature(&features, VIRTIO_PMEM_PLUG);
> +    return features;
> +}
> +
> +
> +static void virtio_pmem_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice   *vdev   = VIRTIO_DEVICE(dev);
> +    VirtIOPMEM     *pmem   = VIRTIO_PMEM(dev);
> +    MachineState   *ms     = MACHINE(qdev_get_machine());
> +    MemoryRegion   *mr;
> +    PCMachineState *pcms   = PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
> +    uint64_t addr;
> +
> +    if (!pmem->memdev) {
> +        error_setg(errp, "virtio-pmem not set");
> +        return;
> +    }
> +
> +    mr               = host_memory_backend_get_memory(pmem->memdev, errp);
> +    addr             = pcms->hotplug_memory.base;
> +    pmem->start      = addr;
> +    pmem->size       = memory_region_size(mr);
> +    pmem->align      = memory_region_get_alignment(mr);
> +
> +    memory_region_init_alias(&pmem->mr, OBJECT(ms),
> +                             "virtio_pmem-memory", mr, 0, pmem->size);
> +
> +    host_memory_backend_set_mapped(pmem->memdev, true);
> +    virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
> +                sizeof(struct virtio_pmem_config));
> +
> +    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
> +    qemu_register_reset(virtio_pmem_system_reset, pmem);


So right now you're just using some memdev for testing.

I assume that the memory region we will provide to the guest will be a
simple memory mapped raw file. Dirty tracking (using the kvm slot) will
be used to detect which blocks actually changed and have to be flushed
to disk.

Will this raw file already have the "disk information header" (no idea
how that stuff is called) encoded? Are there any plans/possible ways to

a) automatically create the headers? (if that's even possible)
b) support anything but raw files?

Please note that under x86, a KVM memory slot still has a (in my
opinion) fairly big overhead depending on the size of the slot (rmap,
page_track). We might have to optimize that.

-- 

Thanks,

David / dhildenb
