Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4068C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F93A2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F93A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeH1Tg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:36:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32910 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Tg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:36:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so3697167oip.0;
        Tue, 28 Aug 2018 08:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=89b9w7zzqpXeIRaut3kilMIAVuwepwExKBnxj95Io4A=;
        b=tPel89QO18qizR6fsdTfX0ILi8S+WHPVG8sRySUuXvxIC0SElev9K0kjKpxUqlu1QC
         JgZR/PLpwNqqyKOkzNRhwk8jVGyuUaaS9Jpu/eZoABIxJlsqgabtMO7poswCHbOlc5Bu
         wsgsJegJrE5ylzJkAMxF2YztHn8ygLZy5Q0qYVMXgJDgYoNNRUGDVDqcLSWh3csAwkCi
         hM4lCcvxmdhzcX6xtFgSYM6YuQXf7wlW7NKbT8hdUacEENhHxQpYjhA6Zc0izdfQwyGj
         ecUeJH5zDR/FJz5gOipTv/vUNf6l/vX6j0IRNy0GWPiXzVJwT3a9vPkNC65/9OI46GVs
         Xo+Q==
X-Gm-Message-State: APzg51DTDPj/icrGcyK66ns4XKg0QULCFl1OEPqBgSQFVhxMDl9xb5iH
        S1W7wfwzvz6gve6rhhi2zDjqRNw=
X-Google-Smtp-Source: ANB0VdYhZDWEFW1hLmSw5rouh+/2BVJ68l3YauodEA7tHBYD8YNigGWN3ZStYcCv9m9FHdJt86TJKg==
X-Received: by 2002:aca:a815:: with SMTP id r21-v6mr1880620oie.64.1535471081176;
        Tue, 28 Aug 2018 08:44:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f4-v6sm1808331oic.52.2018.08.28.08.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:44:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH v2] sparc: Convert to using %pOFn instead of device_node.name
Date:   Tue, 28 Aug 2018 10:44:32 -0500
Message-Id: <20180828154433.5693-6-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828154433.5693-1-robh@kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
In-Reply-To: <20180828015252.28511-7-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- snprint -> snprintf typo fix

 arch/sparc/kernel/auxio_64.c |  4 +--
 arch/sparc/kernel/power.c    |  4 +--
 arch/sparc/kernel/prom_32.c  | 26 +++++++-------
 arch/sparc/kernel/prom_64.c  | 68 ++++++++++++++++++------------------
 4 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 4e8f56c3793c..cc42225c20f3 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -115,8 +115,8 @@ static int auxio_probe(struct platform_device *dev)
 		auxio_devtype = AUXIO_TYPE_SBUS;
 		size = 1;
 	} else {
-		printk("auxio: Unknown parent bus type [%s]\n",
-		       dp->parent->name);
+		printk("auxio: Unknown parent bus type [%pOFn]\n",
+		       dp->parent);
 		return -ENODEV;
 	}
 	auxio_register = of_ioremap(&dev->resource[0], 0, size, "auxio");
diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index 92627abce311..d941875dd718 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -41,8 +41,8 @@ static int power_probe(struct platform_device *op)

 	power_reg = of_ioremap(res, 0, 0x4, "power");

-	printk(KERN_INFO "%s: Control reg at %llx\n",
-	       op->dev.of_node->name, res->start);
+	printk(KERN_INFO "%pOFn: Control reg at %llx\n",
+	       op->dev.of_node, res->start);

 	if (has_button_interrupt(irq, op->dev.of_node)) {
 		if (request_irq(irq,
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index b51cbb9e87dc..17c87d29ff20 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -68,8 +68,8 @@ static void __init sparc32_path_component(struct device_node *dp, char *tmp_buf)
 		return;

 	regs = rprop->value;
-	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+	sprintf(tmp_buf, "%pOFn@%x,%x",
+		dp,
 		regs->which_io, regs->phys_addr);
 }

@@ -84,8 +84,8 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 		return;

 	regs = prop->value;
-	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+	sprintf(tmp_buf, "%pOFn@%x,%x",
+		dp,
 		regs->which_io,
 		regs->phys_addr);
 }
@@ -104,13 +104,13 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	if (devfn & 0x07) {
-		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+		sprintf(tmp_buf, "%pOFn@%x,%x",
+			dp,
 			devfn >> 3,
 			devfn & 0x07);
 	} else {
-		sprintf(tmp_buf, "%s@%x",
-			dp->name,
+		sprintf(tmp_buf, "%pOFn@%x",
+			dp,
 			devfn >> 3);
 	}
 }
@@ -127,8 +127,8 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)

 	regs = prop->value;

-	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+	sprintf(tmp_buf, "%pOFn@%x,%x",
+		dp,
 		regs->which_io, regs->phys_addr);
 }

@@ -167,8 +167,8 @@ static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 		return;
 	device = prop->value;

-	sprintf(tmp_buf, "%s:%d:%d@%x,%x",
-		dp->name, *vendor, *device,
+	sprintf(tmp_buf, "%pOFn:%d:%d@%x,%x",
+		dp, *vendor, *device,
 		*intr, reg0);
 }

