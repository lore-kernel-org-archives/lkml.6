Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeDJMiv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:38:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34827 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbeDJMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:38:48 -0400
X-Google-Smtp-Source: AIpwx4+2I3UT43Gn/69o8SmQlA0naAefoCv/AsJi1LHn/aVAlkssoV5uOJW9baPlmBGgvCV6SEFS2A==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: Kai.Makisara@kolumbus.fi, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] scsi: st: Replace GFP_ATOMIC with GFP_KERNEL in new_tape_buffer
Date: Tue, 10 Apr 2018 20:38:42 +0800
Message-Id: <1523363922-31330-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

new_tape_buffer() is never called in atomic context.

new_tape_buffer() is only called by st_probe(),
which is only set as ".probe" in struct scsi_driver.

Despite never getting called from atomic context,
new_tape_buffer() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 94e402e..b987f6d 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3878,7 +3878,7 @@ static struct st_buffer *new_tape_buffer(int need_dma, int max_sg)
 {
 	struct st_buffer *tb;
 
-	tb = kzalloc(sizeof(struct st_buffer), GFP_ATOMIC);
+	tb = kzalloc(sizeof(struct st_buffer), GFP_KERNEL);
 	if (!tb) {
 		printk(KERN_NOTICE "st: Can't allocate new tape buffer.\n");
 		return NULL;
@@ -3889,7 +3889,7 @@ static struct st_buffer *new_tape_buffer(int need_dma, int max_sg)
 	tb->buffer_size = 0;
 
 	tb->reserved_pages = kzalloc(max_sg * sizeof(struct page *),
-				     GFP_ATOMIC);
+				     GFP_KERNEL);
 	if (!tb->reserved_pages) {
 		kfree(tb);
 		return NULL;
-- 
1.9.1
