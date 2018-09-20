Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA039ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EFB2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EFB2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbeITRrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:47:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37213 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbeITRrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:47:01 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AD0130027B1;
        Thu, 20 Sep 2018 12:03:51 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B6B1308BDAF;
        Thu, 20 Sep 2018 12:03:51 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CA7AB181A12D;
        Thu, 20 Sep 2018 12:03:50 +0000 (UTC)
Date:   Thu, 20 Sep 2018 08:03:50 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com,
        jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        riel@surriel.com, niteshnarayanlal@hotmail.com, mst@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com,
        hch@infradead.org, stefanha@redhat.com, imammedo@redhat.com,
        pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>,
        nilal@redhat.com
Message-ID: <855855433.14658336.1537445030434.JavaMail.zimbra@redhat.com>
In-Reply-To: <2721c3ee-88d1-a8e9-1f1e-ffc3eef1d1ca@redhat.com>
References: <20180831133019.27579-1-pagupta@redhat.com> <20180831133019.27579-5-pagupta@redhat.com> <2721c3ee-88d1-a8e9-1f1e-ffc3eef1d1ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: Add virtio pmem device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.181, 10.4.195.3]
Thread-Topic: qemu: Add virtio pmem device
Thread-Index: pvFmR2SdJU6kL0flOMbEz71SH/Ekfw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 20 Sep 2018 12:03:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > @@ -0,0 +1,241 @@
> > +/*
> > + * Virtio pmem device
> > + *
> > + * Copyright (C) 2018 Red Hat, Inc.
> > + * Copyright (C) 2018 Pankaj Gupta <pagupta@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "qemu/error-report.h"
> > +#include "hw/virtio/virtio-access.h"
> > +#include "hw/virtio/virtio-pmem.h"
> > +#include "hw/mem/memory-device.h"
> > +#include "block/aio.h"
> > +#include "block/thread-pool.h"
> > +
> > +typedef struct VirtIOPMEMresp {
> > +    int ret;
> > +} VirtIOPMEMResp;
> > +
> > +typedef struct VirtIODeviceRequest {
> > +    VirtQueueElement elem;
> > +    int fd;
> > +    VirtIOPMEM *pmem;
> > +    VirtIOPMEMResp resp;
> > +} VirtIODeviceRequest;
> 
> Both, response and request have to go to a linux header (and a header
> sync patch).

Sure.

> 
> Also, you are using the same request for host<->guest handling and
> internal purposes. The fd or pmem pointer definitely don't belong here.
> Use a separate struct for internal handling purposes. (passing to worker_cb)

o.k. will add another struct for internal handling.

> 
> > +
> > +static int worker_cb(void *opaque)
> > +{
> > +    VirtIODeviceRequest *req = opaque;
> > +    int err = 0;
> > +
> > +    /* flush raw backing image */
> > +    err = fsync(req->fd);
> > +    if (err != 0) {
> > +        err = EIO;
> > +    }
> > +    req->resp.ret = err;
> > +
> > +    return 0;
> > +}
> > +
> > +static void done_cb(void *opaque, int ret)
> > +{
> > +    VirtIODeviceRequest *req = opaque;
> > +    int len = iov_from_buf(req->elem.in_sg, req->elem.in_num, 0,
> > +                              &req->resp, sizeof(VirtIOPMEMResp));
> > +
> > +    /* Callbacks are serialized, so no need to use atomic ops.  */
> > +    virtqueue_push(req->pmem->rq_vq, &req->elem, len);
> > +    virtio_notify((VirtIODevice *)req->pmem, req->pmem->rq_vq);
> > +    g_free(req);
> > +}
> > +
> > +static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    VirtIODeviceRequest *req;
> > +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> > +    HostMemoryBackend *backend = MEMORY_BACKEND(pmem->memdev);
> > +    ThreadPool *pool = aio_get_thread_pool(qemu_get_aio_context());
> > +
> > +    req = virtqueue_pop(vq, sizeof(VirtIODeviceRequest));
> > +    if (!req) {
> > +        virtio_error(vdev, "virtio-pmem missing request data");
> > +        return;
> > +    }
> > +
> > +    if (req->elem.out_num < 1 || req->elem.in_num < 1) {
> > +        virtio_error(vdev, "virtio-pmem request not proper");
> > +        g_free(req);
> > +        return;
> > +    }
> > +    req->fd = memory_region_get_fd(&backend->mr);
> > +    req->pmem = pmem;
> > +    thread_pool_submit_aio(pool, worker_cb, req, done_cb, req);
> > +}
> > +
> > +static void virtio_pmem_get_config(VirtIODevice *vdev, uint8_t *config)
> > +{
> > +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> > +    struct virtio_pmem_config *pmemcfg = (struct virtio_pmem_config *)
> > config;
> > +
> > +    virtio_stq_p(vdev, &pmemcfg->start, pmem->start);
> > +    virtio_stq_p(vdev, &pmemcfg->size, pmem->size);
> > +}
> > +
> > +static uint64_t virtio_pmem_get_features(VirtIODevice *vdev, uint64_t
> > features,
> > +                                        Error **errp)
> > +{
> > +    return features;
> > +}
> > +
> > +static void virtio_pmem_realize(DeviceState *dev, Error **errp)
> > +{
> > +    VirtIODevice   *vdev   = VIRTIO_DEVICE(dev);
> > +    VirtIOPMEM     *pmem   = VIRTIO_PMEM(dev);
> > +    MachineState   *ms     = MACHINE(qdev_get_machine());
> > +    uint64_t align;
> > +    Error *local_err = NULL;
> > +    MemoryRegion *mr;
> > +
> > +    if (!pmem->memdev) {
> > +        error_setg(errp, "virtio-pmem memdev not set");
> > +        return;
> > +    }
> > +
> > +    mr  = host_memory_backend_get_memory(pmem->memdev);
> > +    align = memory_region_get_alignment(mr);
> > +    pmem->size = QEMU_ALIGN_DOWN(memory_region_size(mr), align);
> > +    pmem->start = memory_device_get_free_addr(ms, NULL, align, pmem->size,
> > +
> > &local_err);
> > +    if (local_err) {
> > +        error_setg(errp, "Can't get free address in mem device");
> > +        return;
> > +    }
> > +    memory_region_init_alias(&pmem->mr, OBJECT(pmem),
> > +                             "virtio_pmem-memory", mr, 0, pmem->size);
> > +    memory_device_plug_region(ms, &pmem->mr, pmem->start);
> > +
> > +    host_memory_backend_set_mapped(pmem->memdev, true);
> > +    virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
> > +                                          sizeof(struct
> > virtio_pmem_config));
> > +    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
> > +}
> > +
> > +static void virtio_mem_check_memdev(Object *obj, const char *name, Object
> > *val,
> > +                                    Error **errp)
> > +{
> > +    if (host_memory_backend_is_mapped(MEMORY_BACKEND(val))) {
> > +        char *path = object_get_canonical_path_component(val);
> > +        error_setg(errp, "Can't use already busy memdev: %s", path);
> > +        g_free(path);
> > +        return;
> > +    }
> > +
> > +    qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
> > +}
> > +
> > +static const char *virtio_pmem_get_device_id(VirtIOPMEM *vm)
> > +{
> > +    Object *obj = OBJECT(vm);
> > +    DeviceState *parent_dev;
> > +
> > +    /* always use the ID of the proxy device */
> > +    if (obj->parent && object_dynamic_cast(obj->parent, TYPE_DEVICE)) {
> > +        parent_dev = DEVICE(obj->parent);
> > +        return parent_dev->id;
> > +    }
> > +    return NULL;
> > +}
> > +
> > +static void virtio_pmem_md_fill_device_info(const MemoryDeviceState *md,
> > +                                           MemoryDeviceInfo *info)
> > +{
> > +    VirtioPMemDeviceInfo *vi = g_new0(VirtioPMemDeviceInfo, 1);
> > +    VirtIOPMEM *vm = VIRTIO_PMEM(md);
> > +    const char *id = virtio_pmem_get_device_id(vm);
> > +
> > +    if (id) {
> > +        vi->has_id = true;
> > +        vi->id = g_strdup(id);
> > +    }
> > +
> > +    vi->start = vm->start;
> > +    vi->size = vm->size;
> > +    vi->memdev = object_get_canonical_path(OBJECT(vm->memdev));
> > +
> > +    info->u.virtio_pmem.data = vi;
> > +    info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM;
> > +}
> > +
> > +static uint64_t virtio_pmem_md_get_addr(const MemoryDeviceState *md)
> > +{
> > +    VirtIOPMEM *vm = VIRTIO_PMEM(md);
> > +
> > +    return vm->start;
> > +}
> > +
> > +static uint64_t virtio_pmem_md_get_plugged_size(const MemoryDeviceState
> > *md)
> > +{
> > +    VirtIOPMEM *vm = VIRTIO_PMEM(md);
> > +
> > +    return vm->size;
> > +}
> > +
> > +static uint64_t virtio_pmem_md_get_region_size(const MemoryDeviceState
> > *md)
> > +{
> > +    VirtIOPMEM *vm = VIRTIO_PMEM(md);
> > +
> > +    return vm->size;
> > +}
> > +
> > +static void virtio_pmem_instance_init(Object *obj)
> > +{
> > +    VirtIOPMEM *vm = VIRTIO_PMEM(obj);
> > +    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
> > +                                (Object **)&vm->memdev,
> > +                                (void *) virtio_mem_check_memdev,
> > +                                OBJ_PROP_LINK_STRONG,
> > +                                &error_abort);
> > +}
> > +
> > +
> > +static void virtio_pmem_class_init(ObjectClass *klass, void *data)
> > +{
> > +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> > +    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
> > +
> > +    vdc->realize      =  virtio_pmem_realize;
> > +    vdc->get_config   =  virtio_pmem_get_config;
> > +    vdc->get_features =  virtio_pmem_get_features;
> > +
> > +    mdc->get_addr         = virtio_pmem_md_get_addr;
> > +    mdc->get_plugged_size = virtio_pmem_md_get_plugged_size;
> > +    mdc->get_region_size  = virtio_pmem_md_get_region_size;
> > +    mdc->fill_device_info = virtio_pmem_md_fill_device_info;
> > +}
> > +
> > +static TypeInfo virtio_pmem_info = {
> > +    .name          = TYPE_VIRTIO_PMEM,
> > +    .parent        = TYPE_VIRTIO_DEVICE,
> > +    .class_init    = virtio_pmem_class_init,
> > +    .instance_size = sizeof(VirtIOPMEM),
> > +    .instance_init = virtio_pmem_instance_init,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        { TYPE_MEMORY_DEVICE },
> > +        { }
> > +  },
> > +};
> > +
> > +static void virtio_register_types(void)
> > +{
> > +    type_register_static(&virtio_pmem_info);
> > +}
> > +
> > +type_init(virtio_register_types)
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 990d6fcbde..28829b6437 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -85,6 +85,7 @@ extern bool pci_available;
> >  #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
> >  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
> >  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> > +#define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
> >  
> >  #define PCI_VENDOR_ID_REDHAT             0x1b36
> >  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> > diff --git a/include/hw/virtio/virtio-pmem.h
> > b/include/hw/virtio/virtio-pmem.h
> > new file mode 100644
> > index 0000000000..fda3ee691c
> > --- /dev/null
> > +++ b/include/hw/virtio/virtio-pmem.h
> > @@ -0,0 +1,42 @@
> > +/*
> > + * Virtio pmem Device
> > + *
> > + * Copyright Red Hat, Inc. 2018
> > + * Copyright Pankaj Gupta <pagupta@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#ifndef QEMU_VIRTIO_PMEM_H
> > +#define QEMU_VIRTIO_PMEM_H
> > +
> > +#include "hw/virtio/virtio.h"
> > +#include "exec/memory.h"
> > +#include "sysemu/hostmem.h"
> > +#include "standard-headers/linux/virtio_ids.h"
> > +#include "hw/boards.h"
> > +#include "hw/i386/pc.h"
> > +
> > +#define TYPE_VIRTIO_PMEM "virtio-pmem"
> > +
> > +#define VIRTIO_PMEM(obj) \
> > +        OBJECT_CHECK(VirtIOPMEM, (obj), TYPE_VIRTIO_PMEM)
> > +
> > +/* VirtIOPMEM device structure */
> > +typedef struct VirtIOPMEM {
> > +    VirtIODevice parent_obj;
> > +
> > +    VirtQueue *rq_vq;
> > +    uint64_t start;
> > +    uint64_t size;
> > +    MemoryRegion mr;
> > +    HostMemoryBackend *memdev;
> > +} VirtIOPMEM;
> > +
> > +struct virtio_pmem_config {
> > +    uint64_t start;
> > +    uint64_t size;
> > +};
> > +#endif
> > diff --git a/include/standard-headers/linux/virtio_ids.h
> > b/include/standard-headers/linux/virtio_ids.h
> > index 6d5c3b2d4f..346389565a 100644
> > --- a/include/standard-headers/linux/virtio_ids.h
> > +++ b/include/standard-headers/linux/virtio_ids.h
> > @@ -43,5 +43,6 @@
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > +#define VIRTIO_ID_PMEM         25 /* virtio pmem */
> 
> This should be moved to a linux header sync patch.

Sure.

Thanks,
Pankaj
> 
> 
> 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
> 
