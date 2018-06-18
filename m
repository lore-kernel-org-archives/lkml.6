Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F930C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A11208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A11208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936217AbeFRLHx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:07:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:32331 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934536AbeFRLHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:07:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 04:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="238075699"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2018 04:07:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B5A6C592; Mon, 18 Jun 2018 14:07:31 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5/5] thunderbolt: Add support for runtime PM
Date:   Mon, 18 Jun 2018 14:07:31 +0300
Message-Id: <20180618110731.57427-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Thunderbolt host controller is set to RTD3 mode (Runtime D3) it is
present all the time. Because of this it is important to runtime suspend
the controller whenever possible. In case of ICM we have following rules
which all needs to be true before the host controller can be put to D3:

  - The controller firmware reports to support RTD3
  - All the connected devices announce support for RTD3
  - There is no active XDomain connection

Implement this using standard Linux runtime PM APIs so that when all the
children devices are runtime suspended, the Thunderbolt host controller
PCI device is runtime suspended as well. The ICM firmware then starts
powering down power domains towards RTD3 but it can prevent this if it
detects that there is an active Display Port stream (this is not visible
to the software, though).

The Thunderbolt host controller will be runtime resumed either when
there is a remote wake event (device is connected or disconnected), or
when there is access from userspace that requires hardware access.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/domain.c  |  42 +++++++++++-
 drivers/thunderbolt/icm.c     | 119 ++++++++++++++++++++++++++++++----
 drivers/thunderbolt/nhi.c     |  38 ++++++++++-
 drivers/thunderbolt/switch.c  |  65 +++++++++++++++++--
 drivers/thunderbolt/tb.h      |  10 +++
 drivers/thunderbolt/tb_msgs.h |   4 ++
 drivers/thunderbolt/xdomain.c |  18 +++++
 7 files changed, 276 insertions(+), 20 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index b34e7f118fcf..37cf5cfc76df 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <crypto/hash.h>
@@ -132,6 +133,8 @@ static ssize_t boot_acl_show(struct device *dev, struct device_attribute *attr,
 	if (!uuids)
 		return -ENOMEM;
 
+	pm_runtime_get_sync(&tb->dev);
+
 	if (mutex_lock_interruptible(&tb->lock)) {
 		ret = -ERESTARTSYS;
 		goto out;
@@ -153,7 +156,10 @@ static ssize_t boot_acl_show(struct device *dev, struct device_attribute *attr,
 	}
 
 out:
+	pm_runtime_mark_last_busy(&tb->dev);
+	pm_runtime_put_autosuspend(&tb->dev);
 	kfree(uuids);
+
 	return ret;
 }
 
@@ -208,13 +214,18 @@ static ssize_t boot_acl_store(struct device *dev, struct device_attribute *attr,
 		goto err_free_acl;
 	}
 
+	pm_runtime_get_sync(&tb->dev);
+
 	if (mutex_lock_interruptible(&tb->lock)) {
 		ret = -ERESTARTSYS;
-		goto err_free_acl;
+		goto err_rpm_put;
 	}
 	ret = tb->cm_ops->set_boot_acl(tb, acl, tb->nboot_acl);
 	mutex_unlock(&tb->lock);
 
+err_rpm_put:
+	pm_runtime_mark_last_busy(&tb->dev);
+	pm_runtime_put_autosuspend(&tb->dev);
 err_free_acl:
 	kfree(acl);
 err_free_str:
@@ -426,6 +437,13 @@ int tb_domain_add(struct tb *tb)
 	/* This starts event processing */
 	mutex_unlock(&tb->lock);
 
+	pm_runtime_no_callbacks(&tb->dev);
+	pm_runtime_set_active(&tb->dev);
+	pm_runtime_enable(&tb->dev);
+	pm_runtime_set_autosuspend_delay(&tb->dev, TB_AUTOSUSPEND_DELAY);
+	pm_runtime_mark_last_busy(&tb->dev);
+	pm_runtime_use_autosuspend(&tb->dev);
+
 	return 0;
 
 err_domain_del:
@@ -514,6 +532,28 @@ void tb_domain_complete(struct tb *tb)
 		tb->cm_ops->complete(tb);
 }
 
