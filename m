Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E689C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2552420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfB0Dal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:30:41 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:59806 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbfB0Dal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:30:41 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R3LeTP005273;
        Wed, 27 Feb 2019 03:30:35 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qwcbqtfr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 03:30:35 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 697B165;
        Wed, 27 Feb 2019 03:30:34 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 475FB3A;
        Wed, 27 Feb 2019 03:30:32 +0000 (UTC)
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, david.altobelli@hpe.com,
        mark.rusk@hpe.com, jerry.hoemann@hpe.com,
        Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH v2 1/2] misc: hpilo: Exclude unsupported device via blacklist
Date:   Wed, 27 Feb 2019 11:25:29 +0800
Message-Id: <1551237930-28823-2-git-send-email-matt.hsiao@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551237930-28823-1-git-send-email-matt.hsiao@hpe.com>
References: <1551237930-28823-1-git-send-email-matt.hsiao@hpe.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having explicit if statements excluding devices,
use a pci_device_id table of devices to blacklist.

HPE will put out minor updates to the iLO using the same device
info except for the subsystem device id. hpilo driver takes the
approach to claim based upon {Vendor, Device, SubVendor} and it
allows old software to work on new hardware without patching.

As our primary way to support our customers is via distros, the
patching process could take months to go upstream and then
backported to multiple releases of multiple distros.

This approach worked fairly well as this is only the second time
in 10+ years that we need to blacklist an instance.

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 drivers/misc/hpilo.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index e9c9ef5..0224e50 100644
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
@@ -763,9 +768,10 @@ static int ilo_probe(struct pci_dev *pdev,
 	int devnum, minor, start, error = 0;
 	struct ilo_hwinfo *ilo_hw;
 
-	/* Ignore subsystem_device = 0x1979 (set by BIOS)  */
-	if (pdev->subsystem_device == 0x1979)
-		return 0;
+	if (pci_match_id(ilo_blacklist, pdev)) {
+		dev_dbg(&pdev->dev, "Not supported on this device\n");
+		return -ENODEV;
+	}
 
 	if (max_ccb > MAX_CCB)
 		max_ccb = MAX_CCB;
-- 
1.8.3.1

