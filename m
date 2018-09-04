Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9504F2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9504F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIDXKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:10:16 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41738 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:10:16 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so8708716oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UBCx+t3u4c1JDIZsYjCAOjy+ve8hYOVH2wrUJCyxb7A=;
        b=qbH2SH2Gz9cb1U+BBgscc8oGE0ojmt6hngrpHi0ZhMWBtoMoaLFu+bDVc0RoGoZ8YH
         DpjJY0JSqiPciWMFJWx+Ovfhf9mXAGXMaiS+CSmOvgQ60jeZ/V5w6K8eIAEDCk82kvu4
         /OGyOeA/7mRpVGCSHxIOV4AuEhKlF1Ii1AyrJ6IMAuPLYJFXSwuplEahW+jIvbwuRd1C
         r78jvKo/ze8QoILz6mGM7rsuBVWJblkIoo3nF7i/sPZX/q3CT68VqMr3elRYYgtTaHxs
         FIi0IJOhhD55WZsaV5PnX8Re+PoALdMzIZOLzP8AvOmdg6FTnLItEXIwF6aKwT1+2UBd
         FotA==
X-Gm-Message-State: APzg51CTrOGjfoV5yl2x3+Q9yz03psx6IOK+V1gkVO8GJayE4owno8zI
        qownsxaZFd5106TmivBdL44bKgg=
X-Google-Smtp-Source: ANB0VdbIKo8UFttXupLSXy4FThVf3jRgVdtL1zG2g2d0eYUKGZuhMWmEjqwJEXWPWqW86kLQnpPIwg==
X-Received: by 2002:aca:ab0c:: with SMTP id u12-v6mr24556923oie.143.1536086633917;
        Tue, 04 Sep 2018 11:43:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r81-v6sm15543449oih.28.2018.09.04.11.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 11:43:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] macintosh: Convert to using %pOFn instead of device_node.name
Date:   Tue,  4 Sep 2018 13:43:52 -0500
Message-Id: <20180904184352.7836-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2: Add setting dev_name in macio_asic.c

 drivers/macintosh/macio_asic.c            | 8 ++++----
 drivers/macintosh/macio_sysfs.c           | 8 +++++++-
 drivers/macintosh/windfarm_smu_controls.c | 4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 07074820a167..cf2d3b3dd599 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -403,19 +403,19 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 
 	/* MacIO itself has a different reg, we use it's PCI base */
 	if (np == chip->of_node) {
-		dev_set_name(&dev->ofdev.dev, "%1d.%08x:%.*s",
+		dev_set_name(&dev->ofdev.dev, "%1d.%08x:%.*pOFn",
 			     chip->lbus.index,
 #ifdef CONFIG_PCI
 			(unsigned int)pci_resource_start(chip->lbus.pdev, 0),
 #else
 			0, /* NuBus may want to do something better here */
 #endif
-			MAX_NODE_NAME_SIZE, np->name);
+			MAX_NODE_NAME_SIZE, np);
 	} else {
 		reg = of_get_property(np, "reg", NULL);
-		dev_set_name(&dev->ofdev.dev, "%1d.%08x:%.*s",
+		dev_set_name(&dev->ofdev.dev, "%1d.%08x:%.*pOFn",
 			     chip->lbus.index,
-			     reg ? *reg : 0, MAX_NODE_NAME_SIZE, np->name);
+			     reg ? *reg : 0, MAX_NODE_NAME_SIZE, np);
 	}
 
 	/* Setup interrupts & resources */
diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index ca4fcffe454b..d2451e58acb9 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -58,7 +58,13 @@ static ssize_t devspec_show(struct device *dev,
 static DEVICE_ATTR_RO(modalias);
 static DEVICE_ATTR_RO(devspec);
 
-macio_config_of_attr (name, "%s\n");
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%pOFn\n", dev->of_node);
+}
+static DEVICE_ATTR_RO(name);
+
 macio_config_of_attr (type, "%s\n");
 
 static struct attribute *macio_dev_attrs[] = {
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index d174c7437337..86d65462a61c 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -277,7 +277,7 @@ static int __init smu_controls_init(void)
 		fct = smu_fan_create(fan, 0);
 		if (fct == NULL) {
 			printk(KERN_WARNING "windfarm: Failed to create SMU "
-			       "RPM fan %s\n", fan->name);
+			       "RPM fan %pOFn\n", fan);
 			continue;
 		}
 		list_add(&fct->link, &smu_fans);
@@ -296,7 +296,7 @@ static int __init smu_controls_init(void)
 		fct = smu_fan_create(fan, 1);
 		if (fct == NULL) {
 			printk(KERN_WARNING "windfarm: Failed to create SMU "
-			       "PWM fan %s\n", fan->name);
+			       "PWM fan %pOFn\n", fan);
 			continue;
 		}
 		list_add(&fct->link, &smu_fans);
-- 
2.17.1

