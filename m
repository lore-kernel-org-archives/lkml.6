Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC82CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9700F20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfAOKKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:10:23 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:42854 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726011AbfAOKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:10:22 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0F9qWAE030342;
        Tue, 15 Jan 2019 04:10:21 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2pyemuyaeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jan 2019 04:10:20 -0600
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x0FAAK8W024493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Jan 2019 04:10:20 -0600
Received: from us-aus-exch5.ni.corp.natinst.com (130.164.68.15) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 15 Jan 2019 04:10:19 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) by
 us-aus-exch5.ni.corp.natinst.com (130.164.68.15) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 15 Jan 2019 04:10:19 -0600
Received: from my-pen-rd24.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Tue, 15 Jan 2019 04:10:18 -0600
From:   Guan Yung Tseng <guan.yung.tseng@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Guan Yung Tseng" <guan.yung.tseng@ni.com>
Subject: [PATCH v2] 8250_pci.c: Update NI specific devices class to multi serial
Date:   Tue, 15 Jan 2019 18:10:05 +0800
Message-ID: <1547547005-2149-1-git-send-email-guan.yung.tseng@ni.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
The reason of doing this is because all NI multi port serial cards
use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
serial_pci_is_class_communication test added in the commit 7d8905d06405
("serial: 8250_pci: Enable device after we check black list").

Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
---
Changes in v2:
-  added comment to pci_ni_probe function

 drivers/tty/serial/8250/8250_pci.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4986b4a..1f91858 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -663,6 +663,18 @@ static int pci_xircom_init(struct pci_dev *dev)
 	return 0;
 }
 
+/*
+ * NI Serial devices incorrectly identify themselves
+ * PCI_CLASS_COMMUNICATION_OTHER, instead of what
+ * they really are: PCI_CLASS_COMMUNICATION_MULTISERIAL
+ */
+static int pci_ni_probe(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8 |
+			(dev->class & 0xff);
+	return 0;
+}
+
 static int pci_ni8420_init(struct pci_dev *dev)
 {
 	void __iomem *p;
@@ -1850,6 +1862,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI23216,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1859,6 +1872,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2328,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1868,6 +1882,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1877,6 +1892,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1886,6 +1902,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2324I,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1895,6 +1912,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2322I,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1904,6 +1922,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_23216,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1913,6 +1932,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2328,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1922,6 +1942,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1931,6 +1952,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1940,6 +1962,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8422_2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1949,6 +1972,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8422_2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1958,6 +1982,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8430_init,
 		.setup		= pci_ni8430_setup,
 		.exit		= pci_ni8430_exit,
-- 
2.7.4

