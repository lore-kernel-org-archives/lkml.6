Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A49DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5611D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390924AbfBMN1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:27:44 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:36910 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727264AbfBMN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:27:41 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 Feb 2019 15:27:26 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x1DDRPV2009107;
        Wed, 13 Feb 2019 08:27:25 -0500
Received: (from lsun@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x1DDRNmN001402;
        Wed, 13 Feb 2019 08:27:23 -0500
From:   Liming Sun <lsun@mellanox.com>
To:     David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc:     Liming Sun <lsun@mellanox.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v9] platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc
Date:   Wed, 13 Feb 2019 08:27:17 -0500
Message-Id: <1550064437-1363-1-git-send-email-lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the TmFifo platform driver for Mellanox BlueField
Soc. TmFifo is a shared FIFO which enables external host machine
to exchange data with the SoC via USB or PCIe. The driver is based
on virtio framework and has console and network access enabled.

Signed-off-by: Liming Sun <lsun@mellanox.com>

---

v9: Fix coding styles. Adjust code to use devm_xxx() APIs.
    Removed the DT binding documentation since only ACPI is
    supported for now by UEFI on the SoC.
v8: Re-submit under drivers/platform/mellanox with target-size
    platform driver only.
v7: Added host side drivers into the same patch set.
v5~v6: Coding style fix.
v1~v4: Initial version for directory drivers/soc/mellanox.
---
 drivers/platform/mellanox/Kconfig             |   10 +-
 drivers/platform/mellanox/Makefile            |    1 +
 drivers/platform/mellanox/mlxbf-tmfifo-regs.h |   67 ++
 drivers/platform/mellanox/mlxbf-tmfifo.c      | 1361 +++++++++++++++++++++++++
 4 files changed, 1438 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/mellanox/mlxbf-tmfifo-regs.h
 create mode 100644 drivers/platform/mellanox/mlxbf-tmfifo.c

diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index cd8a908..6feceb1 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig MELLANOX_PLATFORM
 	bool "Platform support for Mellanox hardware"
-	depends on X86 || ARM || COMPILE_TEST
+	depends on X86 || ARM || ARM64 || COMPILE_TEST
 	---help---
 	  Say Y here to get to see options for platform support for
 	  Mellanox systems. This option alone does not add any kernel code.
@@ -34,4 +34,12 @@ config MLXREG_IO
 	  to system resets operation, system reset causes monitoring and some
 	  kinds of mux selection.
 
+config MLXBF_TMFIFO
+	tristate "Mellanox BlueField SoC TmFifo platform driver"
+	depends on ARM64 && ACPI && VIRTIO_CONSOLE && VIRTIO_NET
+	help
+	  Say y here to enable TmFifo support. The TmFifo driver provides
+          platform driver support for the TmFifo which supports console
+          and networking based on the virtio framework.
+
 endif # MELLANOX_PLATFORM
diff --git a/drivers/platform/mellanox/Makefile b/drivers/platform/mellanox/Makefile
index 57074d9c..f0c061d 100644
--- a/drivers/platform/mellanox/Makefile
+++ b/drivers/platform/mellanox/Makefile
@@ -5,3 +5,4 @@
 #
 obj-$(CONFIG_MLXREG_HOTPLUG)	+= mlxreg-hotplug.o
 obj-$(CONFIG_MLXREG_IO) += mlxreg-io.o
