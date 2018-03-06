Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeCFVre (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:47:34 -0500
Received: from a8-61.smtp-out.amazonses.com ([54.240.8.61]:48334 "EHLO
        a8-61.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753876AbeCFVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:47:33 -0500
From: Jeremy Cline <jeremy@jcline.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lining916740672@icloud.com, Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH v2] scsi: sd: Keep disk read-only when re-reading partition
Date: Tue, 6 Mar 2018 21:47:32 +0000
Message-ID: <01000161fd48a4af-94cc485f-468a-404a-985e-7e8e50a358f0-000000@email.amazonses.com>
X-Mailer: git-send-email 2.16.2
X-SES-Outgoing: 2018.03.06-54.240.8.61
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the read-only flag is true on a SCSI disk, re-reading the partition
table sets the flag back to false.

To observe this bug, you can run:

1. blockdev --setro /dev/sda
2. blockdev --rereadpt /dev/sda
3. blockdev --getro /dev/sda

This commit reads the disk's old state and combines it with the device
disk-reported state rather than unconditionally marking it as RW.

Reported-by: Li Ning <lining916740672@icloud.com>
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
Sorry about this, but there's a bug in the first version of this patch.
I'm not sure what the protocol is for sending revised patches when the
earlier version got accepted, but I don't see the first version in
4.16/scsi-fixes yet. If I should make a patch on top of the v1 patch,
just let me know.

Changes in v2:
  - Don't save the value of "get_disk_ro" to "sdkp->write_prot" since,
    as Li Ning noticed, that causes a second bug: when you make the disk
    writable again with "blockdev --setrw /dev/sda" it isn't possible to
    write to the disk until the partition is re-read.

 drivers/scsi/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index bff21e636ddd..3541caf3fceb 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2595,6 +2595,7 @@ sd_read_write_protect_flag(struct scsi_disk *sdkp, unsigned char *buffer)
 	int res;
 	struct scsi_device *sdp = sdkp->device;
 	struct scsi_mode_data data;
+	int disk_ro = get_disk_ro(sdkp->disk);
 	int old_wp = sdkp->write_prot;
 
 	set_disk_ro(sdkp->disk, 0);
@@ -2635,7 +2636,7 @@ sd_read_write_protect_flag(struct scsi_disk *sdkp, unsigned char *buffer)
 			  "Test WP failed, assume Write Enabled\n");
 	} else {
 		sdkp->write_prot = ((data.device_specific & 0x80) != 0);
-		set_disk_ro(sdkp->disk, sdkp->write_prot);
+		set_disk_ro(sdkp->disk, sdkp->write_prot || disk_ro);
 		if (sdkp->first_scan || old_wp != sdkp->write_prot) {
 			sd_printk(KERN_NOTICE, sdkp, "Write Protect is %s\n",
 				  sdkp->write_prot ? "on" : "off");
-- 
2.16.2
