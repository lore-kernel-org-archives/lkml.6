Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D030C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4B020C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfB0Dao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:30:44 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:59814 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbfB0Dan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:30:43 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R3LEns004299;
        Wed, 27 Feb 2019 03:30:39 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qwcbqtfrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 03:30:39 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id B7CAC85;
        Wed, 27 Feb 2019 03:30:38 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 9616C37;
        Wed, 27 Feb 2019 03:30:36 +0000 (UTC)
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, david.altobelli@hpe.com,
        mark.rusk@hpe.com, jerry.hoemann@hpe.com,
        Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH v2 2/2] misc: hpilo: Do not claim unsupported hardware
Date:   Wed, 27 Feb 2019 11:25:30 +0800
Message-Id: <1551237930-28823-3-git-send-email-matt.hsiao@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551237930-28823-1-git-send-email-matt.hsiao@hpe.com>
References: <1551237930-28823-1-git-send-email-matt.hsiao@hpe.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=890 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CL2600/CL2800 servers leveraged Proliant hardware but are targeted to a
different market segment and come with a different firmware base. Based
upon targeted market needs, the servers de-featured certain aspects of iLO.

As a result, hpilo driver still claims the hardware but is not functional,
so we decided to blacklist it with SSID 0x0289 to reduce confusion to
customers.

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 drivers/misc/hpilo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 0224e50..927309b 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -32,6 +32,8 @@
 static const struct pci_device_id ilo_blacklist[] = {
 	/* auxiliary iLO */
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP, 0x1979)},
+	/* CL */
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP_3PAR, 0x0289)},
 	{}
 };
 
-- 
1.8.3.1

