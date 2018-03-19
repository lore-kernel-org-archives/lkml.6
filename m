Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELuxQYfN1Go1xcysmjInnLdcH1tCHRp9dnfzx5FWL4DccCEESBAry5Vqvt6BJU9Fz34Jy5zJ
ARC-Seal: i=1; a=rsa-sha256; t=1521476832; cv=none;
        d=google.com; s=arc-20160816;
        b=lOALIxU2I2xItSjK+uOBt0etgbBxiL/Es6awPo2j5wB7YK0PEVCV7O9kyi66Vx0eVP
         SLkeLpxYXYjjqXMqt9wkYsUIknLFW0aou23jsgV8G/0QYphGE4bo6+1BQBRk/cd7w3KE
         7LWa9cKzxSAXE3asvHXhl0Y+WpWgaye2n72mgNSA9roj7MNLsaapc8RsEO7ahwGikVQt
         jZ1+J4gU7G4tTdpCWuhjeCCaCzzn85ZNbrZCbo8WwCG1i1Wp69Ugj8Ha0iSBhLti8XoD
         8TbGImQgPaakIK24n2pyF229kBCZ3XbWmZZ2zIdY02PAelzRLqWqKj+3LJjYj/GzAmDC
         Bk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gmCkY2IPXCIgbqRp8auWVyT91dODyJvt2sfn8Q9ukoc=;
        b=N1KD+g+nBOU+iMpeYOKBuB3ceUj0hZ8jwdsSlRDInCDJ9nS34y34oorm40cTaXspWo
         clJVKsSSQdE1mDojVp7VVM0RZ8GQy0hWr+fDY2KJQ5ldUvQvuYIZD4Rmzs2BXJOKyfRY
         cpMK6xR5LNvW3crQOcbH6OeSW8WIsc0YvnzF+Y9QnMGAVlu/mj3uj0Yc9AheTOR59rJE
         aM8G5sMDJpnetQU+lsU7fKqkQPlkRKDE7SclDterJVYsz4CueFyR342HgSMUOKEQtzDA
         G2Tqabf2EHxUz/oMfGg0iEh3Sg8YYWhn+jb7avG44L+VM7Gs1UtgpGg0m+XFeSWmBvbx
         v2MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="212938692"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: [PATCH 18/19] thunderbolt: Add support for Intel Titan Ridge
Date: Mon, 19 Mar 2018 19:27:02 +0300
Message-Id: <20180319162703.5331-19-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384090947255706?=
X-GMAIL-MSGID: =?utf-8?q?1595384090947255706?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Radion Mirchevsky <radion.mirchevsky@intel.com>

Intel Titan Ridge is the next Thunderbolt 3 controller. The ICM firmware
message format in Titan Ridge differs from Falcon Ridge and Alpine Ridge
somewhat because it is using route strings addressing devices. In
addition to that the DMA port of 4-channel (two port) controller is in
different port number than the previous controllers. There are some
other minor differences as well.

This patch add support for Intel Titan Ridge and the new ICM firmware
message format.

Signed-off-by: Radion Mirchevsky <radion.mirchevsky@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/dma_port.c |  28 ++-
 drivers/thunderbolt/icm.c      | 382 +++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi.c      |   2 +
 drivers/thunderbolt/nhi.h      |   5 +
 drivers/thunderbolt/switch.c   |   3 +
 drivers/thunderbolt/tb_msgs.h  | 141 +++++++++++++++
 6 files changed, 546 insertions(+), 15 deletions(-)

