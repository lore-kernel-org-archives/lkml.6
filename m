Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A84C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E63920661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E63920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeLIW0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:26:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34830 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbeLIVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:15 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002ij-7a; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003Ky-Nc; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Bart Van Assche" <bart.vanassche@wdc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Johannes Thumshirn" <jthumshirn@suse.de>,
        "Tejun Heo" <tj@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.249433289@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 097/328] scsi: core: Avoid that SCSI device removal
 through sysfs triggers a deadlock
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 0ee223b2e1f67cb2de9c0e3247c510d846e74d63 upstream.

A long time ago the unfortunate decision was taken to add a self-deletion
attribute to the sysfs SCSI device directory. That decision was unfortunate
because self-deletion is really tricky. We can't drop that attribute
because widely used user space software depends on it, namely the
rescan-scsi-bus.sh script. Hence this patch that avoids that writing into
that attribute triggers a deadlock. See also commit 7973cbd9fbd9 ("[PATCH]
add sysfs attributes to scan and delete scsi_devices").

This patch avoids that self-removal triggers the following deadlock:

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc2-dbg+ #5 Not tainted
------------------------------------------------------
modprobe/6539 is trying to acquire lock:
000000008323c4cd (kn->count#202){++++}, at: kernfs_remove_by_name_ns+0x45/0x90

but task is already holding lock:
00000000a6ec2c69 (&shost->scan_mutex){+.+.}, at: scsi_remove_host+0x21/0x150 [scsi_mod]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&shost->scan_mutex){+.+.}:
       __mutex_lock+0xfe/0xc70
       mutex_lock_nested+0x1b/0x20
       scsi_remove_device+0x26/0x40 [scsi_mod]
       sdev_store_delete+0x27/0x30 [scsi_mod]
       dev_attr_store+0x3e/0x50
       sysfs_kf_write+0x87/0xa0
       kernfs_fop_write+0x190/0x230
       __vfs_write+0xd2/0x3b0
       vfs_write+0x101/0x270
       ksys_write+0xab/0x120
       __x64_sys_write+0x43/0x50
       do_syscall_64+0x77/0x230
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (kn->count#202){++++}:
       lock_acquire+0xd2/0x260
       __kernfs_remove+0x424/0x4a0
       kernfs_remove_by_name_ns+0x45/0x90
       remove_files.isra.1+0x3a/0x90
       sysfs_remove_group+0x5c/0xc0
       sysfs_remove_groups+0x39/0x60
       device_remove_attrs+0x82/0xb0
       device_del+0x251/0x580
       __scsi_remove_device+0x19f/0x1d0 [scsi_mod]
       scsi_forget_host+0x37/0xb0 [scsi_mod]
       scsi_remove_host+0x9b/0x150 [scsi_mod]
       sdebug_driver_remove+0x4b/0x150 [scsi_debug]
       device_release_driver_internal+0x241/0x360
       device_release_driver+0x12/0x20
       bus_remove_device+0x1bc/0x290
       device_del+0x259/0x580
       device_unregister+0x1a/0x70
       sdebug_remove_adapter+0x8b/0xf0 [scsi_debug]
       scsi_debug_exit+0x76/0xe8 [scsi_debug]
       __x64_sys_delete_module+0x1c1/0x280
       do_syscall_64+0x77/0x230
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&shost->scan_mutex);
                               lock(kn->count#202);
                               lock(&shost->scan_mutex);
  lock(kn->count#202);

 *** DEADLOCK ***

2 locks held by modprobe/6539:
 #0: 00000000efaf9298 (&dev->mutex){....}, at: device_release_driver_internal+0x68/0x360
 #1: 00000000a6ec2c69 (&shost->scan_mutex){+.+.}, at: scsi_remove_host+0x21/0x150 [scsi_mod]

stack backtrace:
CPU: 10 PID: 6539 Comm: modprobe Not tainted 4.18.0-rc2-dbg+ #5
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 dump_stack+0xa4/0xf5
 print_circular_bug.isra.34+0x213/0x221
 __lock_acquire+0x1a7e/0x1b50
 lock_acquire+0xd2/0x260
 __kernfs_remove+0x424/0x4a0
 kernfs_remove_by_name_ns+0x45/0x90
 remove_files.isra.1+0x3a/0x90
 sysfs_remove_group+0x5c/0xc0
 sysfs_remove_groups+0x39/0x60
 device_remove_attrs+0x82/0xb0
 device_del+0x251/0x580
 __scsi_remove_device+0x19f/0x1d0 [scsi_mod]
 scsi_forget_host+0x37/0xb0 [scsi_mod]
 scsi_remove_host+0x9b/0x150 [scsi_mod]
 sdebug_driver_remove+0x4b/0x150 [scsi_debug]
 device_release_driver_internal+0x241/0x360
 device_release_driver+0x12/0x20
 bus_remove_device+0x1bc/0x290
 device_del+0x259/0x580
 device_unregister+0x1a/0x70
 sdebug_remove_adapter+0x8b/0xf0 [scsi_debug]
 scsi_debug_exit+0x76/0xe8 [scsi_debug]
 __x64_sys_delete_module+0x1c1/0x280
 do_syscall_64+0x77/0x230
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

See also https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg54525.html.

Fixes: ac0ece9174ac ("scsi: use device_remove_file_self() instead of device_schedule_callback()")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Johannes Thumshirn <jthumshirn@suse.de>

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/scsi_sysfs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -651,8 +651,24 @@ static ssize_t
 sdev_store_delete(struct device *dev, struct device_attribute *attr,
 		  const char *buf, size_t count)
 {
-	if (device_remove_file_self(dev, attr))
-		scsi_remove_device(to_scsi_device(dev));
+	struct kernfs_node *kn;
+
+	kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	WARN_ON_ONCE(!kn);
+	/*
+	 * Concurrent writes into the "delete" sysfs attribute may trigger
+	 * concurrent calls to device_remove_file() and scsi_remove_device().
+	 * device_remove_file() handles concurrent removal calls by
+	 * serializing these and by ignoring the second and later removal
+	 * attempts.  Concurrent calls of scsi_remove_device() are
+	 * serialized. The second and later calls of scsi_remove_device() are
+	 * ignored because the first call of that function changes the device
+	 * state into SDEV_DEL.
+	 */
+	device_remove_file(dev, attr);
+	scsi_remove_device(to_scsi_device(dev));
+	if (kn)
+		sysfs_unbreak_active_protection(kn);
 	return count;
 };
 static DEVICE_ATTR(delete, S_IWUSR, NULL, sdev_store_delete);

