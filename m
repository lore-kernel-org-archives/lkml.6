Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeDJCxI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:53:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751954AbeDJCxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:53:05 -0400
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        alex.williamson@redhat.com, ddutile@redhat.com,
        alexander.h.duyck@intel.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, jianfeng.tan@intel.com, xiao.w.wang@intel.com
References: <20180402152330.4158-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
Date: Tue, 10 Apr 2018 10:52:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402152330.4158-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月02日 23:23, Tiwei Bie wrote:
> This patch introduces a mdev (mediated device) based hardware
> vhost backend. This backend is an abstraction of the various
> hardware vhost accelerators (potentially any device that uses
> virtio ring can be used as a vhost accelerator). Some generic
> mdev parent ops are provided for accelerator drivers to support
> generating mdev instances.
>
> What's this
> ===========
>
> The idea is that we can setup a virtio ring compatible device
> with the messages available at the vhost-backend. Originally,
> these messages are used to implement a software vhost backend,
> but now we will use these messages to setup a virtio ring
> compatible hardware device. Then the hardware device will be
> able to work with the guest virtio driver in the VM just like
> what the software backend does. That is to say, we can implement
> a hardware based vhost backend in QEMU, and any virtio ring
> compatible devices potentially can be used with this backend.
> (We also call it vDPA -- vhost Data Path Acceleration).
>
> One problem is that, different virtio ring compatible devices
> may have different device interfaces. That is to say, we will
> need different drivers in QEMU. It could be troublesome. And
> that's what this patch trying to fix. The idea behind this
> patch is very simple: mdev is a standard way to emulate device
> in kernel.

So you just move the abstraction layer from qemu to kernel, and you 
still need different drivers in kernel for different device interfaces 
of accelerators. This looks even more complex than leaving it in qemu. 
As you said, another idea is to implement userspace vhost backend for 
accelerators which seems easier and could co-work with other parts of 
qemu without inventing new type of messages.

Need careful thought here to seek a best solution here.

