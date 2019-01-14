Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420D920657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfANOLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:11:46 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:54238 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbfANOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:11:46 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EDeKd8028923;
        Mon, 14 Jan 2019 08:11:33 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2pyd51vexn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jan 2019 08:11:30 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x0EEActA004223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Jan 2019 08:10:38 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 14 Jan 2019 08:10:38 -0600
Received: from my-pen-rd24.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 14 Jan 2019 08:10:35 -0600
From:   Guan Yung Tseng <guan.yung.tseng@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Guan Yung Tseng <guan.yung.tseng@ni.com>
Subject: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
Date:   Mon, 14 Jan 2019 22:10:05 +0800
Message-ID: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_06:,,
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
 drivers/tty/serial/8250/8250_pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4986b4a..0949db1 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -663,6 +663,13 @@ static int pci_xircom_init(struct pci_dev *dev)
 	return 0;
 }
 
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
@@ -1850,6 +1857,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI23216,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1859,6 +1867,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2328,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1868,6 +1877,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1877,6 +1887,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1886,6 +1897,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2324I,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1895,6 +1907,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PCI2322I,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1904,6 +1917,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_23216,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1913,6 +1927,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2328,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1922,6 +1937,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1931,6 +1947,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8420_2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1940,6 +1957,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8422_2324,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1949,6 +1967,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_DEVICE_ID_NI_PXI8422_2322,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8420_init,
 		.setup		= pci_default_setup,
 		.exit		= pci_ni8420_exit,
@@ -1958,6 +1977,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.device		= PCI_ANY_ID,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
+		.probe		= pci_ni_probe,
 		.init		= pci_ni8430_init,
 		.setup		= pci_ni8430_setup,
 		.exit		= pci_ni8430_exit,
-- 
2.7.4

