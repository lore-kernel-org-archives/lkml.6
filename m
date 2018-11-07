Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E831C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169662086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169662086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeKHIEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:04:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35401 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeKHIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:04:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id v198-v6so15306520oif.2;
        Wed, 07 Nov 2018 14:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gl0eGLxWkV78v12QkOZr6gfUapSEn24ksgEQkdeKgY=;
        b=ic42Ac4SVaU4PG4i28tHTKJcbLiljrAla6Xbq5WoO0KrBWG3ZVMCtdHEEEwJ6BX/yG
         bQSJpGiGyNPcghVWI3mRIOROsIC+ZuhXcKJMhbNN3w1ucuH2YQnpaNvK1vNUgY/CjPn+
         4zh0YqdVa0nrFDqyNUR7xG5d7aVkY2gLD3iA/q6jK2YbXEI5A7rEw4gRGkl0+LozEw3I
         mvlGAU8/K6u1hC3icI35t/oTBj9Z23i5ermvVHHNDxmD1QU8x4/fEAeqnmhYTPeGjpRi
         LncbmP4OIQ7514+viXZRQozePD3JiRgbczQ28t9c4ofQpEhfsepi6Ta2Qs0egyAsBY/T
         FC7w==
X-Gm-Message-State: AGRZ1gI7K/6R5NBs52CbGa6qK3vShq1npVgChBC6bKaerfDBn9oAsXtj
        UX779siZvy6xHOE8dTXYJw==
X-Google-Smtp-Source: AJdET5eeBPvFYou99kEqqcXOPe9TYOVBioPXq5XwzUT5jPs9JD6mSu6EUwBS5WHcIx+hXofc7z2bvQ==
X-Received: by 2002:aca:f40d:: with SMTP id s13-v6mr1335131oih.102.1541629916441;
        Wed, 07 Nov 2018 14:31:56 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f9sm750959oth.17.2018.11.07.14.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:31:55 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 3/8] sparc: prom: use property "name" directly to construct node names
Date:   Wed,  7 Nov 2018 16:31:46 -0600
Message-Id: <20181107223151.14991-4-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107223151.14991-1-robh@kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove direct accesses to the device_node.name
pointer, retrieve the node name from the "name" property instead.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/prom_32.c | 20 ++++++++++------
 arch/sparc/kernel/prom_64.c | 47 +++++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index d41e2a749c5d..30e33b461970 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -60,6 +60,7 @@ void * __init prom_early_alloc(unsigned long size)
  */
 static void __init sparc32_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *rprop;
 
@@ -69,13 +70,14 @@ static void __init sparc32_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = rprop->value;
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		regs->which_io, regs->phys_addr);
 }
 
 /* "name@slot,offset"  */
 static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -85,7 +87,7 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		regs->which_io,
 		regs->phys_addr);
 }
@@ -93,6 +95,7 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@devnum[,func]" */
 static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_pci_registers *regs;
 	struct property *prop;
 	unsigned int devfn;
@@ -105,12 +108,12 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	if (devfn & 0x07) {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			devfn >> 3,
 			devfn & 0x07);
 	} else {
 		sprintf(tmp_buf, "%s@%x",
-			dp->name,
+			name,
 			devfn >> 3);
 	}
 }
@@ -118,6 +121,7 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@addrhi,addrlo" */
 static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -128,13 +132,14 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		regs->which_io, regs->phys_addr);
 }
 
 /* "name:vendor:device@irq,addrlo" */
 static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct amba_prom_registers *regs;
 	unsigned int *intr, *device, *vendor, reg0;
 	struct property *prop;
@@ -168,7 +173,7 @@ static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 	device = prop->value;
 
 	sprintf(tmp_buf, "%s:%d:%d@%x,%x",
-		dp->name, *vendor, *device,
+		name, *vendor, *device,
 		*intr, reg0);
 }
 
@@ -196,12 +201,13 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 
 char * __init build_path_component(struct device_node *dp)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	char tmp_buf[64], *n;
 
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] == '\0')
-		strcpy(tmp_buf, dp->name);
+		strcpy(tmp_buf, name);
 
 	n = prom_early_alloc(strlen(tmp_buf) + 1);
 	strcpy(n, tmp_buf);
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index c37955d127fe..1667df573f6f 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -72,6 +72,7 @@ void * __init prom_early_alloc(unsigned long size)
  */
 static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *rprop;
 	u32 high_bits, low_bits, type;