diff --git a/drivers/thunderbolt/dma_port.c b/drivers/thunderbolt/dma_port.c
index af6dde347bee..f2701194f810 100644
--- a/drivers/thunderbolt/dma_port.c
+++ b/drivers/thunderbolt/dma_port.c
@@ -170,24 +170,22 @@ static int dma_port_write(struct tb_ctl *ctl, const void *buffer, u64 route,
 
 static int dma_find_port(struct tb_switch *sw)
 {
-	int port, ret;
-	u32 type;
+	static const int ports[] = { 3, 5, 7 };
+	int i;
 
 	/*
-	 * The DMA (NHI) port is either 3 or 5 depending on the
-	 * controller. Try both starting from 5 which is more common.
+	 * The DMA (NHI) port is either 3, 5 or 7 depending on the
+	 * controller. Try all of them.
 	 */
-	port = 5;
-	ret = dma_port_read(sw->tb->ctl, &type, tb_route(sw), port, 2, 1,
-			    DMA_PORT_TIMEOUT);
-	if (!ret && (type & 0xffffff) == TB_TYPE_NHI)
-		return port;
-
-	port = 3;
-	ret = dma_port_read(sw->tb->ctl, &type, tb_route(sw), port, 2, 1,
-			    DMA_PORT_TIMEOUT);
-	if (!ret && (type & 0xffffff) == TB_TYPE_NHI)
-		return port;
+	for (i = 0; i < ARRAY_SIZE(ports); i++) {
+		u32 type;
+		int ret;
+
+		ret = dma_port_read(sw->tb->ctl, &type, tb_route(sw), ports[i],
+				    2, 1, DMA_PORT_TIMEOUT);
+		if (!ret && (type & 0xffffff) == TB_TYPE_NHI)
+			return ports[i];
+	}
 
 	return -ENODEV;
 }
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 93a198a17f42..6b1041677604 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -118,6 +118,12 @@ static inline u64 get_route(u32 route_hi, u32 route_lo)
 	return (u64)route_hi << 32 | route_lo;
 }
 
+static inline u64 get_parent_route(u64 route)
+{
+	int depth = tb_route_length(route);
+	return depth ? route & ~(0xffULL << (depth - 1) * TB_ROUTE_SHIFT) : 0;
+}
+
 static bool icm_match(const struct tb_cfg_request *req,
 		      const struct ctl_pkg *pkg)
 {
@@ -749,6 +755,351 @@ icm_fr_xdomain_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 	}
 }
 
