Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeB1RK0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:10:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932082AbeB1RKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:10:24 -0500
Date: Wed, 28 Feb 2018 09:10:10 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-d61e2944b6364006e3d7a0152aaafda741c8c876@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        grygorii.strashko@ti.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, hpa@zytor.com, tony@atomide.com
Reply-To: hpa@zytor.com, andriy.shevchenko@linux.intel.com, tony@atomide.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        grygorii.strashko@ti.com, rafael.j.wysocki@intel.com
In-Reply-To: <20180226155043.67937-1-andriy.shevchenko@linux.intel.com>
References: <20180226155043.67937-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add wakeup sysfs node to show IRQ wakeup
 state
Git-Commit-ID: d61e2944b6364006e3d7a0152aaafda741c8c876
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d61e2944b6364006e3d7a0152aaafda741c8c876
Gitweb:     https://git.kernel.org/tip/d61e2944b6364006e3d7a0152aaafda741c8c876
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Mon, 26 Feb 2018 17:50:43 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 18:07:20 +0100

genirq: Add wakeup sysfs node to show IRQ wakeup state

Surprisingly there is no simple way to see if the IRQ line in question
is wakeup source or not.

Note that wakeup might be an OOB (out-of-band) source like GPIO line
which makes things slightly more complicated.

Add a sysfs node to cover this case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20180226155043.67937-1-andriy.shevchenko@linux.intel.com

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
