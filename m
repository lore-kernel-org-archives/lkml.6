Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427542AbeCBMWJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:22:09 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:63506 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423607AbeCBMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:21:17 -0500
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kexec@lists.infradead.org
Cc: davem@davemloft.net, ebiederm@xmission.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC 2/2] cxgb4: collect hardware dump in kernel panic
Date: Fri,  2 Mar 2018 17:49:58 +0530
Message-Id: <733cf5bc8915394baf8f4cac0bccce648ce8938f.1519911559.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
References: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
In-Reply-To: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
References: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pre-allocate dump buffer and register callback to collect hardware/
firmware logs in kernel panic. Free dump buffer on driver unload.

Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h       |  6 ++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c | 95 +++++++++++++++++++++++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h |  4 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  | 12 +++
 4 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index d3fa53db61ee..21d095668374 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -50,6 +50,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/ptp_classify.h>
+#include <linux/crash_core.h>
 #include <asm/io.h>
 #include "t4_chip_type.h"
 #include "cxgb4_uld.h"
@@ -568,6 +569,7 @@ enum {                                 /* adapter flags */
 	FW_OFLD_CONN       = (1 << 9),
 	ROOT_NO_RELAXED_ORDERING = (1 << 10),
 	SHUTTING_DOWN	   = (1 << 11),
+	K_CRASH            = (1 << 12),
 };
 
 enum {
@@ -946,6 +948,10 @@ struct adapter {
 
 	/* Ethtool Dump */
 	struct ethtool_dump eth_dump;
+
+	/* Dump buffer for collecting logs in panic */
+	struct crash_driver_dump dump_buf;
+	struct notifier_block panic_nb;
 };
 
 /* Support for "sched-class" command to allow a TX Scheduling Class to be
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
index 143686c60234..c10d5e88321f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
@@ -383,13 +383,25 @@ static void cxgb4_cudbg_collect_entity(struct cudbg_init *pdbg_init,
 
 static int cudbg_alloc_compress_buff(struct cudbg_init *pdbg_init)
 {
+	struct adapter *adap = pdbg_init->adap;
 	u32 workspace_size;
 
 	workspace_size = cudbg_get_workspace_size();
-	pdbg_init->compress_buff = vzalloc(CUDBG_COMPRESS_BUFF_SIZE +
-					   workspace_size);
-	if (!pdbg_init->compress_buff)
-		return -ENOMEM;
+
+	if (adap->flags & K_CRASH) {
+		/* In panic scenario, the compression buffer is already
+		 * allocated. So, just update accordingly.
+		 */
+		pdbg_init->compress_buff = (u8 *)adap->dump_buf.buf +
+					   adap->dump_buf.size -
+					   workspace_size -
+					   CUDBG_COMPRESS_BUFF_SIZE;
+	} else {
+		pdbg_init->compress_buff = vzalloc(CUDBG_COMPRESS_BUFF_SIZE +
+						   workspace_size);
+		if (!pdbg_init->compress_buff)
+			return -ENOMEM;
+	}
 
 	pdbg_init->compress_buff_size = CUDBG_COMPRESS_BUFF_SIZE;
 	pdbg_init->workspace = (u8 *)pdbg_init->compress_buff +
@@ -399,6 +411,14 @@ static int cudbg_alloc_compress_buff(struct cudbg_init *pdbg_init)
 
 static void cudbg_free_compress_buff(struct cudbg_init *pdbg_init)
 {
+	struct adapter *adap = pdbg_init->adap;
+
+	/* Don't free in panic scenario.  We need the buffer to be present
+	 * in vmcore so that we can extract the dump.
+	 */
+	if (adap->flags & K_CRASH)
+		return;
+
 	if (pdbg_init->compress_buff)
 		vfree(pdbg_init->compress_buff);
 }
@@ -488,3 +508,70 @@ void cxgb4_init_ethtool_dump(struct adapter *adapter)
 	adapter->eth_dump.version = adapter->params.fw_vers;
 	adapter->eth_dump.len = 0;
 }
