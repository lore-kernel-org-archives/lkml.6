Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031749AbeBNPrj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:47:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:23559 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031625AbeBNPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:47:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="17853102"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro
Date: Wed, 14 Feb 2018 17:47:35 +0200
Message-Id: <20180214154735.55233-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...instead of open coding file operations followed by custom ->open()
callbacks per each attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e6a9c36470ee..82b8b18ee1eb 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1726,25 +1726,14 @@ static int irq_domain_debug_show(struct seq_file *m, void *p)
 	irq_domain_debug_show_one(m, d, 0);
 	return 0;
 }
-
-static int irq_domain_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, irq_domain_debug_show, inode->i_private);
-}
-
-static const struct file_operations dfs_domain_ops = {
-	.open		= irq_domain_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(irq_domain_debug);
 
 static void debugfs_add_domain_dir(struct irq_domain *d)
 {
 	if (!d->name || !domain_dir || d->debugfs_file)
 		return;
 	d->debugfs_file = debugfs_create_file(d->name, 0444, domain_dir, d,
-					      &dfs_domain_ops);
+					      &irq_domain_debug_fops);
 }
 
 static void debugfs_remove_domain_dir(struct irq_domain *d)
@@ -1760,7 +1749,8 @@ void __init irq_domain_debugfs_init(struct dentry *root)
 	if (!domain_dir)
 		return;
 
-	debugfs_create_file("default", 0444, domain_dir, NULL, &dfs_domain_ops);
+	debugfs_create_file("default", 0444, domain_dir, NULL,
+			    &irq_domain_debug_fops);
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(d, &irq_domain_list, link)
 		debugfs_add_domain_dir(d);
-- 
2.15.1
