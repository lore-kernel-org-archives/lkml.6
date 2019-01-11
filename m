Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76AAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA25520872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfAKIlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:41:21 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:50540 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728488AbfAKIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:41:20 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0B8fFCM021472;
        Fri, 11 Jan 2019 02:41:18 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2pxcvnhk17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 02:41:18 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod3.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x0B8fH5f016279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 02:41:17 -0600
Received: from us-aus-exch5.ni.corp.natinst.com (130.164.68.15) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 11 Jan 2019 02:41:16 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch5.ni.corp.natinst.com (130.164.68.15) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 11 Jan 2019 02:41:16 -0600
Received: from my-pen-rd24.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Fri, 11 Jan 2019 02:41:15 -0600
From:   Guan Yung Tseng <guan.yung.tseng@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Guan Yung Tseng" <guan.yung.tseng@ni.com>
Subject: [PATCH v2] 8250_pci.c: Only check for communication class in serial_pci_guess_board
Date:   Fri, 11 Jan 2019 16:41:00 +0800
Message-ID: <1547196060-96495-1-git-send-email-guan.yung.tseng@ni.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some multiport serial cards, such as the NI PXI-8430/2, NI PXI-8430/8,
and NI PXI-8432/4 use PCI_CLASS_COMMUNICATION_OTHER and this fail the
serial_pci_is_class_communication test added in the commit 7d8905d06405
("serial: 8250_pci: Enable device after we check black list").

Since these devices are correctly listed in serial_pci_tbl, we
shouldn't need to check the PCI class IDs. This change relocates the
class checking solely into "serial_pci_guess_board" where it had been
before so that the class-check doesn't hinder initialization.

Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
---
Changes in v2:
  - Remain the serial_pci_is_class_communication
  - Call the serial_pci_is_class_communication in serial_pci_guess_board
    function.

 drivers/tty/serial/8250/8250_pci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4986b4a..2ca0694 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3424,8 +3424,11 @@ static int serial_pci_is_blacklisted(struct pci_dev *dev)
 static int
 serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 {
-	int num_iomem, num_port, first_port = -1, i;
+	int num_iomem, num_port, first_port = -1, i, rc;
 
+	rc = serial_pci_is_class_communication(dev);
+	if (rc)
+		return rc;
 	/*
 	 * Should we try to make guesses for multiport serial devices later?
 	 */
@@ -3652,10 +3655,6 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 
 	board = &pci_boards[ent->driver_data];
 
-	rc = serial_pci_is_class_communication(dev);
-	if (rc)
-		return rc;
-
 	rc = serial_pci_is_blacklisted(dev);
 	if (rc)
 		return rc;
-- 
2.7.4

