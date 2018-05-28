Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423786AbeE1LMX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938038AbeE1LMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 179/272] cxl: Check if PSL data-cache is available before issue flush request
Date: Mon, 28 May 2018 12:03:32 +0200
Message-Id: <20180528100255.757970401@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

[ Upstream commit 94322ed8e857e3b2a33cf75118051af9baaa110f ]

PSL9D doesn't have a data-cache that needs to be flushed before
resetting the card. However when cxl tries to flush data-cache on such
a card, it times-out as PSL_Control register never indicates flush
operation complete due to missing data-cache. This is usually
indicated in the kernel logs with this message:

"WARNING: cache flush timed out"

To fix this the patch checks PSL_Debug register CDC-Field(BIT:27)
which indicates the absence of a data-cache and sets a flag
'no_data_cache' in 'struct cxl_native' to indicate this. When
cxl_data_cache_flush() is called it checks the flag and if set bails
out early without requesting a data-cache flush operation to the PSL.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/cxl/cxl.h    |    4 ++++
 drivers/misc/cxl/native.c |   11 ++++++++++-
 drivers/misc/cxl/pci.c    |   19 +++++++++++++------
 3 files changed, 27 insertions(+), 7 deletions(-)

--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -369,6 +369,9 @@ static const cxl_p2n_reg_t CXL_PSL_WED_A
 #define CXL_PSL_TFC_An_AE (1ull << (63-30)) /* Restart PSL with address error */
 #define CXL_PSL_TFC_An_R  (1ull << (63-31)) /* Restart PSL transaction */
 
+/****** CXL_PSL_DEBUG *****************************************************/
+#define CXL_PSL_DEBUG_CDC  (1ull << (63-27)) /* Coherent Data cache support */
+
 /****** CXL_XSL9_IERAT_ERAT - CAIA 2 **********************************/
 #define CXL_XSL9_IERAT_MLPID    (1ull << (63-0))  /* Match LPID */
 #define CXL_XSL9_IERAT_MPID     (1ull << (63-1))  /* Match PID */
@@ -669,6 +672,7 @@ struct cxl_native {
 	irq_hw_number_t err_hwirq;
 	unsigned int err_virq;
 	u64 ps_off;
+	bool no_data_cache; /* set if no data cache on the card */
 	const struct cxl_service_layer_ops *sl_ops;
 };
 
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -353,8 +353,17 @@ int cxl_data_cache_flush(struct cxl *ada
 	u64 reg;
 	unsigned long timeout = jiffies + (HZ * CXL_TIMEOUT);
 
-	pr_devel("Flushing data cache\n");
+	/*
+	 * Do a datacache flush only if datacache is available.
+	 * In case of PSL9D datacache absent hence flush operation.
+	 * would timeout.
+	 */
+	if (adapter->native->no_data_cache) {
+		pr_devel("No PSL data cache. Ignoring cache flush req.\n");
+		return 0;
+	}
 
+	pr_devel("Flushing data cache\n");
 	reg = cxl_p1_read(adapter, CXL_PSL_Control);
 	reg |= CXL_PSL_Control_Fr;
 	cxl_p1_write(adapter, CXL_PSL_Control, reg);
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -456,6 +456,7 @@ static int init_implementation_adapter_r
 	u64 chipid;
 	u32 phb_index;
 	u64 capp_unit_id;
+	u64 psl_debug;
 	int rc;
 
 	rc = cxl_calc_capp_routing(dev, &chipid, &phb_index, &capp_unit_id);
@@ -506,6 +507,16 @@ static int init_implementation_adapter_r
 	} else
 		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x4000000000000000ULL);
 
+	/*
+	 * Check if PSL has data-cache. We need to flush adapter datacache
+	 * when as its about to be removed.
+	 */
+	psl_debug = cxl_p1_read(adapter, CXL_PSL9_DEBUG);
+	if (psl_debug & CXL_PSL_DEBUG_CDC) {
+		dev_dbg(&dev->dev, "No data-cache present\n");
+		adapter->native->no_data_cache = true;
+	}
+
 	return 0;
 }
 
@@ -1449,10 +1460,8 @@ int cxl_pci_reset(struct cxl *adapter)
 
 	/*
 	 * The adapter is about to be reset, so ignore errors.
-	 * Not supported on P9 DD1
 	 */
-	if ((cxl_is_power8()) || (!(cxl_is_power9_dd1())))
-		cxl_data_cache_flush(adapter);
+	cxl_data_cache_flush(adapter);
 
 	/* pcie_warm_reset requests a fundamental pci reset which includes a
 	 * PERST assert/deassert.  PERST triggers a loading of the image
@@ -1936,10 +1945,8 @@ static void cxl_pci_remove_adapter(struc
 
 	/*
 	 * Flush adapter datacache as its about to be removed.
-	 * Not supported on P9 DD1.
 	 */
-	if ((cxl_is_power8()) || (!(cxl_is_power9_dd1())))
-		cxl_data_cache_flush(adapter);
+	cxl_data_cache_flush(adapter);
 
 	cxl_deconfigure_adapter(adapter);
 
