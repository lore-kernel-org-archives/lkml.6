Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB8C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328CC25318
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328CC25318
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeFXVMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 17:12:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:48385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbeFXVMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 17:12:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2018 14:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,267,1526367600"; 
   d="scan'208";a="51888189"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga008.jf.intel.com with ESMTP; 24 Jun 2018 14:12:45 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: add optional timeout to internal bus recv
Date:   Mon, 25 Jun 2018 00:11:40 +0300
Message-Id: <20180624211141.7681-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add optional timeout to internal bus recv function to
enable break out of internal flows in case of no answer from FW.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c |  2 +-
 drivers/misc/mei/bus.c       | 36 ++++++++++++++++++++++++++----------
 drivers/misc/mei/mei_dev.h   |  2 +-
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 0208c4b027c5..b17c46a43812 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -266,7 +266,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 		return -ENOMEM;
 
 	ret = 0;
-	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, 0);
+	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, 0, 0);
 	if (bytes_recv < if_version_length) {
 		dev_err(bus->dev, "Could not read IF version\n");
 		ret = -EIO;
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index b1133739fb4b..7bba62a72921 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -116,11 +116,12 @@ ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
  * @buf: buffer to receive
  * @length: buffer length
  * @mode: io mode
+ * @timeout: recv timeout, 0 for infinite timeout
  *
  * Return: read size in bytes of < 0 on error
  */
 ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
-		      unsigned int mode)
+		      unsigned int mode, unsigned long timeout)
 {
 	struct mei_device *bus;
 	struct mei_cl_cb *cb;
@@ -158,13 +159,28 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
 
 		mutex_unlock(&bus->device_lock);
 
-		if (wait_event_interruptible(cl->rx_wait,
-				(!list_empty(&cl->rd_completed)) ||
-				(!mei_cl_is_connected(cl)))) {
-
-			if (signal_pending(current))
-				return -EINTR;
-			return -ERESTARTSYS;
+		if (timeout) {
+			rets = wait_event_interruptible_timeout
+					(cl->rx_wait,
+					(!list_empty(&cl->rd_completed)) ||
+					(!mei_cl_is_connected(cl)),
+					msecs_to_jiffies(timeout));
+			if (rets == 0)
+				return -ETIME;
+			if (rets < 0) {
+				if (signal_pending(current))
+					return -EINTR;
+				return -ERESTARTSYS;
+			}
+		} else {
+			if (wait_event_interruptible
+					(cl->rx_wait,
+					(!list_empty(&cl->rd_completed)) ||
+					(!mei_cl_is_connected(cl)))) {
+				if (signal_pending(current))
+					return -EINTR;
+				return -ERESTARTSYS;
+			}
 		}
 
 		mutex_lock(&bus->device_lock);
@@ -231,7 +247,7 @@ ssize_t mei_cldev_recv_nonblock(struct mei_cl_device *cldev, u8 *buf,
 {
 	struct mei_cl *cl = cldev->cl;
 
-	return __mei_cl_recv(cl, buf, length, MEI_CL_IO_RX_NONBLOCK);
+	return __mei_cl_recv(cl, buf, length, MEI_CL_IO_RX_NONBLOCK, 0);
 }
 EXPORT_SYMBOL_GPL(mei_cldev_recv_nonblock);
 
@@ -248,7 +264,7 @@ ssize_t mei_cldev_recv(struct mei_cl_device *cldev, u8 *buf, size_t length)
 {
 	struct mei_cl *cl = cldev->cl;
 
-	return __mei_cl_recv(cl, buf, length, 0);
+	return __mei_cl_recv(cl, buf, length, 0, 0);
 }
 EXPORT_SYMBOL_GPL(mei_cldev_recv);
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index be9c48415da9..4058ab5ad2d8 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -317,7 +317,7 @@ void mei_cl_bus_dev_fixup(struct mei_cl_device *dev);
 ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
 		      unsigned int mode);
 ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
-		      unsigned int mode);
+		      unsigned int mode, unsigned long timeout);
 bool mei_cl_bus_rx_event(struct mei_cl *cl);
 bool mei_cl_bus_notify_event(struct mei_cl *cl);
 void mei_cl_bus_remove_devices(struct mei_device *bus);
-- 
2.14.4

