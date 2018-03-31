Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeCaIwi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 04:52:38 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:25881 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeCaIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 04:52:35 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [PATCH net-next v3 3/3] cxgb4: collect hardware dump in second kernel
Date: Sat, 31 Mar 2018 14:20:58 +0530
Message-Id: <302fb326d8d15d64b5ef85471df40635f25cc890.1522483891.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <cover.1522483890.git.rahul.lakkireddy@chelsio.com>
References: <cover.1522483890.git.rahul.lakkireddy@chelsio.com>
In-Reply-To: <cover.1522483890.git.rahul.lakkireddy@chelsio.com>
References: <cover.1522483890.git.rahul.lakkireddy@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register callback to collect hardware/firmware dumps in second kernel
before hardware/firmware is initialized. The dumps for each device
will be available as elf notes in /proc/vmcore in second kernel.

Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
v3:
- Replaced all crashdd* with vmcoredd*.
- Replaced crashdd_add_dump() with vmcore_add_device_dump().
- Updated comments and commit message.

v2:
- No Changes.

Changes since rfc v2:
- Update comments and commit message for sysfs change.

rfc v2:
- Updated dump registration to the new API in patch 1.

 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h       |  4 ++++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c | 25 ++++++++++++++++++++++++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h |  3 +++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  | 10 ++++++++++
 4 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 688f95440af2..01e7aad4ce5b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -50,6 +50,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/ptp_classify.h>
+#include <linux/crash_dump.h>
 #include <asm/io.h>
 #include "t4_chip_type.h"
 #include "cxgb4_uld.h"
@@ -964,6 +965,9 @@ struct adapter {
 	struct hma_data hma;
 
 	struct srq_data *srq;
+
+	/* Dump buffer for collecting logs in kdump kernel */
+	struct vmcoredd_data vmcoredd;
 };
 
 /* Support for "sched-class" command to allow a TX Scheduling Class to be
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
index 143686c60234..76433d4fe483 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
@@ -488,3 +488,28 @@ void cxgb4_init_ethtool_dump(struct adapter *adapter)
 	adapter->eth_dump.version = adapter->params.fw_vers;
 	adapter->eth_dump.len = 0;
 }
+
+static int cxgb4_cudbg_vmcoredd_collect(struct vmcoredd_data *data, void *buf)
+{
+	struct adapter *adap = container_of(data, struct adapter, vmcoredd);
+	u32 len = data->size;
+
+	return cxgb4_cudbg_collect(adap, buf, &len, CXGB4_ETH_DUMP_ALL);
+}
+
+int cxgb4_cudbg_vmcore_add_dump(struct adapter *adap)
+{
+	struct vmcoredd_data *data = &adap->vmcoredd;
+	u32 len;
+
+	len = sizeof(struct cudbg_hdr) +
+	      sizeof(struct cudbg_entity_hdr) * CUDBG_MAX_ENTITY;
+	len += CUDBG_DUMP_BUFF_SIZE;
+
+	data->size = len;
+	snprintf(data->name, sizeof(data->name), "%s_%s", cxgb4_driver_name,
+		 adap->name);
+	data->vmcoredd_callback = cxgb4_cudbg_vmcoredd_collect;
+
+	return vmcore_add_device_dump(data);
+}
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h
index ce1ac9a1c878..ef59ba1ed968 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h
@@ -41,8 +41,11 @@ enum CXGB4_ETHTOOL_DUMP_FLAGS {
 	CXGB4_ETH_DUMP_HW = (1 << 1), /* various FW and HW dumps */
 };
 
+#define CXGB4_ETH_DUMP_ALL (CXGB4_ETH_DUMP_MEM | CXGB4_ETH_DUMP_HW)
+
 u32 cxgb4_get_dump_length(struct adapter *adap, u32 flag);
 int cxgb4_cudbg_collect(struct adapter *adap, void *buf, u32 *buf_size,
 			u32 flag);
 void cxgb4_init_ethtool_dump(struct adapter *adapter);
+int cxgb4_cudbg_vmcore_add_dump(struct adapter *adap);
 #endif /* __CXGB4_CUDBG_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 0072580e2c25..040004db4a35 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5530,6 +5530,16 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto out_free_adapter;
 
+	if (is_kdump_kernel()) {
+		/* Collect hardware state and append to /proc/vmcore */
+		err = cxgb4_cudbg_vmcore_add_dump(adapter);
+		if (err) {
+			dev_warn(adapter->pdev_dev,
+				 "Fail collecting vmcore device dump, err: %d. Continuing\n",
+				 err);
+			err = 0;
+		}
+	}
 
 	if (!is_t4(adapter->params.chip)) {
 		s_qpp = (QUEUESPERPAGEPF0_S +
-- 
2.14.1