+static int
+icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
+		    size_t *nboot_acl)
+{
+	struct icm_tr_pkg_driver_ready_response reply;
+	struct icm_pkg_driver_ready request = {
+		.hdr.code = ICM_DRIVER_READY,
+	};
+	int ret;
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, 20000);
+	if (ret)
+		return ret;
+
+	if (security_level)
+		*security_level = reply.info & ICM_TR_INFO_SLEVEL_MASK;
+	if (nboot_acl)
+		*nboot_acl = (reply.info & ICM_TR_INFO_BOOT_ACL_MASK) >>
+				ICM_TR_INFO_BOOT_ACL_SHIFT;
+	return 0;
+}
+
+static int icm_tr_approve_switch(struct tb *tb, struct tb_switch *sw)
+{
+	struct icm_tr_pkg_approve_device request;
+	struct icm_tr_pkg_approve_device reply;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	memcpy(&request.ep_uuid, sw->uuid, sizeof(request.ep_uuid));
+	request.hdr.code = ICM_APPROVE_DEVICE;
+	request.route_lo = sw->config.route_lo;
+	request.route_hi = sw->config.route_hi;
+	request.connection_id = sw->connection_id;
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, ICM_APPROVE_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (reply.hdr.flags & ICM_FLAGS_ERROR) {
+		tb_warn(tb, "PCIe tunnel creation failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int icm_tr_add_switch_key(struct tb *tb, struct tb_switch *sw)
+{
+	struct icm_tr_pkg_add_device_key_response reply;
+	struct icm_tr_pkg_add_device_key request;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	memcpy(&request.ep_uuid, sw->uuid, sizeof(request.ep_uuid));
+	request.hdr.code = ICM_ADD_DEVICE_KEY;
+	request.route_lo = sw->config.route_lo;
+	request.route_hi = sw->config.route_hi;
+	request.connection_id = sw->connection_id;
+	memcpy(request.key, sw->key, TB_SWITCH_KEY_SIZE);
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, ICM_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (reply.hdr.flags & ICM_FLAGS_ERROR) {
+		tb_warn(tb, "Adding key to switch failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int icm_tr_challenge_switch_key(struct tb *tb, struct tb_switch *sw,
+				       const u8 *challenge, u8 *response)
+{
+	struct icm_tr_pkg_challenge_device_response reply;
+	struct icm_tr_pkg_challenge_device request;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	memcpy(&request.ep_uuid, sw->uuid, sizeof(request.ep_uuid));
+	request.hdr.code = ICM_CHALLENGE_DEVICE;
+	request.route_lo = sw->config.route_lo;
+	request.route_hi = sw->config.route_hi;
+	request.connection_id = sw->connection_id;
+	memcpy(request.challenge, challenge, TB_SWITCH_KEY_SIZE);
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, ICM_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (reply.hdr.flags & ICM_FLAGS_ERROR)
+		return -EKEYREJECTED;
+	if (reply.hdr.flags & ICM_FLAGS_NO_KEY)
+		return -ENOKEY;
+
+	memcpy(response, reply.response, TB_SWITCH_KEY_SIZE);
+
+	return 0;
+}
+
+static int icm_tr_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
+{
+	struct icm_tr_pkg_approve_xdomain_response reply;
+	struct icm_tr_pkg_approve_xdomain request;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	request.hdr.code = ICM_APPROVE_XDOMAIN;
+	request.route_hi = upper_32_bits(xd->route);
+	request.route_lo = lower_32_bits(xd->route);
+	request.transmit_path = xd->transmit_path;
+	request.transmit_ring = xd->transmit_ring;
+	request.receive_path = xd->receive_path;
+	request.receive_ring = xd->receive_ring;
+	memcpy(&request.remote_uuid, xd->remote_uuid, sizeof(*xd->remote_uuid));
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, ICM_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (reply.hdr.flags & ICM_FLAGS_ERROR)
+		return -EIO;
+
+	return 0;
+}
+
+static int icm_tr_xdomain_tear_down(struct tb *tb, struct tb_xdomain *xd,
+				    int stage)
+{
+	struct icm_tr_pkg_disconnect_xdomain_response reply;
+	struct icm_tr_pkg_disconnect_xdomain request;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	request.hdr.code = ICM_DISCONNECT_XDOMAIN;
+	request.stage = stage;
+	request.route_hi = upper_32_bits(xd->route);
+	request.route_lo = lower_32_bits(xd->route);
+	memcpy(&request.remote_uuid, xd->remote_uuid, sizeof(*xd->remote_uuid));
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, ICM_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (reply.hdr.flags & ICM_FLAGS_ERROR)
+		return -EIO;
+
+	return 0;
+}
+
+static int icm_tr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
+{
+	int ret;
+
+	ret = icm_tr_xdomain_tear_down(tb, xd, 1);
+	if (ret)
+		return ret;
+
+	usleep_range(10, 50);
+	return icm_tr_xdomain_tear_down(tb, xd, 2);
+}
+
+static void
+icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
+{
+	const struct icm_tr_event_device_connected *pkg =
+		(const struct icm_tr_event_device_connected *)hdr;
+	enum tb_security_level security_level;
+	struct tb_switch *sw, *parent_sw;
+	struct tb_xdomain *xd;
+	bool authorized, boot;
+	u64 route;
+
+	/*
+	 * Currently we don't use the QoS information coming with the
+	 * device connected message so simply just ignore that extra
+	 * packet for now.
+	 */
+	if (pkg->hdr.packet_id)
+		return;
+
+	/*
+	 * After NVM upgrade adding root switch device fails because we
+	 * initiated reset. During that time ICM might still send device
+	 * connected message which we ignore here.
+	 */
+	if (!tb->root_switch)
+		return;
+
+	route = get_route(pkg->route_hi, pkg->route_lo);
+	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
+	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
+			 ICM_FLAGS_SLEVEL_SHIFT;
+	boot = pkg->link_info & ICM_LINK_INFO_BOOT;
+
+	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
+		tb_info(tb, "switch at %llx was rejected by ICM firmware because topology limit exceeded\n",
+			route);
+		return;
+	}
+
+	sw = tb_switch_find_by_uuid(tb, &pkg->ep_uuid);
+	if (sw) {
+		/* Update the switch if it is still in the same place */
+		if (tb_route(sw) == route && !!sw->authorized == authorized) {
+			parent_sw = tb_to_switch(sw->dev.parent);
+			update_switch(parent_sw, sw, route, pkg->connection_id,
+				      0, 0, 0, boot);
+			tb_switch_put(sw);
+			return;
+		}
+
+		remove_switch(sw);
+		tb_switch_put(sw);
+	}
+
+	/* Another switch with the same address */
+	sw = tb_switch_find_by_route(tb, route);
+	if (sw) {
+		remove_switch(sw);
+		tb_switch_put(sw);
+	}
+
+	/* XDomain connection with the same address */
+	xd = tb_xdomain_find_by_route(tb, route);
+	if (xd) {
+		remove_xdomain(xd);
+		tb_xdomain_put(xd);
+	}
+
+	parent_sw = tb_switch_find_by_route(tb, get_parent_route(route));
+	if (!parent_sw) {
+		tb_err(tb, "failed to find parent switch for %llx\n", route);
+		return;
+	}
+
+	add_switch(parent_sw, route, &pkg->ep_uuid, pkg->connection_id,
+		   0, 0, 0, security_level, authorized, boot);
+
+	tb_switch_put(parent_sw);
+}
+
+static void
+icm_tr_device_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
+{
+	const struct icm_tr_event_device_disconnected *pkg =
+		(const struct icm_tr_event_device_disconnected *)hdr;
+	struct tb_switch *sw;
+	u64 route;
+
+	route = get_route(pkg->route_hi, pkg->route_lo);
+
+	sw = tb_switch_find_by_route(tb, route);
+	if (!sw) {
+		tb_warn(tb, "no switch exists at %llx, ignoring\n", route);
+		return;
+	}
+
+	remove_switch(sw);
+	tb_switch_put(sw);
+}
+
+static void
+icm_tr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
+{
+	const struct icm_tr_event_xdomain_connected *pkg =
+		(const struct icm_tr_event_xdomain_connected *)hdr;
+	struct tb_xdomain *xd;
+	struct tb_switch *sw;
+	u64 route;
+
+	if (!tb->root_switch)
+		return;
+
+	route = get_route(pkg->local_route_hi, pkg->local_route_lo);
+
+	xd = tb_xdomain_find_by_uuid(tb, &pkg->remote_uuid);
+	if (xd) {
+		if (xd->route == route) {
+			update_xdomain(xd, route, 0);
+			tb_xdomain_put(xd);
+			return;
+		}
+
+		remove_xdomain(xd);
+		tb_xdomain_put(xd);
+	}
+
+	/* An existing xdomain with the same address */
+	xd = tb_xdomain_find_by_route(tb, route);
+	if (xd) {
+		remove_xdomain(xd);
+		tb_xdomain_put(xd);
+	}
+
+	/*
+	 * If the user disconnected a switch during suspend and
+	 * connected another host to the same port, remove the switch
+	 * first.
+	 */
+	sw = get_switch_at_route(tb->root_switch, route);
+	if (sw)
+		remove_switch(sw);
+
+	sw = tb_switch_find_by_route(tb, get_parent_route(route));
+	if (!sw) {
+		tb_warn(tb, "no switch exists at %llx, ignoring\n", route);
+		return;
+	}
+
+	add_xdomain(sw, route, &pkg->local_uuid, &pkg->remote_uuid, 0, 0);
+	tb_switch_put(sw);
+}
+
+static void
+icm_tr_xdomain_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
+{
+	const struct icm_tr_event_xdomain_disconnected *pkg =
+		(const struct icm_tr_event_xdomain_disconnected *)hdr;
+	struct tb_xdomain *xd;
+	u64 route;
+
+	route = get_route(pkg->route_hi, pkg->route_lo);
+
+	xd = tb_xdomain_find_by_route(tb, route);
+	if (xd) {
+		remove_xdomain(xd);
+		tb_xdomain_put(xd);
+	}
+}
+
 static struct pci_dev *get_upstream_port(struct pci_dev *pdev)
 {
 	struct pci_dev *parent;
@@ -1472,6 +1823,24 @@ static const struct tb_cm_ops icm_ar_ops = {
 	.disconnect_xdomain_paths = icm_fr_disconnect_xdomain_paths,
 };
 
+/* Titan Ridge */
+static const struct tb_cm_ops icm_tr_ops = {
+	.driver_ready = icm_driver_ready,
+	.start = icm_start,
+	.stop = icm_stop,
+	.suspend = icm_suspend,
+	.complete = icm_complete,
+	.handle_event = icm_handle_event,
+	.get_boot_acl = icm_ar_get_boot_acl,
+	.set_boot_acl = icm_ar_set_boot_acl,
+	.approve_switch = icm_tr_approve_switch,
+	.add_switch_key = icm_tr_add_switch_key,
+	.challenge_switch_key = icm_tr_challenge_switch_key,
+	.disconnect_pcie_paths = icm_disconnect_pcie_paths,
+	.approve_xdomain_paths = icm_tr_approve_xdomain_paths,
+	.disconnect_xdomain_paths = icm_tr_disconnect_xdomain_paths,
+};
+
 struct tb *icm_probe(struct tb_nhi *nhi)
 {
 	struct icm *icm;
@@ -1514,6 +1883,19 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 		icm->xdomain_disconnected = icm_fr_xdomain_disconnected;
 		tb->cm_ops = &icm_ar_ops;
 		break;
+
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
+		icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
+		icm->is_supported = icm_ar_is_supported;
+		icm->get_mode = icm_ar_get_mode;
+		icm->driver_ready = icm_tr_driver_ready;
+		icm->device_connected = icm_tr_device_connected;
+		icm->device_disconnected = icm_tr_device_disconnected;
+		icm->xdomain_connected = icm_tr_xdomain_connected;
+		icm->xdomain_disconnected = icm_tr_xdomain_disconnected;
+		tb->cm_ops = &icm_tr_ops;
+		break;
 	}
 
 	if (!icm->is_supported || !icm->is_supported(tb)) {
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 9e58d09f6029..f5a33e88e676 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1111,6 +1111,8 @@ static struct pci_device_id nhi_ids[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_NHI) },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_NHI) },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI) },
 
 	{ 0,}
 };
diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 4476ab4cfd0c..1696a4560948 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -45,5 +45,10 @@ enum nhi_fw_mode nhi_mailbox_mode(struct tb_nhi *nhi);
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI	0x15dc
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI	0x15dd
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI	0x15de
+#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE	0x15e7
+#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI		0x15e8
+#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE	0x15ea
+#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI		0x15eb
+#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE	0x15ef
 
 #endif
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index e9e30aaab2a3..25758671ddf4 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1051,6 +1051,9 @@ static int tb_switch_get_generation(struct tb_switch *sw)
 	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE:
 	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_BRIDGE:
 	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE:
 		return 3;
 
 	default:
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index 496b91f3b579..bc13f8d6b804 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -102,6 +102,7 @@ enum icm_pkg_code {
 	ICM_ADD_DEVICE_KEY = 0x6,
 	ICM_GET_ROUTE = 0xa,
 	ICM_APPROVE_XDOMAIN = 0x10,
+	ICM_DISCONNECT_XDOMAIN = 0x11,
 	ICM_PREBOOT_ACL = 0x18,
 };
 
@@ -321,6 +322,146 @@ struct icm_ar_pkg_preboot_acl_response {
 	struct icm_ar_boot_acl_entry acl[ICM_AR_PREBOOT_ACL_ENTRIES];
 };
 
