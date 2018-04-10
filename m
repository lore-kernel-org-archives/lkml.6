Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeDJMiW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:38:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41310 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbeDJMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:38:18 -0400
X-Google-Smtp-Source: AIpwx4+RDvo4uuiGchV7/J7vEmosA5WpT3rJ8ro6IwA/XYrGjYhhQ3v2mq3CGtRVvhcjZJ//UhqhEQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: Kai.Makisara@kolumbus.fi, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] scsi: st: Replace GFP_ATOMIC with GFP_KERNEL in st_probe
Date: Tue, 10 Apr 2018 20:37:59 +0800
Message-Id: <1523363879-31242-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st_probe() is never called in atomic context.

st_probe() is only set as ".probe" in struct scsi_driver.

Despite never getting called from atomic context,
st_probe() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 94e402e..1da42f3 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4290,7 +4290,7 @@ static int st_probe(struct device *dev)
 		goto out_buffer_free;
 	}
 
-	tpnt = kzalloc(sizeof(struct scsi_tape), GFP_ATOMIC);
+	tpnt = kzalloc(sizeof(struct scsi_tape), GFP_KERNEL);
 	if (tpnt == NULL) {
 		sdev_printk(KERN_ERR, SDp,
 			    "st: Can't allocate device descriptor.\n");
-- 
1.9.1
