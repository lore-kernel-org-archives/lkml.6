Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeC1IpB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:45:01 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:46344 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbeC1Io5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:44:57 -0400
From: Wen Yang <wen.yang99@zte.com.cn>
To: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@wdc.com, pmladek@suse.com,
        sergey.senozhatsky.work@gmail.com, tj@kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn, Tan Hu <tan.hu@zte.com.cn>
Subject: [PATCH] scsi: Introduce sdev_printk_ratelimited to throttle frequent printk
Date: Wed, 28 Mar 2018 16:43:04 +0800
Message-Id: <1522226584-137056-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-03-28 16:44:48,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-03-28 16:44:34,
        Serialize complete at 2018-03-28 16:44:34
X-MAIL: mse01.zte.com.cn w2S8igcb058246
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There would be so many same lines printed by frequent prink if one 
disk went wrong, like,
[  546.185242] sd 0:1:0:0: rejecting I/O to offline device
[  546.185258] sd 0:1:0:0: rejecting I/O to offline device
[  546.185280] sd 0:1:0:0: rejecting I/O to offline device
[  546.185307] sd 0:1:0:0: rejecting I/O to offline device
[  546.185334] sd 0:1:0:0: rejecting I/O to offline device
[  546.185364] sd 0:1:0:0: rejecting I/O to offline device
[  546.185390] sd 0:1:0:0: rejecting I/O to offline device
[  546.185410] sd 0:1:0:0: rejecting I/O to offline device
For slow serial console, the frequent prink may block the printk, and 
if spin_lock was acquired before the printk like in scsi_request_fn,
that could trigger the watchdog.

Relative disscussion can be found here,
https://bugzilla.kernel.org/show_bug.cgi?id=199003
And Petr brought the idea to throttle the frequent printk here, it's 
useless to print the same lines frequently after all.
 
Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
CC: BartVanAssche <Bart.VanAssche@wdc.com>
CC: Petr Mladek <pmladek@suse.com>
CC: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC: Martin K. Petersen <martin.petersen@oracle.com>
CC: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
CC: Tejun Heo <tj@kernel.org>
---
 drivers/scsi/scsi_lib.c    |  6 +++---
 include/scsi/scsi_device.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c84f931..f77e801 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1301,7 +1301,7 @@ static int scsi_setup_cmnd(struct scsi_device *sdev, struct request *req)
 			 * commands.  The device must be brought online
 			 * before trying any recovery commands.
 			 */
-			sdev_printk(KERN_ERR, sdev,
+			sdev_printk_ratelimited(KERN_ERR, sdev,
 				    "rejecting I/O to offline device\n");
 			ret = BLKPREP_KILL;
 			break;
@@ -1310,7 +1310,7 @@ static int scsi_setup_cmnd(struct scsi_device *sdev, struct request *req)
 			 * If the device is fully deleted, we refuse to
 			 * process any commands as well.
 			 */
-			sdev_printk(KERN_ERR, sdev,
+			sdev_printk_ratelimited(KERN_ERR, sdev,
 				    "rejecting I/O to dead device\n");
 			ret = BLKPREP_KILL;
 			break;
@@ -1802,7 +1802,7 @@ static void scsi_request_fn(struct request_queue *q)
 			break;
 
 		if (unlikely(!scsi_device_online(sdev))) {
-			sdev_printk(KERN_ERR, sdev,
+			sdev_printk_ratelimited(KERN_ERR, sdev,
 				    "rejecting I/O to offline device\n");
 			scsi_kill_request(req, q);
 			continue;
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 7ae177c..378d3f2 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -249,6 +249,16 @@ struct scsi_device {
 #define sdev_printk(l, sdev, fmt, a...)				\
 	sdev_prefix_printk(l, sdev, NULL, fmt, ##a)
 
+#define sdev_printk_ratelimited(l, sdev, fmt, a...)			\
+({									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+									\
+	if (__ratelimit(&_rs))						\
+		sdev_prefix_printk(l, sdev, NULL, fmt, ##a);		\
+})
+
 __printf(3, 4) void
 scmd_printk(const char *, const struct scsi_cmnd *, const char *, ...);
 
-- 
1.8.3.1
