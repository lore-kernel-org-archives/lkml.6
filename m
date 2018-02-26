Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeBZPuw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:50:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:40278 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752256AbeBZPus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:50:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="34234892"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] genirq: Add wakeup sysfs node to show IRQ wakeup state
Date: Mon, 26 Feb 2018 17:50:43 +0200
Message-Id: <20180226155043.67937-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Surprisingly there is no simple way to see if the IRQ line in question
is wakeup source or not.

Note that wakeup might be an OOB (out-of-band) source like GPIO line
which makes things slightly more complicated.

Add a sysfs node to cover this case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-kernel-irq |  7 +++++++
 kernel/irq/irqdesc.c                       | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-irq b/Documentation/ABI/testing/sysfs-kernel-irq
index eb074b100986..8910d0c4bcd8 100644
--- a/Documentation/ABI/testing/sysfs-kernel-irq
+++ b/Documentation/ABI/testing/sysfs-kernel-irq
@@ -51,3 +51,10 @@ Date:		September 2016
 KernelVersion:	4.9
 Contact:	Craig Gallek <kraig@google.com>
 Description:	The type of the interrupt.  Either the string 'level' or 'edge'.
+
+What:		/sys/kernel/irq/<irq>/wakeup
+Date:		March 2018
+KernelVersion:	4.17
+Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+Description:	The wakeup state of the interrupt. Either the string
+		'enabled' or 'disabled'.
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 49b54e9979cc..d9ded088d336 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -210,6 +210,22 @@ static ssize_t type_show(struct kobject *kobj,
 }
 IRQ_ATTR_RO(type);
 
+static ssize_t wakeup_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	ssize_t ret = 0;
+
+	raw_spin_lock_irq(&desc->lock);
+	ret = sprintf(buf, "%s\n",
+		      irqd_is_wakeup_set(&desc->irq_data) ? "enabled" : "disabled");
+	raw_spin_unlock_irq(&desc->lock);
+
+	return ret;
+
+}
+IRQ_ATTR_RO(wakeup);
+
 static ssize_t name_show(struct kobject *kobj,
 			 struct kobj_attribute *attr, char *buf)
 {
@@ -253,6 +269,7 @@ static struct attribute *irq_attrs[] = {
 	&chip_name_attr.attr,
 	&hwirq_attr.attr,
 	&type_attr.attr,
+	&wakeup_attr.attr,
 	&name_attr.attr,
 	&actions_attr.attr,
 	NULL
-- 
2.16.1
