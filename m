Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C174C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392FD2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392FD2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436911AbeKWAM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:12:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388648AbeKWAM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:12:27 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0200994C7911E;
        Thu, 22 Nov 2018 21:33:01 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 21:32:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <richardcochran@gmail.com>,
        <dmitry.torokhov@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ptp: Fix pass zero to ERR_PTR() in ptp_clock_register
Date:   Thu, 22 Nov 2018 21:32:02 +0800
Message-ID: <20181122133202.21908-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:

drivers/ptp/ptp_clock.c:298 ptp_clock_register() warn:
 passing zero to 'ERR_PTR'

'err' should be set while device_create_with_groups or
pps_register_source fails

Fixes: 85a66e550195 ("ptp: create "pins" together with the rest of attributes")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/ptp/ptp_clock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 40fda23..6811f85 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -252,8 +252,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	ptp->dev = device_create_with_groups(ptp_class, parent, ptp->devid,
 					     ptp, ptp->pin_attr_groups,
 					     "ptp%d", ptp->index);
-	if (IS_ERR(ptp->dev))
+	if (IS_ERR(ptp->dev)) {
+		err = PTR_ERR(ptp->dev);
 		goto no_device;
+	}
 
 	/* Register a new PPS source. */
 	if (info->pps) {
@@ -264,6 +266,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 		pps.owner = info->owner;
 		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
 		if (!ptp->pps_source) {
+			err = PTR_ERR(-EINVAL);
 			pr_err("failed to register pps source\n");
 			goto no_pps;
 		}
-- 
2.7.0