@@ -83,7 +84,7 @@ static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 	regs = rprop->value;
 	if (!of_node_is_root(dp->parent)) {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			(unsigned int) (regs->phys_addr >> 32UL),
 			(unsigned int) (regs->phys_addr & 0xffffffffUL));
 		return;
@@ -98,21 +99,22 @@ static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 
 		if (low_bits)
 			sprintf(tmp_buf, "%s@%s%x,%x",
-				dp->name, prefix,
+				name, prefix,
 				high_bits, low_bits);
 		else
 			sprintf(tmp_buf, "%s@%s%x",
-				dp->name,
+				name,
 				prefix,
 				high_bits);
 	} else if (type == 12) {
 		sprintf(tmp_buf, "%s@%x",
-			dp->name, high_bits);
+			name, high_bits);
 	}
 }
 
 static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -123,7 +125,7 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 	if (!of_node_is_root(dp->parent)) {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			(unsigned int) (regs->phys_addr >> 32UL),
 			(unsigned int) (regs->phys_addr & 0xffffffffUL));
 		return;
@@ -139,7 +141,7 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 			mask = 0x7fffff;
 
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			*(u32 *)prop->value,
 			(unsigned int) (regs->phys_addr & mask));
 	}
@@ -148,6 +150,7 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@slot,offset"  */
 static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -157,7 +160,7 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		regs->which_io,
 		regs->phys_addr);
 }
@@ -165,6 +168,7 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@devnum[,func]" */
 static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_pci_registers *regs;
 	struct property *prop;
 	unsigned int devfn;
@@ -177,12 +181,12 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	if (devfn & 0x07) {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+			name,
 			devfn >> 3,
 			devfn & 0x07);
 	} else {
 		sprintf(tmp_buf, "%s@%x",
-			dp->name,
+			name,
 			devfn >> 3);
 	}
 }
@@ -190,6 +194,7 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@UPA_PORTID,offset" */
 static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -204,7 +209,7 @@ static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
 		return;
 
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		*(u32 *) prop->value,
 		(unsigned int) (regs->phys_addr & 0xffffffffUL));
 }
@@ -212,6 +217,7 @@ static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@reg" */
 static void __init vdev_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -221,12 +227,13 @@ static void __init vdev_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 
-	sprintf(tmp_buf, "%s@%x", dp->name, *regs);
+	sprintf(tmp_buf, "%s@%x", name, *regs);
 }
 
 /* "name@addrhi,addrlo" */
 static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -237,7 +244,7 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+		name,
 		(unsigned int) (regs->phys_addr >> 32UL),
 		(unsigned int) (regs->phys_addr & 0xffffffffUL));
 }
@@ -245,6 +252,7 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 /* "name@bus,addr" */
 static void __init i2c_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -258,12 +266,13 @@ static void __init i2c_path_component(struct device_node *dp, char *tmp_buf)
 	 * property of the i2c bus node etc. etc.
 	 */
 	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name, regs[0], regs[1]);
+		name, regs[0], regs[1]);
 }
 
 /* "name@reg0[,reg1]" */
 static void __init usb_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -275,16 +284,17 @@ static void __init usb_path_component(struct device_node *dp, char *tmp_buf)
 
 	if (prop->length == sizeof(u32) || regs[1] == 1) {
 		sprintf(tmp_buf, "%s@%x",
-			dp->name, regs[0]);
+			name, regs[0]);
 	} else {
 		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name, regs[0], regs[1]);
+			name, regs[0], regs[1]);
 	}
 }
 
 /* "name@reg0reg1[,reg2reg3]" */
 static void __init ieee1394_path_component(struct device_node *dp, char *tmp_buf)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -296,10 +306,10 @@ static void __init ieee1394_path_component(struct device_node *dp, char *tmp_buf
 
 	if (regs[2] || regs[3]) {
 		sprintf(tmp_buf, "%s@%08x%08x,%04x%08x",
-			dp->name, regs[0], regs[1], regs[2], regs[3]);
+			name, regs[0], regs[1], regs[2], regs[3]);
 	} else {
 		sprintf(tmp_buf, "%s@%08x%08x",
-			dp->name, regs[0], regs[1]);
+			name, regs[0], regs[1]);
 	}
 }
 
@@ -356,12 +366,13 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 
 char * __init build_path_component(struct device_node *dp)
 {
+	const char *name = of_get_property(dp, "name", NULL);
 	char tmp_buf[64], *n;
 
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] == '\0')
-		strcpy(tmp_buf, dp->name);
+		strcpy(tmp_buf, name);
 
 	n = prom_early_alloc(strlen(tmp_buf) + 1);
 	strcpy(n, tmp_buf);
-- 
2.19.1

