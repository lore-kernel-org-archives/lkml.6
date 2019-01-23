Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B060DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB6020870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfAWOSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:18:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfAWOSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:18:03 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E12A7AC8CF7C487DD1F1;
        Wed, 23 Jan 2019 22:17:58 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 22:17:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 2/2] usb: ftdi-elan: Fix if == else warnings in ftdi_elan_respond_engine
Date:   Wed, 23 Jan 2019 22:16:57 +0800
Message-ID: <20190123141657.8308-3-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190123141657.8308-1-yuehaibing@huawei.com>
References: <20190123141657.8308-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following coccinelle warning:
./drivers/usb/misc/ftdi-elan.c:972:10-12: WARNING: possible condition with no effect (if == else)
./drivers/usb/misc/ftdi-elan.c:983:9-11: WARNING: possible condition with no effect (if == else)
./drivers/usb/misc/ftdi-elan.c:2052:11-13: WARNING: possible condition with no effect (if == else)

All these else/if branches just do the same thing actually as the last else branch,
So it can be merged into the last branch.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/misc/ftdi-elan.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index b2b05c9..257efac 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -959,30 +959,6 @@ read:{
 			dev_err(&ftdi->udev->dev, "error = %d with packet_bytes = %d with total %d bytes%s\n",
 				retval, packet_bytes, bytes_read, diag);
 			return retval;
-		} else if (packet_bytes == 2) {
-			unsigned char s0 = ftdi->bulk_in_buffer[0];
-			unsigned char s1 = ftdi->bulk_in_buffer[1];
-			if (s0 == 0x31 && s1 == 0x60) {
-				if (retry_on_empty-- > 0) {
-					goto more;
-				} else
-					return 0;
-			} else if (s0 == 0x31 && s1 == 0x00) {
-				if (retry_on_empty-- > 0) {
-					goto more;
-				} else
-					return 0;
-			} else {
-				if (retry_on_empty-- > 0) {
-					goto more;
-				} else
-					return 0;
-			}
-		} else if (packet_bytes == 1) {
-			if (retry_on_empty-- > 0) {
-				goto more;
-			} else
-				return 0;
 		} else {
 			if (retry_on_empty-- > 0) {
 				goto more;
-- 
2.7.0


