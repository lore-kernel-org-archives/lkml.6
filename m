Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D567C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0610204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0610204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeIJCfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 22:35:30 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:51335 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeIJCfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 22:35:30 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C73C82800B3CC;
        Sun,  9 Sep 2018 23:44:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7C1B2E542; Sun,  9 Sep 2018 23:44:23 +0200 (CEST)
Message-Id: <756f7148bc106d80d2e43273edd6dc8c48c1b87b.1536517047.git.lukas@wunner.de>
In-Reply-To: <cover.1536517047.git.lukas@wunner.de>
References: <cover.1536517047.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 9 Sep 2018 23:42:01 +0200
Subject: [PATCH 2/5] thunderbolt: Obtain PCI slot number from DROM
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

The port numbers of PCIe adapters on a CIO switch and the slot numbers
of their corresponding PCI devices don't necessarily match up in
ascending order.

E.g. Light Ridge in host mode (MacBookPro9,1) mixes them up like this:
switch port  7 == pci slot 4 (PCIe downstream port)
switch port  8 == pci slot 5 (PCIe downstream port)
switch port  9 == pci slot 6 (PCIe downstream port)
switch port 10 == pci slot 3 (PCIe downstream port)

Light Ridge in endpoint mode (Sonnet Echo Express):
switch port  7 == pci slot 4 (PCIe downstream port)
switch port  8 == pci slot 5 (PCIe downstream port)
switch port  9               (PCIe downstream port, disabled in DROM)
switch port 10 == pci slot 0 (PCIe upstream port, pci slot 3 in DROM)

Obtain the slot number used by a switch port from the DROM and store it
in struct tb_port.  This will allow us to correlate PCI devices with
Thunderbolt ports.  For space efficiency, use a union in struct tb_port
to store attributes that are specific to certain port types.
Attributes specific to TB_TYPE_PORT could be moved into a separate
struct within the union.

The slot number occupies 3 bits in the third byte of PCI DROM entries.
The purpose of the remaining 5 bits is unknown (function number?).

Downstream port entries have 3 bytes, upstream port entries 11 bytes.
The slot number in upstream port entries is not that of the port itself
(which is always zero), but that of the PCI endpoint device built into
the Thunderbolt product.  In the case of the Sonnet Echo Express, the
upstream port specifies slot 3, which is used by a PLX switch.

The purpose of the additional 8 bytes present on upstream ports is
unknown (number of PCIe lanes, priority requirements, direct tunnel to
the host desired?).  Examples:

01 00 64 00 00 00 00 00      (Sonnet Echo Express, PLX switch)
01 40 0a 00 00 00 00 00      (Apple Gigabit Ethernet Adapter, BCM957762)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/eeprom.c | 21 +++++++++++++++++++++
 drivers/thunderbolt/switch.c | 14 +++++++++++++-
 drivers/thunderbolt/tb.h     |  9 +++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 3e8caf22c294..ce6e037fdb39 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -236,6 +236,15 @@ struct tb_drom_entry_port {
 	u8 unknown4:2;
 } __packed;
 
+struct tb_drom_entry_pci {
+	/* BYTES 0-1 */
+	struct tb_drom_entry_header header;
+	/* BYTE 2 */
+	u8 unknown:5;
+	u8 slot:3;
+	/* BYTES 3-10 are only present on PCIe upstream ports */
+} __packed;
+
 
 /**
  * tb_eeprom_get_drom_offset - get drom offset within eeprom
@@ -365,6 +374,18 @@ static int tb_drom_parse_entry_port(struct tb_switch *sw,
 		if (entry->has_dual_link_port)
 			port->dual_link_port =
 				&port->sw->ports[entry->dual_link_port_nr];
+	} else if (type == TB_TYPE_PCIE_UP || type == TB_TYPE_PCIE_DOWN) {
+		struct tb_drom_entry_pci *entry = (void *) header;
+		if (header->len < sizeof(*entry)) {
+			tb_sw_warn(sw,
+				"port entry has size %#x (expected %#zx+)\n",
+				header->len, sizeof(struct tb_drom_entry_pci));
+			return -EIO;
+		}
+		port->pci.devfn = PCI_DEVFN(entry->slot, 0);
+		memcpy(port->pci.unknown, header + 1,
+		       min(header->len - sizeof(struct tb_drom_entry_header),
+			   sizeof(port->pci.unknown)));
 	}
 	return 0;
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 7442bc4c6433..54fd42250935 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -577,6 +577,7 @@ int tb_port_clear_counter(struct tb_port *port, int counter)
  */
 static int tb_init_port(struct tb_port *port)
 {
+	struct tb *tb = port->sw->tb;
 	int res;
 	int cap;
 
@@ -594,9 +595,20 @@ static int tb_init_port(struct tb_port *port)
 			tb_port_WARN(port, "non switch port without a PHY\n");
 	}
 
-	tb_dump_port(port->sw->tb, &port->config);
+	tb_dump_port(tb, &port->config);
 
 	/* TODO: Read dual link port, DP port and more from EEPROM. */
+	switch (port->config.type) {
+	case TB_TYPE_PCIE_UP:
+	case TB_TYPE_PCIE_DOWN:
+		tb_info(tb, "  PCI slot: %02x.0\n", PCI_SLOT(port->pci.devfn));
+		tb_info(tb, "  PCI unknown data: %*ph\n",
+			(int)sizeof(port->pci.unknown), port->pci.unknown);
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5067d69d0501..755183f0b257 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -125,6 +125,9 @@ struct tb_switch {
  * @dual_link_port: If the switch is connected using two ports, points
  *		    to the other port.
  * @link_nr: Is this primary or secondary port on the dual_link.
+ * @pci: Data specific to PCIe adapters
+ * @pci.devfn: PCI slot/function according to DROM
+ * @pci.unknown: Unknown data in DROM (to be reverse-engineered)
  */
 struct tb_port {
 	struct tb_regs_port_header config;
@@ -136,6 +139,12 @@ struct tb_port {
 	bool disabled;
 	struct tb_port *dual_link_port;
 	u8 link_nr:1;
+	union {
+		struct {
+			u8 devfn;
+			u8 unknown[9];
+		} pci;
+	};
 };
 
 /**
-- 
2.18.0

