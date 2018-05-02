Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEBWVo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:21:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42342 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEBWVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:21:42 -0400
X-Google-Smtp-Source: AB8JxZqjTTnc1FlNw7kp17kU5AQrrVSLxjsWlcS0GsJEMx9RN7+kAmKqFJA/lZOXQTvdGv/uVt9ayA==
Date: Wed, 2 May 2018 15:21:38 -0700
From: Kees Cook <keescook@chromium.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: dpt_i2o: Remove VLA usage
Message-ID: <20180502222138.GA22088@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the quest to remove all VLAs from the kernel[1] this moves the sg_list
variable off the stack, as already done for other allocated buffers in
adpt_i2o_passthru(). Additionally consolidates the error path for kfree().

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/dpt_i2o.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 5ceea8da7bb6..37de8fb186d7 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1706,7 +1706,7 @@ static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
 	u32 reply_size = 0;
 	u32 __user *user_msg = arg;
 	u32 __user * user_reply = NULL;
-	void *sg_list[pHba->sg_tablesize];
+	void **sg_list = NULL;
 	u32 sg_offset = 0;
 	u32 sg_count = 0;
 	int sg_index = 0;
@@ -1748,19 +1748,23 @@ static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
 	msg[2] = 0x40000000; // IOCTL context
 	msg[3] = adpt_ioctl_to_context(pHba, reply);
 	if (msg[3] == (u32)-1) {
-		kfree(reply);
-		return -EBUSY;
+		rcode = -EBUSY;
+		goto free;
 	}
 
-	memset(sg_list,0, sizeof(sg_list[0])*pHba->sg_tablesize);
+	sg_list = kcalloc(pHba->sg_tablesize, sizeof(*sg_list), GFP_KERNEL);
+	if (!sg_list) {
+		rcode = -ENOMEM;
+		goto free;
+	}
 	if(sg_offset) {
 		// TODO add 64 bit API
 		struct sg_simple_element *sg =  (struct sg_simple_element*) (msg+sg_offset);
 		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
 		if (sg_count > pHba->sg_tablesize){
 			printk(KERN_DEBUG"%s:IOCTL SG List too large (%u)\n", pHba->name,sg_count);
-			kfree (reply);
-			return -EINVAL;
+			rcode = -EINVAL;
+			goto free;
 		}
 
 		for(i = 0; i < sg_count; i++) {
@@ -1879,7 +1883,6 @@ static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
 	if (rcode != -ETIME && rcode != -EINTR) {
 		struct sg_simple_element *sg =
 				(struct sg_simple_element*) (msg +sg_offset);
-		kfree (reply);
 		while(sg_index) {
 			if(sg_list[--sg_index]) {
 				dma_free_coherent(&pHba->pDev->dev,
@@ -1889,6 +1892,10 @@ static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
 			}
 		}
 	}
+
+free:
+	kfree(sg_list);
+	kfree(reply);
 	return rcode;
 }
 
-- 
2.17.0


-- 
Kees Cook
Pixel Security
