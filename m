Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCOHUn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:20:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:47720 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeCOHUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:20:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,308,1517904000";
   d="scan'208";a="208414772"
From: ning.a.zhang@intel.com
To: linux-kernel@vger.kernel.org
Cc: Zhang Ning <ning.a.zhang@intel.com>
Subject: [PATCH] init: no need to wait device probe
Date: Thu, 15 Mar 2018 15:20:29 +0800
Message-Id: <20180315072029.11441-1-ning.a.zhang@intel.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ning <ning.a.zhang@intel.com>

there are 2 reasons for no need to wait device probe

reason 1:
mount root device is very late in kernel initial stage.
all initcalls are finished. that means most of probe functions
are returned.

and deferred probe are also finished by late_initcall.
only async probe driver are possible in  probing.

no block devices, device-mapper or nfs are use async probe.
so no need to wait device probe.

reason 2:
let's check dd.c, probe_count is increased and decreased only
in really_probe, and when really_probe returns, probe_count
always be 0.

when someone really wants to wait device-B probe.
but code looks like:

thread-1:			thread-2:
probe device-A;                 wait_for_device_probe();
msleep(30);
probe device-B

when device-A probe finishes, thread-2 will be wakeup,
but device-B is not probed.

wait_for_device_probe can't make sure the device you want is probed.

based on above 2 reasons, no need to wait for device probe.

Signed-off-by: Zhang Ning <ning.a.zhang@intel.com>
---
 init/do_mounts.c    | 9 ---------
 init/do_mounts_md.c | 2 --
 2 files changed, 11 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7cf4f6dafd5f..a9fb2ad44964 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -555,15 +555,6 @@ void __init prepare_namespace(void)
 		ssleep(root_delay);
 	}
 
-	/*
-	 * wait for the known devices to complete their probing
-	 *
-	 * Note: this is a potential source of long boot delays.
-	 * For example, it is not atypical to wait 5 seconds here
-	 * for the touchpad of a laptop to initialize.
-	 */
-	wait_for_device_probe();
-
 	md_run_setup();
 
 	if (saved_root_name[0]) {
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index 3f733c760a8c..4aab3492e71d 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
@@ -292,8 +292,6 @@ static void __init autodetect_raid(void)
 	printk(KERN_INFO "md: Waiting for all devices to be available before autodetect\n");
 	printk(KERN_INFO "md: If you don't use raid, use raid=noautodetect\n");
 
-	wait_for_device_probe();
-
 	fd = sys_open("/dev/md0", 0, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, RAID_AUTORUN, raid_autopart);
-- 
2.14.2
