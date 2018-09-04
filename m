Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35774C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7A12077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7A12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeIEByn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:54:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39776 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEByn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:43 -0400
Received: by mail-oi0-f66.google.com with SMTP id c190-v6so9630793oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 14:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ineBaMr8aRnuD6xE4Q5jjIDHv3rtrjxktihB8OIznkc=;
        b=t/1zjcf1dKu2zT2EJj0C8oN9FFKa7Sunrk+YFw6Q7ZYYxsxpAdtCMh5NJ3xBXIQPVm
         yqgXV00tkHQ1cmLDmqQvIhWeZM9VezSMIFJbPlee6lMtIPayhx8CmkKvHpahcG8thi0U
         m35ebExvuCdNlMADvqq3ZK0n9ssv11w8zZFDzEgzpkYHcxmYgoiXOzvHbTcSAolL8ag6
         DZ4DHK+XkMntJ70lxUg0/ab3Wj6qS/ZmR5m4MDW/n+7u+g+gQjYW876y0KYMPLIIC0E3
         CseXWdiKhks2QTq9oacHJDpY4l0MbfQzZte/3CkPh4eB9t85HAD9HhgY4MkVbQcaWHNJ
         40Mg==
X-Gm-Message-State: APzg51DogvJLT96Xl37oZ0OQztM+qx2fBGTqAAGt+Ccik/XAtnfXsSgR
        L9ZGtQUXBJ2BhHurD5svHr+Q67Q=
X-Google-Smtp-Source: ANB0Vdbgid+xtheyJvENinK3Qu3td/pPTQxzHrDTqYI5veLYsPOSvQ6wDc1lBelX1PruRnD1MquZfQ==
X-Received: by 2002:aca:abc3:: with SMTP id u186-v6mr27758961oie.316.1536096465647;
        Tue, 04 Sep 2018 14:27:45 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id i132-v6sm28982541oif.20.2018.09.04.14.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] macintosh: Convert to using %pOFn instead of device_node.name
Date:   Tue,  4 Sep 2018 16:27:44 -0500
Message-Id: <20180904212744.16747-1-robh@kernel.org>
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
v3:
- Fix dev_name handling. Using "%.*p" syntax throws a warning (and 
probably doesn't work).

 drivers/macintosh/macio_asic.c            | 8 +++++---
 drivers/macintosh/macio_sysfs.c           | 8 +++++++-
 drivers/macintosh/windfarm_smu_controls.c | 4 ++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 07074820a167..58e676ca9622 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -362,7 +362,8 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 {
 	struct macio_dev *dev;
 	const u32 *reg;
-	
+	char name[MAX_NODE_NAME_SIZE + 1];
+
 	if (np == NULL)
 		return NULL;
 
@@ -402,6 +403,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 #endif
 
 	/* MacIO itself has a different reg, we use it's PCI base */
+        snprintf(name, sizeof(name), "%pOFn", np);
 	if (np == chip->of_node) {
 		dev_set_name(&dev->ofdev.dev, "%1d.%08x:%.*s",
 			     chip->lbus.index,
@@ -410,12 +412,12 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 #else
 			0, /* NuBus may want to do something better here */
 #endif
-			MAX_NODE_NAME_SIZE, np->name);
+			MAX_NODE_NAME_SIZE, name);
 	} else {
 		reg = of_get_property(np, "reg", NULL);
 		dev_set_name(&dev->ofdev.dev, "%1d.%08x:%.*s",
 			     chip->lbus.index,
-			     reg ? *reg : 0, MAX_NODE_NAME_SIZE, np->name);
+			     reg ? *reg : 0, MAX_NODE_NAME_SIZE, name);
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

