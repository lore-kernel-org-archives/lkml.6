Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01752C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16072086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16072086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbeKQIZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:25:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38801 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQIZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:25:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id u3so17625782ota.5;
        Fri, 16 Nov 2018 14:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsBjmVUpfgFD4+GSZc9VvJ8gIlc1uQbIKJ5t1TJ0p+c=;
        b=lbhdTyASMFTxT275mqCol/UZdu8Y0jxsJ4PAwp7gngDdtkuotpmB0ymnxbzHfWtqO7
         5muu0FqrPxLUskwJsRv6Hiv/ydH+iyUC2JF+DSuBaF7u8wnZciCExGXdo7qJOCvjP/cn
         top75n22g6D5pnKG/BOa78BNuy6rdRg1T243+clWMF2QEA/jr6ZWXBpI8FjU3/nTZFZE
         d7CX21jJ5QV8DclqU7fmdRT7eiDkEhrTb0KUMullcNsbc0ePvIF8hDNK+pcb0IJTHT7E
         dBkxjbCaN6KZZhdNWZpkyohwLIPVQYPoKsFL2k32jPh1DiCLfEbZz7PTaFJlF79IxU1j
         rfcg==
X-Gm-Message-State: AGRZ1gJY/DS4Rs1yfYOeiWcDs4vQrAtgqHiFgPrFrrNx8IwoR3apE5PN
        5/dDxhqXq8yPpLY7lCYeuQ==
X-Google-Smtp-Source: AJdET5cjRP8GK30FQdOzO0d4yJmWyDXpj/R65hY1flmWGxxmvCM4gi6V5+dBm/RFkfCVyT0iR1SNag==
X-Received: by 2002:a9d:2990:: with SMTP id n16mr7158467otb.19.1542406273377;
        Fri, 16 Nov 2018 14:11:13 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id p204-v6sm12142631oib.25.2018.11.16.14.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:11:12 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: Use device_type helpers to access the node type
