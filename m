Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A81C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4312086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WK7HxILb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4312086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeGLR3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:29:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50548 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeGLR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:29:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CHE0nW010062;
        Thu, 12 Jul 2018 17:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=Vtg6o/E9q0d2E8ZKqqxujdhdEM2yl9Ty/CfV3vfSnVk=;
 b=WK7HxILb7qWHFo6hrAzXQm6e8KWbccBTccMEhVp0Iduo6ABKIvck87GARY0Tgij1A0vD
 lt51cVfhFHke/O+G2zKDmdqybt7ZvMhvhMb60sNkxc514QW+mgGlNFV7dTIovnpm+AU+
 qdBRgud9EAyZ7dmpkHmtW2x822ibDSZQJaWaicoyeR3pKg9FFzj4jWAIhTHtAdQ69cz2
 gnoliJRQCBHiDSYz/xC2jpkjV3H7M3dyC2Sa0FjvtxhDUc45bWP8NwPUaS9/MU9bV4jF
 8RzbP8DHXPeDnwG3NyV38vYUB6Ylwfl0CM8sIl0cncR1Gk7QTNf0WTQrsjUnhdJKNb5H tw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k2p76crq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 17:19:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6CHJHwN009654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 17:19:17 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6CHJGqM022505;
        Thu, 12 Jul 2018 17:19:16 GMT
Received: from ovs104.us.oracle.com (/10.149.224.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 10:19:16 -0700
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] xen/x86/vpmu: Zero struct pt_regs before calling into sample handling code
Date:   Thu, 12 Jul 2018 13:27:00 -0400
Message-Id: <1531416420-3580-1-git-send-email-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=538
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise we may leak kernel stack for events that sample user
registers.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org
---
 arch/x86/xen/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 7d00d4a..95997e6 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -478,7 +478,7 @@ static void xen_convert_regs(const struct xen_pmu_regs *xen_regs,
 irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id)
 {
 	int err, ret = IRQ_NONE;
-	struct pt_regs regs;
+	struct pt_regs regs = {0};
 	const struct xen_pmu_data *xenpmu_data = get_xenpmu_data();
 	uint8_t xenpmu_flags = get_xenpmu_flags();
 
-- 
1.8.3.1