+/* Titan Ridge messages */
+
+struct icm_tr_pkg_driver_ready_response {
+	struct icm_pkg_header hdr;
+	u16 reserved1;
+	u16 info;
+	u32 nvm_version;
+	u16 device_id;
+	u16 reserved2;
+};
+
+#define ICM_TR_INFO_SLEVEL_MASK		GENMASK(2, 0)
+#define ICM_TR_INFO_BOOT_ACL_SHIFT	7
+#define ICM_TR_INFO_BOOT_ACL_MASK	GENMASK(12, 7)
+
+struct icm_tr_event_device_connected {
+	struct icm_pkg_header hdr;
+	uuid_t ep_uuid;
+	u32 route_hi;
+	u32 route_lo;
+	u8 connection_id;
+	u8 reserved;
+	u16 link_info;
+	u32 ep_name[55];
+};
+
+struct icm_tr_event_device_disconnected {
+	struct icm_pkg_header hdr;
+	u32 route_hi;
+	u32 route_lo;
+};
+
+struct icm_tr_event_xdomain_connected {
+	struct icm_pkg_header hdr;
+	u16 reserved;
+	u16 link_info;
+	uuid_t remote_uuid;
+	uuid_t local_uuid;
+	u32 local_route_hi;
+	u32 local_route_lo;
+	u32 remote_route_hi;
+	u32 remote_route_lo;
+};
+
+struct icm_tr_event_xdomain_disconnected {
+	struct icm_pkg_header hdr;
+	u32 route_hi;
+	u32 route_lo;
+	uuid_t remote_uuid;
+};
+
+struct icm_tr_pkg_approve_device {
+	struct icm_pkg_header hdr;
+	uuid_t ep_uuid;
+	u32 route_hi;
+	u32 route_lo;
+	u8 connection_id;
+	u8 reserved1[3];
+};
+
+struct icm_tr_pkg_add_device_key {
+	struct icm_pkg_header hdr;
+	uuid_t ep_uuid;
+	u32 route_hi;
+	u32 route_lo;
+	u8 connection_id;
+	u8 reserved[3];
+	u32 key[8];
+};
+
+struct icm_tr_pkg_challenge_device {
+	struct icm_pkg_header hdr;
+	uuid_t ep_uuid;
+	u32 route_hi;
+	u32 route_lo;
+	u8 connection_id;
+	u8 reserved[3];
+	u32 challenge[8];
+};
+
+struct icm_tr_pkg_approve_xdomain {
+	struct icm_pkg_header hdr;
+	u32 route_hi;
+	u32 route_lo;
+	uuid_t remote_uuid;
+	u16 transmit_path;
+	u16 transmit_ring;
+	u16 receive_path;
+	u16 receive_ring;
+};
+
+struct icm_tr_pkg_disconnect_xdomain {
+	struct icm_pkg_header hdr;
+	u8 stage;
+	u8 reserved[3];
+	u32 route_hi;
+	u32 route_lo;
+	uuid_t remote_uuid;
+};
+
+struct icm_tr_pkg_challenge_device_response {
+	struct icm_pkg_header hdr;
+	uuid_t ep_uuid;
+	u32 route_hi;
+	u32 route_lo;
+	u8 connection_id;
+	u8 reserved[3];
+	u32 challenge[8];
+	u32 response[8];
+};
+
+struct icm_tr_pkg_add_device_key_response {
+	struct icm_pkg_header hdr;
+	uuid_t ep_uuid;
+	u32 route_hi;
+	u32 route_lo;
+	u8 connection_id;
+	u8 reserved[3];
+};
+
+struct icm_tr_pkg_approve_xdomain_response {
+	struct icm_pkg_header hdr;
+	u32 route_hi;
+	u32 route_lo;
+	uuid_t remote_uuid;
+	u16 transmit_path;
+	u16 transmit_ring;
+	u16 receive_path;
+	u16 receive_ring;
+};
+
+struct icm_tr_pkg_disconnect_xdomain_response {
+	struct icm_pkg_header hdr;
+	u8 stage;
+	u8 reserved[3];
+	u32 route_hi;
+	u32 route_lo;
+	uuid_t remote_uuid;
+};
+
 /* XDomain messages */
 
 struct tb_xdomain_header {
-- 
2.16.2