Date:   Fri, 16 Nov 2018 16:11:01 -0600
Message-Id: <20181116221104.23024-5-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/macio_asic.c            |  4 ++--
 drivers/macintosh/macio_sysfs.c           | 18 ++++++------------
 drivers/macintosh/windfarm_fcu_controls.c |  8 ++++----
 drivers/macintosh/windfarm_smu_sat.c      |  9 ++++-----
 drivers/macintosh/windfarm_smu_sensors.c  | 13 ++++++-------
 5 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 17d3bc917562..bc8418801224 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -220,8 +220,8 @@ static int macio_resource_quirks(struct device_node *np, struct resource *res,
 		return 1;
 
 	/* Some older IDE resources have bogus sizes */
-	if (!(strcmp(np->name, "IDE") && strcmp(np->name, "ATA") &&
-	      strcmp(np->type, "ide") && strcmp(np->type, "ata"))) {
+	if (!strcmp(np->name, "IDE") || !strcmp(np->name, "ATA") ||
+	    of_node_is_type(np, "ide") || of_node_is_type(np, "ata")) {
 		if (index == 0 && (res->end - res->start) > 0xfff)
 			res->end = res->start + 0xfff;
 		if (index == 1 && (res->end - res->start) > 0xff)
diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index d2451e58acb9..27f5eefc508f 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -3,17 +3,6 @@
 #include <linux/stat.h>
 #include <asm/macio.h>
 
-
-#define macio_config_of_attr(field, format_string)			\
-static ssize_t								\
-field##_show (struct device *dev, struct device_attribute *attr,	\
-              char *buf)						\
-{									\
-	struct macio_dev *mdev = to_macio_device (dev);			\
-	return sprintf (buf, format_string, mdev->ofdev.dev.of_node->field); \
-}									\
-static DEVICE_ATTR_RO(field);
-
 static ssize_t
 compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -65,7 +54,12 @@ static ssize_t name_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(name);
 
-macio_config_of_attr (type, "%s\n");
+static ssize_t type_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", of_node_get_device_type(dev->of_node));
+}
+static DEVICE_ATTR_RO(type);
 
 static struct attribute *macio_dev_attrs[] = {
 	&dev_attr_name.attr,
diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index 2b3ca628a650..629f19875d7f 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -439,11 +439,11 @@ static void wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
 		DBG(" control: %pOFn, type: %s\n", np, of_node_get_device_type(np));
 
 		/* Detect control type */
-		if (!strcmp(np->type, "fan-rpm-control") ||
-		    !strcmp(np->type, "fan-rpm"))
+		if (of_node_is_type(np, "fan-rpm-control") ||
+		    of_node_is_type(np, "fan-rpm"))
 			type = FCU_FAN_RPM;
-		if (!strcmp(np->type, "fan-pwm-control") ||
-		    !strcmp(np->type, "fan-pwm"))
+		if (of_node_is_type(np, "fan-pwm-control") ||
+		    of_node_is_type(np, "fan-pwm"))
 			type = FCU_FAN_PWM;
 		/* Only care about fans for now */
 		if (type == -1)
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index a0f61eb853c5..b4be718beba8 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -197,7 +197,7 @@ static int wf_sat_probe(struct i2c_client *client,
 	struct wf_sat *sat;
 	struct wf_sat_sensor *sens;
 	const u32 *reg;
-	const char *loc, *type;
+	const char *loc;
 	u8 chip, core;
 	struct device_node *child;
 	int shift, cpu, index;
@@ -220,7 +220,6 @@ static int wf_sat_probe(struct i2c_client *client,
 	child = NULL;
 	while ((child = of_get_next_child(dev, child)) != NULL) {
 		reg = of_get_property(child, "reg", NULL);
-		type = of_get_property(child, "device_type", NULL);
 		loc = of_get_property(child, "location", NULL);
 		if (reg == NULL || loc == NULL)
 			continue;
@@ -249,15 +248,15 @@ static int wf_sat_probe(struct i2c_client *client,
 			continue;
 		}
 
-		if (strcmp(type, "voltage-sensor") == 0) {
+		if (of_node_is_type(child, "voltage-sensor")) {
 			name = "cpu-voltage";
 			shift = 4;
 			vsens[core] = index;
-		} else if (strcmp(type, "current-sensor") == 0) {
+		} else if (of_node_is_type(child, "current-sensor")) {
 			name = "cpu-current";
 			shift = 8;
 			isens[core] = index;
-		} else if (strcmp(type, "temp-sensor") == 0) {
+		} else if (of_node_is_type(child, "temp-sensor")) {
 			name = "cpu-temp";
 			shift = 10;
 		} else
diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 172fd267dcf6..1ba86de93f92 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -197,15 +197,14 @@ static const struct wf_sensor_ops smu_slotspow_ops = {
 static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 {
 	struct smu_ad_sensor *ads;
-	const char *c, *l;
+	const char *l;
 	const u32 *v;
 
 	ads = kmalloc(sizeof(struct smu_ad_sensor), GFP_KERNEL);
 	if (ads == NULL)
 		return NULL;
-	c = of_get_property(node, "device_type", NULL);
 	l = of_get_property(node, "location", NULL);
-	if (c == NULL || l == NULL)
+	if (l == NULL)
 		goto fail;
 
 	/* We currently pick the sensors based on the OF name and location
@@ -215,7 +214,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 	 * the names and locations consistents so I'll stick with the names
 	 * and locations for now.
 	 */
-	if (!strcmp(c, "temp-sensor") &&
+	if (of_node_is_type(node, "temp-sensor") &&
 	    !strcmp(l, "CPU T-Diode")) {
 		ads->sens.ops = &smu_cputemp_ops;
 		ads->sens.name = "cpu-temp";
@@ -224,7 +223,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 			    SMU_SDB_CPUDIODE_ID);
 			goto fail;
 		}
-	} else if (!strcmp(c, "current-sensor") &&
+	} else if (of_node_is_type(node, "current-sensor") &&
 		   !strcmp(l, "CPU Current")) {
 		ads->sens.ops = &smu_cpuamp_ops;
 		ads->sens.name = "cpu-current";
@@ -233,7 +232,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 			    SMU_SDB_CPUVCP_ID);
 			goto fail;
 		}
-	} else if (!strcmp(c, "voltage-sensor") &&
+	} else if (of_node_is_type(node, "voltage-sensor") &&
 		   !strcmp(l, "CPU Voltage")) {
 		ads->sens.ops = &smu_cpuvolt_ops;
 		ads->sens.name = "cpu-voltage";
@@ -242,7 +241,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 			    SMU_SDB_CPUVCP_ID);
 			goto fail;
 		}
-	} else if (!strcmp(c, "power-sensor") &&
+	} else if (of_node_is_type(node, "power-sensor") &&
 		   !strcmp(l, "Slots Power")) {
 		ads->sens.ops = &smu_slotspow_ops;
 		ads->sens.name = "slots-power";
-- 
2.19.1

