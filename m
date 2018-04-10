Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDJE7a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 00:59:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:43811 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeDJE72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 00:59:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,430,1517904000";
   d="scan'208";a="45604164"
Date: Tue, 10 Apr 2018 12:57:23 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, alex.williamson@redhat.com, ddutile@redhat.com,
        alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com,
        jianfeng.tan@intel.com, xiao.w.wang@intel.com
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
Message-ID: <20180410045723.rftsb7l4l3ip2ioi@debian>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 10:52:52AM +0800, Jason Wang wrote:
> On 2018年04月02日 23:23, Tiwei Bie wrote:
> > This patch introduces a mdev (mediated device) based hardware
> > vhost backend. This backend is an abstraction of the various
> > hardware vhost accelerators (potentially any device that uses
> > virtio ring can be used as a vhost accelerator). Some generic
> > mdev parent ops are provided for accelerator drivers to support
> > generating mdev instances.
> > 
> > What's this
> > ===========
> > 
> > The idea is that we can setup a virtio ring compatible device
> > with the messages available at the vhost-backend. Originally,
> > these messages are used to implement a software vhost backend,
> > but now we will use these messages to setup a virtio ring
> > compatible hardware device. Then the hardware device will be
> > able to work with the guest virtio driver in the VM just like
> > what the software backend does. That is to say, we can implement
> > a hardware based vhost backend in QEMU, and any virtio ring
> > compatible devices potentially can be used with this backend.
> > (We also call it vDPA -- vhost Data Path Acceleration).
> > 
> > One problem is that, different virtio ring compatible devices
> > may have different device interfaces. That is to say, we will
> > need different drivers in QEMU. It could be troublesome. And
> > that's what this patch trying to fix. The idea behind this
> > patch is very simple: mdev is a standard way to emulate device
> > in kernel.
> 
> So you just move the abstraction layer from qemu to kernel, and you still
> need different drivers in kernel for different device interfaces of
> accelerators. This looks even more complex than leaving it in qemu. As you
> said, another idea is to implement userspace vhost backend for accelerators
> which seems easier and could co-work with other parts of qemu without
> inventing new type of messages.

I'm not quite sure. Do you think it's acceptable to
add various vendor specific hardware drivers in QEMU?

> 
> Need careful thought here to seek a best solution here.

Yeah, definitely! :)
And your opinions would be very helpful!

