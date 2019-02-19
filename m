Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74001C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E60B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfBSG6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:58:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbfBSG6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:58:13 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 86131F2B57E038825E13;
        Tue, 19 Feb 2019 14:58:10 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 14:58:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: typec: mux: Fix unsigned comparison with less than zero
Date:   Tue, 19 Feb 2019 14:57:50 +0800
Message-ID: <20190219065750.9004-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to fwnode_property_read_u16_array is int, 
it can be a negative error code however this is being assigned to
an size_t variable 'nval', hence the check is always false.
Fix this by making 'nval' an int.

Detected by Coccinelle ("Unsigned expression compared with
zero: nval < 0")

Fixes: 96a6d031ca99 ("usb: typec: mux: Find the muxes by also matching against the device node")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/typec/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index a5947d9..54d7497 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -126,7 +126,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
 	const struct typec_altmode_desc *desc = data;
 	struct typec_mux *mux;
-	size_t nval;
+	int nval;
 	bool match;
 	u16 *val;
 	int i;
-- 
2.7.0