@@ -201,7 +201,7 @@ char * __init build_path_component(struct device_node *dp)
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] == '\0')
-		strcpy(tmp_buf, dp->name);
+		snprintf(tmp_buf, sizeof(tmp_buf), "%pOFn", dp);

 	n = prom_early_alloc(strlen(tmp_buf) + 1);
 	strcpy(n, tmp_buf);
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index baeaeed64993..6220411ce8fc 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -82,8 +82,8 @@ static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)

 	regs = rprop->value;
 	if (!of_node_is_root(dp->parent)) {
-		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+		sprintf(tmp_buf, "%pOFn@%x,%x",
+			dp,
 			(unsigned int) (regs->phys_addr >> 32UL),
 			(unsigned int) (regs->phys_addr & 0xffffffffUL));
 		return;
@@ -97,17 +97,17 @@ static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 		const char *prefix = (type == 0) ? "m" : "i";

 		if (low_bits)
-			sprintf(tmp_buf, "%s@%s%x,%x",
-				dp->name, prefix,
+			sprintf(tmp_buf, "%pOFn@%s%x,%x",
+				dp, prefix,
 				high_bits, low_bits);
 		else
-			sprintf(tmp_buf, "%s@%s%x",
-				dp->name,
+			sprintf(tmp_buf, "%pOFn@%s%x",
+				dp,
 				prefix,
 				high_bits);
 	} else if (type == 12) {
-		sprintf(tmp_buf, "%s@%x",
-			dp->name, high_bits);
+		sprintf(tmp_buf, "%pOFn@%x",
+			dp, high_bits);
 	}
 }

@@ -122,8 +122,8 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)

 	regs = prop->value;
 	if (!of_node_is_root(dp->parent)) {
-		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+		sprintf(tmp_buf, "%pOFn@%x,%x",
+			dp,
 			(unsigned int) (regs->phys_addr >> 32UL),
 			(unsigned int) (regs->phys_addr & 0xffffffffUL));
 		return;
@@ -138,8 +138,8 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 		if (tlb_type >= cheetah)
 			mask = 0x7fffff;

-		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+		sprintf(tmp_buf, "%pOFn@%x,%x",
+			dp,
 			*(u32 *)prop->value,
 			(unsigned int) (regs->phys_addr & mask));
 	}
@@ -156,8 +156,8 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 		return;

 	regs = prop->value;
-	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+	sprintf(tmp_buf, "%pOFn@%x,%x",
+		dp,
 		regs->which_io,
 		regs->phys_addr);
 }
@@ -176,13 +176,13 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	if (devfn & 0x07) {
-		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name,
+		sprintf(tmp_buf, "%pOFn@%x,%x",
+			dp,
 			devfn >> 3,
 			devfn & 0x07);
 	} else {
-		sprintf(tmp_buf, "%s@%x",
-			dp->name,
+		sprintf(tmp_buf, "%pOFn@%x",
+			dp,
 			devfn >> 3);
 	}
 }
@@ -203,8 +203,8 @@ static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
 	if (!prop)
 		return;

-	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+	sprintf(tmp_buf, "%pOFn@%x,%x",
+		dp,
 		*(u32 *) prop->value,
 		(unsigned int) (regs->phys_addr & 0xffffffffUL));
 }
@@ -221,7 +221,7 @@ static void __init vdev_path_component(struct device_node *dp, char *tmp_buf)

 	regs = prop->value;

-	sprintf(tmp_buf, "%s@%x", dp->name, *regs);
+	sprintf(tmp_buf, "%pOFn@%x", dp, *regs);
 }

 /* "name@addrhi,addrlo" */
@@ -236,8 +236,8 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)

 	regs = prop->value;

-	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name,
+	sprintf(tmp_buf, "%pOFn@%x,%x",
+		dp,
 		(unsigned int) (regs->phys_addr >> 32UL),
 		(unsigned int) (regs->phys_addr & 0xffffffffUL));
 }
@@ -257,8 +257,8 @@ static void __init i2c_path_component(struct device_node *dp, char *tmp_buf)
 	/* This actually isn't right... should look at the #address-cells
 	 * property of the i2c bus node etc. etc.
 	 */
-	sprintf(tmp_buf, "%s@%x,%x",
-		dp->name, regs[0], regs[1]);
+	sprintf(tmp_buf, "%pOFn@%x,%x",
+		dp, regs[0], regs[1]);
 }

 /* "name@reg0[,reg1]" */
@@ -274,11 +274,11 @@ static void __init usb_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;

 	if (prop->length == sizeof(u32) || regs[1] == 1) {
-		sprintf(tmp_buf, "%s@%x",
-			dp->name, regs[0]);
+		sprintf(tmp_buf, "%pOFn@%x",
+			dp, regs[0]);
 	} else {
-		sprintf(tmp_buf, "%s@%x,%x",
-			dp->name, regs[0], regs[1]);
+		sprintf(tmp_buf, "%pOFn@%x,%x",
+			dp, regs[0], regs[1]);
 	}
 }

@@ -295,11 +295,11 @@ static void __init ieee1394_path_component(struct device_node *dp, char *tmp_buf
 	regs = prop->value;

 	if (regs[2] || regs[3]) {
-		sprintf(tmp_buf, "%s@%08x%08x,%04x%08x",
-			dp->name, regs[0], regs[1], regs[2], regs[3]);
+		sprintf(tmp_buf, "%pOFn@%08x%08x,%04x%08x",
+			dp, regs[0], regs[1], regs[2], regs[3]);
 	} else {
-		sprintf(tmp_buf, "%s@%08x%08x",
-			dp->name, regs[0], regs[1]);
+		sprintf(tmp_buf, "%pOFn@%08x%08x",
+			dp, regs[0], regs[1]);
 	}
 }

@@ -361,7 +361,7 @@ char * __init build_path_component(struct device_node *dp)
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] == '\0')
-		strcpy(tmp_buf, dp->name);
+		snprintf(tmp_buf, sizeof(tmp_buf), "%pOFn", dp);

 	n = prom_early_alloc(strlen(tmp_buf) + 1);
 	strcpy(n, tmp_buf);
--
2.17.1
