Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905E0C37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2C92089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUc/9mjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfAUXcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:32:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53325 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfAUXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:31:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so12409489wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 15:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LW2jwbnHcDjXyjLcAnjP/huOffzJV1JTJ3VHnjGi/n8=;
        b=MUc/9mjz+GnBnDCjTWwdqgwPcPOFls5whXM+lC96NvHuO5Hj/2A3p1srq5lNDAIsHg
         rer6OPl/mkathxBbk58mPeLDsLHm7wpHQjFCy7Jxq5oaGQTM3TGqrzKobVw1TFL/VTfX
         +yY01X340knF6xQGoqYmYDHXAGR+nYSNlYBxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LW2jwbnHcDjXyjLcAnjP/huOffzJV1JTJ3VHnjGi/n8=;
        b=oB2iL/3qD/58bnMT2hc/OomUQ2Xmrhds68VHBoJzT9631iSKJcHKvCPilaYeAScUiY
         DUuYJ0SmIwAVk/7Kn4ERNHW+sFwTcMA395blf5usXYiOrL6mL+Th7OHObDZJ1NQ/EY5w
         sJbDDpmQw0ho3HjwxSfweKuh9N/0dL7C8WWzhI0s4oXZUPzCTjBHTp2noJZwTizzlJ0T
         Dv8ZrXJrUEc+102ylbcLjkPPLlq9JlfLtJlhNqoq56JgYILHjCKp53WoU2YCNKcC8sB+
         LOCv0Ut01x5i2Gg9xJetY6JDdeV66Fw2u4B6W4MNVFgmsBvbv5NXhTb/2kB+XZzQvAnj
         TnuQ==
X-Gm-Message-State: AJcUukeTCkqrP54Jf6xUUCazpmEFwv9mRoc6ZK3N6sdlN5+PjuK+IK+B
        uDkbAE9ERcsDqAKOh4mia7TQsrEcra0=
X-Google-Smtp-Source: ALg8bN59cZzx4F9/eVw9ZilXO8ex39j2rElW/hFG+24Um8AxUGFcukBAdHbhYzLMcd5nbuS2MzqJtA==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr1275476wmh.92.1548113516252;
        Mon, 21 Jan 2019 15:31:56 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id g67sm106405967wmd.38.2019.01.21.15.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 15:31:55 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, mathieu.poirier@linaro.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [RESEND PATCH v3 1/2] drivers: amba: Updates to component identification for driver matching.
Date:   Mon, 21 Jan 2019 23:31:50 +0000
Message-Id: <20190121233151.13363-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121233151.13363-1-mike.leach@linaro.org>
References: <20190121233151.13363-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CoreSight specification (ARM IHI 0029E), updates the ID register
requirements for components on an AMBA bus, to cover both traditional
ARM Primecell type devices, and newer CoreSight and other components.

The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
cases to uniquely identify components. CoreSight components related to
a single function can share Peripheral ID values, and must be further
identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
PMU and Debug hardware of the A35 all share the same PID.

Bits 15:12 of the CID are defined to be the device class.
Class 0xF remains for PrimeCell and legacy components.
Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
at present.
Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.

The specification futher defines which classes of device use the standard
CID/PID pair, and when additional ID registers are required.

The patches provide an update of amba_device and matching code to handle
the additional registers required for the Class 0x9 (CoreSight) UCI.
The *data pointer in the amba_id is used by the driver to provide extended
ID register values for matching.

CoreSight components where PID/CID pair is currently sufficient for
unique identification need not provide this additional information.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/amba/bus.c       | 45 +++++++++++++++++++++++++++++++++-------
 include/linux/amba/bus.h | 32 ++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 41b706403ef7..524296a0eba0 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -26,19 +26,36 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
-static const struct amba_id *
-amba_lookup(const struct amba_id *table, struct amba_device *dev)
+/* called on periphid match and class 0x9 coresight device. */
+static int
+amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
 {
 	int ret = 0;
+	struct amba_cs_uci_id *uci;
+
+	uci = table->data;
 
+	/* no table data - return match on periphid */
+	if (!uci)
+		return 1;
+
+	/* test against read devtype and masked devarch value */
+	ret = (dev->uci.devtype == uci->devtype) &&
+		((dev->uci.devarch & uci->devarch_mask) == uci->devarch);
+	return ret;
+}
+
+static const struct amba_id *
+amba_lookup(const struct amba_id *table, struct amba_device *dev)
+{
 	while (table->mask) {
-		ret = (dev->periphid & table->mask) == table->id;
-		if (ret)
-			break;
+		if (((dev->periphid & table->mask) == table->id) &&
+			((dev->cid != CORESIGHT_CID) ||
+			 (amba_cs_uci_id_match(table, dev))))
+			return table;
 		table++;
 	}
-
-	return ret ? table : NULL;
+	return NULL;
 }
 
 static int amba_match(struct device *dev, struct device_driver *drv)
@@ -399,10 +416,22 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
 				(i * 8);
 
+		if (cid == CORESIGHT_CID) {
+			/* set the base to the start of the last 4k block */
+			void __iomem *csbase = tmp + size - 4096;
+
+			dev->uci.devarch =
+				readl(csbase + UCI_REG_DEVARCH_OFFSET);
+			dev->uci.devtype =
+				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
+		}
+
 		amba_put_disable_pclk(dev);
 
-		if (cid == AMBA_CID || cid == CORESIGHT_CID)
+		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
 			dev->periphid = pid;
+			dev->cid = cid;
+		}
 
 		if (!dev->periphid)
 			ret = -ENODEV;
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index d143c13bed26..8c0f392e4da2 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -25,6 +25,36 @@
 #define AMBA_CID	0xb105f00d
 #define CORESIGHT_CID	0xb105900d
 
+/*
+ * CoreSight Architecture specification updates the ID specification
+ * for components on the AMBA bus. (ARM IHI 0029E)
+ *
+ * Bits 15:12 of the CID are the device class.
+ *
+ * Class 0xF remains for PrimeCell and legacy components. (AMBA_CID above)
+ * Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
+ * Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
+ * at present.
+ * Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
+ *
+ * Remaining CID bits stay as 0xb105-00d
+ */
+
+/*
+ * Class 0x9 components use additional values to form a Unique Component
+ * Identifier (UCI), where peripheral ID values are identical for different
+ * components. Passed to the amba bus code from the component driver via
+ * the amba_id->data pointer.
+ */
+struct amba_cs_uci_id {
+	unsigned int devarch;
+	unsigned int devarch_mask;
+	unsigned int devtype;
+};
+
+#define UCI_REG_DEVTYPE_OFFSET	0xFCC
+#define UCI_REG_DEVARCH_OFFSET	0xFBC
+
 struct clk;
 
 struct amba_device {
@@ -32,6 +62,8 @@ struct amba_device {
 	struct resource		res;
 	struct clk		*pclk;
 	unsigned int		periphid;
+	unsigned int		cid;
+	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
 	char			*driver_override;
 };
-- 
2.19.1

