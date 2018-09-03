Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39289C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2F420652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2F420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeICRxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:53:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:25152 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeICRxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:53:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 06:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="86776153"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Sep 2018 06:33:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B36185D; Mon,  3 Sep 2018 16:33:04 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/3] thunderbolt: Make the driver less verbose
Date:   Mon,  3 Sep 2018 16:33:02 +0300
Message-Id: <20180903133304.70362-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903133304.70362-1-mika.westerberg@linux.intel.com>
References: <20180903133304.70362-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver logs quite a lot to the system message buffer even
when doing normal operations. This information is not useful for
ordinary users and might even annoy some.

For this reason convert most of the logs at info level to happen at
debug level instead. The nice output formatting is untouched.

Logging can be easily re-enabled by passing "thunderbolt.dyndbg" in the
kernel command line (or using the corresponding control file runtime).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/ctl.c    |  6 ++--
 drivers/thunderbolt/eeprom.c |  2 +-
 drivers/thunderbolt/nhi.c    | 30 +++++++++----------
 drivers/thunderbolt/path.c   | 26 ++++++++--------
 drivers/thunderbolt/switch.c | 57 +++++++++++++++++-------------------
 drivers/thunderbolt/tb.c     | 10 +++----
 drivers/thunderbolt/tb.h     |  6 ++--
 7 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 37a7f4c735d0..2ab6033a0a3d 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -631,7 +631,7 @@ struct tb_ctl *tb_ctl_alloc(struct tb_nhi *nhi, event_cb cb, void *cb_data)
 		ctl->rx_packets[i]->frame.callback = tb_ctl_rx_callback;
 	}
 
-	tb_ctl_info(ctl, "control channel created\n");
+	tb_ctl_dbg(ctl, "control channel created\n");
 	return ctl;
 err:
 	tb_ctl_free(ctl);
@@ -673,7 +673,7 @@ void tb_ctl_free(struct tb_ctl *ctl)
 void tb_ctl_start(struct tb_ctl *ctl)
 {
 	int i;
-	tb_ctl_info(ctl, "control channel starting...\n");
+	tb_ctl_dbg(ctl, "control channel starting...\n");
 	tb_ring_start(ctl->tx); /* is used to ack hotplug packets, start first */
 	tb_ring_start(ctl->rx);
 	for (i = 0; i < TB_CTL_RX_PKG_COUNT; i++)
@@ -702,7 +702,7 @@ void tb_ctl_stop(struct tb_ctl *ctl)
 	if (!list_empty(&ctl->request_queue))
 		tb_ctl_WARN(ctl, "dangling request in request_queue\n");
 	INIT_LIST_HEAD(&ctl->request_queue);
-	tb_ctl_info(ctl, "control channel stopped\n");
+	tb_ctl_dbg(ctl, "control channel stopped\n");
 }
 
 /* public interface, commands */
diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 3e8caf22c294..d2dd40390783 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -540,7 +540,7 @@ int tb_drom_read(struct tb_switch *sw)
 		return res;
 	size &= 0x3ff;
 	size += TB_DROM_DATA_START;
