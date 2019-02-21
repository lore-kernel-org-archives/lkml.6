Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB9FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71032086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfBUIKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:10:21 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:39342 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfBUIKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:10:19 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1L86PUN008478;
        Thu, 21 Feb 2019 08:10:17 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qsnsqs1wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Feb 2019 08:10:17 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id B45855F;
        Thu, 21 Feb 2019 08:10:16 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 9EA744A;
        Thu, 21 Feb 2019 08:10:14 +0000 (UTC)
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, david.altobelli@hpe.com,
        mark.rusk@hpe.com, jerry.hoemann@hpe.com,
        Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH 1/4] misc: hpilo: Be more specific when ignoring the aux iLO
Date:   Thu, 21 Feb 2019 16:04:39 +0800
Message-Id: <1550736282-25416-2-git-send-email-matt.hsiao@hpe.com>
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

Be more specific with the subsystem_vendor id used before iLO5

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 drivers/misc/hpilo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index e9c9ef5..01c407a 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -763,8 +763,9 @@ static int ilo_probe(struct pci_dev *pdev,
 	int devnum, minor, start, error = 0;
 	struct ilo_hwinfo *ilo_hw;
 
-	/* Ignore subsystem_device = 0x1979 (set by BIOS)  */
-	if (pdev->subsystem_device == 0x1979)
+	/* Ignore auxiliary iLO device */
+	if (pdev->subsystem_vendor == PCI_VENDOR_ID_HP &&
+	    pdev->subsystem_device == 0x1979)
 		return 0;
 
 	if (max_ccb > MAX_CCB)
-- 
1.8.3.1

