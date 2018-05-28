Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034347AbeE1P3H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966610AbeE1KTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:19:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Ning <lining916740672@icloud.com>,
        Jeremy Cline <jeremy@jcline.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 128/268] scsi: sd: Keep disk read-only when re-reading partition
Date: Mon, 28 May 2018 12:01:42 +0200
Message-Id: <20180528100216.627623125@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jeremy@jcline.org>

[ Upstream commit 20bd1d026aacc5399464f8328f305985c493cde3 ]

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
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2395,6 +2395,7 @@ sd_read_write_protect_flag(struct scsi_d
 	int res;
 	struct scsi_device *sdp = sdkp->device;
 	struct scsi_mode_data data;
+	int disk_ro = get_disk_ro(sdkp->disk);
 	int old_wp = sdkp->write_prot;
 
 	set_disk_ro(sdkp->disk, 0);
@@ -2435,7 +2436,7 @@ sd_read_write_protect_flag(struct scsi_d
 			  "Test WP failed, assume Write Enabled\n");
 	} else {
 		sdkp->write_prot = ((data.device_specific & 0x80) != 0);
-		set_disk_ro(sdkp->disk, sdkp->write_prot);
+		set_disk_ro(sdkp->disk, sdkp->write_prot || disk_ro);
 		if (sdkp->first_scan || old_wp != sdkp->write_prot) {
 			sd_printk(KERN_NOTICE, sdkp, "Write Protect is %s\n",
 				  sdkp->write_prot ? "on" : "off");
