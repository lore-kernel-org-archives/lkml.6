Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2297C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0B8204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0B8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeIJCgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 22:36:16 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:52273 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeIJCgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 22:36:16 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B40F72800B3E0;
        Sun,  9 Sep 2018 23:45:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 728ED43F1A0; Sun,  9 Sep 2018 23:45:10 +0200 (CEST)
Message-Id: <58f16e7dd431381970a09683c71888dba5812c59.1536517047.git.lukas@wunner.de>
In-Reply-To: <cover.1536517047.git.lukas@wunner.de>
References: <cover.1536517047.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 9 Sep 2018 23:42:01 +0200
Subject: [PATCH 3/5] thunderbolt: Move upstream_port to struct tb
To:     Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code for ICM-controlled tunnel management stores a pointer to the
upstream port in struct icm.  We're going to need it in the code for
OS-controlled tunnel management as well, so move the pointer to
struct tb which is shared by both tunnel management methods.

Searching for the upstream port previously comprised walking upward from
the NHI until a PCIe upstream port is found.  That seems needlessly
complicated since on all known Thunderbolt controllers, the upstream
port is the NHI's grandparent, i.e. exactly two levels above.  Simplify
the search accordingly.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/domain.c | 12 +++++++
 drivers/thunderbolt/icm.c    | 65 +++++++++---------------------------
 include/linux/thunderbolt.h  |  2 ++
 3 files changed, 29 insertions(+), 50 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 092381e2accf..ba9e4ed88bf2 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -326,6 +326,7 @@ struct device_type tb_domain_type = {
 struct tb *tb_domain_alloc(struct tb_nhi *nhi, size_t privsize)
 {
 	struct tb *tb;
+	int i;
 
 	/*
 	 * Make sure the structure sizes map with that the hardware
@@ -350,6 +351,15 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, size_t privsize)
 	if (!tb->wq)
 		goto err_remove_ida;
 
+	tb->upstream = nhi->pdev;
+	for (i = 0; i < 2; i++) {
+		tb->upstream = pci_upstream_bridge(tb->upstream);
+		if (!tb->upstream) {
+			pci_err(nhi->pdev, "cannot find upstream, aborting\n");
+			goto err_destroy_wq;
+		}
+	}
+
 	tb->dev.parent = &nhi->pdev->dev;
 	tb->dev.bus = &tb_bus_type;
 	tb->dev.type = &tb_domain_type;
@@ -359,6 +369,8 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, size_t privsize)
 
 	return tb;
 
+err_destroy_wq:
+	destroy_workqueue(tb->wq);
 err_remove_ida:
 	ida_simple_remove(&tb_domain_ida, tb->index);
 err_free:
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e1e264a9a4c7..b6ce3eea3de5 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -51,11 +51,8 @@
  * struct icm - Internal connection manager private data
  * @request_lock: Makes sure only one message is send to ICM at time
  * @rescan_work: Work used to rescan the surviving switches after resume
- * @upstream_port: Pointer to the PCIe upstream port this host
- *		   controller is connected. This is only set for systems
- *		   where ICM needs to be started manually
  * @vnd_cap: Vendor defined capability where PCIe2CIO mailbox resides
- *	     (only set when @upstream_port is not %NULL)
+ *	     (only set on Macs as they require a firmware reset to use ICM)
  * @safe_mode: ICM is in safe mode
  * @max_boot_acl: Maximum number of preboot ACL entries (%0 if not supported)
  * @rpm: Does the controller support runtime PM (RTD3)
@@ -72,7 +69,6 @@
 struct icm {
 	struct mutex request_lock;
 	struct delayed_work rescan_work;
-	struct pci_dev *upstream_port;
 	size_t max_boot_acl;
 	int vnd_cap;
 	bool safe_mode;
@@ -1188,60 +1184,29 @@ icm_tr_xdomain_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 	}
 }
 
-static struct pci_dev *get_upstream_port(struct pci_dev *pdev)
-{
-	struct pci_dev *parent;
-
-	parent = pci_upstream_bridge(pdev);
-	while (parent) {
-		if (!pci_is_pcie(parent))
-			return NULL;
-		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM)
-			break;
-		parent = pci_upstream_bridge(parent);
-	}
-
-	if (!parent)
-		return NULL;
-
-	switch (parent->device) {
-	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE:
-	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE:
-	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE:
-	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE:
-	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_BRIDGE:
-		return parent;
-	}
-
-	return NULL;
-}
-
 static bool icm_ar_is_supported(struct tb *tb)
 {
-	struct pci_dev *upstream_port;
 	struct icm *icm = tb_priv(tb);
+	int cap;
 
 	/*
 	 * Starting from Alpine Ridge we can use ICM on Apple machines
 	 * as well. We just need to reset and re-enable it first.
+	 * Reset is performed through the vendor specific capability.
 	 */
 	if (!x86_apple_machine)
 		return true;
 
-	/*
-	 * Find the upstream PCIe port in case we need to do reset
-	 * through its vendor specific registers.
-	 */
-	upstream_port = get_upstream_port(tb->nhi->pdev);
-	if (upstream_port) {
-		int cap;
-
-		cap = pci_find_ext_capability(upstream_port,
+	switch (tb->upstream->device) {
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_BRIDGE:
+		cap = pci_find_ext_capability(tb->upstream,
 					      PCI_EXT_CAP_ID_VNDR);
 		if (cap > 0) {
-			icm->upstream_port = upstream_port;
 			icm->vnd_cap = cap;
-
 			return true;
 		}
 	}
@@ -1485,7 +1450,7 @@ static int pci2cio_wait_completion(struct icm *icm, unsigned long timeout_msec)
 	u32 cmd;
 
 	do {
-		pci_read_config_dword(icm->upstream_port,
+		pci_read_config_dword(icm_to_tb(icm)->upstream,
 				      icm->vnd_cap + PCIE2CIO_CMD, &cmd);
 		if (!(cmd & PCIE2CIO_CMD_START)) {
 			if (cmd & PCIE2CIO_CMD_TIMEOUT)
@@ -1502,7 +1467,7 @@ static int pci2cio_wait_completion(struct icm *icm, unsigned long timeout_msec)
 static int pcie2cio_read(struct icm *icm, enum tb_cfg_space cs,
 			 unsigned int port, unsigned int index, u32 *data)
 {
-	struct pci_dev *pdev = icm->upstream_port;
+	struct pci_dev *pdev = icm_to_tb(icm)->upstream;
 	int ret, vnd_cap = icm->vnd_cap;
 	u32 cmd;
 
@@ -1523,7 +1488,7 @@ static int pcie2cio_read(struct icm *icm, enum tb_cfg_space cs,
 static int pcie2cio_write(struct icm *icm, enum tb_cfg_space cs,
 			  unsigned int port, unsigned int index, u32 data)
 {
-	struct pci_dev *pdev = icm->upstream_port;
+	struct pci_dev *pdev = icm_to_tb(icm)->upstream;
 	int vnd_cap = icm->vnd_cap;
 	u32 cmd;
 
@@ -1543,7 +1508,7 @@ static int icm_firmware_reset(struct tb *tb, struct tb_nhi *nhi)
 	struct icm *icm = tb_priv(tb);
 	u32 val;
 
-	if (!icm->upstream_port)
+	if (!icm->vnd_cap)
 		return -ENODEV;
 
 	/* Put ARC to wait for CIO reset event to happen */
@@ -1599,7 +1564,7 @@ static int icm_reset_phy_port(struct tb *tb, int phy_port)
 	u32 val0, val1;
 	int ret;
 
-	if (!icm->upstream_port)
+	if (!icm->vnd_cap)
 		return 0;
 
 	if (phy_port) {
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index a3ed26082bc1..968fe1519f8f 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -70,6 +70,7 @@ enum tb_security_level {
  * @index: Linux assigned domain number
  * @security_level: Current security level
  * @nboot_acl: Number of boot ACLs the domain supports
+ * @upstream: Pointer to the PCIe upstream port of this host controller
  * @privdata: Private connection manager specific data
  */
 struct tb {
@@ -83,6 +84,7 @@ struct tb {
 	int index;
 	enum tb_security_level security_level;
 	size_t nboot_acl;
+	struct pci_dev *upstream;
 	unsigned long privdata[0];
 };
 
-- 
2.18.0

