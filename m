Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2710C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762C820881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762C820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeIMNBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:01:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726570AbeIMNBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:01:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6593D723C3CCD;
        Thu, 13 Sep 2018 15:53:26 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Thu, 13 Sep 2018 15:53:25 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] HID: logitech: fix a used uninitialized GCC warning
Date:   Thu, 13 Sep 2018 15:41:10 +0800
Message-ID: <1536824470-36659-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

drivers/hid/hid-logitech-hidpp.c: In function 'hi_res_scroll_enable':
drivers/hid/hid-logitech-hidpp.c:2714:54: warning: 'multiplier' may be used uninitialized in this function [-Wmaybe-uninitialized]
  hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2:
     According to Benjamin's suggestion, To initialize the value
and remove the duplicated assignement. 

 drivers/hid/hid-logitech-hidpp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5f0c080..f012808 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1231,7 +1231,6 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 	*multiplier = response.fap.params[0];
 	return 0;
 return_default:
-	*multiplier = 8;
 	hid_warn(hidpp->hid_dev,
 		 "Couldn't get wheel multiplier (error %d), assuming %d.\n",
 		 ret, *multiplier);
@@ -2696,7 +2695,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
 static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 {
 	int ret;
-	u8 multiplier;
+	u8 multiplier = 8;
 
 	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
 		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
@@ -2704,10 +2703,9 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	} else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
 		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
 							   &multiplier);
-	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
+	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */
 		ret = hidpp10_enable_scrolling_acceleration(hidpp);
-		multiplier = 8;
-	}
+
 	if (ret)
 		return ret;
 
-- 
1.7.12.4