-	tb_sw_info(sw, "reading drom (length: %#x)\n", size);
+	tb_sw_dbg(sw, "reading drom (length: %#x)\n", size);
 	if (size < sizeof(*header)) {
 		tb_sw_warn(sw, "drom too small, aborting\n");
 		return -EIO;
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 5cd6bdfa068f..26d34b76a88f 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -95,9 +95,9 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
 	else
 		new = old & ~mask;
 
-	dev_info(&ring->nhi->pdev->dev,
-		 "%s interrupt at register %#x bit %d (%#x -> %#x)\n",
-		 active ? "enabling" : "disabling", reg, bit, old, new);
+	dev_dbg(&ring->nhi->pdev->dev,
+		"%s interrupt at register %#x bit %d (%#x -> %#x)\n",
+		active ? "enabling" : "disabling", reg, bit, old, new);
 
 	if (new == old)
 		dev_WARN(&ring->nhi->pdev->dev,
@@ -476,8 +476,9 @@ static struct tb_ring *tb_ring_alloc(struct tb_nhi *nhi, u32 hop, int size,
 				     void *poll_data)
 {
 	struct tb_ring *ring = NULL;
-	dev_info(&nhi->pdev->dev, "allocating %s ring %d of size %d\n",
-		 transmit ? "TX" : "RX", hop, size);
+
+	dev_dbg(&nhi->pdev->dev, "allocating %s ring %d of size %d\n",
+		transmit ? "TX" : "RX", hop, size);
 
 	/* Tx Ring 2 is reserved for E2E workaround */
 	if (transmit && hop == RING_E2E_UNUSED_HOPID)
@@ -585,8 +586,8 @@ void tb_ring_start(struct tb_ring *ring)
 		dev_WARN(&ring->nhi->pdev->dev, "ring already started\n");
 		goto err;
 	}
-	dev_info(&ring->nhi->pdev->dev, "starting %s %d\n",
-		 RING_TYPE(ring), ring->hop);
+	dev_dbg(&ring->nhi->pdev->dev, "starting %s %d\n",
+		RING_TYPE(ring), ring->hop);
 
 	if (ring->flags & RING_FLAG_FRAME) {
 		/* Means 4096 */
@@ -647,8 +648,8 @@ void tb_ring_stop(struct tb_ring *ring)
 {
 	spin_lock_irq(&ring->nhi->lock);
 	spin_lock(&ring->lock);
-	dev_info(&ring->nhi->pdev->dev, "stopping %s %d\n",
-		 RING_TYPE(ring), ring->hop);
+	dev_dbg(&ring->nhi->pdev->dev, "stopping %s %d\n",
+		RING_TYPE(ring), ring->hop);
 	if (ring->nhi->going_away)
 		goto err;
 	if (!ring->running) {
@@ -716,10 +717,8 @@ void tb_ring_free(struct tb_ring *ring)
 	ring->descriptors_dma = 0;
 
 
-	dev_info(&ring->nhi->pdev->dev,
-		 "freeing %s %d\n",
-		 RING_TYPE(ring),
-		 ring->hop);
+	dev_dbg(&ring->nhi->pdev->dev, "freeing %s %d\n", RING_TYPE(ring),
+		ring->hop);
 
 	/**
 	 * ring->work can no longer be scheduled (it is scheduled only
@@ -931,7 +930,8 @@ static int nhi_runtime_resume(struct device *dev)
 static void nhi_shutdown(struct tb_nhi *nhi)
 {
 	int i;
-	dev_info(&nhi->pdev->dev, "shutdown\n");
+
+	dev_dbg(&nhi->pdev->dev, "shutdown\n");
 
 	for (i = 0; i < nhi->hop_count; i++) {
 		if (nhi->tx_rings[i])
@@ -1059,7 +1059,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
-	dev_info(&nhi->pdev->dev, "NHI initialized, starting thunderbolt\n");
+	dev_dbg(&nhi->pdev->dev, "NHI initialized, starting thunderbolt\n");
 
 	res = tb_domain_add(tb);
 	if (res) {
diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index ff49ad880bfd..a11956522bac 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -13,19 +13,19 @@
 
 static void tb_dump_hop(struct tb_port *port, struct tb_regs_hop *hop)
 {
-	tb_port_info(port, " Hop through port %d to hop %d (%s)\n",
-		     hop->out_port, hop->next_hop,
-		     hop->enable ? "enabled" : "disabled");
-	tb_port_info(port, "  Weight: %d Priority: %d Credits: %d Drop: %d\n",
-		     hop->weight, hop->priority,
-		     hop->initial_credits, hop->drop_packages);
-	tb_port_info(port, "   Counter enabled: %d Counter index: %d\n",
-		     hop->counter_enable, hop->counter);
-	tb_port_info(port, "  Flow Control (In/Eg): %d/%d Shared Buffer (In/Eg): %d/%d\n",
-		     hop->ingress_fc, hop->egress_fc,
-		     hop->ingress_shared_buffer, hop->egress_shared_buffer);
-	tb_port_info(port, "  Unknown1: %#x Unknown2: %#x Unknown3: %#x\n",
-		     hop->unknown1, hop->unknown2, hop->unknown3);
+	tb_port_dbg(port, " Hop through port %d to hop %d (%s)\n",
+		    hop->out_port, hop->next_hop,
+		    hop->enable ? "enabled" : "disabled");
+	tb_port_dbg(port, "  Weight: %d Priority: %d Credits: %d Drop: %d\n",
+		    hop->weight, hop->priority,
+		    hop->initial_credits, hop->drop_packages);
+	tb_port_dbg(port, "   Counter enabled: %d Counter index: %d\n",
+		    hop->counter_enable, hop->counter);
+	tb_port_dbg(port, "  Flow Control (In/Eg): %d/%d Shared Buffer (In/Eg): %d/%d\n",
+		    hop->ingress_fc, hop->egress_fc,
+		    hop->ingress_shared_buffer, hop->egress_shared_buffer);
+	tb_port_dbg(port, "  Unknown1: %#x Unknown2: %#x Unknown3: %#x\n",
+		    hop->unknown1, hop->unknown2, hop->unknown3);
 }
 
 /**
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7442bc4c6433..81134ee29578 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -436,15 +436,15 @@ static const char *tb_port_type(struct tb_regs_port_header *port)
 
 static void tb_dump_port(struct tb *tb, struct tb_regs_port_header *port)
 {
-	tb_info(tb,
-		" Port %d: %x:%x (Revision: %d, TB Version: %d, Type: %s (%#x))\n",
-		port->port_number, port->vendor_id, port->device_id,
-		port->revision, port->thunderbolt_version, tb_port_type(port),
-		port->type);
-	tb_info(tb, "  Max hop id (in/out): %d/%d\n",
-		port->max_in_hop_id, port->max_out_hop_id);
-	tb_info(tb, "  Max counters: %d\n", port->max_counters);
-	tb_info(tb, "  NFC Credits: %#x\n", port->nfc_credits);
+	tb_dbg(tb,
+	       " Port %d: %x:%x (Revision: %d, TB Version: %d, Type: %s (%#x))\n",
+	       port->port_number, port->vendor_id, port->device_id,
+	       port->revision, port->thunderbolt_version, tb_port_type(port),
+	       port->type);
+	tb_dbg(tb, "  Max hop id (in/out): %d/%d\n",
+	       port->max_in_hop_id, port->max_out_hop_id);
+	tb_dbg(tb, "  Max counters: %d\n", port->max_counters);
+	tb_dbg(tb, "  NFC Credits: %#x\n", port->nfc_credits);
 }
 
 /**
@@ -605,20 +605,18 @@ static int tb_init_port(struct tb_port *port)
 
 static void tb_dump_switch(struct tb *tb, struct tb_regs_switch_header *sw)
 {
-	tb_info(tb,
-		" Switch: %x:%x (Revision: %d, TB Version: %d)\n",
-		sw->vendor_id, sw->device_id, sw->revision,
-		sw->thunderbolt_version);
-	tb_info(tb, "  Max Port Number: %d\n", sw->max_port_number);
-	tb_info(tb, "  Config:\n");
-	tb_info(tb,
+	tb_dbg(tb, " Switch: %x:%x (Revision: %d, TB Version: %d)\n",
+	       sw->vendor_id, sw->device_id, sw->revision,
+	       sw->thunderbolt_version);
+	tb_dbg(tb, "  Max Port Number: %d\n", sw->max_port_number);
+	tb_dbg(tb, "  Config:\n");
+	tb_dbg(tb,
 		"   Upstream Port Number: %d Depth: %d Route String: %#llx Enabled: %d, PlugEventsDelay: %dms\n",
-		sw->upstream_port_number, sw->depth,
-		(((u64) sw->route_hi) << 32) | sw->route_lo,
-		sw->enabled, sw->plug_events_delay);
-	tb_info(tb,
-		"   unknown1: %#x unknown4: %#x\n",
-		sw->__unknown1, sw->__unknown4);
+	       sw->upstream_port_number, sw->depth,
+	       (((u64) sw->route_hi) << 32) | sw->route_lo,
+	       sw->enabled, sw->plug_events_delay);
+	tb_dbg(tb, "   unknown1: %#x unknown4: %#x\n",
+	       sw->__unknown1, sw->__unknown4);
 }
 
 /**
@@ -634,7 +632,7 @@ int tb_switch_reset(struct tb *tb, u64 route)
 		header.route_lo = route,
 		header.enabled = true,
 	};
-	tb_info(tb, "resetting switch at %llx\n", route);
+	tb_dbg(tb, "resetting switch at %llx\n", route);
 	res.err = tb_cfg_write(tb->ctl, ((u32 *) &header) + 2, route,
 			0, 2, 2, 2);
 	if (res.err)
@@ -1139,7 +1137,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 	if (tb_cfg_read(tb->ctl, &sw->config, route, 0, TB_CFG_SWITCH, 0, 5))
 		goto err_free_sw_ports;
 
-	tb_info(tb, "current switch config:\n");
+	tb_dbg(tb, "current switch config:\n");
 	tb_dump_switch(tb, &sw->config);
 
 	/* configure switch */
@@ -1246,9 +1244,8 @@ int tb_switch_configure(struct tb_switch *sw)
 	int ret;
 
 	route = tb_route(sw);
-	tb_info(tb,
-		"initializing Switch at %#llx (depth: %d, up port: %d)\n",
-		route, tb_route_length(route), sw->config.upstream_port_number);
+	tb_dbg(tb, "initializing Switch at %#llx (depth: %d, up port: %d)\n",
+	       route, tb_route_length(route), sw->config.upstream_port_number);
 
 	if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL)
 		tb_sw_warn(sw, "unknown switch vendor id %#x\n",
@@ -1386,13 +1383,13 @@ int tb_switch_add(struct tb_switch *sw)
 			tb_sw_warn(sw, "tb_eeprom_read_rom failed\n");
 			return ret;
 		}
-		tb_sw_info(sw, "uid: %#llx\n", sw->uid);
+		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
 
 		tb_switch_set_uuid(sw);
 
 		for (i = 0; i <= sw->config.max_port_number; i++) {
 			if (sw->ports[i].disabled) {
-				tb_port_info(&sw->ports[i], "disabled by eeprom\n");
+				tb_port_dbg(&sw->ports[i], "disabled by eeprom\n");
 				continue;
 			}
 			ret = tb_init_port(&sw->ports[i]);
@@ -1483,7 +1480,7 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
 int tb_switch_resume(struct tb_switch *sw)
 {
 	int i, err;
-	tb_sw_info(sw, "resuming switch\n");
+	tb_sw_dbg(sw, "resuming switch\n");
 
 	/*
 	 * Check for UID of the connected switches except for root
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 1424581fd9af..30e02c716f6c 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -404,10 +404,10 @@ static int tb_suspend_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
 
-	tb_info(tb, "suspending...\n");
+	tb_dbg(tb, "suspending...\n");
 	tb_switch_suspend(tb->root_switch);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
-	tb_info(tb, "suspend finished\n");
+	tb_dbg(tb, "suspend finished\n");
 
 	return 0;
 }
@@ -417,7 +417,7 @@ static int tb_resume_noirq(struct tb *tb)
 	struct tb_cm *tcm = tb_priv(tb);
 	struct tb_pci_tunnel *tunnel, *n;
 
-	tb_info(tb, "resuming...\n");
+	tb_dbg(tb, "resuming...\n");
 
 	/* remove any pci devices the firmware might have setup */
 	tb_switch_reset(tb, 0);
@@ -432,12 +432,12 @@ static int tb_resume_noirq(struct tb *tb)
 		 * the pcie links need some time to get going.
 		 * 100ms works for me...
 		 */
-		tb_info(tb, "tunnels restarted, sleeping for 100ms\n");
+		tb_dbg(tb, "tunnels restarted, sleeping for 100ms\n");
 		msleep(100);
 	}
 	 /* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
-	tb_info(tb, "resume finished\n");
+	tb_dbg(tb, "resume finished\n");
 
 	return 0;
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5067d69d0501..5a99245573c0 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -327,7 +327,7 @@ static inline int tb_port_write(struct tb_port *port, const void *buffer,
 #define tb_WARN(tb, fmt, arg...) dev_WARN(&(tb)->nhi->pdev->dev, fmt, ## arg)
 #define tb_warn(tb, fmt, arg...) dev_warn(&(tb)->nhi->pdev->dev, fmt, ## arg)
 #define tb_info(tb, fmt, arg...) dev_info(&(tb)->nhi->pdev->dev, fmt, ## arg)
-
+#define tb_dbg(tb, fmt, arg...) dev_dbg(&(tb)->nhi->pdev->dev, fmt, ## arg)
 
 #define __TB_SW_PRINT(level, sw, fmt, arg...)           \
 	do {                                            \
@@ -338,7 +338,7 @@ static inline int tb_port_write(struct tb_port *port, const void *buffer,
 #define tb_sw_WARN(sw, fmt, arg...) __TB_SW_PRINT(tb_WARN, sw, fmt, ##arg)
 #define tb_sw_warn(sw, fmt, arg...) __TB_SW_PRINT(tb_warn, sw, fmt, ##arg)
 #define tb_sw_info(sw, fmt, arg...) __TB_SW_PRINT(tb_info, sw, fmt, ##arg)
-
+#define tb_sw_dbg(sw, fmt, arg...) __TB_SW_PRINT(tb_dbg, sw, fmt, ##arg)
 
 #define __TB_PORT_PRINT(level, _port, fmt, arg...)                      \
 	do {                                                            \
@@ -352,6 +352,8 @@ static inline int tb_port_write(struct tb_port *port, const void *buffer,
 	__TB_PORT_PRINT(tb_warn, port, fmt, ##arg)
 #define tb_port_info(port, fmt, arg...) \
 	__TB_PORT_PRINT(tb_info, port, fmt, ##arg)
+#define tb_port_dbg(port, fmt, arg...) \
+	__TB_PORT_PRINT(tb_dbg, port, fmt, ##arg)
 
 struct tb *icm_probe(struct tb_nhi *nhi);
 struct tb *tb_probe(struct tb_nhi *nhi);
-- 
2.18.0

