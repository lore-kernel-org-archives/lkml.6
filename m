Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELtBN1E+3dK/W8ZEcbpT4Y94tIUieAyVoL0lTHdYRSfqW9JeCOsCxbOMnf8pOYYjeyVwH1C9
ARC-Seal: i=1; a=rsa-sha256; t=1521059050; cv=none;
        d=google.com; s=arc-20160816;
        b=o+V0IKysbnExPishtbhIztWLmvyedbjBajMFzySKVBDkCqDkTHYpvIeKKqAZpWjKLG
         R91EB1Ibp8mhi2mtzGsCKxX4qkvntNKlZffb+TG57AzaiZb5NdAG+KE25uNrH4giyzdD
         MDhtw7a4Uvk2cIAn6cUrMkn7b+0zHsBraVCWHQzFjZNHRQ3aE+GTrfHYjjycw8cmKNm2
         2spPab7e9xmnLPXjRaBJ+dMB+SRgTr7aVYCna5KZuPdenXWh7s6kI8mslDqyxTtdhGLB
         gQY4fNYuViStOnit7NV0ViJ9sqQqI5DUTO2AOzyoVJ8jc+uqGi4u3rOc8/PyfqP9SfB5
         x6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=fkzbXuHuWY4jf6+irseu9syAwAszD92UK7gtceocxHY=;
        b=cB2Boukzi4ABbDfHk/41e/djYEbdVnW3NcX2EGV0KpEfP4pYhOdmdb0QQkURZyJREW
         qKe5Tg8ccZ6c/NV4S+GJodZsdHrdG33PTLETb+Nf5OhZHavvIeQPUbI3Nlclxr76e74u
         L3Sz0c+xtrbDjIryF7t0+2avfen/STItBto+dCPjgFLdVQh8FtO4Ce2dCNg/iXzrsZ3T
         ZP0pAYyQhCdPmJisxKv5sS+YSRlKDrExmylS/mKciL8cBE0Vvp5iNkFkjBruyCzGlOHi
         wDgJ+bQ+at67TaPiJY/NnC35HVgOcfALOyZ/eQjbbU7D69kROrjIZ/DK4s2tIts7rWb0
         EPeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:36 +1100
Subject: [PATCH 10/13] staging: mt7621-eth: add mdio support for mt762X
 family
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105895630.22262.17721435026559861824.stgit@noble>
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594946014834718409?=
X-GMAIL-MSGID: =?utf-8?q?1594946014834718409?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Crispin <blogic@openwrt.org>

NeilBrown: this patch originally contained soc-mt7620.c
  but as I cannot test that, I removed it.  Some functions
  from mdio-mt7620.c are needed for soc-mt7621.c support
  - fixed  mt7620_has_carrier() to read correct register.

Original comment:

Add support for SoCs from the mt7620 family. These all have one dedicated
external gbit port and a builtin 5 port 100mbit switch. Additionally one
of the 5 switch ports can be changed to become an additional gbit port
that we can attach a phy to. MT7620 was the first SoC released after
Ralink was acquired by MTK and has seen a lot of changes to the core.

With MT7620 we have seen the addition of some advanced features such as
TX vlan offloading, RX scatter gather and TSO. Newer MTK SoCs are based on
this design.

Although the builtin MT7530 is gbit capable, the builtin PHYs are only
100mbit. There are boards in the wild that use one of the gbit MACs to
attach an external MT7530. For this to work a few hacks need to be applied
to reorganize the MDIO address mappings and autopolling for the SoC to
correctly work with the external switch. This is however not part of the
series and will be part of a later series once we evaluated if we want to
use DSA or switchdev.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-eth/TODO          |    2 
 drivers/staging/mt7621-eth/mdio_mt7620.c |  173 ++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 drivers/staging/mt7621-eth/mdio_mt7620.c

diff --git a/drivers/staging/mt7621-eth/TODO b/drivers/staging/mt7621-eth/TODO
index 1ab0530131ae..50fb5a959ee8 100644
--- a/drivers/staging/mt7621-eth/TODO
+++ b/drivers/staging/mt7621-eth/TODO
@@ -4,5 +4,7 @@
 - general code review and clean up
 - add support for second MAC on mt7621
 - convert gsw code to use switchdev interfaces
+- md7620_mmi_write etc should probably be wrapped
+  in a regmap abstraction.
 
 Cc: NeilBrown <neil@brown.name>