+
+static int cxgb4_panic_notify(struct notifier_block *this, unsigned long event,
+			      void *ptr)
+{
+	struct adapter *adap = container_of(this, struct adapter, panic_nb);
+	bool use_bd;
+	u32 len;
+
+	/* Save original value and restore after collection */
+	use_bd = adap->use_bd;
+
+	dev_info(adap->pdev_dev, "Initialized cxgb4 debug collection...");
+	adap->flags |= K_CRASH;
+
+	/* Don't contact firmware.  Directly access registers */
+	adap->use_bd = true;
+
+	len = adap->dump_buf.size;
+	cxgb4_cudbg_collect(adap, adap->dump_buf.buf, &len, CXGB4_ETH_DUMP_ALL);
+	dev_info(adap->pdev_dev, "cxgb4 debug collection done...");
+
+	/* Restore original value */
+	adap->use_bd = use_bd;
+	return NOTIFY_DONE;
+}
+
+int cxgb4_cudbg_register_crash_dump(struct adapter *adap)
+{
+	u32 wsize, len;
+	int ret;
+
+	len = sizeof(struct cudbg_hdr) +
+	      sizeof(struct cudbg_entity_hdr) * CUDBG_MAX_ENTITY;
+	len += CUDBG_DUMP_BUFF_SIZE;
+
+	/* If compression is enabled, allocate extra memory needed for
+	 * compression too.
+	 */
+	wsize = cudbg_get_workspace_size();
+	if (wsize)
+		wsize += CUDBG_COMPRESS_BUFF_SIZE;
+
+	adap->dump_buf.size = len + wsize;
+	adap->dump_buf.buf = vzalloc(adap->dump_buf.size);
+	if (!adap->dump_buf.buf)
+		return -ENOMEM;
+
+	sprintf(adap->dump_buf.name, "cxgb4_%s", adap->name);
+	adap->panic_nb.notifier_call = cxgb4_panic_notify;
+	adap->panic_nb.priority = INT_MAX;
+
+	ret = crash_driver_dump_register(&adap->dump_buf, &adap->panic_nb);
+	if (ret) {
+		vfree(adap->dump_buf.buf);
+		return ret;
+	}
+
+	return 0;
+}
+
+void cxgb4_cudbg_unregister_crash_dump(struct adapter *adap)
+{
+	if (adap->dump_buf.buf) {
+		crash_driver_dump_unregister(&adap->dump_buf);
+		vfree(adap->dump_buf.buf);
+	}
+}
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h
index ce1ac9a1c878..79261313a350 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h
@@ -41,8 +41,12 @@ enum CXGB4_ETHTOOL_DUMP_FLAGS {
 	CXGB4_ETH_DUMP_HW = (1 << 1), /* various FW and HW dumps */
 };
 
+#define CXGB4_ETH_DUMP_ALL (CXGB4_ETH_DUMP_MEM | CXGB4_ETH_DUMP_HW)
+
 u32 cxgb4_get_dump_length(struct adapter *adap, u32 flag);
 int cxgb4_cudbg_collect(struct adapter *adap, void *buf, u32 *buf_size,
 			u32 flag);
 void cxgb4_init_ethtool_dump(struct adapter *adapter);
+int cxgb4_cudbg_register_crash_dump(struct adapter *adap);
+void cxgb4_cudbg_unregister_crash_dump(struct adapter *adap);
 #endif /* __CXGB4_CUDBG_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 7b452e85de2a..64eeffe0ba45 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5291,6 +5291,16 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	setup_memwin(adapter);
+
+	/* Register panic notifier */
+	err = cxgb4_cudbg_register_crash_dump(adapter);
+	if (err) {
+		dev_warn(adapter->pdev_dev,
+			 "Fail registering panic notifier, err: %d. Continuing\n",
+			 err);
+		err = 0;
+	}
+
 	err = adap_init0(adapter);
 #ifdef CONFIG_DEBUG_FS
 	bitmap_zero(adapter->sge.blocked_fl, adapter->sge.egr_sz);
@@ -5538,6 +5548,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		destroy_workqueue(adapter->workq);
 
 	kfree(adapter->mbox_log);
+	cxgb4_cudbg_unregister_crash_dump(adapter);
 	kfree(adapter);
  out_unmap_bar0:
 	iounmap(regs);
@@ -5617,6 +5628,7 @@ static void remove_one(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	kfree(adapter->mbox_log);
 	synchronize_rcu();
+	cxgb4_cudbg_unregister_crash_dump(adapter);
 	kfree(adapter);
 }
 
-- 
2.14.1
