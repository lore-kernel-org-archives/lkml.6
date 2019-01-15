Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191CFC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4682086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e71LPwDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbfAOXHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:07:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39245 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbfAOXG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:06:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so3953423edt.6;
        Tue, 15 Jan 2019 15:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2tlvHHTliWPEKYE42LEKdctKb5h1abooAbKy1jd2DTU=;
        b=e71LPwDts3xwVnVibDhJ+z1GobKPIutDfRzJzSJM1qHk9lbMS1t/dMEPawM8Y5B7oj
         tZdYWnHPZd/JRpOSaEqi719AO4zIz+dK+FQEnlgySo8J4xPwXfNOVfAzey1MwR4DY+8o
         9ssDKvoeABY1sn68mNHylVriqtf5k3d16Gyd4Zz9yRyiYuJKk1dGxdHG5tTF+EOlkR4b
         17fb9ltNvvif2VRmQR5cVfEF6cZKBMRwMA6cTAPE0gefU/l5FRQuTUbmNajGZi/33nYR
         egGPRSx97Qu6G+XGfQzVmLlBg2G9SawFpBqopStzR/T9k/9fa4PX6OvpDtoIczqmhHg/
         gR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2tlvHHTliWPEKYE42LEKdctKb5h1abooAbKy1jd2DTU=;
        b=bb8n3bbdwT5C4Jl7/O+LCvxjYNOPT5/5QLVlw6z1K6oA2wEBT5YjjmA0km5Iat0ZRJ
         L6WWym5LI1RwB22nWVpYg/VUqJjO428ngUZDL50IMRuU5wsfpbxMnijc45BRRhMNBWcB
         HzcmtGMm/D9C3zAgRaCEkIMSK3bCKdmhcNH+zS8lQdGrCs3xouRkM9OdTLYUdSn1z+s3
         9YUN0w5R3kZo4hu1K9pgxS7/q2RyIpOaYVMRUppQeE/wX7qmjolsU/V5m4asqX+uIogV
         F1AhrGBwQomRWCDnNiZ5y5KuxlGIkYXglZSGk6z4rrZi4f4VsXDqd4goFhiN6zX1py2B
         w7oA==
X-Gm-Message-State: AJcUukcd3EVLgeRF2ezTGzExHxE23hGOgmmVH/o0SbQuzoqKkdjovKF4
        uFeMafUXaWvUrJ6v9PgpbuiPj79Q
X-Google-Smtp-Source: ALg8bN6wGPula9sQ6HSp8FmKuxJHahRGy9mVKZ+/C43mOVaqh/Z+RPCkdmcoQuiymNkwpf2KFM5NHA==
X-Received: by 2002:a50:d643:: with SMTP id c3mr4986590edj.178.1547593616652;
        Tue, 15 Jan 2019 15:06:56 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v14sm4872324edq.74.2019.01.15.15.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:06:55 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell
        Dove/MV78xx0/Orion SOC support)
Subject: [PATCH net-next 1/3] net: dsa: Split platform data to header file
Date:   Tue, 15 Jan 2019 15:06:11 -0800
Message-Id: <20190115230613.28334-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having net/dsa.h contain both the internal switch tree/driver
structures, split the relevant platform_data parts into
include/linux/platform_data/dsa.h and make that header be included by
net/dsa.h in order not to break any setup. A subsequent set of patches
will update code including net/dsa.h to include only the platform_data
header.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS                       |  1 +
 include/linux/platform_data/dsa.h | 68 +++++++++++++++++++++++++++++++
 include/net/dsa.h                 | 61 +--------------------------
 3 files changed, 70 insertions(+), 60 deletions(-)
 create mode 100644 include/linux/platform_data/dsa.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..a592b9992b46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10576,6 +10576,7 @@ F:	Documentation/devicetree/bindings/net/dsa/
 F:	net/dsa/
 F:	include/net/dsa.h
 F:	include/linux/dsa/
+F:	include/linux/platform_data/dsa.h
 F:	drivers/net/dsa/
 
 NETWORKING [GENERAL]
