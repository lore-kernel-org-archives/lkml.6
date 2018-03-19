Return-Path: <ning.a.zhang@intel.com>
X-Google-Smtp-Source: AG47ELsqdCi20C4ltU3YYzsLQyJ7Urd/kWpEVy1gt0os837upT5mew2xBXmm0mQpCWPDtupfxjn4
ARC-Seal: i=1; a=rsa-sha256; t=1521428120; cv=none;
        d=google.com; s=arc-20160816;
        b=vtPknb8lAb8LYM94FnA6AuKqZEPdO/ycGBg/qGrfr4tKiImBdpo/svVus2OaAObB4g
         MCm0Phebhu5SMPFU91j3oKw6aKQj4I+XyMa0fJxG2JclnZ78l37LGT+9TauzuWcuApvG
         oNTheNc0TYGCSUZJpkAfuanII+ZyPwawC2DLOd2YtaFhfjgxZJ4Zyzc8+q3/iNUh/DeL
         sXEQ3qw/52eZmXax4JlF1RV77AAeqwGMhYjkl62NXp9zBkKzidYsSGDx0+E4JsIVktJ/
         j585fL3OG3z2mkRkmzqIy7RJbYZOMLwzKnh+jmFKzAI2iclo5BOhVp+y2zQjijLOU3hf
         fycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=DwfarKWcu1Tei/1y0pHJFolLDhxe38iTbkxSOCyFUo4=;
        b=Ug6/KPlLVOPPBSwJeCs9cKEgwkOR8o3xIibmKrmxL3zhTIHc3G8UrHH71bxoFAqPrH
         ynke1XL5kztsB31K3lmeFTPVdAi+kd1Oj6Ze0B8Lzy761iWoKOnchthUeEHZEO0Fkc0a
         aOty0sy2k9JbYEs6QGjVjOZWrgzNEz1f0F17oSdJadzWyRwfKc+bfltresg57HyEu1ET
         ehSl5c7h0qCNZYwArobleNXvpOWTchzJGAZzIojFrB7l81vOGakl2LcEbFW6NwSutM5A
         CxcKLbXErAeYRg8PSccEf+X3di4FzdTr8YVMk2kU/IJAIWRKuAvGj+f3QDCxW0I4tDoM
         3kDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ning.a.zhang@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=ning.a.zhang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ning.a.zhang@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=ning.a.zhang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,328,1517904000";
   d="scan'208";a="212762307"
From: ning.a.zhang@intel.com
To: dhowells@redhat.com,
	akpm@linux-foundation.org,
	alexander.levin@verizon.com,
	kstewart@linuxfoundation.org,
	tglx@linutronix.de,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com
Cc: linux-kernel@vger.kernel.org,
	Zhang Ning <ning.a.zhang@intel.com>
Subject: [PATCH] init: no need to wait device probe
Date: Mon, 19 Mar 2018 10:55:08 +0800
Message-Id: <20180319025508.3767-1-ning.a.zhang@intel.com>
X-Mailer: git-send-email 2.14.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595333012085575083?=
X-GMAIL-MSGID: =?utf-8?q?1595333012085575083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