>   So we defined a standard device based on mdev, which
> is able to accept vhost messages. When the mdev emulation code
> (i.e. the generic mdev parent ops provided by this patch) gets
> vhost messages, it will parse and deliver them to accelerator
> drivers. Drivers can use these messages to setup accelerators.
>
> That is to say, the generic mdev parent ops (e.g. read()/write()/
> ioctl()/...) will be provided for accelerator drivers to register
> accelerators as mdev parent devices. And each accelerator device
> will support generating standard mdev instance(s).
>
> With this standard device interface, we will be able to just
> develop one userspace driver to implement the hardware based
> vhost backend in QEMU.
>
> Difference between vDPA and PCI passthru
> ========================================
>
> The key difference between vDPA and PCI passthru is that, in
> vDPA only the data path of the device (e.g. DMA ring, notify
> region and queue interrupt) is pass-throughed to the VM, the
> device control path (e.g. PCI configuration space and MMIO
> regions) is still defined and emulated by QEMU.
>
> The benefits of keeping virtio device emulation in QEMU compared
> with virtio device PCI passthru include (but not limit to):
>
> - consistent device interface for guest OS in the VM;
> - max flexibility on the hardware design, especially the
>    accelerator for each vhost backend doesn't have to be a
>    full PCI device;
> - leveraging the existing virtio live-migration framework;
>
> The interface of this mdev based device
> =======================================
>
> 1. BAR0
>
> The MMIO region described by BAR0 is the main control
> interface. Messages will be written to or read from
> this region.
>
> The message type is determined by the `request` field
> in message header. The message size is encoded in the
> message header too. The message format looks like this:
>
> struct vhost_vfio_op {
> 	__u64 request;
> 	__u32 flags;
> 	/* Flag values: */
> #define VHOST_VFIO_NEED_REPLY 0x1 /* Whether need reply */
> 	__u32 size;
> 	union {
> 		__u64 u64;
> 		struct vhost_vring_state state;
> 		struct vhost_vring_addr addr;
> 		struct vhost_memory memory;
> 	} payload;
> };
>
> The existing vhost-kernel ioctl cmds are reused as
> the message requests in above structure.
>
> Each message will be written to or read from this
> region at offset 0:
>
> int vhost_vfio_write(struct vhost_dev *dev, struct vhost_vfio_op *op)
> {
> 	int count = VHOST_VFIO_OP_HDR_SIZE + op->size;
> 	struct vhost_vfio *vfio = dev->opaque;
> 	int ret;
>
> 	ret = pwrite64(vfio->device_fd, op, count, vfio->bar0_offset);
> 	if (ret != count)
> 		return -1;
>
> 	return 0;
> }
>
> int vhost_vfio_read(struct vhost_dev *dev, struct vhost_vfio_op *op)
> {
> 	int count = VHOST_VFIO_OP_HDR_SIZE + op->size;
> 	struct vhost_vfio *vfio = dev->opaque;
> 	uint64_t request = op->request;
> 	int ret;
>
> 	ret = pread64(vfio->device_fd, op, count, vfio->bar0_offset);
> 	if (ret != count || request != op->request)
> 		return -1;
>
> 	return 0;
> }
>
> It's quite straightforward to set things to the device.
> Just need to write the message to device directly:
>
> int vhost_vfio_set_features(struct vhost_dev *dev, uint64_t features)
> {
> 	struct vhost_vfio_op op;
>
> 	op.request = VHOST_SET_FEATURES;
> 	op.flags = 0;
> 	op.size = sizeof(features);
> 	op.payload.u64 = features;
>
> 	return vhost_vfio_write(dev, &op);
> }
>
> To get things from the device, two steps are needed.
> Take VHOST_GET_FEATURE as an example:
>
> int vhost_vfio_get_features(struct vhost_dev *dev, uint64_t *features)
> {
> 	struct vhost_vfio_op op;
> 	int ret;
>
> 	op.request = VHOST_GET_FEATURES;
> 	op.flags = VHOST_VFIO_NEED_REPLY;
> 	op.size = 0;
>
> 	/* Just need to write the header */
> 	ret = vhost_vfio_write(dev, &op);
> 	if (ret != 0)
> 		goto out;
>
> 	/* `op` wasn't changed during write */
> 	op.flags = 0;
> 	op.size = sizeof(*features);
>
> 	ret = vhost_vfio_read(dev, &op);
> 	if (ret != 0)
> 		goto out;
>
> 	*features = op.payload.u64;
> out:
> 	return ret;
> }
>
> 2. BAR1 (mmap-able)
>
> The MMIO region described by BAR1 will be used to notify the
> device.
>
> Each queue will has a page for notification, and it can be
> mapped to VM (if hardware also supports), and the virtio
> driver in the VM will be able to notify the device directly.
>
> The MMIO region described by BAR1 is also write-able. If the
> accelerator's notification register(s) cannot be mapped to the
> VM, write() can also be used to notify the device. Something
> like this:
>
> void notify_relay(void *opaque)
> {
> 	......
> 	offset = 0x1000 * queue_idx; /* XXX assume page size is 4K here. */
>
> 	ret = pwrite64(vfio->device_fd, &queue_idx, sizeof(queue_idx),
> 			vfio->bar1_offset + offset);
> 	......
> }
>
> Other BARs are reserved.
>
> 3. VFIO interrupt ioctl API
>
> VFIO interrupt ioctl API is used to setup device interrupts.
> IRQ-bypass will also be supported.
>
> Currently, only VFIO_PCI_MSIX_IRQ_INDEX is supported.
>
> The API for drivers to provide mdev instances
> =============================================
>
> The read()/write()/ioctl()/mmap()/open()/release() mdev
> parent ops have been provided for accelerators' drivers
> to provide mdev instances.
>
> ssize_t vdpa_read(struct mdev_device *mdev, char __user *buf,
> 		  size_t count, loff_t *ppos);
> ssize_t vdpa_write(struct mdev_device *mdev, const char __user *buf,
> 		   size_t count, loff_t *ppos);
> long vdpa_ioctl(struct mdev_device *mdev, unsigned int cmd, unsigned long arg);
> int vdpa_mmap(struct mdev_device *mdev, struct vm_area_struct *vma);
> int vdpa_open(struct mdev_device *mdev);
> void vdpa_close(struct mdev_device *mdev);
>
> Each accelerator driver just needs to implement its own
> create()/remove() ops, and provide a vdpa device ops
> which will be called by the generic mdev emulation code.
>
> Currently, the vdpa device ops are defined as:
>
> typedef int (*vdpa_start_device_t)(struct vdpa_dev *vdpa);
> typedef int (*vdpa_stop_device_t)(struct vdpa_dev *vdpa);
> typedef int (*vdpa_dma_map_t)(struct vdpa_dev *vdpa);
> typedef int (*vdpa_dma_unmap_t)(struct vdpa_dev *vdpa);
> typedef int (*vdpa_set_eventfd_t)(struct vdpa_dev *vdpa, int vector, int fd);
> typedef u64 (*vdpa_supported_features_t)(struct vdpa_dev *vdpa);
> typedef void (*vdpa_notify_device_t)(struct vdpa_dev *vdpa, int qid);
> typedef u64 (*vdpa_get_notify_addr_t)(struct vdpa_dev *vdpa, int qid);
>
> struct vdpa_device_ops {
> 	vdpa_start_device_t		start;
> 	vdpa_stop_device_t		stop;
> 	vdpa_dma_map_t			dma_map;
> 	vdpa_dma_unmap_t		dma_unmap;
> 	vdpa_set_eventfd_t		set_eventfd;
> 	vdpa_supported_features_t	supported_features;
> 	vdpa_notify_device_t		notify;
> 	vdpa_get_notify_addr_t		get_notify_addr;
> };
>
> struct vdpa_dev {
> 	struct mdev_device *mdev;
> 	struct mutex ops_lock;
> 	u8 vconfig[VDPA_CONFIG_SIZE];
> 	int nr_vring;
> 	u64 features;
> 	u64 state;
> 	struct vhost_memory *mem_table;
> 	bool pending_reply;
> 	struct vhost_vfio_op pending;
> 	const struct vdpa_device_ops *ops;
> 	void *private;
> 	int max_vrings;
> 	struct vdpa_vring_info vring_info[0];
> };
>
> struct vdpa_dev *vdpa_alloc(struct mdev_device *mdev, void *private,
> 			    int max_vrings);
> void vdpa_free(struct vdpa_dev *vdpa);
>
> A simple example
> ================
>
> # Query the number of available mdev instances
> $ cat /sys/class/mdev_bus/0000:06:00.2/mdev_supported_types/ifcvf_vdpa-vdpa_virtio/available_instances
>
> # Create a mdev instance
> $ echo $UUID > /sys/class/mdev_bus/0000:06:00.2/mdev_supported_types/ifcvf_vdpa-vdpa_virtio/create
>
> # Launch QEMU with a virtio-net device
> $ qemu \
> 	...... \
> 	-netdev type=vhost-vfio,sysfsdev=/sys/bus/mdev/devices/$UUID,id=$ID \
> 	-device virtio-net-pci,netdev=$ID
>
> -------- END --------
>
> Most of above words will be refined and moved to a doc in
> the formal patch. In this RFC, all introductions and code
> are gathered in this patch, the idea is to make it easier
> to find all the relevant information. Anyone who wants to
> comment could use inline comment and just keep the relevant
> parts. Sorry for the big RFC patch..
>
> This patch is just a RFC for now, and something is still
> missing or needs to be refined. But it's never too early
> to hear the thoughts from the community. So any comments
> would be appreciated! Thanks! :-)

