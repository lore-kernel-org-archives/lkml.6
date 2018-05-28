Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969077AbeE1Phl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968769AbeE1KSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:18:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 098/268] s390/cio: fix return code after missing interrupt
Date: Mon, 28 May 2018 12:01:12 +0200
Message-Id: <20180528100213.356478526@linuxfoundation.org>
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

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

[ Upstream commit 770b55c995d171f026a9efb85e71e3b1ea47b93d ]

When a timeout occurs for users of ccw_device_start_timeout
we will stop the IO and call the drivers int handler with
the irb pointer set to ERR_PTR(-ETIMEDOUT). Sometimes
however we'd set the irb pointer to ERR_PTR(-EIO) which is
not intended. Just set the correct value in all codepaths.

Reported-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/cio/device_fsm.c |    6 ++++--
 drivers/s390/cio/io_sch.h     |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -822,6 +822,7 @@ ccw_device_online_timeout(struct ccw_dev
 
 	ccw_device_set_timeout(cdev, 0);
 	cdev->private->iretry = 255;
+	cdev->private->async_kill_io_rc = -ETIMEDOUT;
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
 		ccw_device_set_timeout(cdev, 3*HZ);
@@ -898,7 +899,7 @@ ccw_device_killing_irq(struct ccw_device
 	/* OK, i/o is dead now. Call interrupt handler. */
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-EIO));
+			      ERR_PTR(cdev->private->async_kill_io_rc));
 }
 
 static void
@@ -915,7 +916,7 @@ ccw_device_killing_timeout(struct ccw_de
 	ccw_device_online_verify(cdev, 0);
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-EIO));
+			      ERR_PTR(cdev->private->async_kill_io_rc));
 }
 
 void ccw_device_kill_io(struct ccw_device *cdev)
@@ -923,6 +924,7 @@ void ccw_device_kill_io(struct ccw_devic
 	int ret;
 
 	cdev->private->iretry = 255;
+	cdev->private->async_kill_io_rc = -EIO;
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
 		ccw_device_set_timeout(cdev, 3*HZ);
--- a/drivers/s390/cio/io_sch.h
+++ b/drivers/s390/cio/io_sch.h
@@ -155,6 +155,7 @@ struct ccw_device_private {
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
 	struct irb irb;		/* device status */
+	int async_kill_io_rc;
 	struct senseid senseid;	/* SenseID info */
 	struct pgid pgid[8];	/* path group IDs per chpid*/
 	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