+int tb_domain_runtime_suspend(struct tb *tb)
+{
+	if (tb->cm_ops->runtime_suspend) {
+		int ret = tb->cm_ops->runtime_suspend(tb);
+		if (ret)
+			return ret;
+	}
+	tb_ctl_stop(tb->ctl);
+	return 0;
+}
+
+int tb_domain_runtime_resume(struct tb *tb)
+{
+	tb_ctl_start(tb->ctl);
+	if (tb->cm_ops->runtime_resume) {
+		int ret = tb->cm_ops->runtime_resume(tb);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /**
  * tb_domain_approve_switch() - Approve switch
  * @tb: Domain the switch belongs to
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 5ed3f8a31b0a..47f00752a3c2 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -57,6 +58,7 @@
  *	     (only set when @upstream_port is not %NULL)
  * @safe_mode: ICM is in safe mode
  * @max_boot_acl: Maximum number of preboot ACL entries (%0 if not supported)
+ * @rpm: Does the controller support runtime PM (RTD3)
  * @is_supported: Checks if we can support ICM on this controller
  * @get_mode: Read and return the ICM firmware mode (optional)
  * @get_route: Find a route string for given switch
@@ -74,13 +76,14 @@ struct icm {
 	size_t max_boot_acl;
 	int vnd_cap;
 	bool safe_mode;
+	bool rpm;
 	bool (*is_supported)(struct tb *tb);
 	int (*get_mode)(struct tb *tb);
 	int (*get_route)(struct tb *tb, u8 link, u8 depth, u64 *route);
 	void (*save_devices)(struct tb *tb);
 	int (*driver_ready)(struct tb *tb,
 			    enum tb_security_level *security_level,
-			    size_t *nboot_acl);
+			    size_t *nboot_acl, bool *rpm);
 	void (*device_connected)(struct tb *tb,
 				 const struct icm_pkg_header *hdr);
 	void (*device_disconnected)(struct tb *tb,
@@ -97,6 +100,47 @@ struct icm_notification {
 	struct tb *tb;
 };
 
+struct ep_name_entry {
+	u8 len;
+	u8 type;
+	u8 data[0];
+};
+
+#define EP_NAME_INTEL_VSS	0x10
+
+/* Intel Vendor specific structure */
+struct intel_vss {
+	u16 vendor;
+	u16 model;
+	u8 mc;
+	u8 flags;
+	u16 pci_devid;
+	u32 nvm_version;
+};
+
+#define INTEL_VSS_FLAGS_RTD3	BIT(0)
+
+static const struct intel_vss *parse_intel_vss(const void *ep_name, size_t size)
+{
+	const void *end = ep_name + size;
+
+	while (ep_name < end) {
+		const struct ep_name_entry *ep = ep_name;
+
+		if (!ep->len)
+			break;
+		if (ep_name + ep->len > end)
+			break;
+
+		if (ep->type == EP_NAME_INTEL_VSS)
+			return (const struct intel_vss *)ep->data;
+
+		ep_name += ep->len;
+	}
+
+	return NULL;
+}
+
 static inline struct tb *icm_to_tb(struct icm *icm)
 {
 	return ((void *)icm - sizeof(struct tb));
@@ -267,7 +311,7 @@ static void icm_fr_save_devices(struct tb *tb)
 
 static int
 icm_fr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		    size_t *nboot_acl)
+		    size_t *nboot_acl, bool *rpm)
 {
 	struct icm_fr_pkg_driver_ready_response reply;
 	struct icm_pkg_driver_ready request = {
@@ -417,15 +461,19 @@ static int icm_fr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 }
 
 static void add_switch(struct tb_switch *parent_sw, u64 route,
-		       const uuid_t *uuid, u8 connection_id, u8 connection_key,
+		       const uuid_t *uuid, const u8 *ep_name,
+		       size_t ep_name_size, u8 connection_id, u8 connection_key,
 		       u8 link, u8 depth, enum tb_security_level security_level,
 		       bool authorized, bool boot)
 {
+	const struct intel_vss *vss;
 	struct tb_switch *sw;
 
+	pm_runtime_get_sync(&parent_sw->dev);
+
 	sw = tb_switch_alloc(parent_sw->tb, &parent_sw->dev, route);
 	if (!sw)
-		return;
+		goto out;
 
 	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
 	sw->connection_id = connection_id;
@@ -436,6 +484,10 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 	sw->security_level = security_level;
 	sw->boot = boot;
 
+	vss = parse_intel_vss(ep_name, ep_name_size);
+	if (vss)
+		sw->rpm = !!(vss->flags & INTEL_VSS_FLAGS_RTD3);
+
 	/* Link the two switches now */
 	tb_port_at(route, parent_sw)->remote = tb_upstream_port(sw);
 	tb_upstream_port(sw)->remote = tb_port_at(route, parent_sw);
@@ -443,8 +495,11 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 	if (tb_switch_add(sw)) {
 		tb_port_at(tb_route(sw), parent_sw)->remote = NULL;
 		tb_switch_put(sw);
-		return;
 	}
+
+out:
+	pm_runtime_mark_last_busy(&parent_sw->dev);
+	pm_runtime_put_autosuspend(&parent_sw->dev);
 }
 
 static void update_switch(struct tb_switch *parent_sw, struct tb_switch *sw,
@@ -484,9 +539,11 @@ static void add_xdomain(struct tb_switch *sw, u64 route,
 {
 	struct tb_xdomain *xd;
 
+	pm_runtime_get_sync(&sw->dev);
+
 	xd = tb_xdomain_alloc(sw->tb, &sw->dev, route, local_uuid, remote_uuid);
 	if (!xd)
-		return;
+		goto out;
 
 	xd->link = link;
 	xd->depth = depth;
@@ -494,6 +551,10 @@ static void add_xdomain(struct tb_switch *sw, u64 route,
 	tb_port_at(route, sw)->xdomain = xd;
 
 	tb_xdomain_add(xd);
+
+out:
+	pm_runtime_mark_last_busy(&sw->dev);
+	pm_runtime_put_autosuspend(&sw->dev);
 }
 
 static void update_xdomain(struct tb_xdomain *xd, u64 route, u8 link)
@@ -631,7 +692,8 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
-	add_switch(parent_sw, route, &pkg->ep_uuid, pkg->connection_id,
+	add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
+		   sizeof(pkg->ep_name), pkg->connection_id,
 		   pkg->connection_key, link, depth, security_level,
 		   authorized, boot);
 
@@ -781,7 +843,7 @@ icm_fr_xdomain_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 
 static int
 icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		    size_t *nboot_acl)
+		    size_t *nboot_acl, bool *rpm)
 {
 	struct icm_tr_pkg_driver_ready_response reply;
 	struct icm_pkg_driver_ready request = {
@@ -800,6 +862,9 @@ icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 	if (nboot_acl)
 		*nboot_acl = (reply.info & ICM_TR_INFO_BOOT_ACL_MASK) >>
 				ICM_TR_INFO_BOOT_ACL_SHIFT;
+	if (rpm)
+		*rpm = !!(reply.hdr.flags & ICM_TR_FLAGS_RTD3);
+
 	return 0;
 }
 
@@ -1029,7 +1094,8 @@ icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		return;
 	}
 
-	add_switch(parent_sw, route, &pkg->ep_uuid, pkg->connection_id,
+	add_switch(parent_sw, route, &pkg->ep_uuid, (const u8 *)pkg->ep_name,
+		   sizeof(pkg->ep_name), pkg->connection_id,
 		   0, 0, 0, security_level, authorized, boot);
 
 	tb_switch_put(parent_sw);
@@ -1208,7 +1274,7 @@ static int icm_ar_get_mode(struct tb *tb)
 
 static int
 icm_ar_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		    size_t *nboot_acl)
+		    size_t *nboot_acl, bool *rpm)
 {
 	struct icm_ar_pkg_driver_ready_response reply;
 	struct icm_pkg_driver_ready request = {
@@ -1227,6 +1293,9 @@ icm_ar_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 	if (nboot_acl && (reply.info & ICM_AR_INFO_BOOT_ACL_SUPPORTED))
 		*nboot_acl = (reply.info & ICM_AR_INFO_BOOT_ACL_MASK) >>
 				ICM_AR_INFO_BOOT_ACL_SHIFT;
+	if (rpm)
+		*rpm = !!(reply.hdr.flags & ICM_AR_FLAGS_RTD3);
+
 	return 0;
 }
 
@@ -1380,13 +1449,13 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 
 static int
 __icm_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		   size_t *nboot_acl)
+		   size_t *nboot_acl, bool *rpm)
 {
 	struct icm *icm = tb_priv(tb);
 	unsigned int retries = 50;
 	int ret;
 
-	ret = icm->driver_ready(tb, security_level, nboot_acl);
+	ret = icm->driver_ready(tb, security_level, nboot_acl, rpm);
 	if (ret) {
 		tb_err(tb, "failed to send driver ready to ICM\n");
 		return ret;
@@ -1656,7 +1725,8 @@ static int icm_driver_ready(struct tb *tb)
 		return 0;
 	}
 
-	ret = __icm_driver_ready(tb, &tb->security_level, &tb->nboot_acl);
+	ret = __icm_driver_ready(tb, &tb->security_level, &tb->nboot_acl,
+				 &icm->rpm);
 	if (ret)
 		return ret;
 
@@ -1762,7 +1832,7 @@ static void icm_complete(struct tb *tb)
 	 * Now all existing children should be resumed, start events
 	 * from ICM to get updated status.
 	 */
-	__icm_driver_ready(tb, NULL, NULL);
+	__icm_driver_ready(tb, NULL, NULL, NULL);
 
 	/*
 	 * We do not get notifications of devices that have been
@@ -1772,6 +1842,22 @@ static void icm_complete(struct tb *tb)
 	queue_delayed_work(tb->wq, &icm->rescan_work, msecs_to_jiffies(500));
 }
 
+static int icm_runtime_suspend(struct tb *tb)
+{
+	nhi_mailbox_cmd(tb->nhi, NHI_MAILBOX_DRV_UNLOADS, 0);
+	return 0;
+}
+
+static int icm_runtime_resume(struct tb *tb)
+{
+	/*
+	 * We can reuse the same resume functionality than with system
+	 * suspend.
+	 */
+	icm_complete(tb);
+	return 0;
+}
+
 static int icm_start(struct tb *tb)
 {
 	struct icm *icm = tb_priv(tb);
@@ -1790,6 +1876,7 @@ static int icm_start(struct tb *tb)
 	 * prevent root switch NVM upgrade on Macs for now.
 	 */
 	tb->root_switch->no_nvm_upgrade = x86_apple_machine;
+	tb->root_switch->rpm = icm->rpm;
 
 	ret = tb_switch_add(tb->root_switch);
 	if (ret) {
@@ -1838,6 +1925,8 @@ static const struct tb_cm_ops icm_ar_ops = {
 	.stop = icm_stop,
 	.suspend = icm_suspend,
 	.complete = icm_complete,
+	.runtime_suspend = icm_runtime_suspend,
+	.runtime_resume = icm_runtime_resume,
 	.handle_event = icm_handle_event,
 	.get_boot_acl = icm_ar_get_boot_acl,
 	.set_boot_acl = icm_ar_set_boot_acl,
@@ -1856,6 +1945,8 @@ static const struct tb_cm_ops icm_tr_ops = {
 	.stop = icm_stop,
 	.suspend = icm_suspend,
 	.complete = icm_complete,
+	.runtime_suspend = icm_runtime_suspend,
+	.runtime_resume = icm_runtime_resume,
 	.handle_event = icm_handle_event,
 	.get_boot_acl = icm_ar_get_boot_acl,
 	.set_boot_acl = icm_ar_set_boot_acl,
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index e3b7695fe37e..88cff05a1808 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -900,7 +900,32 @@ static void nhi_complete(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct tb *tb = pci_get_drvdata(pdev);
 
-	tb_domain_complete(tb);
+	/*
+	 * If we were runtime suspended when system suspend started,
+	 * schedule runtime resume now. It should bring the domain back
+	 * to functional state.
+	 */
+	if (pm_runtime_suspended(&pdev->dev))
+		pm_runtime_resume(&pdev->dev);
+	else
+		tb_domain_complete(tb);
+}
+
+static int nhi_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tb *tb = pci_get_drvdata(pdev);
+
+	return tb_domain_runtime_suspend(tb);
+}
+
+static int nhi_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tb *tb = pci_get_drvdata(pdev);
+
+	nhi_enable_int_throttling(tb->nhi);
+	return tb_domain_runtime_resume(tb);
 }
 
 static void nhi_shutdown(struct tb_nhi *nhi)
@@ -1048,6 +1073,11 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	pci_set_drvdata(pdev, tb);
 
+	pm_runtime_allow(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, TB_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 }
 
@@ -1056,6 +1086,10 @@ static void nhi_remove(struct pci_dev *pdev)
 	struct tb *tb = pci_get_drvdata(pdev);
 	struct tb_nhi *nhi = tb->nhi;
 
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_forbid(&pdev->dev);
+
 	tb_domain_remove(tb);
 	nhi_shutdown(nhi);
 }
@@ -1078,6 +1112,8 @@ static const struct dev_pm_ops nhi_pm_ops = {
 	.freeze = nhi_suspend,
 	.poweroff = nhi_suspend,
 	.complete = nhi_complete,
+	.runtime_suspend = nhi_runtime_suspend,
+	.runtime_resume = nhi_runtime_resume,
 };
 
 static struct pci_device_id nhi_ids[] = {
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 25758671ddf4..7442bc4c6433 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/idr.h>
 #include <linux/nvmem-provider.h>
+#include <linux/pm_runtime.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -236,8 +237,14 @@ static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
 			      size_t bytes)
 {
 	struct tb_switch *sw = priv;
+	int ret;
+
+	pm_runtime_get_sync(&sw->dev);
+	ret = dma_port_flash_read(sw->dma_port, offset, val, bytes);
+	pm_runtime_mark_last_busy(&sw->dev);
+	pm_runtime_put_autosuspend(&sw->dev);
 
-	return dma_port_flash_read(sw->dma_port, offset, val, bytes);
+	return ret;
 }
 
 static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
@@ -722,6 +729,7 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	 * the new tunnel too early.
 	 */
 	pci_lock_rescan_remove();
+	pm_runtime_get_sync(&sw->dev);
 
 	switch (val) {
 	/* Approve switch */
@@ -742,6 +750,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 		break;
 	}
 
+	pm_runtime_mark_last_busy(&sw->dev);
+	pm_runtime_put_autosuspend(&sw->dev);
 	pci_unlock_rescan_remove();
 
 	if (!ret) {
@@ -888,9 +898,18 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	nvm_clear_auth_status(sw);
 
 	if (val) {
+		if (!sw->nvm->buf) {
+			ret = -EINVAL;
+			goto exit_unlock;
+		}
+
+		pm_runtime_get_sync(&sw->dev);
 		ret = nvm_validate_and_write(sw);
-		if (ret)
+		if (ret) {
+			pm_runtime_mark_last_busy(&sw->dev);
+			pm_runtime_put_autosuspend(&sw->dev);
 			goto exit_unlock;
+		}
 
 		sw->nvm->authenticating = true;
 
@@ -898,6 +917,8 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 			ret = nvm_authenticate_host(sw);
 		else
 			ret = nvm_authenticate_device(sw);
+		pm_runtime_mark_last_busy(&sw->dev);
+		pm_runtime_put_autosuspend(&sw->dev);
 	}
 
 exit_unlock:
@@ -1023,9 +1044,29 @@ static void tb_switch_release(struct device *dev)
 	kfree(sw);
 }
 
+/*
+ * Currently only need to provide the callbacks. Everything else is handled
+ * in the connection manager.
+ */
+static int __maybe_unused tb_switch_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused tb_switch_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops tb_switch_pm_ops = {
+	SET_RUNTIME_PM_OPS(tb_switch_runtime_suspend, tb_switch_runtime_resume,
+			   NULL)
+};
+
 struct device_type tb_switch_type = {
 	.name = "thunderbolt_device",
 	.release = tb_switch_release,
+	.pm = &tb_switch_pm_ops,
 };
 
 static int tb_switch_get_generation(struct tb_switch *sw)
@@ -1365,10 +1406,21 @@ int tb_switch_add(struct tb_switch *sw)
 		return ret;
 
 	ret = tb_switch_nvm_add(sw);
-	if (ret)
+	if (ret) {
 		device_del(&sw->dev);
+		return ret;
+	}
 
-	return ret;
+	pm_runtime_set_active(&sw->dev);
+	if (sw->rpm) {
+		pm_runtime_set_autosuspend_delay(&sw->dev, TB_AUTOSUSPEND_DELAY);
+		pm_runtime_use_autosuspend(&sw->dev);
+		pm_runtime_mark_last_busy(&sw->dev);
+		pm_runtime_enable(&sw->dev);
+		pm_request_autosuspend(&sw->dev);
+	}
+
+	return 0;
 }
 
 /**
@@ -1383,6 +1435,11 @@ void tb_switch_remove(struct tb_switch *sw)
 {
 	int i;
 
+	if (sw->rpm) {
+		pm_runtime_get_sync(&sw->dev);
+		pm_runtime_disable(&sw->dev);
+	}
+
 	/* port 0 is the switch itself and never has a remote */
 	for (i = 1; i <= sw->config.max_port_number; i++) {
 		if (tb_is_upstream_port(&sw->ports[i]))
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 9d9f0ca16bfb..5067d69d0501 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -67,6 +67,7 @@ struct tb_switch_nvm {
  * @no_nvm_upgrade: Prevent NVM upgrade of this switch
  * @safe_mode: The switch is in safe-mode
  * @boot: Whether the switch was already authorized on boot or not
+ * @rpm: The switch supports runtime PM
  * @authorized: Whether the switch is authorized by user or policy
  * @work: Work used to automatically authorize a switch
  * @security_level: Switch supported security level
@@ -101,6 +102,7 @@ struct tb_switch {
 	bool no_nvm_upgrade;
 	bool safe_mode;
 	bool boot;
+	bool rpm;
 	unsigned int authorized;
 	struct work_struct work;
 	enum tb_security_level security_level;
@@ -199,6 +201,8 @@ struct tb_path {
  * @resume_noirq: Connection manager specific resume_noirq
  * @suspend: Connection manager specific suspend
  * @complete: Connection manager specific complete
+ * @runtime_suspend: Connection manager specific runtime_suspend
+ * @runtime_resume: Connection manager specific runtime_resume
  * @handle_event: Handle thunderbolt event
  * @get_boot_acl: Get boot ACL list
  * @set_boot_acl: Set boot ACL list
@@ -217,6 +221,8 @@ struct tb_cm_ops {
 	int (*resume_noirq)(struct tb *tb);
 	int (*suspend)(struct tb *tb);
 	void (*complete)(struct tb *tb);
+	int (*runtime_suspend)(struct tb *tb);
+	int (*runtime_resume)(struct tb *tb);
 	void (*handle_event)(struct tb *tb, enum tb_cfg_pkg_type,
 			     const void *buf, size_t size);
 	int (*get_boot_acl)(struct tb *tb, uuid_t *uuids, size_t nuuids);
@@ -235,6 +241,8 @@ static inline void *tb_priv(struct tb *tb)
 	return (void *)tb->privdata;
 }
 
+#define TB_AUTOSUSPEND_DELAY		15000 /* ms */
+
 /* helper functions & macros */
 
 /**
@@ -364,6 +372,8 @@ int tb_domain_suspend_noirq(struct tb *tb);
 int tb_domain_resume_noirq(struct tb *tb);
 int tb_domain_suspend(struct tb *tb);
 void tb_domain_complete(struct tb *tb);
+int tb_domain_runtime_suspend(struct tb *tb);
+int tb_domain_runtime_resume(struct tb *tb);
 int tb_domain_approve_switch(struct tb *tb, struct tb_switch *sw);
 int tb_domain_approve_switch_key(struct tb *tb, struct tb_switch *sw);
 int tb_domain_challenge_switch_key(struct tb *tb, struct tb_switch *sw);
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index bc13f8d6b804..2487e162c885 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -286,6 +286,8 @@ struct icm_ar_pkg_driver_ready_response {
 	u16 info;
 };
 
+#define ICM_AR_FLAGS_RTD3		BIT(6)
+
 #define ICM_AR_INFO_SLEVEL_MASK		GENMASK(3, 0)
 #define ICM_AR_INFO_BOOT_ACL_SHIFT	7
 #define ICM_AR_INFO_BOOT_ACL_MASK	GENMASK(11, 7)
@@ -333,6 +335,8 @@ struct icm_tr_pkg_driver_ready_response {
 	u16 reserved2;
 };
 
+#define ICM_TR_FLAGS_RTD3		BIT(6)
+
 #define ICM_TR_INFO_SLEVEL_MASK		GENMASK(2, 0)
 #define ICM_TR_INFO_BOOT_ACL_SHIFT	7
 #define ICM_TR_INFO_BOOT_ACL_MASK	GENMASK(12, 7)
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 8abb4e843085..db8bece63327 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/utsname.h>
 #include <linux/uuid.h>
 #include <linux/workqueue.h>
@@ -1129,6 +1130,14 @@ struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
 	xd->dev.groups = xdomain_attr_groups;
 	dev_set_name(&xd->dev, "%u-%llx", tb->index, route);
 
+	/*
+	 * This keeps the DMA powered on as long as we have active
+	 * connection to another host.
+	 */
+	pm_runtime_set_active(&xd->dev);
+	pm_runtime_get_noresume(&xd->dev);
+	pm_runtime_enable(&xd->dev);
+
 	return xd;
 
 err_free_local_uuid:
@@ -1174,6 +1183,15 @@ void tb_xdomain_remove(struct tb_xdomain *xd)
 
 	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
 
+	/*
+	 * Undo runtime PM here explicitly because it is possible that
+	 * the XDomain was never added to the bus and thus device_del()
+	 * is not called for it (device_del() would handle this otherwise).
+	 */
+	pm_runtime_disable(&xd->dev);
+	pm_runtime_put_noidle(&xd->dev);
+	pm_runtime_set_suspended(&xd->dev);
+
 	if (!device_is_registered(&xd->dev))
 		put_device(&xd->dev);
 	else
-- 
2.17.1