I don't see vhost_vfio_write() and other above functions in the patch. 
Looks like some part of the patch is missed, it would be better to post 
a complete series with an example driver (vDPA) to get a full picture.

Thanks

> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>   drivers/vhost/Makefile     |   3 +
>   drivers/vhost/vdpa.c       | 805 +++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/vdpa_mdev.h  |  76 +++++
>   include/uapi/linux/vhost.h |  26 ++
>   4 files changed, 910 insertions(+)
>   create mode 100644 drivers/vhost/vdpa.c
>   create mode 100644 include/linux/vdpa_mdev.h
>
> diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> index 6c6df24f770c..7d185e083140 100644
> --- a/drivers/vhost/Makefile
> +++ b/drivers/vhost/Makefile
> @@ -11,3 +11,6 @@ vhost_vsock-y := vsock.o
>   obj-$(CONFIG_VHOST_RING) += vringh.o
>   
>   obj-$(CONFIG_VHOST)	+= vhost.o
> +
> +obj-m += vhost_vdpa.o  # FIXME: add an option
> +vhost_vdpa-y := vdpa.o
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> new file mode 100644
> index 000000000000..aa19c266ea19
> --- /dev/null
> +++ b/drivers/vhost/vdpa.c
> @@ -0,0 +1,805 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Intel Corporation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/vfio.h>
> +#include <linux/vhost.h>
> +#include <linux/mdev.h>
> +#include <linux/vdpa_mdev.h>
> +
> +#define VDPA_BAR0_SIZE		0x1000000 // TBD
> +
> +#define VDPA_VFIO_PCI_OFFSET_SHIFT	40
> +#define VDPA_VFIO_PCI_OFFSET_MASK \
> +		((1ULL << VDPA_VFIO_PCI_OFFSET_SHIFT) - 1)
> +#define VDPA_VFIO_PCI_OFFSET_TO_INDEX(offset) \
> +		((offset) >> VDPA_VFIO_PCI_OFFSET_SHIFT)
> +#define VDPA_VFIO_PCI_INDEX_TO_OFFSET(index) \
> +		((u64)(index) << VDPA_VFIO_PCI_OFFSET_SHIFT)
> +#define VDPA_VFIO_PCI_BAR_OFFSET(offset) \
> +		((offset) & VDPA_VFIO_PCI_OFFSET_MASK)
> +
> +#define STORE_LE16(addr, val)	(*(u16 *)(addr) = cpu_to_le16(val))
> +#define STORE_LE32(addr, val)	(*(u32 *)(addr) = cpu_to_le32(val))
> +
> +static void vdpa_create_config_space(struct vdpa_dev *vdpa)
> +{
> +	/* PCI device ID / vendor ID */
> +	STORE_LE32(&vdpa->vconfig[0x0], 0xffffffff); // FIXME TBD
> +
> +	/* Programming interface class */
> +	vdpa->vconfig[0x9] = 0x00;
> +
> +	/* Sub class */
> +	vdpa->vconfig[0xa] = 0x00;
> +
> +	/* Base class */
> +	vdpa->vconfig[0xb] = 0x02;
> +
> +	// FIXME TBD
> +}
> +
> +struct vdpa_dev *vdpa_alloc(struct mdev_device *mdev, void *private,
> +			    int max_vrings)
> +{
> +	struct vdpa_dev *vdpa;
> +	size_t size;
> +
> +	size = sizeof(struct vdpa_dev) + max_vrings *
> +			sizeof(struct vdpa_vring_info);
> +
> +	vdpa = kzalloc(size, GFP_KERNEL);
> +	if (vdpa == NULL)
> +		return NULL;
> +
> +	mutex_init(&vdpa->ops_lock);
> +
> +	vdpa->mdev = mdev;
> +	vdpa->private = private;
> +	vdpa->max_vrings = max_vrings;
> +
> +	vdpa_create_config_space(vdpa);
> +
> +	return vdpa;
> +}
> +EXPORT_SYMBOL(vdpa_alloc);
> +
> +void vdpa_free(struct vdpa_dev *vdpa)
> +{
> +	struct mdev_device *mdev;
> +
> +	mdev = vdpa->mdev;
> +
> +	vdpa->ops->stop(vdpa);
> +	vdpa->ops->dma_unmap(vdpa);
> +
> +	mdev_set_drvdata(mdev, NULL);
> +
> +	mutex_destroy(&vdpa->ops_lock);
> +
> +	kfree(vdpa->mem_table);
> +	kfree(vdpa);
> +}
> +EXPORT_SYMBOL(vdpa_free);
> +
> +static ssize_t vdpa_handle_pcicfg_read(struct mdev_device *mdev,
> +		char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct vdpa_dev *vdpa;
> +	loff_t pos = *ppos;
> +	loff_t offset;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	offset = VDPA_VFIO_PCI_BAR_OFFSET(pos);
> +
> +	if (count + offset > VDPA_CONFIG_SIZE)
> +		return -EINVAL;
> +
> +	if (copy_to_user(buf, (vdpa->vconfig + offset), count))
> +		return -EFAULT;
> +
> +	return count;
> +}
> +
> +static ssize_t vdpa_handle_bar0_read(struct mdev_device *mdev,
> +		char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct vdpa_dev *vdpa;
> +	struct vhost_vfio_op *op = NULL;
> +	loff_t pos = *ppos;
> +	loff_t offset;
> +	int ret;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	offset = VDPA_VFIO_PCI_BAR_OFFSET(pos);
> +	if (offset != 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!vdpa->pending_reply) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	vdpa->pending_reply = false;
> +
> +	op = kzalloc(VHOST_VFIO_OP_HDR_SIZE + VHOST_VFIO_OP_PAYLOAD_MAX_SIZE,
> +		     GFP_KERNEL);
> +	if (op == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	op->request = vdpa->pending.request;
> +
> +	switch (op->request) {
> +	case VHOST_GET_VRING_BASE:
> +		op->payload.state = vdpa->pending.payload.state;
> +		op->size = sizeof(op->payload.state);
> +		break;
> +	case VHOST_GET_FEATURES:
> +		op->payload.u64 = vdpa->pending.payload.u64;
> +		op->size = sizeof(op->payload.u64);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	if (op->size + VHOST_VFIO_OP_HDR_SIZE != count) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	if (copy_to_user(buf, op, count)) {
> +		ret = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	ret = count;
> +
> +out_free:
> +	kfree(op);
> +out:
> +	return ret;
> +}
> +
> +ssize_t vdpa_read(struct mdev_device *mdev, char __user *buf,
> +		  size_t count, loff_t *ppos)
> +{
> +	int done = 0;
> +	unsigned int index;
> +	loff_t pos = *ppos;
> +	struct vdpa_dev *vdpa;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	mutex_lock(&vdpa->ops_lock);
> +
> +	index = VDPA_VFIO_PCI_OFFSET_TO_INDEX(pos);
> +
> +	switch (index) {
> +	case VFIO_PCI_CONFIG_REGION_INDEX:
> +		done = vdpa_handle_pcicfg_read(mdev, buf, count, ppos);
> +		break;
> +	case VFIO_PCI_BAR0_REGION_INDEX:
> +		done = vdpa_handle_bar0_read(mdev, buf, count, ppos);
> +		break;
> +	}
> +
> +	if (done > 0)
> +		*ppos += done;
> +
> +	mutex_unlock(&vdpa->ops_lock);
> +
> +	return done;
> +}
> +EXPORT_SYMBOL(vdpa_read);
> +
> +static ssize_t vdpa_handle_pcicfg_write(struct mdev_device *mdev,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	return count;
> +}
> +
> +static int vhost_set_mem_table(struct mdev_device *mdev,
> +		struct vhost_memory *mem)
> +{
> +	struct vdpa_dev *vdpa;
> +	struct vhost_memory *mem_table;
> +	size_t size;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	// FIXME fix this
> +	if (vdpa->state != VHOST_DEVICE_S_STOPPED)
> +		return -EBUSY;
> +
> +	size = sizeof(*mem) + mem->nregions * sizeof(*mem->regions);
> +
> +	mem_table = kzalloc(size, GFP_KERNEL);
> +	if (mem_table == NULL)
> +		return -ENOMEM;
> +
> +	memcpy(mem_table, mem, size);
> +
> +	kfree(vdpa->mem_table);
> +
> +	vdpa->mem_table = mem_table;
> +
> +	vdpa->ops->dma_unmap(vdpa);
> +	vdpa->ops->dma_map(vdpa);
> +
> +	return 0;
> +}
> +
> +static int vhost_set_vring_addr(struct mdev_device *mdev,
> +		struct vhost_vring_addr *addr)
> +{
> +	struct vdpa_dev *vdpa;
> +	int qid = addr->index;
> +	struct vdpa_vring_info *vring;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	if (qid >= vdpa->max_vrings)
> +		return -EINVAL;
> +
> +	/* FIXME to be fixed */
> +	if (qid >= vdpa->nr_vring)
> +		vdpa->nr_vring = qid + 1;
> +
> +	vring = &vdpa->vring_info[qid];
> +
> +	vring->desc_user_addr = addr->desc_user_addr;
> +	vring->used_user_addr = addr->used_user_addr;
> +	vring->avail_user_addr = addr->avail_user_addr;
> +	vring->log_guest_addr = addr->log_guest_addr;
> +
> +	return 0;
> +}
> +
> +static int vhost_set_vring_num(struct mdev_device *mdev,
> +		struct vhost_vring_state *num)
> +{
> +	struct vdpa_dev *vdpa;
> +	int qid = num->index;
> +	struct vdpa_vring_info *vring;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	if (qid >= vdpa->max_vrings)
> +		return -EINVAL;
> +
> +	vring = &vdpa->vring_info[qid];
> +
> +	vring->size = num->num;
> +
> +	return 0;
> +}
> +
> +static int vhost_set_vring_base(struct mdev_device *mdev,
> +		struct vhost_vring_state *base)
> +{
> +	struct vdpa_dev *vdpa;
> +	int qid = base->index;
> +	struct vdpa_vring_info *vring;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	if (qid >= vdpa->max_vrings)
> +		return -EINVAL;
> +
> +	vring = &vdpa->vring_info[qid];
> +
> +	vring->base = base->num;
> +
> +	return 0;
> +}
> +
> +static int vhost_get_vring_base(struct mdev_device *mdev,
> +		struct vhost_vring_state *base)
> +{
> +	struct vdpa_dev *vdpa;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	vdpa->pending_reply = true;
> +	vdpa->pending.request = VHOST_GET_VRING_BASE;
> +	vdpa->pending.payload.state.index = base->index;
> +
> +	// FIXME to be implemented
> +
> +	return 0;
> +}
> +
> +static int vhost_set_features(struct mdev_device *mdev, u64 *features)
> +{
> +	struct vdpa_dev *vdpa;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	vdpa->features = *features;
> +
> +	return 0;
> +}
> +
> +static int vhost_get_features(struct mdev_device *mdev, u64 *features)
> +{
> +	struct vdpa_dev *vdpa;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	vdpa->pending_reply = true;
> +	vdpa->pending.request = VHOST_GET_FEATURES;
> +	vdpa->pending.payload.u64 =
> +		vdpa->ops->supported_features(vdpa);
> +
> +	return 0;
> +}
> +
> +static int vhost_set_owner(struct mdev_device *mdev)
> +{
> +	return 0;
> +}
> +
> +static int vhost_reset_owner(struct mdev_device *mdev)
> +{
> +	return 0;
> +}
> +
> +static int vhost_set_state(struct mdev_device *mdev, u64 *state)
> +{
> +	struct vdpa_dev *vdpa;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	if (*state >= VHOST_DEVICE_S_MAX)
> +		return -EINVAL;
> +
> +	if (vdpa->state == *state)
> +		return 0;
> +
> +	vdpa->state = *state;
> +
> +	switch (vdpa->state) {
> +	case VHOST_DEVICE_S_RUNNING:
> +		vdpa->ops->start(vdpa);
> +		break;
> +	case VHOST_DEVICE_S_STOPPED:
> +		vdpa->ops->stop(vdpa);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t vdpa_handle_bar0_write(struct mdev_device *mdev,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct vhost_vfio_op *op = NULL;
> +	loff_t pos = *ppos;
> +	loff_t offset;
> +	int ret;
> +
> +	offset = VDPA_VFIO_PCI_BAR_OFFSET(pos);
> +	if (offset != 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (count < VHOST_VFIO_OP_HDR_SIZE) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	op = kzalloc(VHOST_VFIO_OP_HDR_SIZE + VHOST_VFIO_OP_PAYLOAD_MAX_SIZE,
> +		     GFP_KERNEL);
> +	if (op == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (copy_from_user(op, buf, VHOST_VFIO_OP_HDR_SIZE)) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	if (op->size > VHOST_VFIO_OP_PAYLOAD_MAX_SIZE ||
> +	    op->size + VHOST_VFIO_OP_HDR_SIZE != count) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
> +	if (copy_from_user(&op->payload, buf + VHOST_VFIO_OP_HDR_SIZE,
> +			   op->size)) {
> +		ret = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	switch (op->request) {
> +	case VHOST_SET_LOG_BASE:
> +		break;
> +	case VHOST_SET_MEM_TABLE:
> +		vhost_set_mem_table(mdev, &op->payload.memory);
> +		break;
> +	case VHOST_SET_VRING_ADDR:
> +		vhost_set_vring_addr(mdev, &op->payload.addr);
> +		break;
> +	case VHOST_SET_VRING_NUM:
> +		vhost_set_vring_num(mdev, &op->payload.state);
> +		break;
> +	case VHOST_SET_VRING_BASE:
> +		vhost_set_vring_base(mdev, &op->payload.state);
> +		break;
> +	case VHOST_GET_VRING_BASE:
> +		vhost_get_vring_base(mdev, &op->payload.state);
> +		break;
> +	case VHOST_SET_FEATURES:
> +		vhost_set_features(mdev, &op->payload.u64);
> +		break;
> +	case VHOST_GET_FEATURES:
> +		vhost_get_features(mdev, &op->payload.u64);
> +		break;
> +	case VHOST_SET_OWNER:
> +		vhost_set_owner(mdev);
> +		break;
> +	case VHOST_RESET_OWNER:
> +		vhost_reset_owner(mdev);
> +		break;
> +	case VHOST_DEVICE_SET_STATE:
> +		vhost_set_state(mdev, &op->payload.u64);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	ret = count;
> +
> +out_free:
> +	kfree(op);
> +out:
> +	return ret;
> +}
> +
> +static ssize_t vdpa_handle_bar1_write(struct mdev_device *mdev,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct vdpa_dev *vdpa;
> +	int qid;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	if (count < sizeof(qid))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&qid, buf, sizeof(qid)))
> +		return -EINVAL;
> +
> +	vdpa->ops->notify(vdpa, qid);
> +
> +	return count;
> +}
> +
> +ssize_t vdpa_write(struct mdev_device *mdev, const char __user *buf,
> +		   size_t count, loff_t *ppos)
> +{
> +	int done = 0;
> +	unsigned int index;
> +	loff_t pos = *ppos;
> +	struct vdpa_dev *vdpa;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	mutex_lock(&vdpa->ops_lock);
> +
> +	index = VDPA_VFIO_PCI_OFFSET_TO_INDEX(pos);
> +
> +	switch (index) {
> +	case VFIO_PCI_CONFIG_REGION_INDEX:
> +		done = vdpa_handle_pcicfg_write(mdev, buf, count, ppos);
> +		break;
> +	case VFIO_PCI_BAR0_REGION_INDEX:
> +		done = vdpa_handle_bar0_write(mdev, buf, count, ppos);
> +		break;
> +	case VFIO_PCI_BAR1_REGION_INDEX:
> +		done = vdpa_handle_bar1_write(mdev, buf, count, ppos);
> +		break;
> +	}
> +
> +	if (done > 0)
> +		*ppos += done;
> +
> +	mutex_unlock(&vdpa->ops_lock);
> +
> +	return done;
> +}
> +EXPORT_SYMBOL(vdpa_write);
> +
> +static int vdpa_get_region_info(struct mdev_device *mdev,
> +				struct vfio_region_info *region_info,
> +				u16 *cap_type_id, void **cap_type)
> +{
> +	struct vdpa_dev *vdpa;
> +	u32 bar_index;
> +	u64 size = 0;
> +
> +	if (!mdev)
> +		return -EINVAL;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -EINVAL;
> +
> +	bar_index = region_info->index;
> +	if (bar_index >= VFIO_PCI_NUM_REGIONS)
> +		return -EINVAL;
> +
> +	mutex_lock(&vdpa->ops_lock);
> +
> +	switch (bar_index) {
> +	case VFIO_PCI_CONFIG_REGION_INDEX:
> +		size = VDPA_CONFIG_SIZE;
> +		break;
> +	case VFIO_PCI_BAR0_REGION_INDEX:
> +		size = VDPA_BAR0_SIZE;
> +		break;
> +	case VFIO_PCI_BAR1_REGION_INDEX:
> +		size = (u64)vdpa->max_vrings << PAGE_SHIFT;
> +		break;
> +	default:
> +		size = 0;
> +		break;
> +	}
> +
> +	// FIXME: mark BAR1 as mmap-able (VFIO_REGION_INFO_FLAG_MMAP)
> +	region_info->size = size;
> +	region_info->offset = VDPA_VFIO_PCI_INDEX_TO_OFFSET(bar_index);
> +	region_info->flags = VFIO_REGION_INFO_FLAG_READ |
> +		VFIO_REGION_INFO_FLAG_WRITE;
> +	mutex_unlock(&vdpa->ops_lock);
> +	return 0;
> +}
> +
> +static int vdpa_reset(struct mdev_device *mdev)
> +{
> +	struct vdpa_dev *vdpa;
> +
> +	if (!mdev)
> +		return -EINVAL;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int vdpa_get_device_info(struct mdev_device *mdev,
> +				struct vfio_device_info *dev_info)
> +{
> +	struct vdpa_dev *vdpa;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	dev_info->flags = VFIO_DEVICE_FLAGS_PCI;
> +	dev_info->num_regions = VFIO_PCI_NUM_REGIONS;
> +	dev_info->num_irqs = vdpa->max_vrings;
> +
> +	return 0;
> +}
> +
> +static int vdpa_get_irq_info(struct mdev_device *mdev,
> +			     struct vfio_irq_info *info)
> +{
> +	struct vdpa_dev *vdpa;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	if (info->index != VFIO_PCI_MSIX_IRQ_INDEX)
> +		return -ENOTSUPP;
> +
> +	info->flags = VFIO_IRQ_INFO_EVENTFD;
> +	info->count = vdpa->max_vrings;
> +
> +	return 0;
> +}
> +
> +static int vdpa_set_irqs(struct mdev_device *mdev, uint32_t flags,
> +			 unsigned int index, unsigned int start,
> +			 unsigned int count, void *data)
> +{
> +	struct vdpa_dev *vdpa;
> +	int *fd = data, i;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -EINVAL;
> +
> +	if (index != VFIO_PCI_MSIX_IRQ_INDEX)
> +		return -ENOTSUPP;
> +
> +	for (i = 0; i < count; i++)
> +		vdpa->ops->set_eventfd(vdpa, start + i,
> +			(flags & VFIO_IRQ_SET_DATA_EVENTFD) ? fd[i] : -1);
> +
> +	return 0;
> +}
> +
> +long vdpa_ioctl(struct mdev_device *mdev, unsigned int cmd, unsigned long arg)
> +{
> +	int ret = 0;
> +	unsigned long minsz;
> +	struct vdpa_dev *vdpa;
> +
> +	if (!mdev)
> +		return -EINVAL;
> +
> +	vdpa = mdev_get_drvdata(mdev);
> +	if (!vdpa)
> +		return -ENODEV;
> +
> +	switch (cmd) {
> +	case VFIO_DEVICE_GET_INFO:
> +	{
> +		struct vfio_device_info info;
> +
> +		minsz = offsetofend(struct vfio_device_info, num_irqs);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		ret = vdpa_get_device_info(mdev, &info);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user((void __user *)arg, &info, minsz))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +	case VFIO_DEVICE_GET_REGION_INFO:
> +	{
> +		struct vfio_region_info info;
> +		u16 cap_type_id = 0;
> +		void *cap_type = NULL;
> +
> +		minsz = offsetofend(struct vfio_region_info, offset);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		ret = vdpa_get_region_info(mdev, &info, &cap_type_id,
> +					   &cap_type);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user((void __user *)arg, &info, minsz))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +	case VFIO_DEVICE_GET_IRQ_INFO:
> +	{
> +		struct vfio_irq_info info;
> +
> +		minsz = offsetofend(struct vfio_irq_info, count);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz || info.index >= vdpa->max_vrings)
> +			return -EINVAL;
> +
> +		ret = vdpa_get_irq_info(mdev, &info);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user((void __user *)arg, &info, minsz))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +	case VFIO_DEVICE_SET_IRQS:
> +	{
> +		struct vfio_irq_set hdr;
> +		size_t data_size = 0;
> +		u8 *data = NULL;
> +
> +		minsz = offsetofend(struct vfio_irq_set, count);
> +
> +		if (copy_from_user(&hdr, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		ret = vfio_set_irqs_validate_and_prepare(&hdr, vdpa->max_vrings,
> +							 VFIO_PCI_NUM_IRQS,
> +							 &data_size);
> +		if (ret)
> +			return ret;
> +
> +		if (data_size) {
> +			data = memdup_user((void __user *)(arg + minsz),
> +					   data_size);
> +			if (IS_ERR(data))
> +				return PTR_ERR(data);
> +		}
> +
> +		ret = vdpa_set_irqs(mdev, hdr.flags, hdr.index, hdr.start,
> +				hdr.count, data);
> +
> +		kfree(data);
> +		return ret;
> +	}
> +	case VFIO_DEVICE_RESET:
> +		return vdpa_reset(mdev);
> +	}
> +	return -ENOTTY;
> +}
> +EXPORT_SYMBOL(vdpa_ioctl);
> +
> +int vdpa_mmap(struct mdev_device *mdev, struct vm_area_struct *vma)
> +{
> +	// FIXME: to be implemented
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(vdpa_mmap);
> +
> +int vdpa_open(struct mdev_device *mdev)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(vdpa_open);
> +
> +void vdpa_close(struct mdev_device *mdev)
> +{
> +}
> +EXPORT_SYMBOL(vdpa_close);
> +
> +MODULE_VERSION("0.0.0");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Hardware virtio accelerator abstraction");
> diff --git a/include/linux/vdpa_mdev.h b/include/linux/vdpa_mdev.h
> new file mode 100644
> index 000000000000..8414e86ba4b8
> --- /dev/null
> +++ b/include/linux/vdpa_mdev.h
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Intel Corporation.
> + */
> +
> +#ifndef VDPA_MDEV_H
> +#define VDPA_MDEV_H
> +
> +#define VDPA_CONFIG_SIZE 0xff
> +
> +struct mdev_device;
> +struct vdpa_dev;
> +
> +/*
> + * XXX: Any comments about the vDPA API design for drivers
> + *      would be appreciated!
> + */
> +
> +typedef int (*vdpa_start_device_t)(struct vdpa_dev *vdpa);
> +typedef int (*vdpa_stop_device_t)(struct vdpa_dev *vdpa);
> +typedef int (*vdpa_dma_map_t)(struct vdpa_dev *vdpa);
> +typedef int (*vdpa_dma_unmap_t)(struct vdpa_dev *vdpa);
> +typedef int (*vdpa_set_eventfd_t)(struct vdpa_dev *vdpa, int vector, int fd);
> +typedef u64 (*vdpa_supported_features_t)(struct vdpa_dev *vdpa);
> +typedef void (*vdpa_notify_device_t)(struct vdpa_dev *vdpa, int qid);
> +typedef u64 (*vdpa_get_notify_addr_t)(struct vdpa_dev *vdpa, int qid);
> +
> +struct vdpa_device_ops {
> +	vdpa_start_device_t		start;
> +	vdpa_stop_device_t		stop;
> +	vdpa_dma_map_t			dma_map;
> +	vdpa_dma_unmap_t		dma_unmap;
> +	vdpa_set_eventfd_t		set_eventfd;
> +	vdpa_supported_features_t	supported_features;
> +	vdpa_notify_device_t		notify;
> +	vdpa_get_notify_addr_t		get_notify_addr;
> +};
> +
> +struct vdpa_vring_info {
> +	u64 desc_user_addr;
> +	u64 used_user_addr;
> +	u64 avail_user_addr;
> +	u64 log_guest_addr;
> +	u16 size;
> +	u16 base;
> +};
> +
> +struct vdpa_dev {
> +	struct mdev_device *mdev;
> +	struct mutex ops_lock;
> +	u8 vconfig[VDPA_CONFIG_SIZE];
> +	int nr_vring;
> +	u64 features;
> +	u64 state;
> +	struct vhost_memory *mem_table;
> +	bool pending_reply;
> +	struct vhost_vfio_op pending;
> +	const struct vdpa_device_ops *ops;
> +	void *private;
> +	int max_vrings;
> +	struct vdpa_vring_info vring_info[0];
> +};
> +
> +struct vdpa_dev *vdpa_alloc(struct mdev_device *mdev, void *private,
> +			    int max_vrings);
> +void vdpa_free(struct vdpa_dev *vdpa);
> +ssize_t vdpa_read(struct mdev_device *mdev, char __user *buf,
> +		  size_t count, loff_t *ppos);
> +ssize_t vdpa_write(struct mdev_device *mdev, const char __user *buf,
> +		   size_t count, loff_t *ppos);
> +long vdpa_ioctl(struct mdev_device *mdev, unsigned int cmd, unsigned long arg);
> +int vdpa_mmap(struct mdev_device *mdev, struct vm_area_struct *vma);
> +int vdpa_open(struct mdev_device *mdev);
> +void vdpa_close(struct mdev_device *mdev);
> +
> +#endif /* VDPA_MDEV_H */
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c51f8e5cc608..92a1ca0b5fe1 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -207,4 +207,30 @@ struct vhost_scsi_target {
>   #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
>   #define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
>   
> +/* VHOST_DEVICE specific defines */
> +
> +#define VHOST_DEVICE_SET_STATE _IOW(VHOST_VIRTIO, 0x70, __u64)
> +
> +#define VHOST_DEVICE_S_STOPPED 0
> +#define VHOST_DEVICE_S_RUNNING 1
> +#define VHOST_DEVICE_S_MAX     2
> +
> +struct vhost_vfio_op {
> +	__u64 request;
> +	__u32 flags;
> +	/* Flag values: */
> +#define VHOST_VFIO_NEED_REPLY 0x1 /* Whether need reply */
> +	__u32 size;
> +	union {
> +		__u64 u64;
> +		struct vhost_vring_state state;
> +		struct vhost_vring_addr addr;
> +		struct vhost_memory memory;
> +	} payload;
> +};
> +
> +#define VHOST_VFIO_OP_HDR_SIZE \
> +		((unsigned long)&((struct vhost_vfio_op *)NULL)->payload)
> +#define VHOST_VFIO_OP_PAYLOAD_MAX_SIZE 1024 /* FIXME TBD */
> +
>   #endif
