Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeC0U7C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:59:02 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:65135 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751067AbeC0U7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:59:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G5AQDbr7pah8uZ6ERdHAEBAQQBAQoBA?=
 =?us-ascii?q?YUSKJhygwOSUYIDC4UEhAUhNRcBAgEBAQEBAQIBAhABAQEKCwkIKC+COCKDTC8?=
 =?us-ascii?q?gbxOFDq4QiEuCF4U+ghqBVECDZYRqG4VxA4xaimgIgV+MVAKMOo99gSUeAoIHc?=
 =?us-ascii?q?IMSgi+OP1GNNSqCHAEB?=
X-IPAS-Result: =?us-ascii?q?A2G5AQDbr7pah8uZ6ERdHAEBAQQBAQoBAYUSKJhygwOSUYI?=
 =?us-ascii?q?DC4UEhAUhNRcBAgEBAQEBAQIBAhABAQEKCwkIKC+COCKDTC8gbxOFDq4QiEuCF?=
 =?us-ascii?q?4U+ghqBVECDZYRqG4VxA4xaimgIgV+MVAKMOo99gSUeAoIHcIMSgi+OP1GNNSq?=
 =?us-ascii?q?CHAEB?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.48,368,1517896800";
   d="scan'208";a="1124121471"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2 1/2] power/hibernate: Make passing hibernate offsets more friendly
Date: Tue, 27 Mar 2018 15:58:52 -0500
Message-Id: <1522184333-27582-1-git-send-email-mario.limonciello@dell.com>
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
 Documentation/ABI/testing/sysfs-power | 14 ++++++++++++++
 Documentation/power/swsusp.txt        | 10 +++++++++-
 kernel/power/hibernate.c              | 21 +++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

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
index a5c36e9..16e8645 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1061,6 +1061,26 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 power_attr(resume);
 
+static ssize_t resume_offset_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", swsusp_resume_block);
+}
+
+static ssize_t resume_offset_store(struct kobject *kobj,
+				   struct kobj_attribute *attr, const char *buf,
+				   size_t n)
+{
+	int rc = kstrtoul(buf, 0, &swsusp_resume_block);
+
+	if (rc)
+		return rc;
+
+	return n;
+}
+
+power_attr(resume_offset);
+
 static ssize_t image_size_show(struct kobject *kobj, struct kobj_attribute *attr,
 			       char *buf)
 {
@@ -1106,6 +1126,7 @@ power_attr(reserved_size);
 
 static struct attribute * g[] = {
 	&disk_attr.attr,
+	&resume_offset_attr.attr,
 	&resume_attr.attr,
 	&image_size_attr.attr,
 	&reserved_size_attr.attr,
-- 
2.7.4
