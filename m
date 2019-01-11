Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FBAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D955621848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217722;
	bh=uqi27+toaOnvsEtnS6W99/4xTxjYELkTAh8UP530LBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JOv1AViIfkC4LfGYUxAuC8leD1P18A/Ao+a0KkPgwLRDLt8ThTBwS+asFUiXderIG
	 5Fi4q2JrExCROo8YXs+aoxp10bOcNE+8/KSCqMX4WkwzNrw4RyAdl+GBIEItfkxcRX
	 x2F1dxUtRC6x6nGlbbYw3A6yXb1SUv65CnfHebvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404100AbfAKOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404087AbfAKOmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55362063F;
        Fri, 11 Jan 2019 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217719;
        bh=uqi27+toaOnvsEtnS6W99/4xTxjYELkTAh8UP530LBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yif5pbWqceBgv8AZkCdcOlcn04uRz+AGUEgUkLlJlR0OOpBLW+KsbaVw8aip5Lh07
         Hzu99g+mIwatUMu4QWodei4fW/1pzhFJqeJcmdcRUXLOfEC3PquFnSyJbuUUBK8wox
         /ETLk1gQ1352USeu+XAxsyLrpOUyn+sbuFY+IRSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 17/65] media: cx23885: only reset DMA on problematic CPUs
Date:   Fri, 11 Jan 2019 15:15:03 +0100
Message-Id: <20190111131058.815430757@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

commit 4bd46aa0353e022c2401a258e93b107880a66533 upstream.

It is reported that commit 95f408bbc4e4 ("media: cx23885: Ryzen DMA
related RiSC engine stall fixes") caused regresssions with other CPUs.

Ensure that the quirk will be applied only for the CPUs that
are known to cause problems.

A module option is added for explicit control of the behaviour.

Fixes: 95f408bbc4e4 ("media: cx23885: Ryzen DMA related RiSC engine stall fixes")

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/pci/cx23885/cx23885-core.c |   55 +++++++++++++++++++++++++++++--
 drivers/media/pci/cx23885/cx23885.h      |    2 +
 2 files changed, 55 insertions(+), 2 deletions(-)

--- a/drivers/media/pci/cx23885/cx23885-core.c
+++ b/drivers/media/pci/cx23885/cx23885-core.c
@@ -23,6 +23,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kmod.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -41,6 +42,18 @@ MODULE_AUTHOR("Steven Toth <stoth@linuxt
 MODULE_LICENSE("GPL");
 MODULE_VERSION(CX23885_VERSION);
 
+/*
+ * Some platforms have been found to require periodic resetting of the DMA
+ * engine. Ryzen and XEON platforms are known to be affected. The symptom
+ * encountered is "mpeg risc op code error". Only Ryzen platforms employ
+ * this workaround if the option equals 1. The workaround can be explicitly
+ * disabled for all platforms by setting to 0, the workaround can be forced
+ * on for any platform by setting to 2.
+ */
+static unsigned int dma_reset_workaround = 1;
+module_param(dma_reset_workaround, int, 0644);
+MODULE_PARM_DESC(dma_reset_workaround, "periodic RiSC dma engine reset; 0-force disable, 1-driver detect (default), 2-force enable");
+
 static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "enable debug messages");
@@ -603,8 +616,13 @@ static void cx23885_risc_disasm(struct c
 
 static void cx23885_clear_bridge_error(struct cx23885_dev *dev)
 {
-	uint32_t reg1_val = cx_read(TC_REQ); /* read-only */
-	uint32_t reg2_val = cx_read(TC_REQ_SET);
+	uint32_t reg1_val, reg2_val;
+
+	if (!dev->need_dma_reset)
+		return;
+
+	reg1_val = cx_read(TC_REQ); /* read-only */
+	reg2_val = cx_read(TC_REQ_SET);
 
 	if (reg1_val && reg2_val) {
 		cx_write(TC_REQ, reg1_val);
@@ -2058,6 +2076,37 @@ void cx23885_gpio_enable(struct cx23885_
 	/* TODO: 23-19 */
 }
 
+static struct {
+	int vendor, dev;
+} const broken_dev_id[] = {
+	/* According with
+	 * https://openbenchmarking.org/system/1703021-RI-AMDZEN08075/Ryzen%207%201800X/lspci,
+	 * 0x1451 is PCI ID for the IOMMU found on Ryzen
+	 */
+	{ PCI_VENDOR_ID_AMD, 0x1451 },
+};
+
+static bool cx23885_does_need_dma_reset(void)
+{
+	int i;
+	struct pci_dev *pdev = NULL;
+
+	if (dma_reset_workaround == 0)
+		return false;
+	else if (dma_reset_workaround == 2)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(broken_dev_id); i++) {
+		pdev = pci_get_device(broken_dev_id[i].vendor,
+				      broken_dev_id[i].dev, NULL);
+		if (pdev) {
+			pci_dev_put(pdev);
+			return true;
+		}
+	}
+	return false;
+}
+
 static int cx23885_initdev(struct pci_dev *pci_dev,
 			   const struct pci_device_id *pci_id)
 {
@@ -2069,6 +2118,8 @@ static int cx23885_initdev(struct pci_de
 	if (NULL == dev)
 		return -ENOMEM;
 
+	dev->need_dma_reset = cx23885_does_need_dma_reset();
+
 	err = v4l2_device_register(&pci_dev->dev, &dev->v4l2_dev);
 	if (err < 0)
 		goto fail_free;
--- a/drivers/media/pci/cx23885/cx23885.h
+++ b/drivers/media/pci/cx23885/cx23885.h
@@ -451,6 +451,8 @@ struct cx23885_dev {
 	/* Analog raw audio */
 	struct cx23885_audio_dev   *audio_dev;
 
+	/* Does the system require periodic DMA resets? */
+	unsigned int		need_dma_reset:1;
 };
 
 static inline struct cx23885_dev *to_cx23885(struct v4l2_device *v4l2_dev)