+obj-$(CONFIG_MLXBF_TMFIFO)	+= mlxbf-tmfifo.o
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo-regs.h b/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
new file mode 100644
index 0000000..90c9c2cf
--- /dev/null
+++ b/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+ */
+
+#ifndef __MLXBF_TMFIFO_REGS_H__
+#define __MLXBF_TMFIFO_REGS_H__
+
+#include <linux/types.h>
+
+#define MLXBF_TMFIFO_TX_DATA 0x0
+
+#define MLXBF_TMFIFO_TX_STS 0x8
+#define MLXBF_TMFIFO_TX_STS__LENGTH 0x0001
+#define MLXBF_TMFIFO_TX_STS__COUNT_SHIFT 0
+#define MLXBF_TMFIFO_TX_STS__COUNT_WIDTH 9
+#define MLXBF_TMFIFO_TX_STS__COUNT_RESET_VAL 0
+#define MLXBF_TMFIFO_TX_STS__COUNT_RMASK 0x1ff
+#define MLXBF_TMFIFO_TX_STS__COUNT_MASK  0x1ff
+
+#define MLXBF_TMFIFO_TX_CTL 0x10
+#define MLXBF_TMFIFO_TX_CTL__LENGTH 0x0001
+#define MLXBF_TMFIFO_TX_CTL__LWM_SHIFT 0
+#define MLXBF_TMFIFO_TX_CTL__LWM_WIDTH 8
+#define MLXBF_TMFIFO_TX_CTL__LWM_RESET_VAL 128
+#define MLXBF_TMFIFO_TX_CTL__LWM_RMASK 0xff
+#define MLXBF_TMFIFO_TX_CTL__LWM_MASK  0xff
+#define MLXBF_TMFIFO_TX_CTL__HWM_SHIFT 8
+#define MLXBF_TMFIFO_TX_CTL__HWM_WIDTH 8
+#define MLXBF_TMFIFO_TX_CTL__HWM_RESET_VAL 128
+#define MLXBF_TMFIFO_TX_CTL__HWM_RMASK 0xff
+#define MLXBF_TMFIFO_TX_CTL__HWM_MASK  0xff00
+#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_SHIFT 32
+#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_WIDTH 9
+#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_RESET_VAL 256
+#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_RMASK 0x1ff
+#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_MASK  0x1ff00000000ULL
+
+#define MLXBF_TMFIFO_RX_DATA 0x0
+
+#define MLXBF_TMFIFO_RX_STS 0x8
+#define MLXBF_TMFIFO_RX_STS__LENGTH 0x0001
+#define MLXBF_TMFIFO_RX_STS__COUNT_SHIFT 0
+#define MLXBF_TMFIFO_RX_STS__COUNT_WIDTH 9
+#define MLXBF_TMFIFO_RX_STS__COUNT_RESET_VAL 0
+#define MLXBF_TMFIFO_RX_STS__COUNT_RMASK 0x1ff
+#define MLXBF_TMFIFO_RX_STS__COUNT_MASK  0x1ff
+
+#define MLXBF_TMFIFO_RX_CTL 0x10
+#define MLXBF_TMFIFO_RX_CTL__LENGTH 0x0001
+#define MLXBF_TMFIFO_RX_CTL__LWM_SHIFT 0
+#define MLXBF_TMFIFO_RX_CTL__LWM_WIDTH 8
+#define MLXBF_TMFIFO_RX_CTL__LWM_RESET_VAL 128
+#define MLXBF_TMFIFO_RX_CTL__LWM_RMASK 0xff
+#define MLXBF_TMFIFO_RX_CTL__LWM_MASK  0xff
+#define MLXBF_TMFIFO_RX_CTL__HWM_SHIFT 8
+#define MLXBF_TMFIFO_RX_CTL__HWM_WIDTH 8
+#define MLXBF_TMFIFO_RX_CTL__HWM_RESET_VAL 128
+#define MLXBF_TMFIFO_RX_CTL__HWM_RMASK 0xff
+#define MLXBF_TMFIFO_RX_CTL__HWM_MASK  0xff00
+#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_SHIFT 32
+#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_WIDTH 9
+#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RESET_VAL 256
+#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RMASK 0x1ff
+#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK  0x1ff00000000ULL
+
+#endif /* !defined(__MLXBF_TMFIFO_REGS_H__) */
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
new file mode 100644
index 0000000..ce55fca
--- /dev/null
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -0,0 +1,1361 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Mellanox BlueField SoC TmFifo driver
+ *
+ * Copyright (C) 2019 Mellanox Technologies
+ */
+
+#include <linux/acpi.h>
+#include <linux/byteorder/generic.h>
+#include <linux/bitfield.h>
+#include <linux/cache.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_console.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_ring.h>
+
+#include "mlxbf-tmfifo-regs.h"
+
+/* Vring size. */
+#define MLXBF_TMFIFO_VRING_SIZE			1024
+
+/* Console Tx buffer size. */
+#define MLXBF_TMFIFO_CONS_TX_BUF_SIZE		(32 * 1024)
+
+/* Console Tx buffer size with some reservation. */
+#define MLXBF_TMFIFO_CONS_TX_BUF_RSV_SIZE	\
+	(MLXBF_TMFIFO_CONS_TX_BUF_SIZE - 8)
+
+/* House-keeping timer interval. */
+static int mlxbf_tmfifo_timer_interval = HZ / 10;
+
+/* Global lock. */
+static DEFINE_MUTEX(mlxbf_tmfifo_lock);
+
+/* Virtual devices sharing the TM FIFO. */
+#define MLXBF_TMFIFO_VDEV_MAX		(VIRTIO_ID_CONSOLE + 1)
+
+/*
+ * Reserve 1/16 of TmFifo space, so console messages are not starved by
+ * the networking traffic.
+ */
+#define MLXBF_TMFIFO_RESERVE_RATIO		16
+
+/* Message with data needs at least two words (for header & data). */
+#define MLXBF_TMFIFO_DATA_MIN_WORDS		2
+
+/* Struct declaration. */
+struct mlxbf_tmfifo;
+
+/* Structure to maintain the ring state. */
+struct mlxbf_tmfifo_vring {
+	void *va;			/* virtual address */
+	dma_addr_t dma;			/* dma address */
+	struct virtqueue *vq;		/* virtqueue pointer */
+	struct vring_desc *desc;	/* current desc */
+	struct vring_desc *desc_head;	/* current desc head */
+	int cur_len;			/* processed len in current desc */
+	int rem_len;			/* remaining length to be processed */
+	int size;			/* vring size */
+	int align;			/* vring alignment */
+	int id;				/* vring id */
+	int vdev_id;			/* TMFIFO_VDEV_xxx */
+	u32 pkt_len;			/* packet total length */
+	u16 next_avail;			/* next avail desc id */
+	struct mlxbf_tmfifo *fifo;	/* pointer back to the tmfifo */
+};
+
+/* Interrupt types. */
+enum {
+	MLXBF_TM_RX_LWM_IRQ,		/* Rx low water mark irq */
+	MLXBF_TM_RX_HWM_IRQ,		/* Rx high water mark irq */
+	MLXBF_TM_TX_LWM_IRQ,		/* Tx low water mark irq */
+	MLXBF_TM_TX_HWM_IRQ,		/* Tx high water mark irq */
+	MLXBF_TM_IRQ_CNT
+};
+
+/* Ring types (Rx & Tx). */
+enum {
+	MLXBF_TMFIFO_VRING_RX,		/* Rx ring */
+	MLXBF_TMFIFO_VRING_TX,		/* Tx ring */
+	MLXBF_TMFIFO_VRING_NUM
+};
+
+/* Structure for the virtual device. */
+struct mlxbf_tmfifo_vdev {
+	struct virtio_device vdev;	/* virtual device */
+	u8 status;
+	u64 features;
+	union {				/* virtio config space */
+		struct virtio_console_config cons;
+		struct virtio_net_config net;
+	} config;
+	struct mlxbf_tmfifo_vring vrings[MLXBF_TMFIFO_VRING_NUM];
+	u8 *tx_buf;			/* tx buffer */
+	u32 tx_head;			/* tx buffer head */
+	u32 tx_tail;			/* tx buffer tail */
+};
+
+/* Structure of the interrupt information. */
+struct mlxbf_tmfifo_irq_info {
+	struct mlxbf_tmfifo *fifo;	/* tmfifo structure */
+	int irq;			/* interrupt number */
+	int index;			/* array index */
+};
+
+/* Structure of the TmFifo information. */
+struct mlxbf_tmfifo {
+	struct mlxbf_tmfifo_vdev *vdev[MLXBF_TMFIFO_VDEV_MAX]; /* devices */
+	struct platform_device *pdev;	/* platform device */
+	struct mutex lock;		/* fifo lock */
+	void __iomem *rx_base;		/* mapped register base */
+	void __iomem *tx_base;		/* mapped register base */
+	int tx_fifo_size;		/* number of entries of the Tx FIFO */
+	int rx_fifo_size;		/* number of entries of the Rx FIFO */
+	unsigned long pend_events;	/* pending bits for deferred process */
+	struct mlxbf_tmfifo_irq_info irq_info[MLXBF_TM_IRQ_CNT]; /* irq info */
+	struct work_struct work;	/* work struct for deferred process */
+	struct timer_list timer;	/* keepalive timer */
+	struct mlxbf_tmfifo_vring *vring[2];	/* current Tx/Rx ring */
+	bool is_ready;			/* ready flag */
+	spinlock_t spin_lock;		/* spin lock */
+};
+
+/* Use a union struction for 64-bit little/big endian. */
+union mlxbf_tmfifo_data_64bit {
+	u64 data;
+	__le64 data_le;
+};
+
+/* Message header used to demux data in the TmFifo. */
+union mlxbf_tmfifo_msg_hdr {
+	struct {
+		u8 type;		/* message type */
+		__be16 len;		/* payload length */
+		u8 unused[5];		/* reserved, set to 0 */
+	} __packed;
+	union mlxbf_tmfifo_data_64bit u;	/* 64-bit data */
+};
+
+/*
+ * Default MAC.
+ * This MAC address will be read from EFI persistent variable if configured.
+ * It can also be reconfigured with standard Linux tools.
+ */
+static u8 mlxbf_tmfifo_net_default_mac[6] = {
+	0x00, 0x1A, 0xCA, 0xFF, 0xFF, 0x01};
+
+/* EFI variable name of the MAC address. */
+static efi_char16_t mlxbf_tmfifo_efi_name[] = L"RshimMacAddr";
+
+/* MTU setting of the virtio-net interface. */
+#define MLXBF_TMFIFO_NET_MTU		1500
+
+/* Maximum L2 header length. */
+#define MLXBF_TMFIFO_NET_L2_OVERHEAD	36
+
+/* Supported virtio-net features. */
+#define MLXBF_TMFIFO_NET_FEATURES	((1UL << VIRTIO_NET_F_MTU) | \
+					 (1UL << VIRTIO_NET_F_STATUS) | \
+					 (1UL << VIRTIO_NET_F_MAC))
+
+/* Function declarations. */
+static int mlxbf_tmfifo_remove(struct platform_device *pdev);
+
+/* Console output are buffered and can be accessed with the functions below. */
+
+/* Return the consumed Tx buffer space. */
+static int mlxbf_tmfifo_vdev_tx_buf_len(struct mlxbf_tmfifo_vdev *vdev)
+{
+	return ((vdev->tx_tail >= vdev->tx_head) ?
+		(vdev->tx_tail - vdev->tx_head) :
+		(MLXBF_TMFIFO_CONS_TX_BUF_SIZE - vdev->tx_head +
+		 vdev->tx_tail));
+}
+
+/* Return the available Tx buffer space. */
+static int mlxbf_tmfifo_vdev_tx_buf_avail(struct mlxbf_tmfifo_vdev *vdev)
+{
+	return (MLXBF_TMFIFO_CONS_TX_BUF_RSV_SIZE -
+		mlxbf_tmfifo_vdev_tx_buf_len(vdev));
+}
+
+/* Update Rx/Tx buffer index pointer. */
+static void mlxbf_tmfifo_vdev_tx_buf_index_inc(u32 *index, u32 len)
+{
+	*index += len;
+	if (*index >= MLXBF_TMFIFO_CONS_TX_BUF_SIZE)
+		*index -= MLXBF_TMFIFO_CONS_TX_BUF_SIZE;
+}
+
+/* Allocate vrings for the fifo. */
+static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
+				     struct mlxbf_tmfifo_vdev *tm_vdev,
+				     int vdev_id)
+{
+	struct mlxbf_tmfifo_vring *vring;
+	dma_addr_t dma;
+	int i, size;
+	void *va;
+
+	for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
+		vring = &tm_vdev->vrings[i];
+		vring->fifo = fifo;
+		vring->size = MLXBF_TMFIFO_VRING_SIZE;
+		vring->align = SMP_CACHE_BYTES;
+		vring->id = i;
+		vring->vdev_id = vdev_id;
+
+		size = PAGE_ALIGN(vring_size(vring->size, vring->align));
+		va = dma_alloc_coherent(tm_vdev->vdev.dev.parent, size, &dma,
+					GFP_KERNEL);
+		if (!va) {
+			dev_err(tm_vdev->vdev.dev.parent,
+				"dma_alloc_coherent failed\n");
+			return -ENOMEM;
+		}
+
+		vring->va = va;
+		vring->dma = dma;
+	}
+
+	return 0;
+}
+
+/* Free vrings of the fifo device. */
+static void mlxbf_tmfifo_free_vrings(struct mlxbf_tmfifo *fifo, int vdev_id)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev = fifo->vdev[vdev_id];
+	struct mlxbf_tmfifo_vring *vring;
+	int i, size;
+
+	for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
+		vring = &tm_vdev->vrings[i];
+		if (vring->va) {
+			size = PAGE_ALIGN(vring_size(vring->size,
+						     vring->align));
+			dma_free_coherent(tm_vdev->vdev.dev.parent, size,
+					  vring->va, vring->dma);
+			vring->va = NULL;
+			if (vring->vq) {
+				vring_del_virtqueue(vring->vq);
+				vring->vq = NULL;
+			}
+		}
+	}
+}
+
+/* Disable interrupts of the fifo device. */
+static void mlxbf_tmfifo_disable_irqs(struct mlxbf_tmfifo *fifo)
+{
+	int i, irq;
+
+	for (i = 0; i < MLXBF_TM_IRQ_CNT; i++) {
+		irq = fifo->irq_info[i].irq;
+		if (irq) {
+			fifo->irq_info[i].irq = 0;
+			disable_irq(irq);
+		}
+	}
+}
+
+/* Interrupt handler. */
+static irqreturn_t mlxbf_tmfifo_irq_handler(int irq, void *arg)
+{
+	struct mlxbf_tmfifo_irq_info *irq_info;
+
+	irq_info = (struct mlxbf_tmfifo_irq_info *)arg;
+
+	if (irq_info->index < MLXBF_TM_IRQ_CNT &&
+	    !test_and_set_bit(irq_info->index, &irq_info->fifo->pend_events))
+		schedule_work(&irq_info->fifo->work);
+
+	return IRQ_HANDLED;
+}
+
+/* Get the next packet descriptor from the vring. */
+static struct vring_desc *mlxbf_tmfifo_get_next_desc(struct virtqueue *vq)
+{
+	struct mlxbf_tmfifo_vring *vring;
+	unsigned int idx, head;
+	struct vring *vr;
+
+	vr = (struct vring *)virtqueue_get_vring(vq);
+	if (!vr)
+		return NULL;
+	vring = (struct mlxbf_tmfifo_vring *)vq->priv;
+	if (vring->next_avail == virtio16_to_cpu(vq->vdev, vr->avail->idx))
+		return NULL;
+	idx = vring->next_avail % vr->num;
+	head = virtio16_to_cpu(vq->vdev, vr->avail->ring[idx]);
+	if (WARN_ON(head >= vr->num))
+		return NULL;
+	vring->next_avail++;
+
+	return &vr->desc[head];
+}
+
+/* Release virtio descriptor. */
+static void mlxbf_tmfifo_release_desc(struct virtio_device *vdev,
+				      struct vring *vr, struct vring_desc *desc,
+				      u32 len)
+{
+	u16 idx, vr_idx;
+
+	vr_idx = virtio16_to_cpu(vdev, vr->used->idx);
+	idx = vr_idx % vr->num;
+	vr->used->ring[idx].id = cpu_to_virtio32(vdev, desc - vr->desc);
+	vr->used->ring[idx].len = cpu_to_virtio32(vdev, len);
+
+	/* Virtio could poll and check the 'idx' to decide
+	 * whether the desc is done or not. Add a memory
+	 * barrier here to make sure the update above completes
+	 * before updating the idx.
+	 */
+	mb();
+	vr->used->idx = cpu_to_virtio16(vdev, vr_idx + 1);
+}
+
+/* Get the total length of the descriptor chain. */
+static u32 mlxbf_tmfifo_get_pkt_len(struct virtio_device *vdev,
+				    struct vring_desc *desc, struct vring *vr)
+{
+	u32 len = 0, idx;
+
+	while (desc) {
+		len += virtio32_to_cpu(vdev, desc->len);
+		if (!(virtio16_to_cpu(vdev, desc->flags) & VRING_DESC_F_NEXT))
+			break;
+		idx = virtio16_to_cpu(vdev, desc->next);
+		desc = &vr->desc[idx];
+	}
+
+	return len;
+}
+
+static void mlxbf_tmfifo_release_pkt(struct virtio_device *vdev,
+				     struct mlxbf_tmfifo_vring *vring,
+				     struct vring_desc **desc)
+{
+	struct vring_desc *desc_head;
+	struct vring *vr;
+	u32 len = 0;
+
+	vr = (struct vring *)virtqueue_get_vring(vring->vq);
+	if (!vr)
+		return;
+
+	if (desc && *desc && vring->desc_head) {
+		desc_head = vring->desc_head;
+		len = vring->pkt_len;
+	} else {
+		desc_head = mlxbf_tmfifo_get_next_desc(vring->vq);
+		if (desc_head)
+			len = mlxbf_tmfifo_get_pkt_len(vdev, desc_head, vr);
+	}
+
+	if (desc_head)
+		mlxbf_tmfifo_release_desc(vdev, vr, desc_head, len);
+
+	if (desc)
+		*desc = NULL;
+	vring->pkt_len = 0;
+}
+
+/* Get and initialize the next packet. */
+static struct vring_desc *
+mlxbf_tmfifo_get_next_pkt(struct virtio_device *vdev,
+			  struct mlxbf_tmfifo_vring *vring, bool is_rx)
+{
+	struct vring_desc *desc;
+
+	desc = mlxbf_tmfifo_get_next_desc(vring->vq);
+
+	/* Initialize the packet header for received network packet. */
+	if (desc && is_rx && vring->vdev_id == VIRTIO_ID_NET) {
+		struct virtio_net_hdr *net_hdr;
+
+		net_hdr = (struct virtio_net_hdr *)
+			phys_to_virt(virtio64_to_cpu(vdev, desc->addr));
+		memset(net_hdr, 0, sizeof(*net_hdr));
+	}
+
+	vring->desc_head = desc;
+	vring->desc = desc;
+
+	return desc;
+}
+
+/* House-keeping timer. */
+static void mlxbf_tmfifo_timer(struct timer_list *arg)
+{
+	struct mlxbf_tmfifo *fifo;
+
+	fifo = container_of(arg, struct mlxbf_tmfifo, timer);
+
+	/*
+	 * Wake up the work handler to poll the Rx FIFO in case interrupt
+	 * missing or any leftover bytes stuck in the FIFO.
+	 */
+	test_and_set_bit(MLXBF_TM_RX_HWM_IRQ, &fifo->pend_events);
+
+	/*
+	 * Wake up Tx handler in case virtio has queued too many packets
+	 * and are waiting for buffer return.
+	 */
+	test_and_set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events);
+
+	schedule_work(&fifo->work);
+
+	mod_timer(&fifo->timer, jiffies + mlxbf_tmfifo_timer_interval);
+}
+
+/* Copy one console packet into the output buffer. */
+static void mlxbf_tmfifo_console_output_one(struct mlxbf_tmfifo_vdev *cons,
+					    struct virtio_device *vdev,
+					    struct vring *vr,
+					    struct vring_desc *desc)
+{
+	u32 len, idx, seg;
+	void *addr;
+
+	while (desc) {
+		addr = phys_to_virt(virtio64_to_cpu(vdev, desc->addr));
+		len = virtio32_to_cpu(vdev, desc->len);
+
+		if (len <= MLXBF_TMFIFO_CONS_TX_BUF_SIZE - cons->tx_tail) {
+			memcpy(cons->tx_buf + cons->tx_tail, addr, len);
+		} else {
+			seg = MLXBF_TMFIFO_CONS_TX_BUF_SIZE - cons->tx_tail;
+			memcpy(cons->tx_buf + cons->tx_tail, addr, seg);
+			addr += seg;
+			memcpy(cons->tx_buf, addr, len - seg);
+		}
+		mlxbf_tmfifo_vdev_tx_buf_index_inc(&cons->tx_tail, len);
+
+		if (!(virtio16_to_cpu(vdev, desc->flags) & VRING_DESC_F_NEXT))
+			break;
+		idx = virtio16_to_cpu(vdev, desc->next);
+		desc = &vr->desc[idx];
+	}
+}
+
+/* Copy console data into the output buffer. */
+static void mlxbf_tmfifo_console_output(struct mlxbf_tmfifo_vdev *cons,
+					struct virtqueue *vq)
+{
+	struct vring *vr = (struct vring *)virtqueue_get_vring(vq);
+	struct virtio_device *vdev = &cons->vdev;
+	struct vring_desc *desc;
+	u32 len;
+
+	desc = mlxbf_tmfifo_get_next_desc(vq);
+	while (desc) {
+		/* Release the packet if not enough space. */
+		len = mlxbf_tmfifo_get_pkt_len(vdev, desc, vr);
+		if (len > mlxbf_tmfifo_vdev_tx_buf_avail(cons)) {
+			mlxbf_tmfifo_release_desc(vdev, vr, desc, len);
+			break;
+		}
+
+		/* Output this packet. */
+		mlxbf_tmfifo_console_output_one(cons, vdev, vr, desc);
+
+		/* Release the head desc. */
+		mlxbf_tmfifo_release_desc(vdev, vr, desc, len);
+
+		/* Get next packet. */
+		desc = mlxbf_tmfifo_get_next_desc(vq);
+	}
+}
+
+/* Get the number of available words in Rx FIFO for receiving. */
+static int mlxbf_tmfifo_get_rx_avail(struct mlxbf_tmfifo *fifo)
+{
+	u64 sts;
+
+	sts = readq(fifo->rx_base + MLXBF_TMFIFO_RX_STS);
+	return FIELD_GET(MLXBF_TMFIFO_RX_STS__COUNT_MASK, sts);
+}
+
+/* Get the number of available words in the TmFifo for sending. */
+static int mlxbf_tmfifo_get_tx_avail(struct mlxbf_tmfifo *fifo,
+				     struct mlxbf_tmfifo_vring *vring)
+{
+	int tx_reserve;
+	u64 sts;
+
+	/* Reserve some room in FIFO for console messages. */
+	if (vring->vdev_id == VIRTIO_ID_NET)
+		tx_reserve = fifo->tx_fifo_size / MLXBF_TMFIFO_RESERVE_RATIO;
+	else
+		tx_reserve = 1;
+
+	sts = readq(fifo->tx_base + MLXBF_TMFIFO_TX_STS);
+	return (fifo->tx_fifo_size - tx_reserve -
+		FIELD_GET(MLXBF_TMFIFO_TX_STS__COUNT_MASK, sts));
+}
+
+/* Console Tx (move data from the output buffer into the TmFifo). */
+static void mlxbf_tmfifo_console_tx(struct mlxbf_tmfifo *fifo, int avail)
+{
+	union mlxbf_tmfifo_msg_hdr hdr;
+	struct mlxbf_tmfifo_vdev *cons;
+	unsigned long flags;
+	int size, partial;
+	void *addr;
+	u64 data;
+
+	/* Return if not enough space available. */
+	if (avail < MLXBF_TMFIFO_DATA_MIN_WORDS)
+		return;
+
+	cons = fifo->vdev[VIRTIO_ID_CONSOLE];
+	if (!cons || !cons->tx_buf)
+		return;
+
+	/* Return if no data to send. */
+	size = mlxbf_tmfifo_vdev_tx_buf_len(cons);
+	if (size == 0)
+		return;
+
+	/* Adjust the size to available space. */
+	if (size + sizeof(hdr) > avail * sizeof(u64))
+		size = avail * sizeof(u64) - sizeof(hdr);
+
+	/* Write header. */
+	hdr.u.data = 0;
+	hdr.type = VIRTIO_ID_CONSOLE;
+	hdr.len = htons(size);
+	hdr.u.data_le = cpu_to_le64(hdr.u.data);
+	writeq(hdr.u.data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
+
+	spin_lock_irqsave(&fifo->spin_lock, flags);
+
+	while (size > 0) {
+		addr = cons->tx_buf + cons->tx_head;
+
+		if (cons->tx_head + sizeof(u64) <=
+		    MLXBF_TMFIFO_CONS_TX_BUF_SIZE) {
+			memcpy(&data, addr, sizeof(u64));
+		} else {
+			partial = MLXBF_TMFIFO_CONS_TX_BUF_SIZE - cons->tx_head;
+			memcpy(&data, addr, partial);
+			memcpy((u8 *)&data + partial, cons->tx_buf,
+			       sizeof(u64) - partial);
+		}
+		writeq(data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
+
+		if (size >= sizeof(u64)) {
+			mlxbf_tmfifo_vdev_tx_buf_index_inc(&cons->tx_head,
+							   sizeof(u64));
+			size -= sizeof(u64);
+		} else {
+			mlxbf_tmfifo_vdev_tx_buf_index_inc(&cons->tx_head,
+							   size);
+			size = 0;
+		}
+	}
+
+	spin_unlock_irqrestore(&fifo->spin_lock, flags);
+}
+
+/* Rx/Tx one word in the descriptor buffer. */
+static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo *fifo,
+				   struct virtio_device *vdev,
+				   struct mlxbf_tmfifo_vring *vring,
+				   struct vring_desc *desc,
+				   bool is_rx, int *avail, int len)
+{
+	union mlxbf_tmfifo_data_64bit u;
+	void *addr;
+
+	/* Get the buffer address of this desc. */
+	addr = phys_to_virt(virtio64_to_cpu(vdev, desc->addr));
+
+	/* Read a word from FIFO for Rx. */
+	if (is_rx) {
+		u.data = readq(fifo->rx_base + MLXBF_TMFIFO_RX_DATA);
+		u.data = le64_to_cpu(u.data_le);
+	}
+
+	if (vring->cur_len + sizeof(u64) <= len) {
+		/* The whole word. */
+		if (is_rx)
+			memcpy(addr + vring->cur_len, &u.data, sizeof(u64));
+		else
+			memcpy(&u.data, addr + vring->cur_len, sizeof(u64));
+		vring->cur_len += sizeof(u64);
+	} else {
+		/* Leftover bytes. */
+		if (WARN_ON(vring->cur_len > len))
+			return;
+		if (is_rx)
+			memcpy(addr + vring->cur_len, &u.data,
+			       len - vring->cur_len);
+		else
+			memcpy(&u.data, addr + vring->cur_len,
+			       len - vring->cur_len);
+		vring->cur_len = len;
+	}
+
+	/* Write the word into FIFO for Tx. */
+	if (!is_rx) {
+		u.data_le = cpu_to_le64(u.data);
+		writeq(u.data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
+	}
+
+	(*avail)--;
+}
+
+/*
+ * Rx/Tx packet header.
+ *
+ * In Rx case, the packet might be found to belong to a different vring since
+ * the TmFifo is shared by different services. In such case, the 'vring_change'
+ * flag is set.
+ */
+static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo *fifo,
+				     struct virtio_device *vdev,
+				     struct mlxbf_tmfifo_vring *vring,
+				     struct vring *vr,
+				     struct vring_desc *desc,
+				     bool is_rx, int *avail,
+				     int *vring_change)
+{
+	struct virtio_net_config *config;
+	union mlxbf_tmfifo_msg_hdr hdr;
+	int vdev_id;
+	int hdr_len;
+
+	/* Update the available data in the FIFO for the header. */
+	(*avail)--;
+
+	/* Read/Write packet header. */
+	if (is_rx) {
+		/* Drain one word from the FIFO. */
+		hdr.u.data = readq(fifo->rx_base + MLXBF_TMFIFO_RX_DATA);
+		hdr.u.data = le64_to_cpu(hdr.u.data_le);
+
+		/* Skip the length 0 packets (keepalive). */
+		if (hdr.len == 0)
+			return;
+
+		/* Check packet type. */
+		if (hdr.type == VIRTIO_ID_NET) {
+			vdev_id = VIRTIO_ID_NET;
+			hdr_len = sizeof(struct virtio_net_hdr);
+			config = &fifo->vdev[vdev_id]->config.net;
+			if (ntohs(hdr.len) > config->mtu +
+			    MLXBF_TMFIFO_NET_L2_OVERHEAD)
+				return;
+		} else {
+			vdev_id = VIRTIO_ID_CONSOLE;
+			hdr_len = 0;
+		}
+
+		/*
+		 * Check whether the new packet still belongs to this vring.
+		 * If not, update the pkt_len of the new vring.
+		 */
+		if (vdev_id != vring->vdev_id) {
+			struct mlxbf_tmfifo_vdev *dev2 = fifo->vdev[vdev_id];
+
+			if (!dev2)
+				return;
+			vring->desc = desc;
+			vring = &dev2->vrings[MLXBF_TMFIFO_VRING_RX];
+			*vring_change = 1;
+		}
+		vring->pkt_len = ntohs(hdr.len) + hdr_len;
+	} else {
+		/* Network virtio has an extra header. */
+		hdr_len = (vring->vdev_id == VIRTIO_ID_NET) ?
+			   sizeof(struct virtio_net_hdr) : 0;
+		vring->pkt_len = mlxbf_tmfifo_get_pkt_len(vdev, desc, vr);
+		hdr.u.data = 0;
+		hdr.type = (vring->vdev_id == VIRTIO_ID_NET) ?
+			    VIRTIO_ID_NET : VIRTIO_ID_CONSOLE;
+		hdr.len = htons(vring->pkt_len - hdr_len);
+		hdr.u.data_le = cpu_to_le64(hdr.u.data);
+		writeq(hdr.u.data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
+	}
+
+	vring->cur_len = hdr_len;
+	vring->rem_len = vring->pkt_len;
+	fifo->vring[is_rx] = vring;
+}
+
+/*
+ * Rx/Tx one descriptor.
+ *
+ * Return true to indicate more data available.
+ */
+static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo *fifo,
+				       struct mlxbf_tmfifo_vring *vring,
+				       bool is_rx, int *avail)
+{
+	struct virtio_device *vdev;
+	struct vring_desc *desc;
+	unsigned long flags;
+	struct vring *vr;
+	u32 len, idx;
+
+	vdev = &fifo->vdev[vring->vdev_id]->vdev;
+
+	/* Get the descriptor of the next packet. */
+	desc = vring->desc;
+	if (!desc) {
+		desc = mlxbf_tmfifo_get_next_pkt(vdev, vring, is_rx);
+		if (!desc)
+			return false;
+	}
+
+	vr = (struct vring *)virtqueue_get_vring(vring->vq);
+
+	/* Beginning of a packet. Start to Rx/Tx packet header. */
+	if (vring->pkt_len == 0) {
+		int vring_change = 0;
+
+		mlxbf_tmfifo_rxtx_header(fifo, vdev, vring, vr, desc, is_rx,
+					 avail, &vring_change);
+		/* Return if new packet is for another ring. */
+		if (vring_change)
+			return false;
+		goto done;
+	}
+
+	/* Get the length of this desc. */
+	len = virtio32_to_cpu(vdev, desc->len);
+	if (len > vring->rem_len)
+		len = vring->rem_len;
+
+	/* Rx/Tx one word (8 bytes) if not done. */
+	if (vring->cur_len != len)
+		mlxbf_tmfifo_rxtx_word(fifo, vdev, vring, desc, is_rx, avail,
+				       len);
+
+	/* Check again whether it's done. */
+	if (vring->cur_len == len) {
+		vring->cur_len = 0;
+		vring->rem_len -= len;
+
+		/* Get the next desc on the chain. */
+		if (vring->rem_len > 0 &&
+		    (virtio16_to_cpu(vdev, desc->flags) & VRING_DESC_F_NEXT)) {
+			idx = virtio16_to_cpu(vdev, desc->next);
+			desc = &vr->desc[idx];
+			goto done;
+		}
+
+		/* Done and release the desc. */
+		mlxbf_tmfifo_release_pkt(vdev, vring, &desc);
+		fifo->vring[is_rx] = NULL;
+
+		/* Notify upper layer that packet is done. */
+		spin_lock_irqsave(&fifo->spin_lock, flags);
+		vring_interrupt(0, vring->vq);
+		spin_unlock_irqrestore(&fifo->spin_lock, flags);
+	}
+
+done:
+	/* Save the current desc. */
+	vring->desc = desc;
+
+	return true;
+}
+
+/* Rx & Tx processing of a queue. */
+static void mlxbf_tmfifo_rxtx(struct virtqueue *vq, bool is_rx)
+{
+	struct mlxbf_tmfifo_vring *vring;
+	struct mlxbf_tmfifo *fifo;
+	int avail = 0;
+	bool more;
+
+	vring = (struct mlxbf_tmfifo_vring *)vq->priv;
+	fifo = vring->fifo;
+
+	/* Return if vdev is not ready. */
+	if (!fifo->vdev[vring->vdev_id])
+		return;
+
+	/* Return if another vring is running. */
+	if (fifo->vring[is_rx] && fifo->vring[is_rx] != vring)
+		return;
+
+	/* Only handle console and network for now. */
+	if (WARN_ON(vring->vdev_id != VIRTIO_ID_NET &&
+		    vring->vdev_id != VIRTIO_ID_CONSOLE))
+		return;
+
+	do {
+		/* Get available FIFO space. */
+		if (avail == 0) {
+			if (is_rx)
+				avail = mlxbf_tmfifo_get_rx_avail(fifo);
+			else
+				avail = mlxbf_tmfifo_get_tx_avail(fifo, vring);
+			if (avail <= 0)
+				break;
+		}
+
+		/* Console output always comes from the Tx buffer. */
+		if (!is_rx && vring->vdev_id == VIRTIO_ID_CONSOLE) {
+			mlxbf_tmfifo_console_tx(fifo, avail);
+			break;
+		}
+
+		/* Try to handle one descriptor. */
+		more = mlxbf_tmfifo_rxtx_one_desc(fifo, vring, is_rx, &avail);
+	} while (more);
+}
+
+/* Handle Rx or Tx queues. */
+static void mlxbf_tmfifo_work_rxtx(struct mlxbf_tmfifo *fifo, int queue_id,
+				   int irq_id, bool is_rx)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+	struct virtqueue *vq;
+	int i;
+
+	if (!test_and_clear_bit(irq_id, &fifo->pend_events) ||
+	    !fifo->irq_info[irq_id].irq)
+		return;
+
+	for (i = 0; i < MLXBF_TMFIFO_VDEV_MAX; i++) {
+		tm_vdev = fifo->vdev[i];
+		if (tm_vdev) {
+			vq = tm_vdev->vrings[queue_id].vq;
+			if (vq)
+				mlxbf_tmfifo_rxtx(vq, is_rx);
+		}
+	}
+}
+
+/* Work handler for Rx and Tx case. */
+static void mlxbf_tmfifo_work_handler(struct work_struct *work)
+{
+	struct mlxbf_tmfifo *fifo;
+
+	fifo = container_of(work, struct mlxbf_tmfifo, work);
+	if (!fifo->is_ready)
+		return;
+
+	mutex_lock(&fifo->lock);
+
+	/* Tx (Send data to the TmFifo). */
+	mlxbf_tmfifo_work_rxtx(fifo, MLXBF_TMFIFO_VRING_TX,
+			       MLXBF_TM_TX_LWM_IRQ, false);
+
+	/* Rx (Receive data from the TmFifo). */
+	mlxbf_tmfifo_work_rxtx(fifo, MLXBF_TMFIFO_VRING_RX,
+			       MLXBF_TM_RX_HWM_IRQ, true);
+
+	mutex_unlock(&fifo->lock);
+}
+
+/* The notify function is called when new buffers are posted. */
+static bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq)
+{
+	struct mlxbf_tmfifo_vring *vring;
+	struct mlxbf_tmfifo_vdev *vdev;
+	struct mlxbf_tmfifo *fifo;
+	unsigned long flags;
+
+	vring = (struct mlxbf_tmfifo_vring *)vq->priv;
+	fifo = vring->fifo;
+
+	/*
+	 * Virtio maintains vrings in pairs, even number ring for Rx
+	 * and odd number ring for Tx.
+	 */
+	if (!(vring->id & 1)) {
+		/* Set the RX HWM bit to start Rx. */
+		if (!test_and_set_bit(MLXBF_TM_RX_HWM_IRQ, &fifo->pend_events))
+			schedule_work(&fifo->work);
+	} else {
+		/*
+		 * Console could make blocking call with interrupts disabled.
+		 * In such case, the vring needs to be served right away. For
+		 * other cases, just set the TX LWM bit to start Tx in the
+		 * worker handler.
+		 */
+		if (vring->vdev_id == VIRTIO_ID_CONSOLE) {
+			spin_lock_irqsave(&fifo->spin_lock, flags);
+			vdev = fifo->vdev[VIRTIO_ID_CONSOLE];
+			mlxbf_tmfifo_console_output(vdev, vq);
+			spin_unlock_irqrestore(&fifo->spin_lock, flags);
+			schedule_work(&fifo->work);
+		} else if (!test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
+					     &fifo->pend_events)) {
+			schedule_work(&fifo->work);
+		}
+	}
+
+	return true;
+}
+
+/* Get the array of feature bits for this device. */
+static u64 mlxbf_tmfifo_virtio_get_features(struct virtio_device *vdev)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+	return tm_vdev->features;
+}
+
+/* Confirm device features to use. */
+static int mlxbf_tmfifo_virtio_finalize_features(struct virtio_device *vdev)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+	tm_vdev->features = vdev->features;
+
+	return 0;
+}
+
+/* Free virtqueues found by find_vqs(). */
+static void mlxbf_tmfifo_virtio_del_vqs(struct virtio_device *vdev)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+	struct mlxbf_tmfifo_vring *vring;
+	struct virtqueue *vq;
+	int i;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+
+	for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
+		vring = &tm_vdev->vrings[i];
+
+		/* Release the pending packet. */
+		if (vring->desc)
+			mlxbf_tmfifo_release_pkt(&tm_vdev->vdev, vring,
+						 &vring->desc);
+		vq = vring->vq;
+		if (vq) {
+			vring->vq = NULL;
+			vring_del_virtqueue(vq);
+		}
+	}
+}
+
+/* Create and initialize the virtual queues. */
+static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
+					unsigned int nvqs,
+					struct virtqueue *vqs[],
+					vq_callback_t *callbacks[],
+					const char * const names[],
+					const bool *ctx,
+					struct irq_affinity *desc)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+	struct mlxbf_tmfifo_vring *vring;
+	struct virtqueue *vq;
+	int i, ret, size;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+	if (nvqs > ARRAY_SIZE(tm_vdev->vrings))
+		return -EINVAL;
+
+	for (i = 0; i < nvqs; ++i) {
+		if (!names[i]) {
+			ret = -EINVAL;
+			goto error;
+		}
+		vring = &tm_vdev->vrings[i];
+
+		/* zero vring */
+		size = vring_size(vring->size, vring->align);
+		memset(vring->va, 0, size);
+		vq = vring_new_virtqueue(i, vring->size, vring->align, vdev,
+					 false, false, vring->va,
+					 mlxbf_tmfifo_virtio_notify,
+					 callbacks[i], names[i]);
+		if (!vq) {
+			dev_err(&vdev->dev, "vring_new_virtqueue failed\n");
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		vqs[i] = vq;
+		vring->vq = vq;
+		vq->priv = vring;
+	}
+
+	return 0;
+
+error:
+	mlxbf_tmfifo_virtio_del_vqs(vdev);
+	return ret;
+}
+
+/* Read the status byte. */
+static u8 mlxbf_tmfifo_virtio_get_status(struct virtio_device *vdev)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+
+	return tm_vdev->status;
+}
+
+/* Write the status byte. */
+static void mlxbf_tmfifo_virtio_set_status(struct virtio_device *vdev,
+					   u8 status)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+	tm_vdev->status = status;
+}
+
+/* Reset the device. Not much here for now. */
+static void mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+	tm_vdev->status = 0;
+}
+
+/* Read the value of a configuration field. */
+static void mlxbf_tmfifo_virtio_get(struct virtio_device *vdev,
+				    unsigned int offset,
+				    void *buf,
+				    unsigned int len)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+
+	if (offset + len > sizeof(tm_vdev->config)) {
+		dev_err(vdev->dev.parent, "virtio_get out of bounds\n");
+		return;
+	}
+
+	memcpy(buf, (u8 *)&tm_vdev->config + offset, len);
+}
+
+/* Write the value of a configuration field. */
+static void mlxbf_tmfifo_virtio_set(struct virtio_device *vdev,
+				    unsigned int offset,
+				    const void *buf,
+				    unsigned int len)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+
+	tm_vdev = container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
+
+	if (offset + len > sizeof(tm_vdev->config)) {
+		dev_err(vdev->dev.parent, "virtio_set out of bounds\n");
+		return;
+	}
+
+	memcpy((u8 *)&tm_vdev->config + offset, buf, len);
+}
+
+/* Virtio config operations. */
+static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
+	.get_features = mlxbf_tmfifo_virtio_get_features,
+	.finalize_features = mlxbf_tmfifo_virtio_finalize_features,
+	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
+	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
+	.reset = mlxbf_tmfifo_virtio_reset,
+	.set_status = mlxbf_tmfifo_virtio_set_status,
+	.get_status = mlxbf_tmfifo_virtio_get_status,
+	.get = mlxbf_tmfifo_virtio_get,
+	.set = mlxbf_tmfifo_virtio_set,
+};
+
+/* Create vdev type in a tmfifo. */
+static int mlxbf_tmfifo_create_vdev(struct device *dev,
+				    struct mlxbf_tmfifo *fifo,
+				    int vdev_id, u64 features,
+				    void *config, u32 size)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+	int ret = 0;
+
+	mutex_lock(&fifo->lock);
+
+	tm_vdev = fifo->vdev[vdev_id];
+	if (tm_vdev) {
+		dev_err(dev, "vdev %d already exists\n", vdev_id);
+		ret = -EEXIST;
+		goto fail;
+	}
+
+	tm_vdev = devm_kzalloc(dev, sizeof(*tm_vdev), GFP_KERNEL);
+	if (!tm_vdev) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	tm_vdev->vdev.id.device = vdev_id;
+	tm_vdev->vdev.config = &mlxbf_tmfifo_virtio_config_ops;
+	tm_vdev->vdev.dev.parent = &fifo->pdev->dev;
+	tm_vdev->features = features;
+	if (config)
+		memcpy(&tm_vdev->config, config, size);
+	if (mlxbf_tmfifo_alloc_vrings(fifo, tm_vdev, vdev_id)) {
+		dev_err(dev, "unable to allocate vring\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+	if (vdev_id == VIRTIO_ID_CONSOLE)
+		tm_vdev->tx_buf = devm_kmalloc(dev,
+					       MLXBF_TMFIFO_CONS_TX_BUF_SIZE,
+					       GFP_KERNEL);
+	fifo->vdev[vdev_id] = tm_vdev;
+
+	/* Register the virtio device. */
+	ret = register_virtio_device(&tm_vdev->vdev);
+	if (ret) {
+		dev_err(&fifo->pdev->dev, "register_virtio_device failed\n");
+		goto register_fail;
+	}
+
+	mutex_unlock(&fifo->lock);
+	return 0;
+
+register_fail:
+	mlxbf_tmfifo_free_vrings(fifo, vdev_id);
+	fifo->vdev[vdev_id] = NULL;
+fail:
+	mutex_unlock(&fifo->lock);
+	return ret;
+}
+
+/* Delete vdev type from a tmfifo. */
+static int mlxbf_tmfifo_delete_vdev(struct mlxbf_tmfifo *fifo, int vdev_id)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev;
+
+	mutex_lock(&fifo->lock);
+
+	/* Unregister vdev. */
+	tm_vdev = fifo->vdev[vdev_id];
+	if (tm_vdev) {
+		unregister_virtio_device(&tm_vdev->vdev);
+		mlxbf_tmfifo_free_vrings(fifo, vdev_id);
+		fifo->vdev[vdev_id] = NULL;
+	}
+
+	mutex_unlock(&fifo->lock);
+
+	return 0;
+}
+
+/* Read the configured network MAC address from efi variable. */
+static void mlxbf_tmfifo_get_cfg_mac(u8 *mac)
+{
+	efi_guid_t guid = EFI_GLOBAL_VARIABLE_GUID;
+	efi_status_t status;
+	unsigned long size;
+	u8 buf[6];
+
+	size = sizeof(buf);
+	status = efi.get_variable(mlxbf_tmfifo_efi_name, &guid, NULL, &size,
+				  buf);
+	if (status == EFI_SUCCESS && size == sizeof(buf))
+		memcpy(mac, buf, sizeof(buf));
+}
+
+/* Set TmFifo thresolds which is used to trigger interrupts. */
+static void mlxbf_tmfifo_set_threshold(struct mlxbf_tmfifo *fifo)
+{
+	u64 ctl;
+
+	/* Get Tx FIFO size and set the low/high watermark. */
+	ctl = readq(fifo->tx_base + MLXBF_TMFIFO_TX_CTL);
+	fifo->tx_fifo_size =
+		FIELD_GET(MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_MASK, ctl);
+	ctl = (ctl & ~MLXBF_TMFIFO_TX_CTL__LWM_MASK) |
+		FIELD_PREP(MLXBF_TMFIFO_TX_CTL__LWM_MASK,
+			   fifo->tx_fifo_size / 2);
+	ctl = (ctl & ~MLXBF_TMFIFO_TX_CTL__HWM_MASK) |
+		FIELD_PREP(MLXBF_TMFIFO_TX_CTL__HWM_MASK,
+			   fifo->tx_fifo_size - 1);
+	writeq(ctl, fifo->tx_base + MLXBF_TMFIFO_TX_CTL);
+
+	/* Get Rx FIFO size and set the low/high watermark. */
+	ctl = readq(fifo->rx_base + MLXBF_TMFIFO_RX_CTL);
+	fifo->rx_fifo_size =
+		FIELD_GET(MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK, ctl);
+	ctl = (ctl & ~MLXBF_TMFIFO_RX_CTL__LWM_MASK) |
+		FIELD_PREP(MLXBF_TMFIFO_RX_CTL__LWM_MASK, 0);
+	ctl = (ctl & ~MLXBF_TMFIFO_RX_CTL__HWM_MASK) |
+		FIELD_PREP(MLXBF_TMFIFO_RX_CTL__HWM_MASK, 1);
+	writeq(ctl, fifo->rx_base + MLXBF_TMFIFO_RX_CTL);
+}
+
+/* Device remove function. */
+static void mlxbf_tmfifo_cleanup(struct mlxbf_tmfifo *fifo)
+{
+	int i;
+
+	mutex_lock(&mlxbf_tmfifo_lock);
+	fifo->is_ready = false;
+
+	/* Stop the timer. */
+	del_timer_sync(&fifo->timer);
+
+	/* Disable interrupts. */
+	mlxbf_tmfifo_disable_irqs(fifo);
+
+	/* Cancel the pending work. */
+	cancel_work_sync(&fifo->work);
+
+	for (i = 0; i < MLXBF_TMFIFO_VDEV_MAX; i++)
+		mlxbf_tmfifo_delete_vdev(fifo, i);
+
+	mutex_unlock(&mlxbf_tmfifo_lock);
+}
+
+/* Probe the TMFIFO. */
+static int mlxbf_tmfifo_probe(struct platform_device *pdev)
+{
+	struct virtio_net_config net_config;
+	struct resource *rx_res, *tx_res;
+	struct mlxbf_tmfifo *fifo;
+	int i, ret;
+
+	/* Get the resource of the Rx FIFO. */
+	rx_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!rx_res)
+		return -ENODEV;
+
+	/* Get the resource of the Tx FIFO. */
+	tx_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!tx_res)
+		return -ENODEV;
+
+	if (!devm_request_mem_region(&pdev->dev, rx_res->start,
+				     resource_size(rx_res), "bf-tmfifo"))
+		return -EBUSY;
+
+	if (!devm_request_mem_region(&pdev->dev, tx_res->start,
+				     resource_size(tx_res), "bf-tmfifo"))
+		return -EBUSY;
+
+	fifo = devm_kzalloc(&pdev->dev, sizeof(*fifo), GFP_KERNEL);
+	if (!fifo)
+		return -ENOMEM;
+
+	fifo->pdev = pdev;
+	platform_set_drvdata(pdev, fifo);
+
+	spin_lock_init(&fifo->spin_lock);
+	INIT_WORK(&fifo->work, mlxbf_tmfifo_work_handler);
+
+	timer_setup(&fifo->timer, mlxbf_tmfifo_timer, 0);
+
+	for (i = 0; i < MLXBF_TM_IRQ_CNT; i++) {
+		fifo->irq_info[i].index = i;
+		fifo->irq_info[i].fifo = fifo;
+		fifo->irq_info[i].irq = platform_get_irq(pdev, i);
+		ret = devm_request_irq(&pdev->dev, fifo->irq_info[i].irq,
+				       mlxbf_tmfifo_irq_handler, 0,
+				       "tmfifo", &fifo->irq_info[i]);
+		if (ret) {
+			dev_err(&pdev->dev, "devm_request_irq failed\n");
+			fifo->irq_info[i].irq = 0;
+			return ret;
+		}
+	}
+
+	fifo->rx_base = devm_ioremap(&pdev->dev, rx_res->start,
+				     resource_size(rx_res));
+	if (!fifo->rx_base)
+		return -ENOMEM;
+
+	fifo->tx_base = devm_ioremap(&pdev->dev, tx_res->start,
+				     resource_size(tx_res));
+	if (!fifo->tx_base)
+		return -ENOMEM;
+
+	mutex_init(&fifo->lock);
+
+	mlxbf_tmfifo_set_threshold(fifo);
+
+	/* Create the console vdev. */
+	ret = mlxbf_tmfifo_create_vdev(&pdev->dev, fifo, VIRTIO_ID_CONSOLE, 0,
+				       NULL, 0);
+	if (ret)
+		goto fail;
+
+	/* Create the network vdev. */
+	memset(&net_config, 0, sizeof(net_config));
+	net_config.mtu = MLXBF_TMFIFO_NET_MTU;
+	net_config.status = VIRTIO_NET_S_LINK_UP;
+	memcpy(net_config.mac, mlxbf_tmfifo_net_default_mac, 6);
+	mlxbf_tmfifo_get_cfg_mac(net_config.mac);
+	ret = mlxbf_tmfifo_create_vdev(&pdev->dev, fifo, VIRTIO_ID_NET,
+				       MLXBF_TMFIFO_NET_FEATURES, &net_config,
+				       sizeof(net_config));
+	if (ret)
+		goto fail;
+
+	mod_timer(&fifo->timer, jiffies + mlxbf_tmfifo_timer_interval);
+
+	fifo->is_ready = true;
+	return 0;
+
+fail:
+	mlxbf_tmfifo_cleanup(fifo);
+	return ret;
+}
+
+/* Device remove function. */
+static int mlxbf_tmfifo_remove(struct platform_device *pdev)
+{
+	struct mlxbf_tmfifo *fifo = platform_get_drvdata(pdev);
+
+	if (fifo)
+		mlxbf_tmfifo_cleanup(fifo);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct acpi_device_id mlxbf_tmfifo_acpi_match[] = {
+	{ "MLNXBF01", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf_tmfifo_acpi_match);
+
+static struct platform_driver mlxbf_tmfifo_driver = {
+	.probe = mlxbf_tmfifo_probe,
+	.remove = mlxbf_tmfifo_remove,
+	.driver = {
+		.name = "bf-tmfifo",
+		.acpi_match_table = mlxbf_tmfifo_acpi_match,
+	},
+};
+
+module_platform_driver(mlxbf_tmfifo_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField SoC TmFifo Driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mellanox Technologies");
-- 
1.8.3.1