diff --git a/drivers/staging/mt7621-eth/mdio_mt7620.c b/drivers/staging/mt7621-eth/mdio_mt7620.c
new file mode 100644
index 000000000000..ced605c2914e
--- /dev/null
+++ b/drivers/staging/mt7621-eth/mdio_mt7620.c
@@ -0,0 +1,173 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "mtk_eth_soc.h"
+#include "gsw_mt7620.h"
+#include "mdio.h"
+
+static int mt7620_mii_busy_wait(struct mt7620_gsw *gsw)
+{
+	unsigned long t_start = jiffies;
+
+	while (1) {
+		if (!(mtk_switch_r32(gsw,
+				     gsw->piac_offset + MT7620_GSW_REG_PIAC) &
+				     GSW_MDIO_ACCESS))
+			return 0;
+		if (time_after(jiffies, t_start + GSW_REG_PHY_TIMEOUT))
+			break;
+	}
+
+	dev_err(gsw->dev, "mdio: MDIO timeout\n");
+	return -1;
+}
+
+u32 _mt7620_mii_write(struct mt7620_gsw *gsw, u32 phy_addr,
+		      u32 phy_register, u32 write_data)
+{
+	if (mt7620_mii_busy_wait(gsw))
+		return -1;
+
+	write_data &= 0xffff;
+
+	mtk_switch_w32(gsw, GSW_MDIO_ACCESS | GSW_MDIO_START | GSW_MDIO_WRITE |
+		(phy_register << GSW_MDIO_REG_SHIFT) |
+		(phy_addr << GSW_MDIO_ADDR_SHIFT) | write_data,
+		MT7620_GSW_REG_PIAC);
+
+	if (mt7620_mii_busy_wait(gsw))
+		return -1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(_mt7620_mii_write);
+
+u32 _mt7620_mii_read(struct mt7620_gsw *gsw, int phy_addr, int phy_reg)
+{
+	u32 d;
+
+	if (mt7620_mii_busy_wait(gsw))
+		return 0xffff;
+
+	mtk_switch_w32(gsw, GSW_MDIO_ACCESS | GSW_MDIO_START | GSW_MDIO_READ |
+		(phy_reg << GSW_MDIO_REG_SHIFT) |
+		(phy_addr << GSW_MDIO_ADDR_SHIFT),
+		MT7620_GSW_REG_PIAC);
+
+	if (mt7620_mii_busy_wait(gsw))
+		return 0xffff;
+
+	d = mtk_switch_r32(gsw, MT7620_GSW_REG_PIAC) & 0xffff;
+
+	return d;
+}
+EXPORT_SYMBOL_GPL(_mt7620_mii_read);
+
+int mt7620_mdio_write(struct mii_bus *bus, int phy_addr, int phy_reg, u16 val)
+{
+	struct mtk_eth *eth = bus->priv;
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)eth->sw_priv;
+
+	return _mt7620_mii_write(gsw, phy_addr, phy_reg, val);
+}
+
+int mt7620_mdio_read(struct mii_bus *bus, int phy_addr, int phy_reg)
+{
+	struct mtk_eth *eth = bus->priv;
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)eth->sw_priv;
+
+	return _mt7620_mii_read(gsw, phy_addr, phy_reg);
+}
+
+void mt7530_mdio_w32(struct mt7620_gsw *gsw, u32 reg, u32 val)
+{
+	_mt7620_mii_write(gsw, 0x1f, 0x1f, (reg >> 6) & 0x3ff);
+	_mt7620_mii_write(gsw, 0x1f, (reg >> 2) & 0xf,  val & 0xffff);
+	_mt7620_mii_write(gsw, 0x1f, 0x10, val >> 16);
+}
+EXPORT_SYMBOL_GPL(mt7530_mdio_w32);
+
+u32 mt7530_mdio_r32(struct mt7620_gsw *gsw, u32 reg)
+{
+	u16 high, low;
+
+	_mt7620_mii_write(gsw, 0x1f, 0x1f, (reg >> 6) & 0x3ff);
+	low = _mt7620_mii_read(gsw, 0x1f, (reg >> 2) & 0xf);
+	high = _mt7620_mii_read(gsw, 0x1f, 0x10);
+
+	return (high << 16) | (low & 0xffff);
+}
+EXPORT_SYMBOL_GPL(mt7530_mdio_r32);
+
+void mt7530_mdio_m32(struct mt7620_gsw *gsw, u32 mask, u32 set, u32 reg)
+{
+	u32 val = mt7530_mdio_r32(gsw, reg);
+
+	val &= ~mask;
+	val |= set;
+	mt7530_mdio_w32(gsw, reg, val);
+}
+EXPORT_SYMBOL_GPL(mt7530_mdio_m32);
+
+static unsigned char *mtk_speed_str(int speed)
+{
+	switch (speed) {
+	case 2:
+	case SPEED_1000:
+		return "1000";
+	case 1:
+	case SPEED_100:
+		return "100";
+	case 0:
+	case SPEED_10:
+		return "10";
+	}
+
+	return "? ";
+}
+
+int mt7620_has_carrier(struct mtk_eth *eth)
+{
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)eth->sw_priv;
+	int i;
+
+	for (i = 0; i < GSW_PORT6; i++)
+		if (mt7530_mdio_r32(gsw, GSW_REG_PORT_STATUS(i)) & 0x1)
+			return 1;
+	return 0;
+}
+
+void mt7620_print_link_state(struct mtk_eth *eth, int port, int link,
+			     int speed, int duplex)
+{
+	struct mt7620_gsw *gsw = eth->sw_priv;
+
+	if (link)
+		dev_info(gsw->dev, "port %d link up (%sMbps/%s duplex)\n",
+			 port, mtk_speed_str(speed),
+			 (duplex) ? "Full" : "Half");
+	else
+		dev_info(gsw->dev, "port %d link down\n", port);
+}
+
+void mt7620_mdio_link_adjust(struct mtk_eth *eth, int port)
+{
+	mt7620_print_link_state(eth, port, eth->link[port],
+				eth->phy->speed[port],
+				(eth->phy->duplex[port] == DUPLEX_FULL));
+}
