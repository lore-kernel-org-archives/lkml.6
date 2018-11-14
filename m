Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39DF223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39DF223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fluff.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbeKODye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:54:34 -0500
Received: from cpc82359-stkp12-2-0-cust135.10-2.cable.virginm.net ([86.17.48.136]:36656
        "EHLO freya" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727576AbeKODye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:54:34 -0500
X-Greylist: delayed 2222 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2018 22:54:33 EST
Received: from ben by freya with local (Exim 4.91)
        (envelope-from <ben@fluff.org>)
        id 1gMyj8-0007B5-88; Wed, 14 Nov 2018 17:13:18 +0000
From:   Ben Dooks <ben-linux@fluff.org>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@lists.codethink.co.uk, linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] USB: host: ehci: allow tine of highspeed nak-count
Date:   Wed, 14 Nov 2018 17:13:15 +0000
Message-Id: <20181114171315.27549-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

At least some systems benefit with less scheduling if the NAK count
value is set higher than the default 4. For instance a Tegra3 with
an SMSC9512 showed less interrupt load when this was changed to 14.

To allow the changing of this value, add a sysfs node to each of
the controllers to allow run-time changing.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/usb/host/ehci-hcd.c   |  1 +
 drivers/usb/host/ehci-q.c     |  4 +--
 drivers/usb/host/ehci-sysfs.c | 52 +++++++++++++++++++++++++++++++++--
 drivers/usb/host/ehci.h       |  1 +
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 8608ac513fb7..799262951f41 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -526,6 +526,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	hw->hw_qtd_next = EHCI_LIST_END(ehci);
 	ehci->async->qh_state = QH_STATE_LINKED;
 	hw->hw_alt_next = QTD_NEXT(ehci, ehci->async->dummy->qtd_dma);
+	ehci->nak_tune_hs = EHCI_TUNE_RL_HS;
 
 	/* clear interrupt enables, set irq latency */
 	if (log2_irq_thresh < 0 || log2_irq_thresh > 6)
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 327630405695..ccb754893b5a 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -898,12 +898,12 @@ qh_make (
 	case USB_SPEED_HIGH:		/* no TT involved */
 		info1 |= QH_HIGH_SPEED;
 		if (type == PIPE_CONTROL) {
-			info1 |= (EHCI_TUNE_RL_HS << 28);
+			info1 |= ehci->nak_tune_hs << 28;
 			info1 |= 64 << 16;	/* usb2 fixed maxpacket */
 			info1 |= QH_TOGGLE_CTL;	/* toggle from qtd */
 			info2 |= (EHCI_TUNE_MULT_HS << 30);
 		} else if (type == PIPE_BULK) {
-			info1 |= (EHCI_TUNE_RL_HS << 28);
+			info1 |= ehci->nak_tune_hs << 28;
 			/* The USB spec says that high speed bulk endpoints
 			 * always use 512 byte maxpacket.  But some device
 			 * vendors decided to ignore that, and MSFT is happy
diff --git a/drivers/usb/host/ehci-sysfs.c b/drivers/usb/host/ehci-sysfs.c
index 8f75cb7b197c..d710d35282a6 100644
--- a/drivers/usb/host/ehci-sysfs.c
+++ b/drivers/usb/host/ehci-sysfs.c
@@ -145,19 +145,66 @@ static ssize_t uframe_periodic_max_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(uframe_periodic_max);
 
+static ssize_t nak_tune_hs_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ehci_hcd		*ehci;
+
+	ehci = hcd_to_ehci(dev_get_drvdata(dev));
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ehci->nak_tune_hs);
+}
+
+static ssize_t nak_tune_hs_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct ehci_hcd		*ehci;
+	unsigned		val;
+	unsigned long		flags;
+
+	ehci = hcd_to_ehci(dev_get_drvdata(dev));
+
+	if (kstrtouint(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val >= 15) {
+		ehci_info(ehci, "invalid value for nak_tune_hs (%d)\n", val);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave (&ehci->lock, flags);
+	ehci->nak_tune_hs = val;
+	spin_unlock_irqrestore (&ehci->lock, flags);
+	return count;
+}
+
+static DEVICE_ATTR_RW(nak_tune_hs);
 
 static inline int create_sysfs_files(struct ehci_hcd *ehci)
 {
 	struct device	*controller = ehci_to_hcd(ehci)->self.controller;
 	int	i = 0;
 
+	i = device_create_file(controller, &dev_attr_nak_tune_hs);
+	if (i)
+		goto out;
+
+	i = device_create_file(controller, &dev_attr_uframe_periodic_max);
+	if (i)
+		goto out_nak;
+
 	/* with integrated TT there is no companion! */
 	if (!ehci_is_TDI(ehci))
 		i = device_create_file(controller, &dev_attr_companion);
 	if (i)
-		goto out;
+		goto out_all;
 
-	i = device_create_file(controller, &dev_attr_uframe_periodic_max);
+	return 0;
+out_all:
+	device_remove_file(controller, &dev_attr_uframe_periodic_max);
+out_nak:
+	device_remove_file(controller, &dev_attr_nak_tune_hs);
 out:
 	return i;
 }
@@ -170,5 +217,6 @@ static inline void remove_sysfs_files(struct ehci_hcd *ehci)
 	if (!ehci_is_TDI(ehci))
 		device_remove_file(controller, &dev_attr_companion);
 
+	device_remove_file(controller, &dev_attr_nak_tune_hs);
 	device_remove_file(controller, &dev_attr_uframe_periodic_max);
 }
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index c8e9a48e1d51..1fb6f1ad8128 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -154,6 +154,7 @@ struct ehci_hcd {			/* one per controller */
 	dma_addr_t		periodic_dma;
 	struct list_head	intr_qh_list;
 	unsigned		i_thresh;	/* uframes HC might cache */
+	u32			nak_tune_hs;
 
 	union ehci_shadow	*pshadow;	/* mirror hw periodic table */
 	struct list_head	intr_unlink_wait;
-- 
2.19.1

