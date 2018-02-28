Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934226AbeB1RpC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:45:02 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:32190 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932466AbeB1Ro7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:44:59 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HnAADY6ZZah2Oa6ERbGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYMfggcom2WDGJZACoUwglhXFQECAQEBAQEBAgECEAEBAQoLCQgoL4I?=
 =?us-ascii?q?4IoNKT28ThRyuBohughYyhSOCJ4FXgWaIMoJwgxsFiByFVnSLbAmCC45pAoFkh?=
 =?us-ascii?q?1GFPQGRU4EuNIF1cIMSgXMBTxAMghpYjDwBAQE?=
X-IPAS-Result: =?us-ascii?q?A2HnAADY6ZZah2Oa6ERbGgEBAQEBAgEBAQEIAQEBAYMfggc?=
 =?us-ascii?q?om2WDGJZACoUwglhXFQECAQEBAQEBAgECEAEBAQoLCQgoL4I4IoNKT28ThRyuB?=
 =?us-ascii?q?ohughYyhSOCJ4FXgWaIMoJwgxsFiByFVnSLbAmCC45pAoFkh1GFPQGRU4EuNIF?=
 =?us-ascii?q?1cIMSgXMBTxAMghpYjDwBAQE?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,406,1515477600";
   d="scan'208";a="1222142815"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [RFC] power/hibernate: Make passing hibernate offsets more friendly
Date: Wed, 28 Feb 2018 11:43:49 -0600
Message-Id: <1519839829-2191-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the only way to specify a hibernate offset for a swap
file is on the kernel command line.

This makes some changes to improve:
1) Add a new /sys/power/disk_offset that lets userspace specify
the offset and disk to use when initiating a hibernate cycle.

2) Adjust /sys/power/resume interpretation to also read in an
offset.

Actually klibc's /bin/resume has supported passing a hibernate
offset in since 20695264e21dcbde309cd81f73cfe2cea42e779d.

The kernel was just lobbing anything after the device specified
off the string.  Instead parse that and populate hibernate offset
with it.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
An alternative to introducing a new sysfs parameter may be to document
setting these values via /sys/power/resume.  If the wrong signature is found
on the swapfile/swap partition by the kernel it does show an error
but it updates the values and they'll work when actually invoked later.

In that case it may make sense to adjust that error and make it level
info and explain the situation.

 kernel/power/hibernate.c | 59 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a5c36e9..f606ed6 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1025,33 +1025,68 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 power_attr(disk);
 
-static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
-			   char *buf)
-{
-	return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
-		       MINOR(swsusp_resume_device));
-}
-
-static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
-			    const char *buf, size_t n)
+static int parse_device_input(const char *buf, size_t n)
 {
+	unsigned long long offset;
 	dev_t res;
 	int len = n;
 	char *name;
+	char *last;
 
 	if (len && buf[len-1] == '\n')
 		len--;
 	name = kstrndup(buf, len, GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
-
+	last = strrchr(name, ':');
+	printk("%lu %s %s %d", last-name, name, last, len);
+	if (last != NULL &&
+	    (last-name) != len-1 &&
+	    sscanf(last+1, "%llu", &offset) == 1)
+                swsusp_resume_block = offset;
 	res = name_to_dev_t(name);
 	kfree(name);
 	if (!res)
 		return -EINVAL;
+	swsusp_resume_device = res;
+
+	return 1;
+}
+
+static ssize_t disk_offset_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	return sprintf(buf,"%d:%d:%lu\n", MAJOR(swsusp_resume_device),
+		       MINOR(swsusp_resume_device), swsusp_resume_block);
+}
+
+static ssize_t disk_offset_store(struct kobject *kobj, struct kobj_attribute *attr,
+				 const char *buf, size_t n)
+{
+	ssize_t rc = parse_device_input(buf, n);
+	if (rc < 0)
+		return rc;
+
+	return n;
+}
+
+power_attr(disk_offset);
+
+static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
+		       MINOR(swsusp_resume_device));
+}
+
+static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t n)
+{
+	ssize_t rc = parse_device_input(buf, n);
+	if (rc < 0)
+		return rc;
 
 	lock_system_sleep();
-	swsusp_resume_device = res;
 	unlock_system_sleep();
 	pr_info("Starting manual resume from disk\n");
 	noresume = 0;
@@ -1106,6 +1141,7 @@ power_attr(reserved_size);
 
 static struct attribute * g[] = {
 	&disk_attr.attr,
+	&disk_offset_attr.attr,
 	&resume_attr.attr,
 	&image_size_attr.attr,
 	&reserved_size_attr.attr,
@@ -1125,7 +1161,6 @@ static int __init pm_disk_init(void)
 
 core_initcall(pm_disk_init);
 
-
 static int __init resume_setup(char *str)
 {
 	if (noresume)
-- 
2.7.4
