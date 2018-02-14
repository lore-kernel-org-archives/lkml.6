Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966557AbeBNBwg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:52:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:56118 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966454AbeBNBv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="34498949"
From: Dongwon Kim <dongwon.kim@intel.com>
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, dongwon.kim@intel.com,
        mateuszx.potrola@intel.com, sumit.semwal@linaro.org
Subject: [RFC PATCH v2 5/9] hyper_dmabuf: default backend for XEN hypervisor
Date: Tue, 13 Feb 2018 17:50:04 -0800
Message-Id: <20180214015008.9513-6-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matuesz Polrola" <mateuszx.potrola@intel.com>

The default backend for XEN hypervisor. This backend contains actual
implementation of individual methods defined in "struct hyper_dmabuf_bknd_ops"
defined as:

struct hyper_dmabuf_bknd_ops {
        /* backend initialization routine (optional) */
        int (*init)(void);

        /* backend cleanup routine (optional) */
        int (*cleanup)(void);

        /* retreiving id of current virtual machine */
        int (*get_vm_id)(void);

        /* get pages shared via hypervisor-specific method */
        int (*share_pages)(struct page **, int, int, void **);

        /* make shared pages unshared via hypervisor specific method */
        int (*unshare_pages)(void **, int);

        /* map remotely shared pages on importer's side via
         * hypervisor-specific method
         */
        struct page ** (*map_shared_pages)(unsigned long, int, int, void **);

        /* unmap and free shared pages on importer's side via
         * hypervisor-specific method
         */
        int (*unmap_shared_pages)(void **, int);

        /* initialize communication environment */
        int (*init_comm_env)(void);

        void (*destroy_comm)(void);

        /* upstream ch setup (receiving and responding) */
        int (*init_rx_ch)(int);

        /* downstream ch setup (transmitting and parsing responses) */
        int (*init_tx_ch)(int);

        int (*send_req)(int, struct hyper_dmabuf_req *, int);
};

First two methods are for extra initialization or cleaning up possibly
required for the current Hypervisor (optional). Third method
(.get_vm_id) provides a way to get current VM's id, which will be used
as an identication of source VM of shared hyper_DMABUF later.

All other methods are related to either memory sharing or inter-VM
communication, which are minimum requirement for hyper_DMABUF driver.
(Brief description of role of each method is embedded as a comment in the
definition of the structure above and header file.)

Actual implementation of each of these methods specific to XEN is under
backends/xen/. Their mappings are done as followed:

struct hyper_dmabuf_bknd_ops xen_bknd_ops = {
        .init = NULL, /* not needed for xen */
        .cleanup = NULL, /* not needed for xen */
        .get_vm_id = xen_be_get_domid,
        .share_pages = xen_be_share_pages,
        .unshare_pages = xen_be_unshare_pages,
        .map_shared_pages = (void *)xen_be_map_shared_pages,
        .unmap_shared_pages = xen_be_unmap_shared_pages,
        .init_comm_env = xen_be_init_comm_env,
        .destroy_comm = xen_be_destroy_comm,
        .init_rx_ch = xen_be_init_rx_rbuf,
        .init_tx_ch = xen_be_init_tx_rbuf,
        .send_req = xen_be_send_req,
};

A section for Hypervisor Backend has been added to

"Documentation/hyper-dmabuf-sharing.txt" accordingly

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Mateusz Polrola <mateuszx.potrola@intel.com>
---
 drivers/dma-buf/hyper_dmabuf/Kconfig               |   7 +
 drivers/dma-buf/hyper_dmabuf/Makefile              |   7 +
 .../backends/xen/hyper_dmabuf_xen_comm.c           | 941 +++++++++++++++++++++
 .../backends/xen/hyper_dmabuf_xen_comm.h           |  78 ++
 .../backends/xen/hyper_dmabuf_xen_comm_list.c      | 158 ++++
 .../backends/xen/hyper_dmabuf_xen_comm_list.h      |  67 ++
 .../backends/xen/hyper_dmabuf_xen_drv.c            |  46 +
 .../backends/xen/hyper_dmabuf_xen_drv.h            |  53 ++
 .../backends/xen/hyper_dmabuf_xen_shm.c            | 525 ++++++++++++
 .../backends/xen/hyper_dmabuf_xen_shm.h            |  46 +
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c    |  10 +
 11 files changed, 1938 insertions(+)
 create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.h

diff --git a/drivers/dma-buf/hyper_dmabuf/Kconfig b/drivers/dma-buf/hyper_dmabuf/Kconfig
index 5ebf516d65eb..68f3d6ce2c1f 100644
--- a/drivers/dma-buf/hyper_dmabuf/Kconfig
+++ b/drivers/dma-buf/hyper_dmabuf/Kconfig
@@ -20,4 +20,11 @@ config HYPER_DMABUF_SYSFS
 
 	  The location of sysfs is under "...."
 
+config HYPER_DMABUF_XEN
+        bool "Configure hyper_dmabuf for XEN hypervisor"
+        default y
+        depends on HYPER_DMABUF && XEN && XENFS
+        help
+          Enabling Hyper_DMABUF Backend for XEN hypervisor
+
 endmenu
diff --git a/drivers/dma-buf/hyper_dmabuf/Makefile b/drivers/dma-buf/hyper_dmabuf/Makefile
index 3908522b396a..b9ab4eeca6f2 100644
--- a/drivers/dma-buf/hyper_dmabuf/Makefile
+++ b/drivers/dma-buf/hyper_dmabuf/Makefile
@@ -10,6 +10,13 @@ ifneq ($(KERNELRELEASE),)
 				 hyper_dmabuf_msg.o \
 				 hyper_dmabuf_id.o \
 
+ifeq ($(CONFIG_HYPER_DMABUF_XEN), y)
+	$(TARGET_MODULE)-objs += backends/xen/hyper_dmabuf_xen_comm.o \
+				 backends/xen/hyper_dmabuf_xen_comm_list.o \
+				 backends/xen/hyper_dmabuf_xen_shm.o \
+				 backends/xen/hyper_dmabuf_xen_drv.o
+endif
+
 obj-$(CONFIG_HYPER_DMABUF) := $(TARGET_MODULE).o
 
 # If we are running without kernel build system
diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
new file mode 100644
index 000000000000..30bc4b6304ac
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.c
@@ -0,0 +1,941 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Dongwon Kim <dongwon.kim@intel.com>
+ *    Mateusz Polrola <mateuszx.potrola@intel.com>
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <xen/grant_table.h>
+#include <xen/events.h>
+#include <xen/xenbus.h>
+#include <asm/xen/page.h>
+#include "hyper_dmabuf_xen_comm.h"
+#include "hyper_dmabuf_xen_comm_list.h"
+#include "../../hyper_dmabuf_drv.h"
+
+static int export_req_id;
+
+struct hyper_dmabuf_req req_pending = {0};
+
+static void xen_get_domid_delayed(struct work_struct *unused);
+static void xen_init_comm_env_delayed(struct work_struct *unused);
+
+static DECLARE_DELAYED_WORK(get_vm_id_work, xen_get_domid_delayed);
+static DECLARE_DELAYED_WORK(xen_init_comm_env_work, xen_init_comm_env_delayed);
+
+/* Creates entry in xen store that will keep details of all
+ * exporter rings created by this domain
+ */
+static int xen_comm_setup_data_dir(void)
+{
+	char buf[255];
+
+	sprintf(buf, "/local/domain/%d/data/hyper_dmabuf",
+		hy_drv_priv->domid);
+
+	return xenbus_mkdir(XBT_NIL, buf, "");
+}
+
+/* Removes entry from xenstore with exporter ring details.
+ * Other domains that has connected to any of exporter rings
+ * created by this domain, will be notified about removal of
+ * this entry and will treat that as signal to cleanup importer
+ * rings created for this domain
+ */
+static int xen_comm_destroy_data_dir(void)
+{
+	char buf[255];
+
+	sprintf(buf, "/local/domain/%d/data/hyper_dmabuf",
+		hy_drv_priv->domid);
+
+	return xenbus_rm(XBT_NIL, buf, "");
+}
+
+/* Adds xenstore entries with details of exporter ring created
+ * for given remote domain. It requires special daemon running
+ * in dom0 to make sure that given remote domain will have right
+ * permissions to access that data.
+ */
+static int xen_comm_expose_ring_details(int domid, int rdomid,
+					int gref, int port)
+{
+	char buf[255];
+	int ret;
+
+	sprintf(buf, "/local/domain/%d/data/hyper_dmabuf/%d",
+		domid, rdomid);
+
+	ret = xenbus_printf(XBT_NIL, buf, "grefid", "%d", gref);
+
+	if (ret) {
+		dev_err(hy_drv_priv->dev,
+			"Failed to write xenbus entry %s: %d\n",
+			buf, ret);
+
+		return ret;
+	}
+
+	ret = xenbus_printf(XBT_NIL, buf, "port", "%d", port);
+
+	if (ret) {
+		dev_err(hy_drv_priv->dev,
+			"Failed to write xenbus entry %s: %d\n",
+			buf, ret);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Queries details of ring exposed by remote domain.
+ */
+static int xen_comm_get_ring_details(int domid, int rdomid,
+				     int *grefid, int *port)
+{
+	char buf[255];
+	int ret;
+
+	sprintf(buf, "/local/domain/%d/data/hyper_dmabuf/%d",
+		rdomid, domid);
+
+	ret = xenbus_scanf(XBT_NIL, buf, "grefid", "%d", grefid);
+
+	if (ret <= 0) {
+		dev_err(hy_drv_priv->dev,
+			"Failed to read xenbus entry %s: %d\n",
+			buf, ret);
+
+		return ret;
+	}
+
+	ret = xenbus_scanf(XBT_NIL, buf, "port", "%d", port);
+
+	if (ret <= 0) {
+		dev_err(hy_drv_priv->dev,
+			"Failed to read xenbus entry %s: %d\n",
+			buf, ret);
+
+		return ret;
+	}
+
+	return (ret <= 0 ? 1 : 0);
+}
+
+static void xen_get_domid_delayed(struct work_struct *unused)
+{
+	struct xenbus_transaction xbt;
+	int domid, ret;
+
+	/* scheduling another if driver is still running
+	 * and xenstore has not been initialized
+	 */
+	if (likely(xenstored_ready == 0)) {
+		dev_dbg(hy_drv_priv->dev,
+			"Xenstore is not ready yet. Will retry in 500ms\n");
+		schedule_delayed_work(&get_vm_id_work, msecs_to_jiffies(500));
+	} else {
+		xenbus_transaction_start(&xbt);
+
+		ret = xenbus_scanf(xbt, "domid", "", "%d", &domid);
+
+		if (ret <= 0)
+			domid = -1;
+
+		xenbus_transaction_end(xbt, 0);
+
+		/* try again since -1 is an invalid id for domain
+		 * (but only if driver is still running)
+		 */
+		if (unlikely(domid == -1)) {
+			dev_dbg(hy_drv_priv->dev,
+				"domid==-1 is invalid. Will retry it in 500ms\n");
+			schedule_delayed_work(&get_vm_id_work,
+					      msecs_to_jiffies(500));
+		} else {
+			dev_info(hy_drv_priv->dev,
+				 "Successfully retrieved domid from Xenstore:%d\n",
+				 domid);
+			hy_drv_priv->domid = domid;
+		}
+	}
+}
+
+int xen_be_get_domid(void)
+{
+	struct xenbus_transaction xbt;
+	int domid;
+
+	if (unlikely(xenstored_ready == 0)) {
+		xen_get_domid_delayed(NULL);
+		return -1;
+	}
+
+	xenbus_transaction_start(&xbt);
+
+	if (!xenbus_scanf(xbt, "domid", "", "%d", &domid))
+		domid = -1;
+
+	xenbus_transaction_end(xbt, 0);
+
+	return domid;
+}
+
+static int xen_comm_next_req_id(void)
+{
+	export_req_id++;
+	return export_req_id;
+}
+
+/* For now cache latast rings as global variables TODO: keep them in list*/
+static irqreturn_t front_ring_isr(int irq, void *info);
+static irqreturn_t back_ring_isr(int irq, void *info);
+
+/* Callback function that will be called on any change of xenbus path
+ * being watched. Used for detecting creation/destruction of remote
+ * domain exporter ring.
+ *
+ * When remote domain's exporter ring will be detected, importer ring
+ * on this domain will be created.
+ *
+ * When remote domain's exporter ring destruction will be detected it
+ * will celanup this domain importer ring.
+ *
+ * Destruction can be caused by unloading module by remote domain or
+ * it's crash/force shutdown.
+ */
+static void remote_dom_exporter_watch_cb(struct xenbus_watch *watch,
+					 const char *path, const char *token)
+{
+	int rdom, ret;
+	uint32_t grefid, port;
+	struct xen_comm_rx_ring_info *ring_info;
+
+	/* Check which domain has changed its exporter rings */
+	ret = sscanf(watch->node, "/local/domain/%d/", &rdom);
+	if (ret <= 0)
+		return;
+
+	/* Check if we have importer ring for given remote domain already
+	 * created
+	 */
+	ring_info = xen_comm_find_rx_ring(rdom);
+
+	/* Try to query remote domain exporter ring details - if
+	 * that will fail and we have importer ring that means remote
+	 * domains has cleanup its exporter ring, so our importer ring
+	 * is no longer useful.
+	 *
+	 * If querying details will succeed and we don't have importer ring,
+	 * it means that remote domain has setup it for us and we should
+	 * connect to it.
+	 */
+
+	ret = xen_comm_get_ring_details(xen_be_get_domid(),
+					rdom, &grefid, &port);
+
+	if (ring_info && ret != 0) {
+		dev_info(hy_drv_priv->dev,
+			 "Remote exporter closed, cleaninup importer\n");
+		xen_be_cleanup_rx_rbuf(rdom);
+	} else if (!ring_info && ret == 0) {
+		dev_info(hy_drv_priv->dev,
+			 "Registering importer\n");
+		xen_be_init_rx_rbuf(rdom);
+	}
+}
+
+/* exporter needs to generated info for page sharing */
+int xen_be_init_tx_rbuf(int domid)
+{
+	struct xen_comm_tx_ring_info *ring_info;
+	struct xen_comm_sring *sring;
+	struct evtchn_alloc_unbound alloc_unbound;
+	struct evtchn_close close;
+
+	void *shared_ring;
+	int ret;
+
+	/* check if there's any existing tx channel in the table */
+	ring_info = xen_comm_find_tx_ring(domid);
+
+	if (ring_info) {
+		dev_info(hy_drv_priv->dev,
+			 "tx ring ch to domid = %d already exist\ngref = %d, port = %d\n",
+		ring_info->rdomain, ring_info->gref_ring, ring_info->port);
+		return 0;
+	}
+
+	ring_info = kmalloc(sizeof(*ring_info), GFP_KERNEL);
+
+	if (!ring_info)
+		return -ENOMEM;
+
+	/* from exporter to importer */
+	shared_ring = (void *)__get_free_pages(GFP_KERNEL, 1);
+	if (shared_ring == 0) {
+		kfree(ring_info);
+		return -ENOMEM;
+	}
+
+	sring = (struct xen_comm_sring *) shared_ring;
+
+	SHARED_RING_INIT(sring);
+
+	FRONT_RING_INIT(&(ring_info->ring_front), sring, PAGE_SIZE);
+
+	ring_info->gref_ring = gnttab_grant_foreign_access(domid,
+						virt_to_mfn(shared_ring),
+						0);
+	if (ring_info->gref_ring < 0) {
+		/* fail to get gref */
+		kfree(ring_info);
+		return -EFAULT;
+	}
+
+	alloc_unbound.dom = DOMID_SELF;
+	alloc_unbound.remote_dom = domid;
+	ret = HYPERVISOR_event_channel_op(EVTCHNOP_alloc_unbound,
+					  &alloc_unbound);
+	if (ret) {
+		dev_err(hy_drv_priv->dev,
+			"Cannot allocate event channel\n");
+		kfree(ring_info);
+		return -EIO;
+	}
+
+	/* setting up interrupt */
+	ret = bind_evtchn_to_irqhandler(alloc_unbound.port,
+					front_ring_isr, 0,
+					NULL, (void *) ring_info);
+
+	if (ret < 0) {
+		dev_err(hy_drv_priv->dev,
+			"Failed to setup event channel\n");
+		close.port = alloc_unbound.port;
+		HYPERVISOR_event_channel_op(EVTCHNOP_close, &close);
+		gnttab_end_foreign_access(ring_info->gref_ring, 0,
+					virt_to_mfn(shared_ring));
+		kfree(ring_info);
+		return -EIO;
+	}
+
+	ring_info->rdomain = domid;
+	ring_info->irq = ret;
+	ring_info->port = alloc_unbound.port;
+
+	mutex_init(&ring_info->lock);
+
+	dev_dbg(hy_drv_priv->dev,
+		"%s: allocated eventchannel gref %d  port: %d  irq: %d\n",
+		__func__,
+		ring_info->gref_ring,
+		ring_info->port,
+		ring_info->irq);
+
+	ret = xen_comm_add_tx_ring(ring_info);
+
+	ret = xen_comm_expose_ring_details(xen_be_get_domid(),
+					   domid,
+					   ring_info->gref_ring,
+					   ring_info->port);
+
+	/* Register watch for remote domain exporter ring.
+	 * When remote domain will setup its exporter ring,
+	 * we will automatically connect our importer ring to it.
+	 */
+	ring_info->watch.callback = remote_dom_exporter_watch_cb;
+	ring_info->watch.node = kmalloc(255, GFP_KERNEL);
+
+	if (!ring_info->watch.node) {
+		kfree(ring_info);
+		return -ENOMEM;
+	}
+
+	sprintf((char *)ring_info->watch.node,
+		"/local/domain/%d/data/hyper_dmabuf/%d/port",
+		domid, xen_be_get_domid());
+
+	register_xenbus_watch(&ring_info->watch);
+
+	return ret;
+}
+
+/* cleans up exporter ring created for given remote domain */
+void xen_be_cleanup_tx_rbuf(int domid)
+{
+	struct xen_comm_tx_ring_info *ring_info;
+	struct xen_comm_rx_ring_info *rx_ring_info;
+
+	/* check if we at all have exporter ring for given rdomain */
+	ring_info = xen_comm_find_tx_ring(domid);
+
+	if (!ring_info)
+		return;
+
+	xen_comm_remove_tx_ring(domid);
+
+	unregister_xenbus_watch(&ring_info->watch);
+	kfree(ring_info->watch.node);
+
+	/* No need to close communication channel, will be done by
+	 * this function
+	 */
+	unbind_from_irqhandler(ring_info->irq, (void *) ring_info);
+
+	/* No need to free sring page, will be freed by this function
+	 * when other side will end its access
+	 */
+	gnttab_end_foreign_access(ring_info->gref_ring, 0,
+				  (unsigned long) ring_info->ring_front.sring);
+
+	kfree(ring_info);
+
+	rx_ring_info = xen_comm_find_rx_ring(domid);
+	if (!rx_ring_info)
+		return;
+
+	BACK_RING_INIT(&(rx_ring_info->ring_back),
+		       rx_ring_info->ring_back.sring,
+		       PAGE_SIZE);
+}
+
+/* importer needs to know about shared page and port numbers for
+ * ring buffer and event channel
+ */
+int xen_be_init_rx_rbuf(int domid)
+{
+	struct xen_comm_rx_ring_info *ring_info;
+	struct xen_comm_sring *sring;
+
+	struct page *shared_ring;
+
+	struct gnttab_map_grant_ref *map_ops;
+
+	int ret;
+	int rx_gref, rx_port;
+
+	/* check if there's existing rx ring channel */
+	ring_info = xen_comm_find_rx_ring(domid);
+
+	if (ring_info) {
+		dev_info(hy_drv_priv->dev,
+			 "rx ring ch from domid = %d already exist\n",
+			 ring_info->sdomain);
+
+		return 0;
+	}
+
+	ret = xen_comm_get_ring_details(xen_be_get_domid(), domid,
+					&rx_gref, &rx_port);
+
+	if (ret) {
+		dev_err(hy_drv_priv->dev,
+			"Domain %d has not created exporter ring for current domain\n",
+			domid);
+
+		return ret;
+	}
+
+	ring_info = kmalloc(sizeof(*ring_info), GFP_KERNEL);
+
+	if (!ring_info)
+		return -ENOMEM;
+
+	ring_info->sdomain = domid;
+	ring_info->evtchn = rx_port;
+
+	map_ops = kmalloc(sizeof(*map_ops), GFP_KERNEL);
+
+	if (!map_ops) {
+		ret = -ENOMEM;
+		goto fail_no_map_ops;
+	}
+
+	if (gnttab_alloc_pages(1, &shared_ring)) {
+		ret = -ENOMEM;
+		goto fail_others;
+	}
+
+	gnttab_set_map_op(&map_ops[0],
+			  (unsigned long)pfn_to_kaddr(
+					page_to_pfn(shared_ring)),
+			  GNTMAP_host_map, rx_gref, domid);
+
+	gnttab_set_unmap_op(&ring_info->unmap_op,
+			    (unsigned long)pfn_to_kaddr(
+					page_to_pfn(shared_ring)),
+			    GNTMAP_host_map, -1);
+
+	ret = gnttab_map_refs(map_ops, NULL, &shared_ring, 1);
+	if (ret < 0) {
+		dev_err(hy_drv_priv->dev, "Cannot map ring\n");
+		ret = -EFAULT;
+		goto fail_others;
+	}
+
+	if (map_ops[0].status) {
+		dev_err(hy_drv_priv->dev, "Ring mapping failed\n");
+		ret = -EFAULT;
+		goto fail_others;
+	} else {
+		ring_info->unmap_op.handle = map_ops[0].handle;
+	}
+
+	kfree(map_ops);
+
+	sring = (struct xen_comm_sring *)pfn_to_kaddr(page_to_pfn(shared_ring));
+
+	BACK_RING_INIT(&ring_info->ring_back, sring, PAGE_SIZE);
+
+	ret = bind_interdomain_evtchn_to_irq(domid, rx_port);
+
+	if (ret < 0) {
+		ret = -EIO;
+		goto fail_others;
+	}
+
+	ring_info->irq = ret;
+
+	dev_dbg(hy_drv_priv->dev,
+		"%s: bound to eventchannel port: %d  irq: %d\n", __func__,
+		rx_port,
+		ring_info->irq);
+
+	ret = xen_comm_add_rx_ring(ring_info);
+
+	/* Setup communcation channel in opposite direction */
+	if (!xen_comm_find_tx_ring(domid))
+		ret = xen_be_init_tx_rbuf(domid);
+
+	ret = request_irq(ring_info->irq,
+			  back_ring_isr, 0,
+			  NULL, (void *)ring_info);
+
+	return ret;
+
+fail_others:
+	kfree(map_ops);
+
+fail_no_map_ops:
+	kfree(ring_info);
+
+	return ret;
+}
+
+/* clenas up importer ring create for given source domain */
+void xen_be_cleanup_rx_rbuf(int domid)
+{
+	struct xen_comm_rx_ring_info *ring_info;
+	struct xen_comm_tx_ring_info *tx_ring_info;
+	struct page *shared_ring;
+
+	/* check if we have importer ring created for given sdomain */
+	ring_info = xen_comm_find_rx_ring(domid);
+
+	if (!ring_info)
+		return;
+
+	xen_comm_remove_rx_ring(domid);
+
+	/* no need to close event channel, will be done by that function */
+	unbind_from_irqhandler(ring_info->irq, (void *)ring_info);
+
+	/* unmapping shared ring page */
+	shared_ring = virt_to_page(ring_info->ring_back.sring);
+	gnttab_unmap_refs(&ring_info->unmap_op, NULL, &shared_ring, 1);
+	gnttab_free_pages(1, &shared_ring);
+
+	kfree(ring_info);
+
+	tx_ring_info = xen_comm_find_tx_ring(domid);
+	if (!tx_ring_info)
+		return;
+
+	SHARED_RING_INIT(tx_ring_info->ring_front.sring);
+	FRONT_RING_INIT(&(tx_ring_info->ring_front),
+			tx_ring_info->ring_front.sring,
+			PAGE_SIZE);
+}
+
+#ifdef CONFIG_HYPER_DMABUF_XEN_AUTO_RX_CH_ADD
+
+static void xen_rx_ch_add_delayed(struct work_struct *unused);
+
+static DECLARE_DELAYED_WORK(xen_rx_ch_auto_add_work, xen_rx_ch_add_delayed);
+
+#define DOMID_SCAN_START	1	/*  domid = 1 */
+#define DOMID_SCAN_END		10	/* domid = 10 */
+
+static void xen_rx_ch_add_delayed(struct work_struct *unused)
+{
+	int ret;
+	char buf[128];
+	int i, dummy;
+
+	dev_dbg(hy_drv_priv->dev,
+		"Scanning new tx channel comming from another domain\n");
+
+	/* check other domains and schedule another work if driver
+	 * is still running and backend is valid
+	 */
+	if (hy_drv_priv &&
+	    hy_drv_priv->initialized) {
+		for (i = DOMID_SCAN_START; i < DOMID_SCAN_END + 1; i++) {
+			if (i == hy_drv_priv->domid)
+				continue;
+
+			sprintf(buf, "/local/domain/%d/data/hyper_dmabuf/%d",
+				i, hy_drv_priv->domid);
+
+			ret = xenbus_scanf(XBT_NIL, buf, "port", "%d", &dummy);
+
+			if (ret > 0) {
+				if (xen_comm_find_rx_ring(i) != NULL)
+					continue;
+
+				ret = xen_be_init_rx_rbuf(i);
+
+				if (!ret)
+					dev_info(hy_drv_priv->dev,
+						 "Done rx ch init for VM %d\n",
+						 i);
+			}
+		}
+
+		/* check every 10 seconds */
+		schedule_delayed_work(&xen_rx_ch_auto_add_work,
+				      msecs_to_jiffies(10000));
+	}
+}
+
+#endif /* CONFIG_HYPER_DMABUF_XEN_AUTO_RX_CH_ADD */
+
+void xen_init_comm_env_delayed(struct work_struct *unused)
+{
+	int ret;
+
+	/* scheduling another work if driver is still running
+	 * and xenstore hasn't been initialized or dom_id hasn't
+	 * been correctly retrieved.
+	 */
+	if (likely(xenstored_ready == 0 ||
+	    hy_drv_priv->domid == -1)) {
+		dev_dbg(hy_drv_priv->dev,
+			"Xenstore not ready Will re-try in 500ms\n");
+		schedule_delayed_work(&xen_init_comm_env_work,
+				      msecs_to_jiffies(500));
+	} else {
+		ret = xen_comm_setup_data_dir();
+		if (ret < 0) {
+			dev_err(hy_drv_priv->dev,
+				"Failed to create data dir in Xenstore\n");
+		} else {
+			dev_info(hy_drv_priv->dev,
+				"Successfully finished comm env init\n");
+			hy_drv_priv->initialized = true;
+
+#ifdef CONFIG_HYPER_DMABUF_XEN_AUTO_RX_CH_ADD
+			xen_rx_ch_add_delayed(NULL);
+#endif /* CONFIG_HYPER_DMABUF_XEN_AUTO_RX_CH_ADD */
+		}
+	}
+}
+
+int xen_be_init_comm_env(void)
+{
+	int ret;
+
+	xen_comm_ring_table_init();
+
+	if (unlikely(xenstored_ready == 0 ||
+	    hy_drv_priv->domid == -1)) {
+		xen_init_comm_env_delayed(NULL);
+		return -1;
+	}
+
+	ret = xen_comm_setup_data_dir();
+	if (ret < 0) {
+		dev_err(hy_drv_priv->dev,
+			"Failed to create data dir in Xenstore\n");
+	} else {
+		dev_info(hy_drv_priv->dev,
+			"Successfully finished comm env initialization\n");
+
+		hy_drv_priv->initialized = true;
+	}
+
+	return ret;
+}
+
+/* cleans up all tx/rx rings */
+static void xen_be_cleanup_all_rbufs(void)
+{
+	xen_comm_foreach_tx_ring(xen_be_cleanup_tx_rbuf);
+	xen_comm_foreach_rx_ring(xen_be_cleanup_rx_rbuf);
+}
+
+void xen_be_destroy_comm(void)
+{
+	xen_be_cleanup_all_rbufs();
+	xen_comm_destroy_data_dir();
+}
+
+int xen_be_send_req(int domid, struct hyper_dmabuf_req *req,
+			      int wait)
+{
+	struct xen_comm_front_ring *ring;
+	struct hyper_dmabuf_req *new_req;
+	struct xen_comm_tx_ring_info *ring_info;
+	int notify;
+
+	struct timeval tv_start, tv_end;
+	struct timeval tv_diff;
+
+	int timeout = 1000;
+
+	/* find a ring info for the channel */
+	ring_info = xen_comm_find_tx_ring(domid);
+	if (!ring_info) {
+		dev_err(hy_drv_priv->dev,
+			"Can't find ring info for the channel\n");
+		return -ENOENT;
+	}
+
+
+	ring = &ring_info->ring_front;
+
+	do_gettimeofday(&tv_start);
+
+	while (RING_FULL(ring)) {
+		dev_dbg(hy_drv_priv->dev, "RING_FULL\n");
+
+		if (timeout == 0) {
+			dev_err(hy_drv_priv->dev,
+				"Timeout while waiting for an entry in the ring\n");
+			return -EIO;
+		}
+		usleep_range(100, 120);
+		timeout--;
+	}
+
+	timeout = 1000;
+
+	mutex_lock(&ring_info->lock);
+
+	new_req = RING_GET_REQUEST(ring, ring->req_prod_pvt);
+	if (!new_req) {
+		mutex_unlock(&ring_info->lock);
+		dev_err(hy_drv_priv->dev,
+			"NULL REQUEST\n");
+		return -EIO;
+	}
+
+	req->req_id = xen_comm_next_req_id();
+
+	/* update req_pending with current request */
+	memcpy(&req_pending, req, sizeof(req_pending));
+
+	/* pass current request to the ring */
+	memcpy(new_req, req, sizeof(*new_req));
+
+	ring->req_prod_pvt++;
+
+	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(ring, notify);
+	if (notify)
+		notify_remote_via_irq(ring_info->irq);
+
+	if (wait) {
+		while (timeout--) {
+			if (req_pending.stat !=
+			    HYPER_DMABUF_REQ_NOT_RESPONDED)
+				break;
+			usleep_range(100, 120);
+		}
+
+		if (timeout < 0) {
+			mutex_unlock(&ring_info->lock);
+			dev_err(hy_drv_priv->dev,
+				"request timed-out\n");
+			return -EBUSY;
+		}
+
+		mutex_unlock(&ring_info->lock);
+		do_gettimeofday(&tv_end);
+
+		/* checking time duration for round-trip of a request
+		 * for debugging
+		 */
+		if (tv_end.tv_usec >= tv_start.tv_usec) {
+			tv_diff.tv_sec = tv_end.tv_sec-tv_start.tv_sec;
+			tv_diff.tv_usec = tv_end.tv_usec-tv_start.tv_usec;
+		} else {
+			tv_diff.tv_sec = tv_end.tv_sec-tv_start.tv_sec-1;
+			tv_diff.tv_usec = tv_end.tv_usec+1000000-
+					  tv_start.tv_usec;
+		}
+
+		if (tv_diff.tv_sec != 0 && tv_diff.tv_usec > 16000)
+			dev_dbg(hy_drv_priv->dev,
+				"send_req:time diff: %ld sec, %ld usec\n",
+				tv_diff.tv_sec, tv_diff.tv_usec);
+	}
+
+	mutex_unlock(&ring_info->lock);
+
+	return 0;
+}
+
+/* ISR for handling request */
+static irqreturn_t back_ring_isr(int irq, void *info)
+{
+	RING_IDX rc, rp;
+	struct hyper_dmabuf_req req;
+	struct hyper_dmabuf_resp resp;
+
+	int notify, more_to_do;
+	int ret;
+
+	struct xen_comm_rx_ring_info *ring_info;
+	struct xen_comm_back_ring *ring;
+
+	ring_info = (struct xen_comm_rx_ring_info *)info;
+	ring = &ring_info->ring_back;
+
+	dev_dbg(hy_drv_priv->dev, "%s\n", __func__);
+
+	do {
+		rc = ring->req_cons;
+		rp = ring->sring->req_prod;
+		more_to_do = 0;
+		while (rc != rp) {
+			if (RING_REQUEST_CONS_OVERFLOW(ring, rc))
+				break;
+
+			memcpy(&req, RING_GET_REQUEST(ring, rc), sizeof(req));
+			ring->req_cons = ++rc;
+
+			ret = hyper_dmabuf_msg_parse(ring_info->sdomain, &req);
+
+			if (ret > 0) {
+				/* preparing a response for the request and
+				 * send it to the requester
+				 */
+				memcpy(&resp, &req, sizeof(resp));
+				memcpy(RING_GET_RESPONSE(ring,
+							 ring->rsp_prod_pvt),
+							 &resp, sizeof(resp));
+				ring->rsp_prod_pvt++;
+
+				dev_dbg(hy_drv_priv->dev,
+					"responding to exporter for req:%d\n",
+					resp.resp_id);
+
+				RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(ring,
+								     notify);
+
+				if (notify)
+					notify_remote_via_irq(ring_info->irq);
+			}
+
+			RING_FINAL_CHECK_FOR_REQUESTS(ring, more_to_do);
+		}
+	} while (more_to_do);
+
+	return IRQ_HANDLED;
+}
+
+/* ISR for handling responses */
+static irqreturn_t front_ring_isr(int irq, void *info)
+{
+	/* front ring only care about response from back */
+	struct hyper_dmabuf_resp *resp;
+	RING_IDX i, rp;
+	int more_to_do, ret;
+
+	struct xen_comm_tx_ring_info *ring_info;
+	struct xen_comm_front_ring *ring;
+
+	ring_info = (struct xen_comm_tx_ring_info *)info;
+	ring = &ring_info->ring_front;
+
+	dev_dbg(hy_drv_priv->dev, "%s\n", __func__);
+
+	do {
+		more_to_do = 0;
+		rp = ring->sring->rsp_prod;
+		for (i = ring->rsp_cons; i != rp; i++) {
+			resp = RING_GET_RESPONSE(ring, i);
+
+			/* update pending request's status with what is
+			 * in the response
+			 */
+
+			dev_dbg(hy_drv_priv->dev,
+				"getting response from importer\n");
+
+			if (req_pending.req_id == resp->resp_id)
+				req_pending.stat = resp->stat;
+
+			if (resp->stat == HYPER_DMABUF_REQ_NEEDS_FOLLOW_UP) {
+				/* parsing response */
+				ret = hyper_dmabuf_msg_parse(ring_info->rdomain,
+					(struct hyper_dmabuf_req *)resp);
+
+				if (ret < 0) {
+					dev_err(hy_drv_priv->dev,
+						"err while parsing resp\n");
+				}
+			} else if (resp->stat == HYPER_DMABUF_REQ_PROCESSED) {
+				/* for debugging dma_buf remote synch */
+				dev_dbg(hy_drv_priv->dev,
+					"original request = 0x%x\n", resp->cmd);
+				dev_dbg(hy_drv_priv->dev,
+					"got HYPER_DMABUF_REQ_PROCESSED\n");
+			} else if (resp->stat == HYPER_DMABUF_REQ_ERROR) {
+				/* for debugging dma_buf remote synch */
+				dev_dbg(hy_drv_priv->dev,
+					"original request = 0x%x\n", resp->cmd);
+				dev_dbg(hy_drv_priv->dev,
+					"got HYPER_DMABUF_REQ_ERROR\n");
+			}
+		}
+
+		ring->rsp_cons = i;
+
+		if (i != ring->req_prod_pvt)
+			RING_FINAL_CHECK_FOR_RESPONSES(ring, more_to_do);
+		else
+			ring->sring->rsp_event = i+1;
+
+	} while (more_to_do);
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.h b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.h
new file mode 100644
index 000000000000..c0d3139ace59
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HYPER_DMABUF_XEN_COMM_H__
+#define __HYPER_DMABUF_XEN_COMM_H__
+
+#include "xen/interface/io/ring.h"
+#include "xen/xenbus.h"
+#include "../../hyper_dmabuf_msg.h"
+
+extern int xenstored_ready;
+
+DEFINE_RING_TYPES(xen_comm, struct hyper_dmabuf_req, struct hyper_dmabuf_resp);
+
+struct xen_comm_tx_ring_info {
+	struct xen_comm_front_ring ring_front;
+	int rdomain;
+	int gref_ring;
+	int irq;
+	int port;
+	struct mutex lock;
+	struct xenbus_watch watch;
+};
+
+struct xen_comm_rx_ring_info {
+	int sdomain;
+	int irq;
+	int evtchn;
+	struct xen_comm_back_ring ring_back;
+	struct gnttab_unmap_grant_ref unmap_op;
+};
+
+int xen_be_get_domid(void);
+
+int xen_be_init_comm_env(void);
+
+/* exporter needs to generated info for page sharing */
+int xen_be_init_tx_rbuf(int domid);
+
+/* importer needs to know about shared page and port numbers
+ * for ring buffer and event channel
+ */
+int xen_be_init_rx_rbuf(int domid);
+
+/* cleans up exporter ring created for given domain */
+void xen_be_cleanup_tx_rbuf(int domid);
+
+/* cleans up importer ring created for given domain */
+void xen_be_cleanup_rx_rbuf(int domid);
+
+void xen_be_destroy_comm(void);
+
+/* send request to the remote domain */
+int xen_be_send_req(int domid, struct hyper_dmabuf_req *req,
+		    int wait);
+
+#endif /* __HYPER_DMABUF_XEN_COMM_H__ */
diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.c b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.c
new file mode 100644
index 000000000000..5a8e9d9b737f
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Dongwon Kim <dongwon.kim@intel.com>
+ *    Mateusz Polrola <mateuszx.potrola@intel.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/cdev.h>
+#include <linux/hashtable.h>
+#include <xen/grant_table.h>
+#include "../../hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_xen_comm.h"
+#include "hyper_dmabuf_xen_comm_list.h"
+
+DECLARE_HASHTABLE(xen_comm_tx_ring_hash, MAX_ENTRY_TX_RING);
+DECLARE_HASHTABLE(xen_comm_rx_ring_hash, MAX_ENTRY_RX_RING);
+
+void xen_comm_ring_table_init(void)
+{
+	hash_init(xen_comm_rx_ring_hash);
+	hash_init(xen_comm_tx_ring_hash);
+}
+
+int xen_comm_add_tx_ring(struct xen_comm_tx_ring_info *ring_info)
+{
+	struct xen_comm_tx_ring_info_entry *info_entry;
+
+	info_entry = kmalloc(sizeof(*info_entry), GFP_KERNEL);
+
+	if (!info_entry)
+		return -ENOMEM;
+
+	info_entry->info = ring_info;
+
+	hash_add(xen_comm_tx_ring_hash, &info_entry->node,
+		info_entry->info->rdomain);
+
+	return 0;
+}
+
+int xen_comm_add_rx_ring(struct xen_comm_rx_ring_info *ring_info)
+{
+	struct xen_comm_rx_ring_info_entry *info_entry;
+
+	info_entry = kmalloc(sizeof(*info_entry), GFP_KERNEL);
+
+	if (!info_entry)
+		return -ENOMEM;
+
+	info_entry->info = ring_info;
+
+	hash_add(xen_comm_rx_ring_hash, &info_entry->node,
+		info_entry->info->sdomain);
+
+	return 0;
+}
+
+struct xen_comm_tx_ring_info *xen_comm_find_tx_ring(int domid)
+{
+	struct xen_comm_tx_ring_info_entry *info_entry;
+	int bkt;
+
+	hash_for_each(xen_comm_tx_ring_hash, bkt, info_entry, node)
+		if (info_entry->info->rdomain == domid)
+			return info_entry->info;
+
+	return NULL;
+}
+
+struct xen_comm_rx_ring_info *xen_comm_find_rx_ring(int domid)
+{
+	struct xen_comm_rx_ring_info_entry *info_entry;
+	int bkt;
+
+	hash_for_each(xen_comm_rx_ring_hash, bkt, info_entry, node)
+		if (info_entry->info->sdomain == domid)
+			return info_entry->info;
+
+	return NULL;
+}
+
+int xen_comm_remove_tx_ring(int domid)
+{
+	struct xen_comm_tx_ring_info_entry *info_entry;
+	int bkt;
+
+	hash_for_each(xen_comm_tx_ring_hash, bkt, info_entry, node)
+		if (info_entry->info->rdomain == domid) {
+			hash_del(&info_entry->node);
+			kfree(info_entry);
+			return 0;
+		}
+
+	return -ENOENT;
+}
+
+int xen_comm_remove_rx_ring(int domid)
+{
+	struct xen_comm_rx_ring_info_entry *info_entry;
+	int bkt;
+
+	hash_for_each(xen_comm_rx_ring_hash, bkt, info_entry, node)
+		if (info_entry->info->sdomain == domid) {
+			hash_del(&info_entry->node);
+			kfree(info_entry);
+			return 0;
+		}
+
+	return -ENOENT;
+}
+
+void xen_comm_foreach_tx_ring(void (*func)(int domid))
+{
+	struct xen_comm_tx_ring_info_entry *info_entry;
+	struct hlist_node *tmp;
+	int bkt;
+
+	hash_for_each_safe(xen_comm_tx_ring_hash, bkt, tmp,
+			   info_entry, node) {
+		func(info_entry->info->rdomain);
+	}
+}
+
+void xen_comm_foreach_rx_ring(void (*func)(int domid))
+{
+	struct xen_comm_rx_ring_info_entry *info_entry;
+	struct hlist_node *tmp;
+	int bkt;
+
+	hash_for_each_safe(xen_comm_rx_ring_hash, bkt, tmp,
+			   info_entry, node) {
+		func(info_entry->info->sdomain);
+	}
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.h b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.h
new file mode 100644
index 000000000000..8d4b52bd41b0
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_comm_list.h
@@ -0,0 +1,67 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HYPER_DMABUF_XEN_COMM_LIST_H__
+#define __HYPER_DMABUF_XEN_COMM_LIST_H__
+
+/* number of bits to be used for exported dmabufs hash table */
+#define MAX_ENTRY_TX_RING 7
+/* number of bits to be used for imported dmabufs hash table */
+#define MAX_ENTRY_RX_RING 7
+
+struct xen_comm_tx_ring_info_entry {
+	struct xen_comm_tx_ring_info *info;
+	struct hlist_node node;
+};
+
+struct xen_comm_rx_ring_info_entry {
+	struct xen_comm_rx_ring_info *info;
+	struct hlist_node node;
+};
+
+void xen_comm_ring_table_init(void);
+
+int xen_comm_add_tx_ring(struct xen_comm_tx_ring_info *ring_info);
+
+int xen_comm_add_rx_ring(struct xen_comm_rx_ring_info *ring_info);
+
+int xen_comm_remove_tx_ring(int domid);
+
+int xen_comm_remove_rx_ring(int domid);
+
+struct xen_comm_tx_ring_info *xen_comm_find_tx_ring(int domid);
+
+struct xen_comm_rx_ring_info *xen_comm_find_rx_ring(int domid);
+
+/* iterates over all exporter rings and calls provided
+ * function for each of them
+ */
+void xen_comm_foreach_tx_ring(void (*func)(int domid));
+
+/* iterates over all importer rings and calls provided
+ * function for each of them
+ */
+void xen_comm_foreach_rx_ring(void (*func)(int domid));
+
+#endif // __HYPER_DMABUF_XEN_COMM_LIST_H__
diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.c b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.c
new file mode 100644
index 000000000000..8122dc15b4cb
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Dongwon Kim <dongwon.kim@intel.com>
+ *    Mateusz Polrola <mateuszx.potrola@intel.com>
+ *
+ */
+
+#include "../../hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_xen_comm.h"
+#include "hyper_dmabuf_xen_shm.h"
+
+struct hyper_dmabuf_bknd_ops xen_bknd_ops = {
+	.init = NULL, /* not needed for xen */
+	.cleanup = NULL, /* not needed for xen */
+	.get_vm_id = xen_be_get_domid,
+	.share_pages = xen_be_share_pages,
+	.unshare_pages = xen_be_unshare_pages,
+	.map_shared_pages = (void *)xen_be_map_shared_pages,
+	.unmap_shared_pages = xen_be_unmap_shared_pages,
+	.init_comm_env = xen_be_init_comm_env,
+	.destroy_comm = xen_be_destroy_comm,
+	.init_rx_ch = xen_be_init_rx_rbuf,
+	.init_tx_ch = xen_be_init_tx_rbuf,
+	.send_req = xen_be_send_req,
+};
diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.h b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.h
new file mode 100644
index 000000000000..c97dc1c5d042
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_drv.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HYPER_DMABUF_XEN_DRV_H__
+#define __HYPER_DMABUF_XEN_DRV_H__
+#include <xen/interface/grant_table.h>
+
+extern struct hyper_dmabuf_bknd_ops xen_bknd_ops;
+
+/* Main purpose of this structure is to keep
+ * all references created or acquired for sharing
+ * pages with another domain for freeing those later
+ * when unsharing.
+ */
+struct xen_shared_pages_info {
+	/* top level refid */
+	grant_ref_t lvl3_gref;
+
+	/* page of top level addressing, it contains refids of 2nd lvl pages */
+	grant_ref_t *lvl3_table;
+
+	/* table of 2nd level pages, that contains refids to data pages */
+	grant_ref_t *lvl2_table;
+
+	/* unmap ops for mapped pages */
+	struct gnttab_unmap_grant_ref *unmap_ops;
+
+	/* data pages to be unmapped */
+	struct page **data_pages;
+};
+
+#endif // __HYPER_DMABUF_XEN_COMM_H__
diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.c b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.c
new file mode 100644
index 000000000000..b2dcef34e10f
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.c
@@ -0,0 +1,525 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Dongwon Kim <dongwon.kim@intel.com>
+ *    Mateusz Polrola <mateuszx.potrola@intel.com>
+ *
+ */
+
+#include <linux/slab.h>
+#include <xen/grant_table.h>
+#include <asm/xen/page.h>
+#include "hyper_dmabuf_xen_drv.h"
+#include "../../hyper_dmabuf_drv.h"
+
+#define REFS_PER_PAGE (PAGE_SIZE/sizeof(grant_ref_t))
+
+/*
+ * Creates 2 level page directory structure for referencing shared pages.
+ * Top level page is a single page that contains up to 1024 refids that
+ * point to 2nd level pages.
+ *
+ * Each 2nd level page contains up to 1024 refids that point to shared
+ * data pages.
+ *
+ * There will always be one top level page and number of 2nd level pages
+ * depends on number of shared data pages.
+ *
+ *      3rd level page                2nd level pages            Data pages
+ * +-------------------------+   ┌>+--------------------+ ┌>+------------+
+ * |2nd level page 0 refid   |---┘ |Data page 0 refid   |-┘ |Data page 0 |
+ * |2nd level page 1 refid   |---┐ |Data page 1 refid   |-┐ +------------+
+ * |           ...           |   | |     ....           | |
+ * |2nd level page 1023 refid|-┐ | |Data page 1023 refid| └>+------------+
+ * +-------------------------+ | | +--------------------+   |Data page 1 |
+ *                             | |                          +------------+
+ *                             | └>+--------------------+
+ *                             |   |Data page 1024 refid|
+ *                             |   |Data page 1025 refid|
+ *                             |   |       ...          |
+ *                             |   |Data page 2047 refid|
+ *                             |   +--------------------+
+ *                             |
+ *                             |        .....
+ *                             └-->+-----------------------+
+ *                                 |Data page 1047552 refid|
+ *                                 |Data page 1047553 refid|
+ *                                 |       ...             |
+ *                                 |Data page 1048575 refid|
+ *                                 +-----------------------+
+ *
+ * Using such 2 level structure it is possible to reference up to 4GB of
+ * shared data using single refid pointing to top level page.
+ *
+ * Returns refid of top level page.
+ */
+int xen_be_share_pages(struct page **pages, int domid, int nents,
+		       void **refs_info)
+{
+	grant_ref_t lvl3_gref;
+	grant_ref_t *lvl2_table;
+	grant_ref_t *lvl3_table;
+
+	/*
+	 * Calculate number of pages needed for 2nd level addresing:
+	 */
+	int n_lvl2_grefs = (nents/REFS_PER_PAGE +
+			   ((nents % REFS_PER_PAGE) ? 1 : 0));
+
+	struct xen_shared_pages_info *sh_pages_info;
+	int i;
+
+	lvl3_table = (grant_ref_t *)__get_free_pages(GFP_KERNEL, 1);
+	lvl2_table = (grant_ref_t *)__get_free_pages(GFP_KERNEL, n_lvl2_grefs);
+
+	sh_pages_info = kmalloc(sizeof(*sh_pages_info), GFP_KERNEL);
+
+	if (!sh_pages_info)
+		return -ENOMEM;
+
+	*refs_info = (void *)sh_pages_info;
+
+	/* share data pages in readonly mode for security */
+	for (i = 0; i < nents; i++) {
+		lvl2_table[i] = gnttab_grant_foreign_access(domid,
+					pfn_to_mfn(page_to_pfn(pages[i])),
+					true /* read only */);
+		if (lvl2_table[i] == -ENOSPC) {
+			dev_err(hy_drv_priv->dev,
+				"No more space left in grant table\n");
+
+			/* Unshare all already shared pages for lvl2 */
+			while (i--) {
+				gnttab_end_foreign_access_ref(lvl2_table[i], 0);
+				gnttab_free_grant_reference(lvl2_table[i]);
+			}
+			goto err_cleanup;
+		}
+	}
+
+	/* Share 2nd level addressing pages in readonly mode*/
+	for (i = 0; i < n_lvl2_grefs; i++) {
+		lvl3_table[i] = gnttab_grant_foreign_access(domid,
+					virt_to_mfn(
+					(unsigned long)lvl2_table+i*PAGE_SIZE),
+					true);
+
+		if (lvl3_table[i] == -ENOSPC) {
+			dev_err(hy_drv_priv->dev,
+				"No more space left in grant table\n");
+
+			/* Unshare all already shared pages for lvl3 */
+			while (i--) {
+				gnttab_end_foreign_access_ref(lvl3_table[i], 1);
+				gnttab_free_grant_reference(lvl3_table[i]);
+			}
+
+			/* Unshare all pages for lvl2 */
+			while (nents--) {
+				gnttab_end_foreign_access_ref(
+							lvl2_table[nents], 0);
+				gnttab_free_grant_reference(lvl2_table[nents]);
+			}
+
+			goto err_cleanup;
+		}
+	}
+
+	/* Share lvl3_table in readonly mode*/
+	lvl3_gref = gnttab_grant_foreign_access(domid,
+			virt_to_mfn((unsigned long)lvl3_table),
+			true);
+
+	if (lvl3_gref == -ENOSPC) {
+		dev_err(hy_drv_priv->dev,
+			"No more space left in grant table\n");
+
+		/* Unshare all pages for lvl3 */
+		while (i--) {
+			gnttab_end_foreign_access_ref(lvl3_table[i], 1);
+			gnttab_free_grant_reference(lvl3_table[i]);
+		}
+
+		/* Unshare all pages for lvl2 */
+		while (nents--) {
+			gnttab_end_foreign_access_ref(lvl2_table[nents], 0);
+			gnttab_free_grant_reference(lvl2_table[nents]);
+		}
+
+		goto err_cleanup;
+	}
+
+	/* Store lvl3_table page to be freed later */
+	sh_pages_info->lvl3_table = lvl3_table;
+
+	/* Store lvl2_table pages to be freed later */
+	sh_pages_info->lvl2_table = lvl2_table;
+
+
+	/* Store exported pages refid to be unshared later */
+	sh_pages_info->lvl3_gref = lvl3_gref;
+
+	dev_dbg(hy_drv_priv->dev, "%s exit\n", __func__);
+	return lvl3_gref;
+
+err_cleanup:
+	free_pages((unsigned long)lvl2_table, n_lvl2_grefs);
+	free_pages((unsigned long)lvl3_table, 1);
+
+	return -ENOSPC;
+}
+
+int xen_be_unshare_pages(void **refs_info, int nents)
+{
+	struct xen_shared_pages_info *sh_pages_info;
+	int n_lvl2_grefs = (nents/REFS_PER_PAGE +
+			    ((nents % REFS_PER_PAGE) ? 1 : 0));
+	int i;
+
+	dev_dbg(hy_drv_priv->dev, "%s entry\n", __func__);
+	sh_pages_info = (struct xen_shared_pages_info *)(*refs_info);
+
+	if (sh_pages_info->lvl3_table == NULL ||
+	    sh_pages_info->lvl2_table ==  NULL ||
+	    sh_pages_info->lvl3_gref == -1) {
+		dev_warn(hy_drv_priv->dev,
+			 "gref table for hyper_dmabuf already cleaned up\n");
+		return 0;
+	}
+
+	/* End foreign access for data pages, but do not free them */
+	for (i = 0; i < nents; i++) {
+		if (gnttab_query_foreign_access(sh_pages_info->lvl2_table[i]))
+			dev_warn(hy_drv_priv->dev, "refid not shared !!\n");
+
+		gnttab_end_foreign_access_ref(sh_pages_info->lvl2_table[i], 0);
+		gnttab_free_grant_reference(sh_pages_info->lvl2_table[i]);
+	}
+
+	/* End foreign access for 2nd level addressing pages */
+	for (i = 0; i < n_lvl2_grefs; i++) {
+		if (gnttab_query_foreign_access(sh_pages_info->lvl3_table[i]))
+			dev_warn(hy_drv_priv->dev, "refid not shared !!\n");
+
+		if (!gnttab_end_foreign_access_ref(
+					sh_pages_info->lvl3_table[i], 1))
+			dev_warn(hy_drv_priv->dev, "refid still in use!!!\n");
+
+		gnttab_free_grant_reference(sh_pages_info->lvl3_table[i]);
+	}
+
+	/* End foreign access for top level addressing page */
+	if (gnttab_query_foreign_access(sh_pages_info->lvl3_gref))
+		dev_warn(hy_drv_priv->dev, "gref not shared !!\n");
+
+	gnttab_end_foreign_access_ref(sh_pages_info->lvl3_gref, 1);
+	gnttab_free_grant_reference(sh_pages_info->lvl3_gref);
+
+	/* freeing all pages used for 2 level addressing */
+	free_pages((unsigned long)sh_pages_info->lvl2_table, n_lvl2_grefs);
+	free_pages((unsigned long)sh_pages_info->lvl3_table, 1);
+
+	sh_pages_info->lvl3_gref = -1;
+	sh_pages_info->lvl2_table = NULL;
+	sh_pages_info->lvl3_table = NULL;
+	kfree(sh_pages_info);
+	sh_pages_info = NULL;
+
+	dev_dbg(hy_drv_priv->dev, "%s exit\n", __func__);
+	return 0;
+}
+
+/* Maps provided top level ref id and then return array of pages
+ * containing data refs.
+ */
+struct page **xen_be_map_shared_pages(unsigned long lvl3_gref, int domid,
+				      int nents, void **refs_info)
+{
+	struct page *lvl3_table_page;
+	struct page **lvl2_table_pages;
+	struct page **data_pages;
+	struct xen_shared_pages_info *sh_pages_info;
+
+	grant_ref_t *lvl3_table;
+	grant_ref_t *lvl2_table;
+
+	struct gnttab_map_grant_ref lvl3_map_ops;
+	struct gnttab_unmap_grant_ref lvl3_unmap_ops;
+
+	struct gnttab_map_grant_ref *lvl2_map_ops;
+	struct gnttab_unmap_grant_ref *lvl2_unmap_ops;
+
+	struct gnttab_map_grant_ref *data_map_ops;
+	struct gnttab_unmap_grant_ref *data_unmap_ops;
+
+	/* # of grefs in the last page of lvl2 table */
+	int nents_last = (nents - 1) % REFS_PER_PAGE + 1;
+	int n_lvl2_grefs = (nents / REFS_PER_PAGE) +
+			   ((nents_last > 0) ? 1 : 0) -
+			   (nents_last == REFS_PER_PAGE);
+	int i, j, k;
+
+	dev_dbg(hy_drv_priv->dev, "%s entry\n", __func__);
+
+	sh_pages_info = kmalloc(sizeof(*sh_pages_info), GFP_KERNEL);
+	*refs_info = (void *) sh_pages_info;
+
+	lvl2_table_pages = kcalloc(n_lvl2_grefs, sizeof(struct page *),
+				   GFP_KERNEL);
+
+	data_pages = kcalloc(nents, sizeof(struct page *), GFP_KERNEL);
+
+	lvl2_map_ops = kcalloc(n_lvl2_grefs, sizeof(*lvl2_map_ops),
+			       GFP_KERNEL);
+
+	lvl2_unmap_ops = kcalloc(n_lvl2_grefs, sizeof(*lvl2_unmap_ops),
+				 GFP_KERNEL);
+
+	data_map_ops = kcalloc(nents, sizeof(*data_map_ops), GFP_KERNEL);
+	data_unmap_ops = kcalloc(nents, sizeof(*data_unmap_ops), GFP_KERNEL);
+
+	/* Map top level addressing page */
+	if (gnttab_alloc_pages(1, &lvl3_table_page)) {
+		dev_err(hy_drv_priv->dev, "Cannot allocate pages\n");
+		return NULL;
+	}
+
+	lvl3_table = (grant_ref_t *)pfn_to_kaddr(page_to_pfn(lvl3_table_page));
+
+	gnttab_set_map_op(&lvl3_map_ops, (unsigned long)lvl3_table,
+			  GNTMAP_host_map | GNTMAP_readonly,
+			  (grant_ref_t)lvl3_gref, domid);
+
+	gnttab_set_unmap_op(&lvl3_unmap_ops, (unsigned long)lvl3_table,
+			    GNTMAP_host_map | GNTMAP_readonly, -1);
+
+	if (gnttab_map_refs(&lvl3_map_ops, NULL, &lvl3_table_page, 1)) {
+		dev_err(hy_drv_priv->dev,
+			"HYPERVISOR map grant ref failed");
+		return NULL;
+	}
+
+	if (lvl3_map_ops.status) {
+		dev_err(hy_drv_priv->dev,
+			"HYPERVISOR map grant ref failed status = %d",
+			lvl3_map_ops.status);
+
+		goto error_cleanup_lvl3;
+	} else {
+		lvl3_unmap_ops.handle = lvl3_map_ops.handle;
+	}
+
+	/* Map all second level pages */
+	if (gnttab_alloc_pages(n_lvl2_grefs, lvl2_table_pages)) {
+		dev_err(hy_drv_priv->dev, "Cannot allocate pages\n");
+		goto error_cleanup_lvl3;
+	}
+
+	for (i = 0; i < n_lvl2_grefs; i++) {
+		lvl2_table = (grant_ref_t *)pfn_to_kaddr(
+					page_to_pfn(lvl2_table_pages[i]));
+		gnttab_set_map_op(&lvl2_map_ops[i],
+				  (unsigned long)lvl2_table, GNTMAP_host_map |
+				  GNTMAP_readonly,
+				  lvl3_table[i], domid);
+		gnttab_set_unmap_op(&lvl2_unmap_ops[i],
+				    (unsigned long)lvl2_table, GNTMAP_host_map |
+				    GNTMAP_readonly, -1);
+	}
+
+	/* Unmap top level page, as it won't be needed any longer */
+	if (gnttab_unmap_refs(&lvl3_unmap_ops, NULL,
+			      &lvl3_table_page, 1)) {
+		dev_err(hy_drv_priv->dev,
+			"xen: cannot unmap top level page\n");
+		return NULL;
+	}
+
+	/* Mark that page was unmapped */
+	lvl3_unmap_ops.handle = -1;
+
+	if (gnttab_map_refs(lvl2_map_ops, NULL,
+			    lvl2_table_pages, n_lvl2_grefs)) {
+		dev_err(hy_drv_priv->dev,
+			"HYPERVISOR map grant ref failed");
+		return NULL;
+	}
+
+	/* Checks if pages were mapped correctly */
+	for (i = 0; i < n_lvl2_grefs; i++) {
+		if (lvl2_map_ops[i].status) {
+			dev_err(hy_drv_priv->dev,
+				"HYPERVISOR map grant ref failed status = %d",
+				lvl2_map_ops[i].status);
+			goto error_cleanup_lvl2;
+		} else {
+			lvl2_unmap_ops[i].handle = lvl2_map_ops[i].handle;
+		}
+	}
+
+	if (gnttab_alloc_pages(nents, data_pages)) {
+		dev_err(hy_drv_priv->dev,
+			"Cannot allocate pages\n");
+		goto error_cleanup_lvl2;
+	}
+
+	k = 0;
+
+	for (i = 0; i < n_lvl2_grefs - 1; i++) {
+		lvl2_table = pfn_to_kaddr(page_to_pfn(lvl2_table_pages[i]));
+		for (j = 0; j < REFS_PER_PAGE; j++) {
+			gnttab_set_map_op(&data_map_ops[k],
+				(unsigned long)pfn_to_kaddr(
+						page_to_pfn(data_pages[k])),
+				GNTMAP_host_map | GNTMAP_readonly,
+				lvl2_table[j], domid);
+
+			gnttab_set_unmap_op(&data_unmap_ops[k],
+				(unsigned long)pfn_to_kaddr(
+						page_to_pfn(data_pages[k])),
+				GNTMAP_host_map | GNTMAP_readonly, -1);
+			k++;
+		}
+	}
+
+	/* for grefs in the last lvl2 table page */
+	lvl2_table = pfn_to_kaddr(page_to_pfn(
+				lvl2_table_pages[n_lvl2_grefs - 1]));
+
+	for (j = 0; j < nents_last; j++) {
+		gnttab_set_map_op(&data_map_ops[k],
+			(unsigned long)pfn_to_kaddr(page_to_pfn(data_pages[k])),
+			GNTMAP_host_map | GNTMAP_readonly,
+			lvl2_table[j], domid);
+
+		gnttab_set_unmap_op(&data_unmap_ops[k],
+			(unsigned long)pfn_to_kaddr(page_to_pfn(data_pages[k])),
+			GNTMAP_host_map | GNTMAP_readonly, -1);
+		k++;
+	}
+
+	if (gnttab_map_refs(data_map_ops, NULL,
+			    data_pages, nents)) {
+		dev_err(hy_drv_priv->dev,
+			"HYPERVISOR map grant ref failed\n");
+		return NULL;
+	}
+
+	/* unmapping lvl2 table pages */
+	if (gnttab_unmap_refs(lvl2_unmap_ops,
+			      NULL, lvl2_table_pages,
+			      n_lvl2_grefs)) {
+		dev_err(hy_drv_priv->dev,
+			"Cannot unmap 2nd level refs\n");
+		return NULL;
+	}
+
+	/* Mark that pages were unmapped */
+	for (i = 0; i < n_lvl2_grefs; i++)
+		lvl2_unmap_ops[i].handle = -1;
+
+	for (i = 0; i < nents; i++) {
+		if (data_map_ops[i].status) {
+			dev_err(hy_drv_priv->dev,
+				"HYPERVISOR map grant ref failed status = %d\n",
+				data_map_ops[i].status);
+			goto error_cleanup_data;
+		} else {
+			data_unmap_ops[i].handle = data_map_ops[i].handle;
+		}
+	}
+
+	/* store these references for unmapping in the future */
+	sh_pages_info->unmap_ops = data_unmap_ops;
+	sh_pages_info->data_pages = data_pages;
+
+	gnttab_free_pages(1, &lvl3_table_page);
+	gnttab_free_pages(n_lvl2_grefs, lvl2_table_pages);
+	kfree(lvl2_table_pages);
+	kfree(lvl2_map_ops);
+	kfree(lvl2_unmap_ops);
+	kfree(data_map_ops);
+
+	dev_dbg(hy_drv_priv->dev, "%s exit\n", __func__);
+	return data_pages;
+
+error_cleanup_data:
+	gnttab_unmap_refs(data_unmap_ops, NULL, data_pages,
+			  nents);
+
+	gnttab_free_pages(nents, data_pages);
+
+error_cleanup_lvl2:
+	if (lvl2_unmap_ops[0].handle != -1)
+		gnttab_unmap_refs(lvl2_unmap_ops, NULL,
+				  lvl2_table_pages, n_lvl2_grefs);
+	gnttab_free_pages(n_lvl2_grefs, lvl2_table_pages);
+
+error_cleanup_lvl3:
+	if (lvl3_unmap_ops.handle != -1)
+		gnttab_unmap_refs(&lvl3_unmap_ops, NULL,
+				  &lvl3_table_page, 1);
+	gnttab_free_pages(1, &lvl3_table_page);
+
+	kfree(lvl2_table_pages);
+	kfree(lvl2_map_ops);
+	kfree(lvl2_unmap_ops);
+	kfree(data_map_ops);
+
+
+	return NULL;
+}
+
+int xen_be_unmap_shared_pages(void **refs_info, int nents)
+{
+	struct xen_shared_pages_info *sh_pages_info;
+
+	dev_dbg(hy_drv_priv->dev, "%s entry\n", __func__);
+
+	sh_pages_info = (struct xen_shared_pages_info *)(*refs_info);
+
+	if (sh_pages_info->unmap_ops == NULL ||
+	    sh_pages_info->data_pages == NULL) {
+		dev_warn(hy_drv_priv->dev,
+			 "pages already cleaned up or buffer not imported yet\n");
+		return 0;
+	}
+
+	if (gnttab_unmap_refs(sh_pages_info->unmap_ops, NULL,
+			      sh_pages_info->data_pages, nents)) {
+		dev_err(hy_drv_priv->dev, "Cannot unmap data pages\n");
+		return -EFAULT;
+	}
+
+	gnttab_free_pages(nents, sh_pages_info->data_pages);
+
+	kfree(sh_pages_info->data_pages);
+	kfree(sh_pages_info->unmap_ops);
+	sh_pages_info->unmap_ops = NULL;
+	sh_pages_info->data_pages = NULL;
+	kfree(sh_pages_info);
+	sh_pages_info = NULL;
+
+	dev_dbg(hy_drv_priv->dev, "%s exit\n", __func__);
+	return 0;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.h b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.h
new file mode 100644
index 000000000000..c39f241351f8
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/backends/xen/hyper_dmabuf_xen_shm.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HYPER_DMABUF_XEN_SHM_H__
+#define __HYPER_DMABUF_XEN_SHM_H__
+
+/* This collects all reference numbers for 2nd level shared pages and
+ * create a table with those in 1st level shared pages then return reference
+ * numbers for this top level table.
+ */
+int xen_be_share_pages(struct page **pages, int domid, int nents,
+		    void **refs_info);
+
+int xen_be_unshare_pages(void **refs_info, int nents);
+
+/* Maps provided top level ref id and then return array of pages containing
+ * data refs.
+ */
+struct page **xen_be_map_shared_pages(unsigned long lvl3_gref, int domid,
+				      int nents,
+				      void **refs_info);
+
+int xen_be_unmap_shared_pages(void **refs_info, int nents);
+
+#endif /* __HYPER_DMABUF_XEN_SHM_H__ */
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
index 18c1cd735ea2..3320f9dcc769 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
@@ -42,6 +42,10 @@
 #include "hyper_dmabuf_list.h"
 #include "hyper_dmabuf_id.h"
 
+#ifdef CONFIG_HYPER_DMABUF_XEN
+#include "backends/xen/hyper_dmabuf_xen_drv.h"
+#endif
+
 MODULE_LICENSE("GPL and additional rights");
 MODULE_AUTHOR("Intel Corporation");
 
@@ -145,7 +149,13 @@ static int __init hyper_dmabuf_drv_init(void)
 		return ret;
 	}
 
+/* currently only supports XEN hypervisor */
+#ifdef CONFIG_HYPER_DMABUF_XEN
+	hy_drv_priv->bknd_ops = &xen_bknd_ops;
+#else
 	hy_drv_priv->bknd_ops = NULL;
+	pr_err("hyper_dmabuf drv currently supports XEN only.\n");
+#endif
 
 	if (hy_drv_priv->bknd_ops == NULL) {
 		pr_err("Hyper_dmabuf: no backend found\n");
-- 
2.16.1
