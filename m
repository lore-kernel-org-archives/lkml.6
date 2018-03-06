Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeCFKyJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:54:09 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:6828 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753024AbeCFKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:54:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GEAAAycp5amD+a6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUmKJtxgxiUSIIBCoUwgn4hNxUBAgEBAQEBAQIBAhABAQEBAQg?=
 =?us-ascii?q?LCwYoLoI4IoNKLyBvE4UbqwyIaIImhS6CLoFXihgFhgQEiCOFWXWLdgmCDo5xA?=
 =?us-ascii?q?o51AZFWgS40gXVwgxKCQYImWIldKoIfAQEB?=
X-IPAS-Result: =?us-ascii?q?A2GEAAAycp5amD+a6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?mKJtxgxiUSIIBCoUwgn4hNxUBAgEBAQEBAQIBAhABAQEBAQgLCwYoLoI4IoNKL?=
 =?us-ascii?q?yBvE4UbqwyIaIImhS6CLoFXihgFhgQEiCOFWXWLdgmCDo5xAo51AZFWgS40gXV?=
 =?us-ascii?q?wgxKCQYImWIldKoIfAQEB?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,431,1515477600";
   d="scan'208";a="223719879"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] power/hibernate: Make passing hibernate offsets more friendly
Date: Tue,  6 Mar 2018 04:53:40 -0600
Message-Id: <1520333620-22342-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the only way to specify a hibernate offset for a
swap file is on the kernel command line.

Add a new /sys/power/disk_offset that lets userspace
specify the offset and disk to use when initiating a hibernate
cycle.

Also split up the parsing routine to re-use the same code
for the /sys/power/resume and /sys/power/disk_offset parsing.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 Documentation/ABI/testing/sysfs-power | 43 +++++++++++++++++
 Documentation/power/swsusp.txt        | 10 +++-
 kernel/power/hibernate.c              | 88 +++++++++++++++++++++++++++++------
 3 files changed, 125 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 1e0d1da..9b66cd6 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -287,3 +287,46 @@ Description:
 		Writing a "1" to this file enables the debug messages and
 		writing a "0" (default) to it disables them.  Reads from
 		this file return the current value.
+
+What:		/sys/power/disk_offset
+Date:		April 2018
+Contact:	Mario Limonciello <mario.limonciello@dell.com>
+Description:
+		This file is used for telling the kernel which disk partiion
+		and offset to use when hibernating the system.
+
+		Reads from this file will display the current disk and
+		offset the kernel will be using on the next hibernation
+		attempt.
+
+		Using this sysfs file will override any values that were
+		set using the kernel command line for resume disk or offset.
+
+		Swap partition
+		--------------
+		You can write the partition to this file with no offset.
+
+		For example to use a swap partition you may write:
+		- "8:2" into the file.
+		or
+		- "/dev/sda2" into the file.
+		or
+		- "PARTUUID=a1386b9c-0d2a-41dd-bcf5-b9b19a863bfb" into the file
+
+		Note: writing a partition with no offset will also reset the
+		offset to zero.
+
+		Swap file
+		---------
+		To use a swapfile you will need to write the partition
+		containing the swapfile along with a ";" and offset within
+		the partition that points to that file.
+
+		For example to use a swapfile located in the disk you
+		may write:
+		- "8:2;38416" into the file.
+		or
+		- "/dev/sda2;38416" into the file
+		or
+		- "PARTUUID=a1386b9c-0d2a-41dd-bcf5-b9b19a863bfb;38416" into
+		  the file
diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index 9f2f942..539bb0b 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -24,8 +24,16 @@ Some warnings, first.
  * see the FAQ below for details.  (This is not true for more traditional
  * power states like "standby", which normally don't turn USB off.)
 
+Swap partition:
 You need to append resume=/dev/your_swap_partition to kernel command
-line. Then you suspend by
+line or specify it using /sys/power/disk_offset.
+
+Swap file:
+If using a swapfile you can also specify a resume offset usin
+resume_offset=<number> on the kernel command line or specify it after
+the disk with a ";<offset>" in /sys/power/disk_offset.
+
+After preparing then you suspend by
 
 echo shutdown > /sys/power/disk; echo disk > /sys/power/state
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a5c36e9..fc9dc7a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1025,33 +1025,69 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 power_attr(disk);
 
+static int parse_device_input(const char *buf, size_t n, bool update_offset)
+{
+	char *start, *tok, *end;
+	int ret = -EINVAL;
+	dev_t res = 0;
+	int len = n;
+
+	if (!len)
+		return ret;
+	if (buf[len-1] == '\n')
+		len--;
+	start = end = kstrndup(buf, len, GFP_KERNEL);
+	if (!end)
+		return -ENOMEM;
+
+	tok = strsep(&end, ";");
+	if (!tok)
+		goto out;
+
+	res = name_to_dev_t(tok);
+	if (!res)
+		goto out;
+	ret = 0;
+
+	/* keep behavior for /sys/power/resume */
+	if (!update_offset)
+		goto out_name;
+
+	/* If no offset specified, reset it */
+	tok = strsep(&end, ";");
+	if (!tok) {
+		swsusp_resume_block = 0;
+		goto out_name;
+	}
+
+	ret = kstrtoull(tok, 0, (unsigned long long *) &swsusp_resume_block);
+	if (ret)
+		goto out;
+out_name:
+	swsusp_resume_device = res;
+out:
+	if (ret)
+		pr_warn("Unable to parse from %s (%d)", start, ret);
+	kfree(start);
+	return ret;
+}
+
 static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
 			   char *buf)
 {
-	return sprintf(buf,"%d:%d\n", MAJOR(swsusp_resume_device),
+	return sprintf(buf, "%d:%d\n", MAJOR(swsusp_resume_device),
 		       MINOR(swsusp_resume_device));
 }
 
 static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 			    const char *buf, size_t n)
 {
-	dev_t res;
-	int len = n;
-	char *name;
+	int rc = parse_device_input(buf, n, false);
 
-	if (len && buf[len-1] == '\n')
-		len--;
-	name = kstrndup(buf, len, GFP_KERNEL);
-	if (!name)
-		return -ENOMEM;
-
-	res = name_to_dev_t(name);
-	kfree(name);
-	if (!res)
-		return -EINVAL;
+	if (rc < 0)
+		return rc;
 
 	lock_system_sleep();
-	swsusp_resume_device = res;
 	unlock_system_sleep();
 	pr_info("Starting manual resume from disk\n");
 	noresume = 0;
@@ -1061,6 +1097,27 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 power_attr(resume);
 
+static ssize_t disk_offset_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d:%d;%lu\n", MAJOR(swsusp_resume_device),
+		       MINOR(swsusp_resume_device), swsusp_resume_block);
+}
+
+static ssize_t disk_offset_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t n)
+{
+	int rc = parse_device_input(buf, n, true);
+
+	if (rc < 0)
+		return rc;
+
+	return n;
+}
+
+power_attr(disk_offset);
+
 static ssize_t image_size_show(struct kobject *kobj, struct kobj_attribute *attr,
 			       char *buf)
 {
@@ -1106,6 +1163,7 @@ power_attr(reserved_size);
 
 static struct attribute * g[] = {
 	&disk_attr.attr,
+	&disk_offset_attr.attr,
 	&resume_attr.attr,
 	&image_size_attr.attr,
 	&reserved_size_attr.attr,
-- 
2.7.4
