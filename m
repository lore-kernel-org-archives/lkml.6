Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3466CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B178214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBUIK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:10:28 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:59232 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfBUIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:10:28 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1L86PYC015845;
        Thu, 21 Feb 2019 08:10:24 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qsr2n02kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Feb 2019 08:10:24 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id D3BB566;
        Thu, 21 Feb 2019 08:10:23 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id BE00D4D;
        Thu, 21 Feb 2019 08:10:21 +0000 (UTC)
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, david.altobelli@hpe.com,
        mark.rusk@hpe.com, jerry.hoemann@hpe.com,
        Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH 2/4] misc: hpilo: Exclude unsupported device via blacklist
Date:   Thu, 21 Feb 2019 16:04:40 +0800
Message-Id: <1550736282-25416-3-git-send-email-matt.hsiao@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having explicit if statments excluding devices,
use a pci_device_id table of devices to blacklist.

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 drivers/misc/hpilo.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 01c407a..0224e50 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -29,6 +29,11 @@
 static unsigned int ilo_major;
 static unsigned int max_ccb = 16;
 static char ilo_hwdev[MAX_ILO_DEV];
+static const struct pci_device_id ilo_blacklist[] = {
+	/* auxiliary iLO */
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP, 0x1979)},
+	{}
+};
 
 static inline int get_entry_id(int entry)
 {
@@ -763,10 +768,10 @@ static int ilo_probe(struct pci_dev *pdev,
 	int devnum, minor, start, error = 0;
 	struct ilo_hwinfo *ilo_hw;
 
-	/* Ignore auxiliary iLO device */
-	if (pdev->subsystem_vendor == PCI_VENDOR_ID_HP &&
-	    pdev->subsystem_device == 0x1979)
-		return 0;
+	if (pci_match_id(ilo_blacklist, pdev)) {
+		dev_dbg(&pdev->dev, "Not supported on this device\n");
+		return -ENODEV;
+	}
 
 	if (max_ccb > MAX_CCB)
 		max_ccb = MAX_CCB;
-- 
1.8.3.1

