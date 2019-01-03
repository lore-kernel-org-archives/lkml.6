Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FA8C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4B821479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfACL4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:56:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728474AbfACL4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:56:08 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 28A3FB6F09603;
        Thu,  3 Jan 2019 19:56:05 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Thu, 3 Jan 2019 19:55:58 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <arm@kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] HISI LPC: Don't fail probe for unrecognised child devices
Date:   Thu, 3 Jan 2019 19:57:02 +0800
Message-ID: <1546516622-46343-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for ACPI-based FW we fail the probe for an unrecognised child
HID.

However, there is FW in the field with LPC child devices having fake HIDs,
namely "IPI0002", which was an IPMI device invented to support the
initial out-of-tree LPC host driver, different from the final mainline
version.

To provide compatibility support for these dodgy FWs, just discard the
unrecognised HIDs instead of failing the probe altogether.

Tested-by: Zengruan Ye <yezengruan@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index d5f8545..19d7b6f 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -522,10 +522,9 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 
 		if (!found) {
 			dev_warn(hostdev,
-				 "could not find cell for child device (%s)\n",
+				 "could not find cell for child device (%s), discarding\n",
 				 hid);
-			ret = -ENODEV;
-			goto fail;
+			continue;
 		}
 
 		pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
-- 
1.9.1