> 
> >   So we defined a standard device based on mdev, which
> > is able to accept vhost messages. When the mdev emulation code
> > (i.e. the generic mdev parent ops provided by this patch) gets
> > vhost messages, it will parse and deliver them to accelerator
> > drivers. Drivers can use these messages to setup accelerators.
> > 
> > That is to say, the generic mdev parent ops (e.g. read()/write()/
> > ioctl()/...) will be provided for accelerator drivers to register
> > accelerators as mdev parent devices. And each accelerator device
> > will support generating standard mdev instance(s).
> > 
> > With this standard device interface, we will be able to just
> > develop one userspace driver to implement the hardware based
> > vhost backend in QEMU.
> > 
> > Difference between vDPA and PCI passthru
> > ========================================
> > 
> > The key difference between vDPA and PCI passthru is that, in
> > vDPA only the data path of the device (e.g. DMA ring, notify
> > region and queue interrupt) is pass-throughed to the VM, the
> > device control path (e.g. PCI configuration space and MMIO
> > regions) is still defined and emulated by QEMU.
> > 
> > The benefits of keeping virtio device emulation in QEMU compared
> > with virtio device PCI passthru include (but not limit to):
> > 
> > - consistent device interface for guest OS in the VM;
> > - max flexibility on the hardware design, especially the
> >    accelerator for each vhost backend doesn't have to be a
> >    full PCI device;
> > - leveraging the existing virtio live-migration framework;
> > 
> > The interface of this mdev based device
> > =======================================
> > 
> > 1. BAR0
> > 
> > The MMIO region described by BAR0 is the main control
> > interface. Messages will be written to or read from
> > this region.
> > 
> > The message type is determined by the `request` field
> > in message header. The message size is encoded in the
> > message header too. The message format looks like this:
> > 
> > struct vhost_vfio_op {
> > 	__u64 request;
> > 	__u32 flags;
> > 	/* Flag values: */
> > #define VHOST_VFIO_NEED_REPLY 0x1 /* Whether need reply */
> > 	__u32 size;
> > 	union {
> > 		__u64 u64;
> > 		struct vhost_vring_state state;
> > 		struct vhost_vring_addr addr;
> > 		struct vhost_memory memory;
> > 	} payload;
> > };
> > 
> > The existing vhost-kernel ioctl cmds are reused as
> > the message requests in above structure.
> > 
> > Each message will be written to or read from this
> > region at offset 0:
> > 
> > int vhost_vfio_write(struct vhost_dev *dev, struct vhost_vfio_op *op)
> > {
> > 	int count = VHOST_VFIO_OP_HDR_SIZE + op->size;
> > 	struct vhost_vfio *vfio = dev->opaque;
> > 	int ret;
> > 
> > 	ret = pwrite64(vfio->device_fd, op, count, vfio->bar0_offset);
> > 	if (ret != count)
> > 		return -1;
> > 
> > 	return 0;
> > }
> > 
> > int vhost_vfio_read(struct vhost_dev *dev, struct vhost_vfio_op *op)
> > {
> > 	int count = VHOST_VFIO_OP_HDR_SIZE + op->size;
> > 	struct vhost_vfio *vfio = dev->opaque;
> > 	uint64_t request = op->request;
> > 	int ret;
> > 
> > 	ret = pread64(vfio->device_fd, op, count, vfio->bar0_offset);
> > 	if (ret != count || request != op->request)
> > 		return -1;
> > 
> > 	return 0;
> > }
> > 
> > It's quite straightforward to set things to the device.
> > Just need to write the message to device directly:
> > 
> > int vhost_vfio_set_features(struct vhost_dev *dev, uint64_t features)
> > {
> > 	struct vhost_vfio_op op;
> > 
> > 	op.request = VHOST_SET_FEATURES;
> > 	op.flags = 0;
> > 	op.size = sizeof(features);
> > 	op.payload.u64 = features;
> > 
> > 	return vhost_vfio_write(dev, &op);
> > }
> > 
> > To get things from the device, two steps are needed.
> > Take VHOST_GET_FEATURE as an example:
> > 
> > int vhost_vfio_get_features(struct vhost_dev *dev, uint64_t *features)
> > {
> > 	struct vhost_vfio_op op;
> > 	int ret;
> > 
> > 	op.request = VHOST_GET_FEATURES;
> > 	op.flags = VHOST_VFIO_NEED_REPLY;
> > 	op.size = 0;
> > 
> > 	/* Just need to write the header */
> > 	ret = vhost_vfio_write(dev, &op);
> > 	if (ret != 0)
> > 		goto out;
> > 
> > 	/* `op` wasn't changed during write */
> > 	op.flags = 0;
> > 	op.size = sizeof(*features);
> > 
> > 	ret = vhost_vfio_read(dev, &op);
> > 	if (ret != 0)
> > 		goto out;
> > 
> > 	*features = op.payload.u64;
> > out:
> > 	return ret;
> > }
> > 
> > 2. BAR1 (mmap-able)
> > 
> > The MMIO region described by BAR1 will be used to notify the
> > device.
> > 
> > Each queue will has a page for notification, and it can be
> > mapped to VM (if hardware also supports), and the virtio
> > driver in the VM will be able to notify the device directly.
> > 
> > The MMIO region described by BAR1 is also write-able. If the
> > accelerator's notification register(s) cannot be mapped to the
> > VM, write() can also be used to notify the device. Something
> > like this:
> > 
> > void notify_relay(void *opaque)
> > {
> > 	......
> > 	offset = 0x1000 * queue_idx; /* XXX assume page size is 4K here. */
> > 
> > 	ret = pwrite64(vfio->device_fd, &queue_idx, sizeof(queue_idx),
> > 			vfio->bar1_offset + offset);
> > 	......
> > }
> > 
> > Other BARs are reserved.
> > 
> > 3. VFIO interrupt ioctl API
> > 
> > VFIO interrupt ioctl API is used to setup device interrupts.
> > IRQ-bypass will also be supported.
> > 
> > Currently, only VFIO_PCI_MSIX_IRQ_INDEX is supported.
> > 
> > The API for drivers to provide mdev instances
> > =============================================
> > 
> > The read()/write()/ioctl()/mmap()/open()/release() mdev
> > parent ops have been provided for accelerators' drivers
> > to provide mdev instances.
> > 
> > ssize_t vdpa_read(struct mdev_device *mdev, char __user *buf,
> > 		  size_t count, loff_t *ppos);
> > ssize_t vdpa_write(struct mdev_device *mdev, const char __user *buf,
> > 		   size_t count, loff_t *ppos);
> > long vdpa_ioctl(struct mdev_device *mdev, unsigned int cmd, unsigned long arg);
> > int vdpa_mmap(struct mdev_device *mdev, struct vm_area_struct *vma);
> > int vdpa_open(struct mdev_device *mdev);
> > void vdpa_close(struct mdev_device *mdev);
> > 
> > Each accelerator driver just needs to implement its own
> > create()/remove() ops, and provide a vdpa device ops
> > which will be called by the generic mdev emulation code.
> > 
> > Currently, the vdpa device ops are defined as:
> > 
> > typedef int (*vdpa_start_device_t)(struct vdpa_dev *vdpa);
> > typedef int (*vdpa_stop_device_t)(struct vdpa_dev *vdpa);
> > typedef int (*vdpa_dma_map_t)(struct vdpa_dev *vdpa);
> > typedef int (*vdpa_dma_unmap_t)(struct vdpa_dev *vdpa);
> > typedef int (*vdpa_set_eventfd_t)(struct vdpa_dev *vdpa, int vector, int fd);
> > typedef u64 (*vdpa_supported_features_t)(struct vdpa_dev *vdpa);
> > typedef void (*vdpa_notify_device_t)(struct vdpa_dev *vdpa, int qid);
> > typedef u64 (*vdpa_get_notify_addr_t)(struct vdpa_dev *vdpa, int qid);
> > 
> > struct vdpa_device_ops {
> > 	vdpa_start_device_t		start;
> > 	vdpa_stop_device_t		stop;
> > 	vdpa_dma_map_t			dma_map;
> > 	vdpa_dma_unmap_t		dma_unmap;
> > 	vdpa_set_eventfd_t		set_eventfd;
> > 	vdpa_supported_features_t	supported_features;
> > 	vdpa_notify_device_t		notify;
> > 	vdpa_get_notify_addr_t		get_notify_addr;
> > };
> > 
> > struct vdpa_dev {
> > 	struct mdev_device *mdev;
> > 	struct mutex ops_lock;
> > 	u8 vconfig[VDPA_CONFIG_SIZE];
> > 	int nr_vring;
> > 	u64 features;
> > 	u64 state;
> > 	struct vhost_memory *mem_table;
> > 	bool pending_reply;
> > 	struct vhost_vfio_op pending;
> > 	const struct vdpa_device_ops *ops;
> > 	void *private;
> > 	int max_vrings;
> > 	struct vdpa_vring_info vring_info[0];
> > };
> > 
> > struct vdpa_dev *vdpa_alloc(struct mdev_device *mdev, void *private,
> > 			    int max_vrings);
> > void vdpa_free(struct vdpa_dev *vdpa);
> > 
> > A simple example
> > ================
> > 
> > # Query the number of available mdev instances
> > $ cat /sys/class/mdev_bus/0000:06:00.2/mdev_supported_types/ifcvf_vdpa-vdpa_virtio/available_instances
> > 
> > # Create a mdev instance
> > $ echo $UUID > /sys/class/mdev_bus/0000:06:00.2/mdev_supported_types/ifcvf_vdpa-vdpa_virtio/create
> > 
> > # Launch QEMU with a virtio-net device
> > $ qemu \
> > 	...... \
> > 	-netdev type=vhost-vfio,sysfsdev=/sys/bus/mdev/devices/$UUID,id=$ID \
> > 	-device virtio-net-pci,netdev=$ID
> > 
> > -------- END --------
> > 
> > Most of above words will be refined and moved to a doc in
> > the formal patch. In this RFC, all introductions and code
> > are gathered in this patch, the idea is to make it easier
> > to find all the relevant information. Anyone who wants to
> > comment could use inline comment and just keep the relevant
> > parts. Sorry for the big RFC patch..
> > 
> > This patch is just a RFC for now, and something is still
> > missing or needs to be refined. But it's never too early
> > to hear the thoughts from the community. So any comments
> > would be appreciated! Thanks! :-)
> 
> I don't see vhost_vfio_write() and other above functions in the patch. Looks
> like some part of the patch is missed, it would be better to post a complete
> series with an example driver (vDPA) to get a full picture.

No problem. We will send out the QEMU changes soon!

Thanks!

> 
> Thanks
> 
[...]