diff --git a/include/linux/platform_data/dsa.h b/include/linux/platform_data/dsa.h
new file mode 100644
index 000000000000..d4d9bf2060a6
--- /dev/null
+++ b/include/linux/platform_data/dsa.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DSA_PDATA_H
+#define __DSA_PDATA_H
+
+struct device;
+struct net_device;
+
+#define DSA_MAX_SWITCHES	4
+#define DSA_MAX_PORTS		12
+#define DSA_RTABLE_NONE		-1
+
+struct dsa_chip_data {
+	/*
+	 * How to access the switch configuration registers.
+	 */
+	struct device	*host_dev;
+	int		sw_addr;
+
+	/*
+	 * Reference to network devices
+	 */
+	struct device	*netdev[DSA_MAX_PORTS];
+
+	/* set to size of eeprom if supported by the switch */
+	int		eeprom_len;
+
+	/* Device tree node pointer for this specific switch chip
+	 * used during switch setup in case additional properties
+	 * and resources needs to be used
+	 */
+	struct device_node *of_node;
+
+	/*
+	 * The names of the switch's ports.  Use "cpu" to
+	 * designate the switch port that the cpu is connected to,
+	 * "dsa" to indicate that this port is a DSA link to
+	 * another switch, NULL to indicate the port is unused,
+	 * or any other string to indicate this is a physical port.
+	 */
+	char		*port_names[DSA_MAX_PORTS];
+	struct device_node *port_dn[DSA_MAX_PORTS];
+
+	/*
+	 * An array of which element [a] indicates which port on this
+	 * switch should be used to send packets to that are destined
+	 * for switch a. Can be NULL if there is only one switch chip.
+	 */
+	s8		rtable[DSA_MAX_SWITCHES];
+};
+
+struct dsa_platform_data {
+	/*
+	 * Reference to a Linux network interface that connects
+	 * to the root switch chip of the tree.
+	 */
+	struct device	*netdev;
+	struct net_device *of_netdev;
+
+	/*
+	 * Info structs describing each of the switch chips
+	 * connected via this network interface.
+	 */
+	int		nr_chips;
+	struct dsa_chip_data	*chip;
+};
+
+
+#endif /* __DSA_PDATA_H */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index b3eefe8e18fd..6178b648d08a 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -21,6 +21,7 @@
 #include <linux/ethtool.h>
 #include <linux/net_tstamp.h>
 #include <linux/phy.h>
+#include <linux/platform_data/dsa.h>
 #include <net/devlink.h>
 #include <net/switchdev.h>
 
@@ -44,66 +45,6 @@ enum dsa_tag_protocol {
 	DSA_TAG_LAST,		/* MUST BE LAST */
 };
 
-#define DSA_MAX_SWITCHES	4
-#define DSA_MAX_PORTS		12
-
-#define DSA_RTABLE_NONE		-1
-
-struct dsa_chip_data {
-	/*
-	 * How to access the switch configuration registers.
-	 */
-	struct device	*host_dev;
-	int		sw_addr;
-
-	/*
-	 * Reference to network devices
-	 */
-	struct device	*netdev[DSA_MAX_PORTS];
-
-	/* set to size of eeprom if supported by the switch */
-	int		eeprom_len;
-
-	/* Device tree node pointer for this specific switch chip
-	 * used during switch setup in case additional properties
-	 * and resources needs to be used
-	 */
-	struct device_node *of_node;
-
-	/*
-	 * The names of the switch's ports.  Use "cpu" to
-	 * designate the switch port that the cpu is connected to,
-	 * "dsa" to indicate that this port is a DSA link to
-	 * another switch, NULL to indicate the port is unused,
-	 * or any other string to indicate this is a physical port.
-	 */
-	char		*port_names[DSA_MAX_PORTS];
-	struct device_node *port_dn[DSA_MAX_PORTS];
-
-	/*
-	 * An array of which element [a] indicates which port on this
-	 * switch should be used to send packets to that are destined
-	 * for switch a. Can be NULL if there is only one switch chip.
-	 */
-	s8		rtable[DSA_MAX_SWITCHES];
-};
-
-struct dsa_platform_data {
-	/*
-	 * Reference to a Linux network interface that connects
-	 * to the root switch chip of the tree.
-	 */
-	struct device	*netdev;
-	struct net_device *of_netdev;
-
-	/*
-	 * Info structs describing each of the switch chips
-	 * connected via this network interface.
-	 */
-	int		nr_chips;
-	struct dsa_chip_data	*chip;
-};
-
 struct packet_type;
 struct dsa_switch;
 
-- 
2.17.1

