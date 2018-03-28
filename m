Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeC1RBe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:01:34 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:27321 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752853AbeC1RBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:01:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G4AAC1ybtamMmZ6ERdHAEBAQQBAQoBA?=
 =?us-ascii?q?YURKItcjQGDA5JKgXoLhQSEDyE0GAECAQEBAQEBAgECEAEBAQEBCAsLBigvgjg?=
 =?us-ascii?q?ig0wvIG8ThQ6uDohGgimHXoFUP4NihGYbhXACjFCKYwiBX4xJAowvj3eBJRyCC?=
 =?us-ascii?q?3CDEoIujj1RjSoqghwBAQ?=
X-IPAS-Result: =?us-ascii?q?A2G4AAC1ybtamMmZ6ERdHAEBAQQBAQoBAYURKItcjQGDA5J?=
 =?us-ascii?q?KgXoLhQSEDyE0GAECAQEBAQEBAgECEAEBAQEBCAsLBigvgjgig0wvIG8ThQ6uD?=
 =?us-ascii?q?ohGgimHXoFUP4NihGYbhXACjFCKYwiBX4xJAowvj3eBJRyCC3CDEoIujj1RjSo?=
 =?us-ascii?q?qghwBAQ?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.48,372,1517896800";
   d="scan'208";a="637271539"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v3 1/2] power/hibernate: Make passing hibernate offsets more friendly
Date: Wed, 28 Mar 2018 12:01:09 -0500
Message-Id: <1522256470-2825-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the only way to specify a hibernate offset for a
swap file is on the kernel command line.

Add a new /sys/power/resume_offset that lets userspace
specify the offset and disk to use when initiating a hibernate
cycle.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
Changes from v2:
 * Cast the output for sector_t when printing
 * Fix a compilation problem with i386 due to different size of sector_t

 Documentation/ABI/testing/sysfs-power | 14 ++++++++++++++
 Documentation/power/swsusp.txt        | 10 +++++++++-
 kernel/power/hibernate.c              | 24 ++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 1e0d1da..2f813d6 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -287,3 +287,17 @@ Description:
 		Writing a "1" to this file enables the debug messages and
 		writing a "0" (default) to it disables them.  Reads from
 		this file return the current value.
+
+What:		/sys/power/resume_offset
+Date:		April 2018
+Contact:	Mario Limonciello <mario.limonciello@dell.com>
+Description:
+		This file is used for telling the kernel an offset into a disk
+		to use when hibernating the system such as with a swap file.
+
+		Reads from this file will display the current offset
+		the kernel will be using on the next hibernation
+		attempt.
+
+		Using this sysfs file will override any values that were
+		set using the kernel command line for disk offset.
\ No newline at end of file
diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index 9f2f942..cc87adf 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -24,8 +24,16 @@ Some warnings, first.
  * see the FAQ below for details.  (This is not true for more traditional
  * power states like "standby", which normally don't turn USB off.)
 
+Swap partition:
 You need to append resume=/dev/your_swap_partition to kernel command
-line. Then you suspend by
+line or specify it using /sys/power/resume.
+
+Swap file:
+If using a swapfile you can also specify a resume offset using
+resume_offset=<number> on the kernel command line or specify it
+in /sys/power/resume_offset.
+
+After preparing then you suspend by
 
 echo shutdown > /sys/power/disk; echo disk > /sys/power/state
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a5c36e9..d58fad3d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1061,6 +1061,29 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 power_attr(resume);
 
+static ssize_t resume_offset_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%llu\n", (unsigned long long)swsusp_resume_block);
+}
+
+static ssize_t resume_offset_store(struct kobject *kobj,
+				   struct kobj_attribute *attr, const char *buf,
+				   size_t n)
+{
+	unsigned long long offset;
+	int rc;
+
+	rc = kstrtoull(buf, 0, &offset);
+	if (rc)
+		return rc;
+	swsusp_resume_block = offset;
+
+	return n;
+}
+
+power_attr(resume_offset);
+
 static ssize_t image_size_show(struct kobject *kobj, struct kobj_attribute *attr,
 			       char *buf)
 {
@@ -1106,6 +1129,7 @@ power_attr(reserved_size);
 
 static struct attribute * g[] = {
 	&disk_attr.attr,
+	&resume_offset_attr.attr,
 	&resume_attr.attr,
 	&image_size_attr.attr,
 	&reserved_size_attr.attr,
-- 
2.7.4
